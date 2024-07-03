import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:serti0x_blog_editor/services/models/article_model.dart";
import "package:serti0x_blog_editor/shared/constants/app_colours.dart";

class AppUtils {
  //!
  static String formatDateTime({
    required DateTime theDate,
  }) {
    //! GET WEEK DAY
    String dayOfWeek = DateFormat("EEE").format(theDate);

    //! GET DAY OF THE MONTH
    String dayOfMonth = DateFormat("d").format(theDate);

    //! CREATE THE SUFFIX
    String suffix;
    if (dayOfMonth.endsWith("1") && dayOfMonth != "11") {
      suffix = "st";
    } else if (dayOfMonth.endsWith("2") && dayOfMonth != "12") {
      suffix = "nd";
    } else if (dayOfMonth.endsWith("3") && dayOfMonth != "13") {
      suffix = "rd";
    } else {
      suffix = "th";
    }

    //! GET MONTH AND YEAR
    String monthYear = DateFormat("MMMM yyyy").format(theDate);

    //! GET THE TIME
    String time = DateFormat("h:mma").format(theDate).toUpperCase();

    //! DESIRED STRING
    return "$dayOfWeek / $monthYear $dayOfMonth$suffix / $time";
  }

  //!
  //!
  static Color getArticleCategoryBGColour({
    required ArticleModel currentArticle,
  }) {
    const coloursInstance = AppColours.instance;

    final category = getArticleCategory(categoryName: currentArticle.category!);

    switch (category) {
      case ArticleCategory.backEnd:
        return coloursInstance.purple.withOpacity(0.1);
      case ArticleCategory.frontEnd:
        return coloursInstance.peach.withOpacity(0.1);
      case ArticleCategory.gist:
        return coloursInstance.blue.withOpacity(0.1);
      default:
        return coloursInstance.grey900.withOpacity(0.1);
    }
  }

  //!
  //!
  static Color getArticleCategoryColour({
    required ArticleModel currentArticle,
  }) {
    const coloursInstance = AppColours.instance;

    final category = getArticleCategory(categoryName: currentArticle.category!);

    switch (category) {
      case ArticleCategory.backEnd:
        return coloursInstance.purple;
      case ArticleCategory.frontEnd:
        return coloursInstance.peach;
      case ArticleCategory.gist:
        return coloursInstance.blue;
      default:
        return coloursInstance.grey900;
    }
  }

  //!
  //!
  MaterialColor getMaterialColour({
    required Color theColour,
  }) {
    final int red = theColour.red;
    final int green = theColour.green;
    final int blue = theColour.blue;
    final int alpha = theColour.alpha;

    final Map<int, Color> shades = {
      50: Color.fromARGB(alpha, red, green, blue),
      100: Color.fromARGB(alpha, red, green, blue),
      200: Color.fromARGB(alpha, red, green, blue),
      300: Color.fromARGB(alpha, red, green, blue),
      400: Color.fromARGB(alpha, red, green, blue),
      500: Color.fromARGB(alpha, red, green, blue),
      600: Color.fromARGB(alpha, red, green, blue),
      700: Color.fromARGB(alpha, red, green, blue),
      800: Color.fromARGB(alpha, red, green, blue),
      900: Color.fromARGB(alpha, red, green, blue),
    };

    return MaterialColor(theColour.value, shades);
  }
}
