import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/ui_utils.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
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
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Invalid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomeTextFormField(
                hintText: 'Password',
                isPassword: true,
                controller: passWordContoller,
                prefixIconImage: AppAssets.passwordIcon,
                validator: (value) {
                  if (value == null || value.length < 8) {
                    return 'Invalid Password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              CustomeElevatedButton(
                  label: 'Create Account',
                  onPressed: () {
                    register(emailContoller.text, passWordContoller.text,
                        nameContoller.text);
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
      ),
    );
  }

  Future<void> register(String email, String password, String name) async {
    if (formKey.currentState!.validate()) {
      try {
        UserModel? user = await FirebaseServices.register(
            name: name, email: email, password: password);
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      } catch (error) {
        String? errorMessage;
        if (error is FirebaseAuthException) {
          errorMessage = error.message;
        }
        UiUtils.showErrorMessage(errorMessage);
      }
    }
  }
}
