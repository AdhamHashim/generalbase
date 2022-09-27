import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:generalbase/core/network/models/failur.dart';

part 'generic_state.dart';

class GenericBloc<T> extends Cubit<GenericState<T>> {
  GenericBloc(T data) : super(GenericInitialState<T>(data));

  onUpdateData(T data) {
    emit(GenericUpdateState<T>(data));
  }

  onUpdateToInitState(T data) {
    emit(GenericInitialState<T>(data));
  }

  onUpdateError(Failur failur) {
    emit(GenericErrorState<T>(failur));
  }

  onUpdateInternetError(Failur failur) {
    emit(GenericInternetState<T>(failur));
  }
}
