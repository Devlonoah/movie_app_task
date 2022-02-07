import 'package:bloc/bloc.dart';

import 'package:movie_app_task/data/repository/configuration_repository.dart';

part 'remember_me_state.dart';

class RememberMeCubit extends Cubit<RememberMeState> {
  RememberMeCubit(this.configurationRepository) : super(RememberMeInitial());

  final ConfigurationRepository configurationRepository;

  void checkRememberMeStatus() {
    bool? result = configurationRepository.getRememberMeStatus();

    if (result != null && result == true) {
      emit(RememberMeActive());
    } else {
      emit(RememberMeInActive());
    }
  }
}
