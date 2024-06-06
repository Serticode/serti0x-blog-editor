//!
class AppStrings {
  AppStrings._internal();
  static AppStrings? _instance;

  static AppStrings get instance {
    _instance ??= AppStrings._internal();
    return _instance!;
  }

  //! FOR THE DEV
  final String appName = "Serti0x Blog.";
  final String developerName = "Serticode.";
  final String githubURL = "https://github.com/Serticode";

  //! FONT FAMILY
  final String fontFamily = "Eudoxus Sans";

  //! IN APP PUBLIC KEYS
  final String appThemeKey = "appThemeKey";

  //!
  //!
  //! ICONS
  final String moon = "moon";
  final String sun = "sun";
  final String codeLogo = "codeLogo";
  final String verticalLines = "verticalLines";
  final String backDrop = "backdrop";
  final String footerImage = "footerImage";

  //!
  //!
  //! REGULAR WORDS
  final String theFuture = "The Future of Blogs.";
  final String theFutureRider =
      "Write, organize and share information collaboratively.";
  final String soMuchMore = "So Much More Than A Note Taking Dashboard";
  final String welcome = "Welcome to Serti's Blog.";
  final String welcomeRider =
      "Work together in real time, organize information \nand create a learning note from your experience.";
  final String contactMe = "Contact Me 🙈.";
  final String preview = "Preview";

  //! SOCKET REPO STRINGS
  String join = "join";
  String isTyping = "typing";
  String autoSave = "save";
  String changes = "changes";

  //! AUTH
  String login = "Login 🙈";
}
