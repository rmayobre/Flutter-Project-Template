import 'analytics.dart';

class OfflineAnalytics implements Analytics {

  @override
  void send({
    required String event,
    Map<String, dynamic>parameters = const {}
  }) {}

  @override
  void setPage(String name, String widgetName) {}

  @override
  void setUserId(String? id) {}

}