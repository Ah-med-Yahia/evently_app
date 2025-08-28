import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? user;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        await Provider.of<UserProvider>(listen: false, context)
            .loadCurrentUser();
        if (mounted) {
          user = Provider.of<UserProvider>(listen: false, context).currentUser;
          if (user == null) {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          } else {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(
                AppAssets.logo,
                height: MediaQuery.sizeOf(context).height * .2,
                fit: BoxFit.fill,
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                AppLocalizations.of(context)!.welcome,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppTheme.primaryColor),
              ),
              const Spacer(
                flex: 2,
              ),
              Text(
                'By : Ahmed Yahia',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
