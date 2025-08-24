import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/ui_utils.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                hintText: AppLocalizations.of(context)!.name,
                controller: nameContoller,
                prefixIconImage: AppAssets.userNameIcon,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomeTextFormField(
                hintText: AppLocalizations.of(context)!.email,
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
                hintText: AppLocalizations.of(context)!.password,
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
                  label: AppLocalizations.of(context)!.createAccount,
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
                    AppLocalizations.of(context)!.have_account,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text(AppLocalizations.of(context)!.login))
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
          Provider.of<UserProvider>(listen: false, context)
              .updateCurrentUser(user);
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
