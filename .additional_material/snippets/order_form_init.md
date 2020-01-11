```dart
class _OrderFormButtonsState extends State<OrderFormButtons> {
  OrderBloc _orderBloc;

  @override
  void initState() {
    _orderBloc = OrderBloc(
      currentOrderBloc: BlocProvider.of<CurrentOrderBloc>(context),
      orderService: RepositoryProvider.of<RepositoryBundle>(context).order,
    );
    
    _setUpOrderResponses(_orderBloc);
    super.initState();
  }

  ...
}
```