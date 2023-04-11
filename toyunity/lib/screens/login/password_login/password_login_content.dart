import 'package:toyunity/screens/components/forms/costum_text_field.dart';
import 'package:toyunity/screens/components/forms/custom_button.dart';
import 'package:toyunity/screens/navigations/navigation_screen.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import '../../components/forms/custom_text.dart';
import '../../home/home_screen.dart';

class PasswordLoginContent extends StatefulWidget {
  const PasswordLoginContent({Key? key}) : super(key: key);

  @override
  State<PasswordLoginContent> createState() => _PasswordLoginContent();
}

class _PasswordLoginContent extends State<PasswordLoginContent> {
  bool isLoading = true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/png/login.png",
              height: size.height * 0.4,
            ),
            const SizedBox(
              height: appPadding,
            ),
            const CustumText(
              text: "Let's you in",
              size: 35,
              weight: FontWeight.bold,
              color: primaryColor,
            ),
            const SizedBox(
              height: appPadding,
            ),
            CustomTextField(
                hintText: "Email",
                icon: Icons.mail_rounded,
                onChanged: (value) {},
                controller: emailController),
            const SizedBox(
              height: appPadding * 2,
            ),
            CustomTextField(
                hintText: "Password",
                icon: Icons.lock_rounded,
                onChanged: (value) {},
                controller: passwordController),
            const SizedBox(
              height: appPadding * 2,
            ),
            CustomButton(
                text: "Sign in",
                width: size.width * 0.8,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => NavigationScreen(screen: HomeScreen(),)));
                })
          ],
        ),
      ),
    );
  }
}
