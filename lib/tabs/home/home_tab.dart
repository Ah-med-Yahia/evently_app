import 'package:evently_app/tabs/home/home_header.dart';
import 'package:evently_app/widgets/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeHeader(),
        const SizedBox(
          height: 16,
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
    );
  }
}
