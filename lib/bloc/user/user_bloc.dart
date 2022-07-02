import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:pokedex_prueba__tecnica/services/storage_services.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    on<ActivateNameUser>((event, emit) async {
      final storage = StorageServices();
      await storage.setUser(event.name);
      emit(UserSetState(event.name));
    });

    on<DeleteUser>(
      (event, emit) async {
        const storage = FlutterSecureStorage();
        await storage.delete(key: 'name');
        emit(const UserInitialState());
      },
    );
  }
}
