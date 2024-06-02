extension StringCasingExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(" ").map((final word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(" ");
  }
}
