import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:login_firebase_bloc/login/cubit/login_cubit.dart';
import 'package:login_firebase_bloc/signup/view/signup_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure')));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/bloc_logo_small.png',
                height: 120,
              ),
              const SizedBox(
                height: 16,
              ),
              const _EmailInput(),
              const SizedBox(
                height: 8,
              ),
              const _PasswordInput(),
              const SizedBox(
                height: 8,
              ),
              const _LoginButton(),
              const SizedBox(
                height: 8,
              ),
              const _GoogleLoginButton(),
              const SizedBox(
                height: 4,
              ),
              const _SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  // ignore: unused_element
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previons, current) => previons.email != current.email,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_emailInput_textFirld'),
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'email',
              helperText: '',
              errorText:
                  state.email.displayError != null ? 'invalid email' : null,
            ),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  // ignore: unused_element
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previons, current) => previons.password != current.password,
        builder: (context, state) {
          return TextField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              helperText: '',
              errorText: state.password.displayError != null
                  ? ' invalid password'
                  : null,
            ),
          );
        });
  }
}

class _LoginButton extends StatelessWidget {
  // ignore: unused_element
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
              key: const Key('loginForm_continue_raiseButtom'),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFFFFD600)),
              onPressed: state.isValid
                  ? () => context.read<LoginCubit>().logInWithCredentials()
                  : null,
              child: const Text('LOGIN'));
    });
  }
}

class _GoogleLoginButton extends StatelessWidget {
  // ignore: unused_element
  const _GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
        key: const Key('loginForm_googloLogin_raisedButton'),
        onPressed: () => context.read<LoginCubit>().logInWithGoogle(),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: theme.colorScheme.secondary),
        icon: const Icon(
          FontAwesomeIcons.google,
          color: Colors.white,
        ),
        label: const Text(
          'SING IN WITH GOOGLE',
          style: TextStyle(color: Colors.white),
        ));
  }
}

class _SignUpButton extends StatelessWidget {
  // ignore: unused_element
  const _SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
        onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
        child: Text(
          'CREATE ACCOUNT',
          style: TextStyle(color: theme.primaryColor),
        ));
  }
}
