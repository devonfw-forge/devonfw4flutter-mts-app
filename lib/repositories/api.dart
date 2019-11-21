abstract class Api<Input, Output> {
  Future<Output> post(Input input);
}
