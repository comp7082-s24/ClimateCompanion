import "package:climate_companion/constants.dart";
import "package:flutter/material.dart";

class DeleteProfileButton extends StatelessWidget {
  final void Function() onPressed;

  const DeleteProfileButton({super.key, required this.onPressed});

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (final BuildContext context) {
            return AlertDialog(
              title: const Text(Constants.deleteProfileDialogTitle),
              content: const Text(Constants.deleteProfileDialogMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(Constants.cancelButtonTitle),
                ),
                TextButton(
                  onPressed: () {
                    onPressed();
                    Navigator.of(context).pop();
                  },
                  child: const Text(Constants.deleteButtonTitle),
                ),
              ],
            );
          },
        );
      },
      child: const Text(
        Constants.deleteProfileButtonTitle,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
