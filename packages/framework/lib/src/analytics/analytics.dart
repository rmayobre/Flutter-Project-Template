import 'offline_analytics.dart';

abstract class Analytics {

  factory Analytics.offline() {
    return OfflineAnalytics();
  }

  /// Setting [id] to null will remove the user from analytics.
  void setUserId(String? id);

  /// Inform analytics what page the user is currently viewing.
  void setPage(String name, String widgetName);

  /// Send a custom event to analytics.
  void send({required String event, Map<String, dynamic> parameters = const {}});
}