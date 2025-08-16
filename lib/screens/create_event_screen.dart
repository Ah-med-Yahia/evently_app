import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  static const String routeName = 'create_event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(AppAssets.sportBackground),
            ),
          ),
          DefaultTabController(
            length: CategoryModel.categories.length,
            child: TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.only(left: 16),
              tabs: CategoryModel.categories
                  .map((category) => TabItem(
                      text: category.name,
                      icon: category.icon,
                      isSelected: false,
                      selectedForegroundColor: AppTheme.white,
                      unSelectedForegroundColor: AppTheme.primaryColor,
                      selectedBackgroundColor: AppTheme.primaryColor))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomeTextFormField(
                    hintText: 'Event Title',
                    prefixIconImage: AppAssets.noteEditIcon,
                    controller: eventTitleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You Should Type anything';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Description',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomeTextFormField(
                    hintText: 'Event Description',
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'You Should Type anything';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.calendarDaysIcon),
                      const SizedBox(width: 10),
                      Text(
                        'Event Date',
                        style: textTheme.titleMedium,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now()
                                  .add(const Duration(days: 365)));
                        },
                        child: Text(
                          'Choose Date',
                          style: textTheme.titleMedium!
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.clockIcon),
                      const SizedBox(width: 10),
                      Text(
                        'Event Time',
                        style: textTheme.titleMedium,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                        },
                        child: Text(
                          'Choose Time',
                          style: textTheme.titleMedium!
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomeElevatedButton(
                      label: 'Add Event', onPressed: createEvent)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate()) {}
  }
}
