part of 'team_bloc.dart';

abstract class TeamsState extends Equatable {
  final List<Map<String, dynamic>> teamList;
  const TeamsState({required this.teamList});

  @override
  List<Object> get props => [teamList];
}

class TeamsInitialState extends TeamsState {
  TeamsInitialState()
      : super(
          teamList: [
            {'nombre': '', 'team': null}
          ],
        );
}
