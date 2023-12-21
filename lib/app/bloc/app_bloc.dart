import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  //AppBloc รับ [AuthenticationRepository] เป็น parameter
  //กำหนด [authenticationRepository]  สร้าง instance ของ AppBloc โดยใช้
  //`super` และกำหนด `initialState` โดยตรวจสอบว่ามีผู้ใช้เข้าสู่ระบบหรือไม่
  AppBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    //
    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    //สร้าง Subscription สำหรับตรวจสอบผู้ใช้ใน AuthenticationRepository
    _userSubscription = _authenticationRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  //ใช้ในการจัดการเมื่อผู้ใช้เปลี่ยนแปลงข้อมูล
  void _onUserChanged(_AppUserChanged event, Emitter<AppState> emit) {
    emit(
      event.user.isNotEmpty
          ? AppState.authenticated(event
              .user) //ถ้ามีผู้ใช้ login จะสร้าง Appstate ในสถานะ authenticated พร้อมกับข้อมูลผู้ใช้
          : const AppState
              .unauthenticated(), //ถ้าไม่มีผู้ใช้ login  จะสร้าง Appstate ในสถานะ unauthenticated
    );
  }

  //ใข้ในการจัดการเมื่อผู้ใช้ขอ logout

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_authenticationRepository
        .logOut()); //เรียกใช้เมธอด logOut() จาก AuthenticationRepository เพื่อทำการล็อกเอ้าท์
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
