import 'package:evently_app/onboarding/onBoarding_screen.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:evently_app/widgets/toggle_switch_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const String routeName = 'welcome screen';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.onboardingLogo,
                width: screenSize.width * .4,
                height: 48,
              ),
              const SizedBox(
                height: 28,
              ),
              Image.asset(
                AppAssets.beingCreative,
                width: double.infinity,
                height: screenSize.height * .4,
                fit: BoxFit.fill,
              ),
              Text(
                AppLocalizations.of(context)!.welcome_screen_text1,
                textAlign: TextAlign.start,
                style: textTheme.titleLarge!.copyWith(
                    color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                AppLocalizations.of(context)!.welcome_screen_text2,
                style: textTheme.titleMedium!.copyWith(
                    color: settingsProvider.isDark()
                        ? AppTheme.white
                        : AppTheme.black),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: textTheme.titleLarge!
                        .copyWith(color: AppTheme.primaryColor),
                  ),
                  const Spacer(),
                  const ToggleSwitchLanguage()
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: textTheme.titleLarge!
                        .copyWith(color: AppTheme.primaryColor),
                  ),
                  const Spacer(),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: AppTheme.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: ToggleSwitch(
                      minWidth: 50,
                      minHeight: 30,
                      activeBgColor: const [AppTheme.primaryColor],
                      inactiveBgColor: Colors.transparent,
                      initialLabelIndex: settingsProvider.isDark() ? 0 : 1,
                      totalSwitches: 2,
                      customWidgets: [
                        SvgPicture.asset(AppAssets.darkIcon,
                            colorFilter: ColorFilter.mode(
                                settingsProvider.isDark()
                                    ? AppTheme.white
                                    : AppTheme.primaryColor,
                                BlendMode.srcIn)),
                        SvgPicture.asset(
                          AppAssets.lightIcon,
                          colorFilter: const ColorFilter.mode(
                              AppTheme.white, BlendMode.srcIn),
                        ),
                      ],
                      onToggle: (index) {
                        settingsProvider.changeTheme(
                            index == 1 ? ThemeMode.light : ThemeMode.dark);
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OnboardingScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: Text(
                    AppLocalizations.of(context)!.start,
                    style: textTheme.titleLarge,
                  )),
              const SizedBox(
                height: 27,
              )
            ],
          ),
        ),
      ),
    );
  }
}
