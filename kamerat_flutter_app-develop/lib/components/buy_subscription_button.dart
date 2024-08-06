import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/stores/purchase.store.dart';
import 'package:kamerat_flutter_app/stores/user.store.dart';

class BuySubscriptionButton extends StatelessWidget {
  final VoidCallback? onSubscriptionComplete;
  const BuySubscriptionButton({super.key, this.onSubscriptionComplete});

  @override
  Widget build(BuildContext context) {
    PurchaseStore purchaseStore = PurchaseStore();
    purchaseStore.onSubscriptionComplete = onSubscriptionComplete;
    return Obx(
      () {
        if (purchaseStore.isAvailable.value &&
            purchaseStore.products.isNotEmpty &&
            !UserStore().isSubscribed) {
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(19, 154, 67, 1),
                  Color.fromRGBO(20, 166, 47, 1),
                ],
              ),
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.transparent,
              extendedPadding: const EdgeInsets.all(32.0),
              elevation: 0,
              highlightElevation: 0,
              label: Text(
                'Upgrade für vollen Zugang (${purchaseStore.products.first.price}/month)',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              onPressed: () {
                Overlay.of(context).insert(purchaseStore.modalOverlay!);
                purchaseStore.buySubscription();
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
