import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  const AppFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      clipBehavior: Clip.none,
      onPressed: () => onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      label: Container(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(19, 154, 67, 1),
              Color.fromRGBO(20, 166, 47, 1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(19, 154, 67, 0.15),
              offset: Offset(0, 8),
              blurRadius: 16.0,
            )
          ],
        ),
        child: Text(
          "Upgrade for access (€ 19.99)/month",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
      ),
      extendedPadding: EdgeInsets.zero,
    );
  }
}
