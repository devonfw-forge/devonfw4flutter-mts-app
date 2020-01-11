```dart
@override
Widget build(BuildContext context) {
  return RepositoryProvider<RepositoryBundle>(
    //Provide Repositories Globally
    builder: (context) => RepositoryBundle(
      mock: Configuration.useMockData,
      baseUrl: Configuration.baseUrl,
    ),
    child: MyThaiStar(), //Create rest of the widget tree
  );
}
```