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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';




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
  int currentIndex = 0;
  CategoryModel currentCategory = CategoryModel.categories.first;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('d/M/yyyy');

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(currentCategory.image),
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
                            selectedDate = date;
                            setState(() {});
                          },
                          child: Text(
                            selectedDate == null
                                ? 'Choose Date'
                                : dateFormat.format(selectedDate!),
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
                            selectedTime == null
                                ? 'Choose Time'
                                : selectedTime!.format(context),
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
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      EventModel event = EventModel(
          userId: FirebaseAuth.instance.currentUser!.uid,
          title: eventTitleController.text,
          description: descriptionController.text,
          category: currentCategory,
          dateTime: DateTime(
            selectedDate!.year,
            selectedDate!.month,
            selectedDate!.day,
            selectedTime!.hour,
            selectedTime!.minute,
          ));
      Provider.of<EventsProvider>(listen: false,context).addEvent(event).then((_) {
        Navigator.of(context).pop();
        UiUtils.showSuccessMessage('Event Created Succesfully 🤩');
      }).catchError((error) {
        UiUtils.showErrorMessage('Failed to create Event 😥');
      });
    }
  }
}
