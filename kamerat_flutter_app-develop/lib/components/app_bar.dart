import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLeading;
  const MyAppBar({super.key, required this.title, this.showLeading = true});

  @override
  Size get preferredSize => const Size.fromHeight(48);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLeading
          ? IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.tertiary),
              onPressed: () => Get.back(),
            )
          : Container(),
      backgroundColor: Theme.of(context).colorScheme.background,
      primary: true,
      scrolledUnderElevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.bold,
            ),
      ),
      centerTitle: true,
    );
  }
}
