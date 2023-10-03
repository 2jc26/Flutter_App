import "package:flutter/material.dart";
import "package:giusseppe_flut/screens/sign_up.dart";
import "package:giusseppe_flut/screens/user_list.dart";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffDAE3E5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(), // Call the _page() method to display the icon
      ),
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
              const SizedBox(height: 50),
              _inputField("E-mail", usernameController),
              const SizedBox(height: 20),
              _inputField("Password", passwordController, isPassword: true),
              const SizedBox(height: 50),
              _loginButton(),
              const SizedBox(height: 20),
              _extraText(),
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

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFC4C4C4)),
    );
    return TextField(
      style: const TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFFC4C4C4)),
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: const Color(0XffEBEDF0),
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserList()),
        );
        debugPrint("Username: ${usernameController.text}");
        debugPrint("Password: ${passwordController.text}");
      },
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
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
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
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ElevatedButton(
        onPressed: () {
          // Handle navigation here, e.g., go to the sign-up page
          // Replace 'YourSignUpRoute' with the actual route for sign-up
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignUp(),
            ),
          );
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
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
}
