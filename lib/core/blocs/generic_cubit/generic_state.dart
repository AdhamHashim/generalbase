part of 'generic_cubit.dart';

abstract class GenericState<T> extends Equatable {
  final T? data;
  final Failur? failur;

  const GenericState(this.data, this.failur);
}

class GenericInitialState<T> extends GenericState<T> {
  const GenericInitialState(T data) : super(data, null);

  @override
  List<Object> get props => [];
}

class GenericUpdateState<T> extends GenericState<T> {
  const GenericUpdateState(T data) : super(data, null);

  @override
  List<Object> get props => [];
}

class GenericErrorState<T> extends GenericState<T> {
  const GenericErrorState(Failur failur) : super(null, failur);

  @override
  List<Object> get props => [failur!];
}

class GenericInternetState<T> extends GenericState<T> {
  const GenericInternetState(Failur failur) : super(null, failur);

  @override
  List<Object> get props => [failur!];
}
