import 'package:dots_indicator/dots_indicator.dart';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/onboarding/onboarding_item.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = 'Onboarding_Screen';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController pageController = PageController();

  double currentPosition = 0;

  @override
  void initState() {
    pageController.addListener(() {
      currentPosition = pageController.page!;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final List<OnboardingItem> onboardingItems = [
      OnboardingItem(
        image: AppAssets.onboarding1,
        title: AppLocalizations.of(context)!.title1_Onboarding,
        description: AppLocalizations.of(context)!.description1_Onboarding,
      ),
      OnboardingItem(
          image: AppAssets.onboarding2,
          title: AppLocalizations.of(context)!.title2_Onboarding,
          description: AppLocalizations.of(context)!.description2_Onboarding),
      OnboardingItem(
          image: AppAssets.onboarding3,
          title: AppLocalizations.of(context)!.title3_Onboarding,
          description: AppLocalizations.of(context)!.description3_Onboarding),
    ];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Image.asset(
                AppAssets.onboardingLogo,
                width: MediaQuery.sizeOf(context).width * .4,
                height: 48,
              ),
              const SizedBox(
                height: 28,
              ),
              Expanded(
                  child: PageView.builder(
                controller: pageController,
                itemCount: onboardingItems.length,
                itemBuilder: (context, index) => onboardingItems[index],
              )),
              Stack(alignment: Alignment.center, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: currentPosition.toInt() != 0,
                      child: IconButton(
                          onPressed: () {
                            pageController.animateToPage(
                                currentPosition.toInt() - 1,
                                duration: const Duration(microseconds: 300),
                                curve: Curves.bounceIn);
                          },
                          icon: SvgPicture.asset(
                              settingsProvider.languageCode == 'ar'
                                  ? AppAssets.arrowRightIconLight
                                  : AppAssets.arrowLeftIconLight)),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (currentPosition.toInt() ==
                              onboardingItems.length - 1) {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('onboarding_done', true);
                          } else {
                            pageController.animateToPage(
                                currentPosition.toInt() + 1,
                                duration: const Duration(microseconds: 300),
                                curve: Curves.bounceIn);
                          }
                        },
                        icon: SvgPicture.asset(
                            settingsProvider.languageCode == 'ar'
                                ? AppAssets.arrowLeftIconLight
                                : AppAssets.arrowRightIconLight)),
                  ],
                ),
                DotsIndicator(
                  dotsCount: onboardingItems.length,
                  position: currentPosition,
                  onTap: (position) {
                    pageController.animateToPage(position,
                        duration: const Duration(microseconds: 300),
                        curve: Curves.bounceIn);
                  },
                  decorator: DotsDecorator(
                    color: settingsProvider.isDark()
                        ? AppTheme.white
                        : AppTheme.black, // Inactive color
                    activeColor: AppTheme.primaryColor,
                    size: const Size(8, 8),
                    activeSize: const Size(20.0, 8.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ]),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
