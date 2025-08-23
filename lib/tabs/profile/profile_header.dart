import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64))),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              AppAssets.userBackground,
              height: MediaQuery.sizeOf(context).height * .12,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Provider.of<UserProvider>(context).currentUser!.name,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'useremail@gmail.com',
                  style: textTheme.titleMedium!.copyWith(color: AppTheme.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
