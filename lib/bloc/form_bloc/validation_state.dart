abstract class ValidationState<T> {
  final T data;

  ValidationState(this.data);
}

class InitialState<T> extends ValidationState<T> {
  InitialState(data) : super(data);
}

class InvalidState<T> extends ValidationState<T> {
  InvalidState(data) : super(data);
}

class ValidState<T> extends ValidationState<T> {
  ValidState(data) : super(data);
}
