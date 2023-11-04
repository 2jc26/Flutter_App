import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:giusseppe_flut/auth/auth_cubit.dart";
import "package:giusseppe_flut/auth/auth_repository.dart";
import "package:giusseppe_flut/auth/form_submission_status.dart";
import "package:giusseppe_flut/auth/sign_up/sign_up_block.dart";
import "package:giusseppe_flut/auth/sign_up/sign_up_event.dart";
import "package:giusseppe_flut/auth/sign_up/sign_up_state.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  final String title = 'Sign Up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController generoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  String rolController = "Renter";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffDAE3E5),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: const Color(0xFF2E5EAA),
            title: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            centerTitle: true,
          ),
          body: BlocProvider(
            create: (context) => SignUpBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
            child: _page(),
          )),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _signUpForm(),
        ],
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "I'm a",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2c595b),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 4,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  rolController = "Renter";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.person,
                                      color: Color(0xFF2c595b),
                                      size: 60,
                                    ),
                                  ),
                                  Text(
                                    "Renter",
                                    style: TextStyle(
                                      color: Color(0xFF2c595b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 4,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  rolController = "Landlord";
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.home,
                                      color: Color(0xFF2c595b),
                                      size: 60,
                                    ),
                                  ),
                                  Text(
                                    "Landlord",
                                    style: TextStyle(
                                      color: Color(0xFF2c595b),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        _usernameField(),
                        const SizedBox(height: 20),
                        _passwordField(),
                        const SizedBox(height: 20),
                        _fullnameField(),
                        const SizedBox(height: 20),
                        _ageField(),
                        const SizedBox(height: 20),
                        _phoneField(),
                        const SizedBox(height: 20),
                        _generoField(),
                        const SizedBox(height: 20),
                        _cityField(),
                        const SizedBox(height: 20),
                        _localityField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _signUpButton(),
                        const SizedBox(height: 20),
                        _extraText(context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            hintText: 'Username',
          ),
          maxLength: 16,
          validator: (value) =>
              state.isValidUsername ? null : 'Username is invalid',
          onChanged: (value) {
            context
                .read<SignUpBloc>()
                .add(SignUpEmailChanged(email: value));
            usernameController.text = value;
          },
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
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
          hintText: 'Password',
        ),
        maxLength: 50,
        validator: (value) =>
            state.isValidPassword ? null : 'Password is to short',
        onChanged: (value) {
          context
              .read<SignUpBloc>()
              .add(SignUpPasswordChanged(password: value));
          passwordController.text = value;
        },
      );
    });
  }

  Widget _fullnameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            hintText: 'Fullname',
          ),
          maxLength: 50,
          validator: (value) =>
              state.isValidFullName ? null : 'Fullname is invalid',
          onChanged: (value) {
            context
                .read<SignUpBloc>()
                .add(SignUpFullNameChanged(fullname: value));
            fullnameController.text = value;
          },
        );
      },
    );
  }

  Widget _ageField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
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
            hintText: 'Age',
          ),
          maxLength: 2,
          onChanged: (value) {
            context.read<SignUpBloc>().add(
                SignUpAgeChanged(age: value.isEmpty ? 0 : int.parse(value)));
            ageController.text = value;
          },
        );
      },
    );
  }

  Widget _phoneField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
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
            hintText: 'Phone Number',
          ),
          maxLength: 10,
          validator: (value) => state.isValidPhone ? null : 'Phone is invalid',
          onChanged: (value) {
            context.read<SignUpBloc>().add(SignUpPhoneChanged(phone: value));
            phoneController.text = value;
          },
        );
      },
    );
  }


  Widget _generoField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            hintText: 'Genre',
          ),
          maxLength: 20,
          onChanged: (value) {
            context.read<SignUpBloc>().add(SignUpGeneroChanged(genero: value));
            generoController.text = value;
          },
        );
      },
    );
  }

  Widget _cityField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            hintText: 'city',
          ),
          maxLength: 20,
          validator: (value) => state.isValidCity ? null : 'City is invalid',
          onChanged: (value) {
            context.read<SignUpBloc>().add(SignUpCityChanged(city: value));
            cityController.text = value;
          },
        );
      },
    );
  }

  Widget _localityField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
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
            hintText: 'Locality',
          ),
          maxLength: 50,
          validator: (value) =>
              state.isValidLocality ? null : 'Locality is invalid',
          onChanged: (value) {
            context
                .read<SignUpBloc>()
                .add(SignUpLocalityChanged(locality: value));
            localityController.text = value;
          },
        );
      },
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
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
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: const Text('Sign Up'),
            );
    });
  }

  Widget _extraText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().showLogin();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove button elevation
          ),
          child: const Text(
            "Already have an account? Login",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      dismissDirection: DismissDirection.down,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
