// Capitalize the first letter of each word in a string
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

// Fetches the link to the weather icon
String fetchWeatherIcon(final String icon) {
  return "http://openweathermap.org/img/w/$icon.png";
}
