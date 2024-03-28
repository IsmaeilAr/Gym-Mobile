class ApiConstants {
  // static const String serverUrl = "http://91.144.20.117:7770/"; // public
  static const String serverUrl = "http://192.168.2.138:808/"; // local
  static const String baseUrl = "${serverUrl}api/";
  static const String imageUrl = "${serverUrl}uploads/images/";
  static const String pdfUrl = "${serverUrl}uploads/programs/";

  static const String loginUrl = "${baseUrl}login";
  static const String logoutUrl = "${baseUrl}logout";
  static const String initStatusUrl = "${baseUrl}status";
  static const String activePlayersUrl = "${baseUrl}activePlayers";
  static const String getMyProfileInfoUrl = "${baseUrl}showPlayer";
  static const String addInfoUrl = "${baseUrl}addInfo";
  static const String editInfoUrl = "${baseUrl}updateUserInfo";
  static const String editMetricsUrl = "${baseUrl}updateInfo";
  static const String getChatsUrl = "${baseUrl}listChat";
  static const String checkInUrl = "${baseUrl}storeUserTime";
  static const String storeTimeUrl = "${baseUrl}storeTime";
  static const String checkOutUrl = "${baseUrl}endCounter";
  static const String weeklyUrl = "${baseUrl}weekly";
  static const String monthlyUrl = "${baseUrl}monthly";
  static const String programProgressUrl = "${baseUrl}programCommitment";
  static const String sendMessageUrl = "${baseUrl}sendMessage";
  static const String setRateUrl = "${baseUrl}setRate";
  static const String submitReportUrl = "${baseUrl}report";
  static const String programSearchUrl = "${baseUrl}programSearch";
  static const String setProgramUrl = "${baseUrl}selectProgram";
  static const String userSearchUrl = "${baseUrl}userSearch";
  static const String getArticlesUrl = "${baseUrl}allArticle";
  static const String addArticleUrl = "${baseUrl}addArticle";

  static const String requestCoachUrl = "${baseUrl}addOrder";

  static const String acceptOrderUrl = "${baseUrl}acceptOrder";
  static const String getNotificationsUrl = "${baseUrl}listNotification";

  static String getProfileInfoUrl(
    int userId,
  ) {
    return "${baseUrl}playerInfo/$userId";
  }

  static String getPersonMetricsUrl(
    int userId,
  ) {
    return "${baseUrl}showInfo/$userId";
  }

  static String chatMessagesUrl(
    int userId,
  ) {
    return "${baseUrl}showChat/$userId";
  }

  static String allProgramsUrl(
    String type,
    int categoryID,
  ) {
    return "${baseUrl}showProgram?type=$type&categoryId=$categoryID";
  }

  static String premiumProgramsUrl(
    String type,
  ) {
    return "${baseUrl}getPrograms?type=$type";
    // return "${baseUrl}getPrograms?categoryId=1&programType=private&type=$type";
  }

  static String allCategoriesUrl(
    String type,
  ) {
    return "${baseUrl}getCategories?type=$type";
  }

  static String myProgramsUrl(
    String type,
  ) {
    return "${baseUrl}myprogram?type=$type";
  }

  static String requestProgramUrl(
    int coachId,
  ) {
    return "${baseUrl}requestPrograme?coachId=$coachId";
  }

  static String getMyOrderUrl(
    String genre,
  ) {
    return "${baseUrl}getMyOrder?type=$genre";
  }

  static String cancelOrderUrl(
    int orderId,
  ) {
    return "${baseUrl}cancle$orderId";
  }

  static String assignUrl(
    int programId,
  ) {
    return "${baseUrl}asignprogram/$programId";
  }

  static String showCoachTimeUrl(
    int coachId,
  ) {
    return "${baseUrl}showCoachTime/$coachId";
  }

  static String unSetCoach(
    int coachId,
  ) {
    return "${baseUrl}unAssign/$coachId";
  }

  static String showCoachInfoUrl(
    int coachId,
  ) {
    return "${baseUrl}showCoachInfo/$coachId";
  }

  static String getUserListUrl(
    String type,
  ) {
    return "${baseUrl}show$type";
  }

  static String deleteMessageUrl(
    int messageID,
  ) {
    return "${baseUrl}deleteMessage/$messageID";
  }

  static String deleteArticleUrl(
    int articleID,
  ) {
    return "${baseUrl}deleteArticle/$articleID";
  }

  static String favArticleUrl(
    int articleID,
  ) {
    return "${baseUrl}makeFavourite/$articleID";
  }

  static String getCoachArticlesUrl(
    int coachId,
  ) {
    return "${baseUrl}coachArticle/$coachId";
  }

  static String deleteRateUrl(
    int rateId,
  ) {
    return "${baseUrl}deleteRate?id=/$rateId";
  }
}
