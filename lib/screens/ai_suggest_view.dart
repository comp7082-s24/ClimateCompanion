import "package:flutter/cupertino.dart";
import "package:go_router/go_router.dart";

class AiSuggestView extends StatelessWidget {
  const AiSuggestView({
    super.key,
    required final GoRouterState goRouterState,
  });

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text("AI Suggest View"),
    );
  }
}
