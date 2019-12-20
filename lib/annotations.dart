///Marks a top-level Widget class
///
///Top-level in this context means it defines the
///Page layout of a given feature.
///Search for it if and read the doc comments of the 
///related classes if you want to get a high-level understanding
///of the supported features.
class TopLevelRoute{
  ///The route member is not set for any logic based reason, 
  ///it's just a form of documentaion
  final String route;
  const TopLevelRoute(this.route);
}

///Used to annotate a class that is related to not fully implemented feature
///
///This annotation makes un-implemented parts of the App
///easy to find incase the project will be further developed in the future
class _NotFullyImplemented{
  const _NotFullyImplemented();
}

///Marks a class that is related to not fully implemented feature
///
///this const enables using the annotation in this style:
///````dart
///@notFullyImplemented
///class Name{}
///````
///instead of this style:
///````dart
///@NotFullyImplemented()
///class Name{}
///````
const _NotFullyImplemented notFullyImplemented = const _NotFullyImplemented();