import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E5EAA),
        title: const Text(
          "Search Roommate",
          textAlign: TextAlign.center,
          style: TextStyle(
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
      body: Container(
        color: const Color(0xffDAE3E5),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xffDAE3E5),
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                children: [
                  Text(
                    "I'm a",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2c595b),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CardOption(
                        title: 'Arrendador',
                        icon: Icons.home,
                      ),
                      CardOption(
                        title: 'Arrendatario',
                        icon: Icons.person,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xffDAE3E5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(hintText: 'Name',),
                  SizedBox(height: 16),
                  CustomTextField(hintText: 'Last Name',),
                  SizedBox(height: 16),
                  CustomTextField(hintText: 'E-mail',),
                  SizedBox(height: 16),
                  CustomTextField(hintText: 'Age',),
                  SizedBox(height: 16),
                  CustomTextField(hintText: 'Occupation',),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para registrar al usuario
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF2196F3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;

  const CustomTextField({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class CardOption extends StatelessWidget {
  final String title;
  final IconData icon;

  const CardOption({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: const Color(0xFF2c595b), // Color del ícono
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: const Color(0xFF2c595b), // Color del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}