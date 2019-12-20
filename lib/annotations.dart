///Marks a top-level Widget class
///
///Top-level in this context means it defines the
///Page layout of a given feature.
///Search for it if and read the doc comments of the 
///related classes if you want to get a high-level understanding
///of the supported features.
class TopLevelRoute{
  final String route;
  const TopLevelRoute(this.route);
}

///Marks a class that is related to not fully implemented feature
///
///This annotation makes un-implemented parts of the App
///easy to find incase the project will be further developed in the future
class NotFullyImplemented{
  const NotFullyImplemented();
}