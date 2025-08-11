import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passWordContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.logo,
              fit: BoxFit.fill,
              height: MediaQuery.sizeOf(context).height * .2,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomeTextFormField(
              hintText: 'Email',
              controller: emailContoller,
              prefixIconImage: AppAssets.emailIcon,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomeTextFormField(
              hintText: 'Password',
              controller: passWordContoller,
              prefixIconImage: AppAssets.passwordIcon,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomeElevatedButton(label: 'Login', onPressed: () {}),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don`t Have Account?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: const Text('Create Account'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
