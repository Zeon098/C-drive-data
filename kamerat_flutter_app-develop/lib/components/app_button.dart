import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const AppButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(19, 154, 67, 1),
          Color.fromRGBO(20, 166, 47, 1)
        ]),
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(19, 154, 67, 0.15),
            offset: Offset(0, 8),
            blurRadius: 16.0,
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () => {
          onPressed(),
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 16.0)),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}
