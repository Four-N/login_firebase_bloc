import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase_bloc/app/bloc/app_bloc.dart';
// import 'package:login_firebase_bloc/app/bloc/app_bloc.dart';
import 'package:login_firebase_bloc/edit_todo/view/edit_todo_page.dart';
import 'package:login_firebase_bloc/home/cubit/home_cubit.dart';
import 'package:login_firebase_bloc/stats/view/stats_page.dart';
import 'package:login_firebase_bloc/todos_overview/view/todo_overview_page.dart';
// import 'package:login_firebase_bloc/l10n/l10n.dart';
// import 'package:login_firebase_bloc/todos_overview/widget/todos_overview_filter_button.dart';
// import 'package:login_firebase_bloc/todos_overview/widget/todos_overview_option_button.dart';
// import 'package:login_firebase_bloc/home/widget/avatar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);

    // print(selectedTab);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(l10n.todosOverviewAppBarTitle),
      //   actions: <Widget>[
      //     IconButton(
      //       key: const Key('homePage_logout_iconButton'),
      //       icon: const Icon(Icons.exit_to_app),
      //       onPressed: () {
      //         context.read<AppBloc>().add(const AppLogoutRequested());
      //       },
      //     ),
      //   ],
      // ),
      body: IndexedStack(
        index: selectedTab.index,
        children: const [TodosOverviewPage(), StatsPage()],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        key: const Key('homeView_addTodo_floatingActionButton'),
        onPressed: () => Navigator.of(context).push(EditTodoPage.route()),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.todos,
                icon: const Icon(Icons.list_rounded)),
            _HomeTabButton(
                groupValue: selectedTab,
                value: HomeTab.stats,
                icon: const Icon((Icons.show_chart_rounded))),
            IconButton(
              key: const Key('homePage_logout_iconButton'),
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    required this.groupValue,
    required this.value,
    required this.icon,
  });

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeCubit>().setTab(value),
      iconSize: 32,
      color:
          groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
