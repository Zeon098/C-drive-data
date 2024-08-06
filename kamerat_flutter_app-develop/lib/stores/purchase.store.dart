import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';

import 'package:kamerat_flutter_app/services/in_app_purchase.service.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class PurchaseStore {
  static final PurchaseStore _instance = PurchaseStore._internal();
  PurchaseStore._internal();
  factory PurchaseStore() {
    return _instance;
  }

  late InAppPurchase _inAppPurchase;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final RxList<ProductDetails> products = <ProductDetails>[].obs;
  final RxBool isAvailable = false.obs;
  final RxString queryProductError = ''.obs;

  VoidCallback? onSubscriptionComplete;

  OverlayEntry? modalOverlay;

  Future<void> init() async {
    _inAppPurchase = InAppPurchase.instance;

    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;

    _subscription =
        purchaseUpdated.listen(_listenToPurchaseUpdated, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      Get.snackbar('Fehler', 'Etwas ist schief gelaufen');
    });
    await _initStore();

    modalOverlay = OverlayEntry(
      builder: (context) => const Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Future<void> _initStore() async {
    isAvailable.value = await _inAppPurchase.isAvailable();
    if (!isAvailable.value) {
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentDelegateQueue());
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails({kSubscriptionID});

    if (productDetailResponse.error != null) {
      queryProductError.value = productDetailResponse.error!.message;
      return;
    }

    products.value = productDetailResponse.productDetails;
  }

  Future<void> buySubscription() async {
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: products.first,
      applicationUserName: UserStore().uuid,
    );

    await _completePendingPurchases();

    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  Future<void> restoreSubscription() async {
    await _completePendingPurchases();
    _inAppPurchase.restorePurchases();
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.error ||
          purchaseDetails.status == PurchaseStatus.canceled) {
        _handlePurchaseCompletion();
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
          purchaseDetails.status == PurchaseStatus.restored) {
        final isVerified =
            await _verifyPurchase(transactionId: purchaseDetails.purchaseID!);
        UserStore().updateUser(
            UserStore().user.copyWith(inApppaymentSubscription: isVerified));
        if (isVerified) {
          Get.snackbar("Erfolg", "Kauf erfolgreich");
        } else {
          Get.snackbar("Fehler", "Ihr Kauf konnte nicht verifiziert werden");
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
        _handlePurchaseCompletion();
      }
    }
  }

  void _handlePurchaseCompletion() {
    modalOverlay?.remove();
    onSubscriptionComplete?.call();
  }

  Future<bool> _verifyPurchase({required String transactionId}) async {
    final response = await InAppPurchaseService()
        .verifySubscription(transactionId: transactionId);
    return response.code == kSuccessCode;
  }

  Future<void> _completePendingPurchases() async {
    if (Platform.isIOS) {
      try {
        final transactions = await SKPaymentQueueWrapper().transactions();
        for (final transaction in transactions) {
          if (transaction.transactionState ==
                  SKPaymentTransactionStateWrapper.purchased ||
              transaction.transactionState ==
                  SKPaymentTransactionStateWrapper.restored) {
            bool isVerified = await _verifyPurchase(
                transactionId: transaction.transactionIdentifier!);
            if (isVerified) {
              await SKPaymentQueueWrapper().finishTransaction(transaction);
            }
          }
        }
      } catch (e) {
        debugPrint("Error completing pending purchases: $e");
      }
    }
  }
}

class PaymentDelegateQueue implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return true;
  }
}
