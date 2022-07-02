part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class ActivateNameUser extends UserEvent {
  final String name;
  ActivateNameUser(this.name);
}

class DeleteUser extends UserEvent {}
