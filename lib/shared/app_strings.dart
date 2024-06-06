//!
class AppStrings {
  AppStrings._internal();
  static AppStrings? _instance;

  static AppStrings get instance {
    _instance ??= AppStrings._internal();
    return _instance!;
  }

  //! SOCKET REPO STRINGS
  String join = "join";
  String isTyping = "typing";
  String autoSave = "save";
  String changes = "changes";
}
