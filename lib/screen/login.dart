import 'package:flutter/material.dart';
import 'package:pawlinker/screen/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _login = true;
  String id = "";
  String pass = "";
  String? emailError;
  String? passwordError;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Email validation function
  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  // Password validation function
  bool isValidPassword(String password) {
    return password.length >= 6;
  }

  // Validate form fields
  void validateFields() {
    setState(() {
      // Reset errors
      emailError = null;
      passwordError = null;

      // Validate email
      if (id.isEmpty) {
        emailError = "Email cannot be empty";
      } else if (!isValidEmail(id)) {
        emailError = "Please enter a valid email address";
      }

      // Validate password
      if (pass.isEmpty) {
        passwordError = "Password cannot be empty";
      } else if (!isValidPassword(pass)) {
        passwordError = "Password must be at least 6 characters";
      }
    });
  }

  // Submit form
  void submitForm() {
    validateFields();
    if (emailError == null && passwordError == null) {
      if (_login) {
        // Here you would typically authenticate with your backend
        // For now, just navigate to home
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        // Here you would typically register with your backend
        // For now, just show a success message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration successful! You can now login.")));
        setState(() => _login = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            "lib/resources/logo.png",
            fit: BoxFit.cover,
            width: 150,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "lib/resources/background.png",
              color: Theme.of(context).colorScheme.primary.withAlpha(25),
              fit: BoxFit.none,
              alignment: Alignment.center,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.only(bottom: keyboardHeight + 40, left: 40, right: 40, top: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  if (_login)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          "Welcome back! please login to continue",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  if (!_login)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          "Welcome to pawlinker! please register to continue",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  SizedBox(height: 100 - 0.2 * keyboardHeight),
                  TextFormField(
                    decoration: InputDecoration(
                      label: const Text("Email"),
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      errorText: emailError,
                    ),
                    onChanged: (value) => setState(() => id = value),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password_sharp),
                      label: const Text("Password"),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      errorText: passwordError,
                    ),
                    obscureText: true,
                    onChanged: (value) => setState(() => pass = value),
                  ),
                  const SizedBox(height: 10),
                  if (_login)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                        child: Text(
                          "Login",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: submitForm,
                      ),
                    ),
                  if (!_login)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
                        child: Text(
                          "Register",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: submitForm,
                      ),
                    ),
                  const Spacer(),
                  if (_login)
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                        GestureDetector(
                          child: Text(
                            " Register",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                          onTap: () => setState(() => _login = false),
                        ),
                      ],
                    ),
                  if (!_login)
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          "Already have an account?",
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                        GestureDetector(
                          child: Text(
                            " Login",
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                          onTap: () => setState(() => _login = true),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
