class FavoriteActivity {
  final String title;
  final String description;
  final String weatherDescription;

  FavoriteActivity({
    required this.title,
    required this.description,
    required this.weatherDescription,
  });

  factory FavoriteActivity.fromJson(final Map<String, dynamic> json) {
    return FavoriteActivity(
      title: json["title"] as String,
      description: json["description"] as String,
      weatherDescription: json["weatherDescription"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "weatherDescription": weatherDescription,
    };
  }
}
