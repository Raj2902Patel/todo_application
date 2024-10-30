import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/const/app_style.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/provider/date_time_provider.dart';
import 'package:todo_app/provider/radio_provider.dart';
import 'package:todo_app/provider/service_provider.dart';
import 'package:todo_app/widget/date_time_widget.dart';
import 'package:todo_app/widget/radio_widget.dart';
import 'package:todo_app/widget/textfield_widget.dart';
import 'package:intl/intl.dart';

class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({super.key});

  @override
  ConsumerState<AddNewTaskModel> createState() => _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          // Rest of your code here...
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text("Task Title", style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
            maxL: 15,
            txtController: titleController,
            hintText: "Add Task Title",
            maxLines: 1,
          ),
          const Gap(12),
          const Text("Description", style: AppStyle.headingOne),
          const Gap(6),
          TextFieldWidget(
              maxL: 50,
              txtController: descController,
              hintText: "Add Task Description",
              maxLines: 2),
          const Gap(12),
          const Text(
            "Category",
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  titleRadio: "LRN",
                  categoryColor: Colors.green,
                  valueInput: 1,
                  onChnageValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 1,
                      ),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "WRK",
                  categoryColor: Colors.blue.shade700,
                  valueInput: 2,
                  onChnageValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 2,
                      ),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  titleRadio: "GEN",
                  categoryColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                  onChnageValue: () => ref.read(radioProvider.notifier).update(
                        (state) => 3,
                      ),
                ),
              ),
            ],
          ),

          // Date & Time Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: "Date",
                iconSection: CupertinoIcons.calendar,
                valueText: dateProv,
                onTap: () async {
                  final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now());

                  if (getValue != null) {
                    final format = DateFormat.yMd();
                    // print(format.format(getValue));
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));
                  }
                },
              ),
              const Gap(22),
              DateTimeWidget(
                titleText: "Time",
                iconSection: CupertinoIcons.time,
                valueText: ref.watch(timeProvider),
                onTap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref.read(timeProvider.notifier).update(
                          (state) => getTime.format(context),
                        );
                  }
                },
              ),
            ],
          ),
          const Gap(12),
          //Button Section
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      splashFactory: InkRipple.splashFactory,
                      overlayColor: Colors.redAccent.withOpacity(0.5),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side:
                          BorderSide(color: Colors.redAccent.withOpacity(0.7)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                      titleController.clear();
                      descController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => "DD/MM/YY");
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => "HH : MM");
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const Gap(22),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      splashFactory: InkRipple.splashFactory,
                      overlayColor: Colors.blue.withOpacity(0.5),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      side: BorderSide(color: Colors.blue.withOpacity(0.7)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);
                      String category = '';

                      switch (getRadioValue) {
                        case 1:
                          category = "Learning";
                          break;
                        case 2:
                          category = "Working";
                          break;
                        case 3:
                          category = "General";
                          break;
                      }

                      if (dateProv == "DD/MM/YY" ||
                          timeProv == "HH : MM" ||
                          titleController.text.isEmpty ||
                          descController.text.isEmpty ||
                          category.isEmpty) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      "All Fields Are Required\nFields",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      overlayColor: Colors.redAccent,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        ref.read(serviceProvider).addNewTask(
                              TodoModel(
                                titleTask: titleController.text,
                                description: descController.text,
                                category: category,
                                dateTask: ref.read(dateProvider),
                                timeTask: ref.read(timeProvider),
                                isDone: false,
                              ),
                            );

                        Navigator.pop(context);

                        titleController.clear();
                        descController.clear();
                        ref.read(radioProvider.notifier).update((state) => 0);
                        ref
                            .read(dateProvider.notifier)
                            .update((state) => "DD/MM/YY");
                        ref
                            .read(timeProvider.notifier)
                            .update((state) => "HH : MM");
                      }
                    },
                    child: const Text("Create Task"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
