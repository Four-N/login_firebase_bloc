import 'package:flutter/widgets.dart';
import 'package:login_firebase_bloc/app/bloc/app_bloc.dart';
import 'package:login_firebase_bloc/home/view/home_page.dart';
import 'package:login_firebase_bloc/login/view/login_page.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
