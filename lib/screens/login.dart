import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:giusseppe_flut/auth/auth_cubit.dart";
import "package:giusseppe_flut/auth/auth_repository.dart";
import "package:giusseppe_flut/auth/form_submission_status.dart";
import "package:giusseppe_flut/auth/login/login_block.dart";
import "package:giusseppe_flut/auth/login/login_event.dart";
import "package:giusseppe_flut/auth/login/login_state.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool exception = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffDAE3E5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: _page(),
        )
      ) // Call the _page() method to display the icon
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              const SizedBox(height: 50),
              _icon(),
              const SizedBox(height: 20),
              _begainText(),
              _otherTexr(),
              _loginForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Senehouse",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.person,
        size: 100,
        color: Colors.black,
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed && exception) {
            _showSnackBar(context, formStatus.exception.toString());
            exception = false;
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _usernameField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 50),
                _loginButton(),
                const SizedBox(height: 20),
                _extraText(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
            ),
            filled: true,
            fillColor: const Color(0XffEBEDF0),
            // icon: const Icon(Icons.person),
            hintText: 'E-mail',
          ),
          validator: (value) =>
              state.isValidUsername ? null : 'E-mail is invalid',
          onChanged: (value) {
            context.read<LoginBloc>().add(LoginUsernameChanged(username: value));
            usernameController.text = value;
          },
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
          ),
          filled: true,
          fillColor: const Color(0XffEBEDF0),
          // icon: const Icon(Icons.lock),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is to short',
        onChanged: (value) {
          context.read<LoginBloc>().add(LoginPasswordChanged(password: value));
          passwordController.text = value;
        },
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xFF2E5EAA),
                foregroundColor: const Color(0xFFF2F4F6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 10,
                shadowColor: Colors.black,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  exception = true;
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: const Text('Login'),
            );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error in the Login"),
          content: message.contains("Login fallido")
              ? const Text(
                  'It seems that the credentials you have entered are incorrect. Please review your data and try again')
              : Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _begainText() {
    return const Text(
      "Join us",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 40, color: Color(0xFF1E1E1E), fontWeight: FontWeight.bold),
    );
  }

  Widget _otherTexr() {
    return const Text(
      "Size your life",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, color: Color(0xFF1E1E1E), fontWeight: FontWeight.bold),
    );
  }

  Widget _extraText() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              if (context.read<LoginBloc>().authRepo.connectivity) {
                context.read<AuthCubit>().showSignUp();
              } else {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("No hay Conexión a una red"),
                      content: const Text(
                        'En este momento no hay conexión a internet. Está función solo funciona con conexión a internet, intente de nuevo más tarde.'
                      ),
                      actions: <Widget>[
                        TextButton (
                          child: const Text('Cerrar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0, // Remove button elevation
            ),
            child: const Text(
              "Don't have an account?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "Forget Details?",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    });
  }
}
