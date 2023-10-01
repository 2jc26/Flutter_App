import "package:flutter/material.dart";
import "package:giusseppe_flut/screens/roomie_detail.dart";
import "package:giusseppe_flut/widgets/drawer.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  final String title = 'Sign Up';

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
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          onPressed: () {},
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
                          onPressed: () {},
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
          MaterialPageRoute(builder: (context) => RoommateDetail()),
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
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
