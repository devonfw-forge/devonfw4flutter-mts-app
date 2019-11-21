abstract class ExchangePoint<Input, Output> {
  Future<Output> post(Input input);
}
