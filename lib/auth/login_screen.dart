import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/firebase_services.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/ui_utils.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:evently_app/widgets/toggle_switch_language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passWordContoller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
                  label: AppLocalizations.of(context)!.login,
                  onPressed: () {
                    login(emailContoller.text, passWordContoller.text);
                  }),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.have_no_account,
                    style: textTheme.titleMedium,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RegisterScreen.routeName);
                      },
                      child: Text(AppLocalizations.of(context)!.createAccount))
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Divider(
                    color: AppTheme.primaryColor,
                    indent: 35,
                    endIndent: 35,
                  ),
                  Container(
                      width: 32,
                      alignment: Alignment.center,
                      color: Provider.of<SettingsProvider>(context).isDark()
                          ? AppTheme.backgroundDark
                          : AppTheme.backgroundLight,
                      child: Text(
                        AppLocalizations.of(context)!.or,
                        style: textTheme.titleMedium!
                            .copyWith(color: AppTheme.primaryColor),
                      ))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  loginWithGoogle();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.primaryColor),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppAssets.googleIcon),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        AppLocalizations.of(context)!.login_google,
                        style: textTheme.titleLarge!
                            .copyWith(color: AppTheme.primaryColor),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const ToggleSwitchLanguage(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserModel user =
            await FirebaseServices.login(email: email, password: password);

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

  Future<void> loginWithGoogle() async {
    try {
      UserModel user = await FirebaseServices.signInWithGoogle();

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
