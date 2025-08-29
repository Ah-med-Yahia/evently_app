import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/tabs/home/tab_item.dart';
import 'package:evently_app/ui_utils.dart';
import 'package:evently_app/utils/app_assets.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:evently_app/widgets/custome_elevated_button.dart';
import 'package:evently_app/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  static const routeName = 'edit_event';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late int currentIndex;
  late CategoryModel currentCategory;
  late DateTime selectedDate;
  late TimeOfDay selectedTime;
  bool firstBuild = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController eventTitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EventModel event = ModalRoute.of(context)!.settings.arguments as EventModel;
    SettingsProvider settingsProvider = Provider.of(context);
    if (firstBuild) {
      currentIndex = int.parse(event.category.id) - 1;
      currentCategory = event.category;
      firstBuild = false;
      eventTitleController.text = event.title;
      descriptionController.text = event.description;
      selectedDate = event.dateTime;
      selectedTime =
          TimeOfDay(hour: event.dateTime.hour, minute: event.dateTime.minute);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.event_details),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(event.category.image),
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
              onTap: (index) {
                if (currentIndex == index) return;
                currentIndex = index;
                currentCategory = CategoryModel.categories[currentIndex];
                setState(() {});
              },
              tabs: CategoryModel.categories
                  .map((category) => TabItem(
                      text: category.name,
                      icon: category.icon,
                      isSelected: currentIndex ==
                          CategoryModel.categories.indexOf(category),
                      selectedForegroundColor: settingsProvider.isDark()
                          ? AppTheme.black
                          : AppTheme.white,
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
                    AppLocalizations.of(context)!.title,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomeTextFormField(
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
                    AppLocalizations.of(context)!.description,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomeTextFormField(
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
                      SvgPicture.asset(
                        AppAssets.calendarDaysIcon,
                        colorFilter: ColorFilter.mode(
                            settingsProvider.isDark()
                                ? AppTheme.white
                                : AppTheme.black,
                            BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.eventDate,
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
                          if (date != null) {
                            selectedDate = date;
                            setState(() {});
                          }
                        },
                        child: Text(
                          DateFormat('d/M/yyyy').format(selectedDate),
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
                      SvgPicture.asset(
                        AppAssets.clockIcon,
                        colorFilter: ColorFilter.mode(
                            settingsProvider.isDark()
                                ? AppTheme.white
                                : AppTheme.black,
                            BlendMode.srcIn),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        AppLocalizations.of(context)!.eventTime,
                        style: textTheme.titleMedium,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            selectedTime = time;
                            setState(() {});
                          }
                        },
                        child: Text(
                          selectedTime.format(context),
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
                      label: 'Add Event',
                      onPressed: () {
                        editEvent(event);
                      })
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  void editEvent(EventModel event) {
    if (formKey.currentState!.validate()) {
      event.title = eventTitleController.text;
      event.description = descriptionController.text;
      event.category = currentCategory;
      event.dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      Provider.of<EventsProvider>(listen: false, context)
          .addEvent(event)
          .then((_) {
        Navigator.of(context).pop();
        UiUtils.showSuccessMessage('Event Edited Succesfully 🤩');
      }).catchError((error) {
        UiUtils.showErrorMessage('Failed to edit Event 😥');
      });
    }
  }
}
