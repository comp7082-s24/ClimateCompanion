import "package:climate_companion/constants.dart";
import "package:flutter/material.dart";

class DeleteProfileButton extends StatelessWidget {
  final void Function() onPressed;

  const DeleteProfileButton({super.key, required this.onPressed});

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (final BuildContext context) {
            return AlertDialog(
              title: Text(
                Constants.deleteProfileDialogTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              content: Text(
                Constants.deleteProfileDialogMessage,
                style: Theme.of(context).textTheme.titleSmall,
              ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          Constants.deleteProfileButtonTitle,
          style: Theme.of(context).primaryTextTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.error),
        ),
      ),
    );
  }
}
