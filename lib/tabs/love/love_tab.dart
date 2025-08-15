import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:evently_app/widgets/event_item.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            CustomeTextFormField(
              hintText: 'Search for Event',
              prefixIconImage: AppAssets.searchIcon,
              onChanged: (query) {
                
              },
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 20,
                itemBuilder: (_, index) {
                  return const EventItem();
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
