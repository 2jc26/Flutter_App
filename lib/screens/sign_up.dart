import "package:flutter/material.dart";
import "package:giusseppe_flut/screens/roomie_detail.dart";
import "package:giusseppe_flut/widgets/drawer.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key, required this.title});

  final String title;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ocupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffDAE3E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First Component: Container with Blue Margin and Buttons
            // Container(margin: const EdgeInsets.all(
            //       20.0),
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.blue,
            //       width: 2.0,
            //     ),
            //   ),
            //   child: Ink.image(
            //     image: const AssetImage("assets/images/Renter.svg"),
            //     height: 200,
            //     width: 200,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(
                  20.0),
              decoration: BoxDecoration(
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
                    _inputField("Name", nameController),
                    const SizedBox(height: 20),
                    _inputField("Lastname", passwordController),
                    const SizedBox(height: 20),
                    _inputField("E-mail", emailController),
                    const SizedBox(height: 20),
                    _inputField("Age", ageController),
                    const SizedBox(height: 20),
                    _inputField(
                      "Ocupation",
                      ocupationController,
                    ),
                    const SizedBox(height: 20),
                    _inputField("Password", passwordController,
                        isPassword: true),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(
                  20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _loginButton(),
                  ],
                ),
              ),
            )
          ],
        ),
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
      style: const TextStyle(color: Color(0XFF2C595B)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF2C595B)),
        enabledBorder: border,
        focusedBorder: border,
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: isPassword,
    );
  }

  Widget _loginButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyScrollView()),
                  );
        debugPrint("Name: ${nameController.text}");
        debugPrint("Password: ${passwordController.text}");
        debugPrint("Lastname: ${lastnameController.text}");
        debugPrint("E-mail: ${emailController.text}");
        debugPrint("Age: ${ageController.text}");
        debugPrint("Ocupation: ${ocupationController.text}");
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
}
