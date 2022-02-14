import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'remember_me_event.dart';

import '../../data/repository/configuration_repository.dart';

part 'remember_me_state.dart';

class RememberMeBloc extends Bloc<RememberMeStatusEvent, RememberMeState> {
  final ConfigurationRepository configurationRepository;

  RememberMeBloc(this.configurationRepository) : super(RememberMeInitial()) {
    on<RememberMeStatusEvent>((event, emit) {
      print("remember me status cehck start");
      bool? result = configurationRepository.getRememberMeStatus();

      if (result != null && result == true) {
        emit(RememberMeActive());
      } else if (result == null) {
        emit(RememberMeInActive());
      }
      emit(RememberMeInActive());
    });
  }

  // void checkRememberMeStatus() {

  // }
}
