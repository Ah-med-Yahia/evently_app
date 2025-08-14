import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.text,
      required this.icon,
      required this.isSelected,
      required this.selectedForegroundColor,
      required this.unSelectedForegroundColor,
      required this.selectedBackgroundColor});

  final String text;
  final IconData icon;
  final bool isSelected;
  final Color selectedForegroundColor;
  final Color unSelectedForegroundColor;
  final Color selectedBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(46),
          border:
              isSelected ? null : Border.all(width: 1, color: AppTheme.white)),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected
                ? selectedForegroundColor
                : unSelectedForegroundColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: isSelected
                    ? selectedForegroundColor
                    : unSelectedForegroundColor),
          ),
        ],
      ),
    );
  }
}
