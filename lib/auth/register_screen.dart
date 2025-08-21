import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passWordContoller = TextEditingController();
  TextEditingController nameContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              hintText: 'Name',
              controller: nameContoller,
              prefixIconImage: AppAssets.userNameIcon,
            ),
            const SizedBox(
              height: 16,
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
              isPassword: true,
              controller: passWordContoller,
              prefixIconImage: AppAssets.passwordIcon,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomeElevatedButton(
                label: 'Create Account',
                onPressed: () async {
                  UserModel user = await register(emailContoller.text,
                      passWordContoller.text, nameContoller.text);
                  if (!context.mounted) return;
                  Navigator.of(context).pushReplacementNamed(
                    HomeScreen.routeName,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already Have Account?',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<UserModel> register(String email, String password, String name) async {
    return await FirebaseServices.register(
        name: name, email: email, password: password);
  }
}
