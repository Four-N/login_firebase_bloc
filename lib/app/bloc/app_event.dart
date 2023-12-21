part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

///แจ้งกับ bloc ว่า user ปัจจุบันต้องการที่จะขอ logout
final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();

  @override
  List<Object?> get props => [];
}

///แจ้งกับ bloc ว่า user ปัจจุบัน ถูกเปลี่ยน
final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);

  final User user;

  @override
  List<Object?> get props => [];
}
