import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:framework/analytics.dart';

class ToolboxAnalytics implements Analytics {

  ToolboxAnalytics._(this._analytics);

  ToolboxAnalytics({FirebaseAnalytics? firebaseAnalytics})
      : this._(firebaseAnalytics ?? FirebaseAnalytics.instance);

  /// Applies default parameters to the firebase analytics.
  factory ToolboxAnalytics.defaultParameters({
    required Map<String, dynamic> parameters
  }) {
    var analytics = FirebaseAnalytics.instance;
    analytics.setDefaultEventParameters(parameters);
    return ToolboxAnalytics(firebaseAnalytics: analytics);
  }

  final FirebaseAnalytics _analytics;

  @override
  void send({required String event, Map<String, dynamic>? parameters}) {
    _analytics.logEvent(name: event, parameters: parameters);
  }

  @override
  void setPage(String name, String widgetName) {
    _analytics.setCurrentScreen(screenName: name, screenClassOverride: widgetName);
  }

  @override
  void setUserId(String? id) {
    _analytics.setUserId(id: id);
  }
}