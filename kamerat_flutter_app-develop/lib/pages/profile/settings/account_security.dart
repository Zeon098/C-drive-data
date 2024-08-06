import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kamerat_flutter_app/components/app_bar.dart';
// import 'package:kamerat_flutter_app/stores/user.store.dart';
import 'package:kamerat_flutter_app/utils/constants.dart';

class AccountSecurity extends StatelessWidget {
  const AccountSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "Konto Sicherheit"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Email & Passwort",
            //   style: Theme.of(context).textTheme.titleSmall!.copyWith(
            //         fontWeight: FontWeight.w700,
            //         color: Theme.of(context).colorScheme.tertiary,
            //       ),
            // ),
            // const SizedBox(height: 24.0),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "Email",
            //             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //                   fontWeight: FontWeight.w600,
            //                   color: Theme.of(context).colorScheme.tertiary,
            //                 ),
            //           ),
            //           const SizedBox(height: 8.0),
            //           Text(
            //             UserStore().user.email,
            //             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //                   fontWeight: FontWeight.w500,
            //                   color: Theme.of(context).colorScheme.onBackground,
            //                 ),
            //           ),
            //         ],
            //       ),
            //       TextButton(
            //         onPressed: () => Get.toNamed(kEmailChangeRoute),
            //         style: TextButton.styleFrom(
            //           padding: EdgeInsets.zero,
            //           minimumSize: Size.zero,
            //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //           splashFactory: NoSplash.splashFactory,
            //         ),
            //         child: Text(
            //           "Bearbeiten",
            //           style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //                 fontWeight: FontWeight.w600,
            //                 color: Theme.of(context).colorScheme.primary,
            //               ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Passwort",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "*********",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(kPasswordChangeRoute),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Text(
                      "Bearbeiten",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
