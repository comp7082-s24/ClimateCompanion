class Constants {
  static const String onBoardingWelcomeTitle = "Hello and welcome";
  static const String onBoardingWelcomeMessage =
      "Please provide the following information to assist ClimateCompanion in understanding you better and delivering more tailored results";
  static const String deleteProfileDialogTitle = "Delete Profile";
  static const String deleteProfileDialogMessage = "Are you sure you want to delete your profile? This action cannot be undone.";
  static const String cancelButtonTitle = "Cancel";
  static const String deleteButtonTitle = "Delete";
  static const String deleteProfileButtonTitle = "Delete Profile";
  static const String reSuggestButtonTitle = "Re-Suggest";
  static const String suggestionSavedDialogMessage = "Would you like me to come up with something else?";
  static const String suggestionSavedSnackBarMessage = "Suggestion saved successfully";
  static const String suggestionRemovedSnackBarMessage = "Suggestion removed successfully";
  static const String saveButtonTitle = "Save";
  static const String updateProfileButtonTitle = "Update Profile";
  static const String noFavouritesMessage = "No favorites yet.";
  static const String updateProfileHeaderMessage = "Okay, let's update your profile!";
  static const String ccAiSuggestMessage = "Hey CC, got any activities for me?";
  static const String createdByMessage = "Created with ❤️ at BCIT";

  static String prompt(final String areaName, final String country, final String weatherDescription, {final bool isRePrompt = false}) {
    return "Give me a list of ${isRePrompt ? "" : "another"} 3 of activities to do in $areaName located in Country Code ($country) when "
        "the weather is "
        "$weatherDescription. Return the response as a json object containing a title and a description with a max of 50 characters";
  }

  static String aiSuggestHeaderMessage(final String areaName, final String weatherDescription) {
    return "I found some activities you might like, perfect for $weatherDescription in $areaName!";
  }

  static const String aiSuggestRetryMessage = "Would you like me to come up with something else?";
  static const String aiSuggestErrorMessage = "I'm sorry, I couldn't find any activities for you. Please try again later.";
}
