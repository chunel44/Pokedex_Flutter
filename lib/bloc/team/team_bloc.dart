import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'team_event.dart';
part 'team_state.dart';

class TeamBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamBloc() : super(TeamsInitialState()) {
    on<TeamsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
