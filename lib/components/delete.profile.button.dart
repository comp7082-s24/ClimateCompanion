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
              title: const Text("Delete Profile"),
              content: const Text("Are you sure you want to delete your profile? This action cannot be undone."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    onPressed();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Delete"),
                ),
              ],
            );
          },
        );
      },
      child: const Text("Delete Profile",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
    );
  }
}
