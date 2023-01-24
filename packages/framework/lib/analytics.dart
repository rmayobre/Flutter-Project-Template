library analytics;

abstract class Analytics {

  factory Analytics.offline() {
    return _OfflineAnalytics();
  }

  /// Setting [id] to null will remove the user from analytics.
  void setUserId(String? id);

  /// Inform analytics what page the user is currently viewing.
  void setPage(String name, String widgetName);

  /// Send a custom event to analytics.
  void send({required String event, Map<String, dynamic> parameters = const {}});
}

class _OfflineAnalytics implements Analytics {

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