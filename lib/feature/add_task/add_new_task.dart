// feature/add_task/add_new_task.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/functions/newNavigation.dart';
import 'package:todo/core/utils/text_style.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/feature/home/home_screen.dart';
import '../../core/utils/color.dart';
import '../../core/widgets/textfieldflorm_widget.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var formKey = GlobalKey();
  var titleController = TextEditingController();
  var noteController = TextEditingController();
  var dateController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
  var starttimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  var endtimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    Size mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Add Task",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //////////////////////////////////////////////title
                Text(
                  "Title",
                  style: gettitleTextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.normal,
                    fontsize: mediaquery.width * .047,
                  ),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () {},
                  controller: titleController,
                  validator: (p0) =>
                      p0!.isEmpty ? "Please enter your title" : null,
                  isobsecure: false,
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),
                /////////////////////////////////////////////////////////////////note
                Text(
                  "Note",
                  style: gettitleTextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.normal,
                    fontsize: mediaquery.width * .047,
                  ),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () {},
                  maxLength: 4,
                  isobsecure: false,
                  controller: noteController,
                  validator: (p0) =>
                      p0!.isEmpty ? "Please enter your note" : null,
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),

                ////////////////////////////////////////////////////////////////////date
                Text(
                  "Date",
                  style: gettitleTextStyle(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.normal,
                    fontsize: mediaquery.width * .047,
                  ),
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                TextfieldflormWidget(
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    ).then((value) {
                      if (value != null) {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(value);
                      }
                    });
                  },
                  controller: dateController,
                  readOnly: true,
                  isobsecure: false,
                  suffixIcon:
                      Icon(Icons.calendar_month, color: AppColor.purpleColor),
                ),

                SizedBox(
                  height: mediaquery.height * .02,
                ),

                /////////////////////////////////////////////////////////Endtime&starttime
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Time",
                            style: gettitleTextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.normal,
                              fontsize: mediaquery.width * .047,
                            ),
                          ),
                          SizedBox(
                            height: mediaquery.height * .01,
                          ),
                          TextfieldflormWidget(
                            onTap: () async {
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  starttimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            controller: starttimeController,
                            readOnly: true,
                            isobsecure: false,
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: AppColor.purpleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: mediaquery.width * .02,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: gettitleTextStyle(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.normal,
                              fontsize: mediaquery.width * .047,
                            ),
                          ),
                          SizedBox(
                            height: mediaquery.height * .01,
                          ),
                          TextfieldflormWidget(
                            onTap: () async {
                              await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              ).then((value) {
                                if (value != null) {
                                  endtimeController.text =
                                      value.format(context);
                                }
                              });
                            },
                            controller: endtimeController,
                            readOnly: true,
                            isobsecure: false,
                            suffixIcon: Icon(
                              Icons.access_time,
                              color: AppColor.purpleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: mediaquery.height * .02,
                ),

                /////////////////////////////////////////////////circleAvatar for color

                Row(
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(2.5),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: index == 0
                                  ? AppColor.purpleColor
                                  : index == 1
                                      ? AppColor.orangeColor
                                      : AppColor.redColor,
                              child: (selectedColor == index)
                                  ? Icon(
                                      Icons.check,
                                      color: AppColor.whiteColor,
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        );
                      }),
                    ),
                    Spacer(),
                    SizedBox(
                      height: mediaquery.height * .06,
                      width: mediaquery.width * .3,
                      child: CustomButton(
                        text: "Create Task",
                        onPressed: () {
                          if ((formKey.currentState as FormState).validate()) {
                            pushWithReplacement(context, HomeScreen());
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
