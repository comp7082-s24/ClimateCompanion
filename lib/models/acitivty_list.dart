class ActivityList {
  final List<Activity> activities;

  ActivityList({required this.activities});

  factory ActivityList.fromJson(final List<dynamic> json) {
    final List<Activity> activities = json.map((final activity) => Activity.fromJson(activity as Map<String, dynamic>)).toList();
    return ActivityList(activities: activities);
  }
}

class Activity {
  final String title;
  final String description;

  Activity({required this.title, required this.description});

  factory Activity.fromJson(final Map<String, dynamic> json) {
    return Activity(
      title: json["title"] as String,
      description: json["description"] as String,
    );
  }
}