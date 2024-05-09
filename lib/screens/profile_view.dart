import "package:flutter/cupertino.dart";
import "package:go_router/go_router.dart";

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
    required final GoRouterState goRouterState,
  });

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text("Profile View"),
    );
  }
}
