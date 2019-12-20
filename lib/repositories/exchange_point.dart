///Use-case independant interface that exchanges 
///[Input] for [Output] asynchronously
abstract class ExchangePoint<Input, Output> {

  ///Exchange one [Input] for a [Future<Output>]
  Future<Output> post(Input input);
}
