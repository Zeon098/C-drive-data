String getMonthInGerman(String month) {
  switch (month.toLowerCase()) {
    case "january":
      return "Januar";
    case "february":
      return "Februar";
    case "march":
      return "März";
    case "april":
      return "April";
    case "may":
      return "Mai";
    case "june":
      return "Juni";
    case "july":
      return "Juli";
    case "august":
      return "August";
    case "september":
      return "September";
    case "october":
      return "Oktober";
    case "november":
      return "November";
    case "december":
      return "Dezember";
    default:
      return "Januar";
  }
}
