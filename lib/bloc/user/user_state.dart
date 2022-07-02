part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool existUser;
  final String? name;

  const UserState({this.existUser = false, this.name});
}

class UserInitialState extends UserState {
  const UserInitialState() : super(existUser: false, name: null);
}

class UserSetState extends UserState {
  final String name;
  const UserSetState(this.name) : super(existUser: true, name: name);
}
