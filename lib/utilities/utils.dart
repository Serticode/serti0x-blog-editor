import "package:intl/intl.dart";

class AppUtils {
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
}
