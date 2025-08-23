import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    super.key,
  });

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    EventsProvider eventsProvider = Provider.of<EventsProvider>(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, bottom: 16),
      decoration: const BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back ✨',
              style: textTheme.titleSmall,
            ),
            Text(
              'User Name',
              style: textTheme.headlineSmall,
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultTabController(
              length: CategoryModel.categories.length + 1,
              child: TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.only(right: 10),
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    CategoryModel? selectedCategory = currentIndex == 0
                        ? null
                        : CategoryModel.categories[currentIndex - 1];
                    eventsProvider.filterEvents(selectedCategory);
                    setState(() {});
                  },
                  tabs: [
                    TabItem(
                        text: 'All',
                        icon: Icons.ac_unit_outlined,
                        isSelected: currentIndex == 0,
                        selectedForegroundColor: AppTheme.primaryColor,
                        unSelectedForegroundColor: AppTheme.white,
                        selectedBackgroundColor: AppTheme.white),
                    ...CategoryModel.categories.map((category) => TabItem(
                        text: category.name,
                        icon: category.icon,
                        isSelected: currentIndex ==
                            CategoryModel.categories.indexOf(category) + 1,
                        selectedForegroundColor: AppTheme.primaryColor,
                        unSelectedForegroundColor: AppTheme.white,
                        selectedBackgroundColor: AppTheme.white)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
