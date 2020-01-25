```dart
///Marks a top-level Widget class
///
///Top-level in this context means it defines the
///Page layout of a given feature.
///Search for it and read the doc comments of the 
///related classes if you want to get a high-level understanding
///of the supported features.
class TopLevelRoute{
  ///The route member is not set for any logic based reason, 
  ///it's just a form of documentaion
  final String route;
  const TopLevelRoute(this.route);
}

///Provides a set of constant values that are used for configuration
@immutable
class Configuration {
  //localhost for AVD: http://10.0.2.2:8082/
  static final String baseUrl = "http://138.197.218.225:8082/";
  static final bool useMockData = false;
  static final bool logging = true;
  static final int defaultTimeOut = 5; //In Seconds
}

```