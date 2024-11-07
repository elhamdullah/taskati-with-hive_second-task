// feature/home/home_screen.dart
import 'dart:math';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/text_style.dart';
import 'package:todo/core/widgets/action_appbar.dart';
import 'package:todo/core/widgets/task_item.dart';
import 'package:todo/core/widgets/title_appbar.dart';
import '../../core/functions/newNavigation.dart';
import '../../core/utils/color.dart';
import '../add_task/add_new_task.dart';
import 'dart:developer';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime focusDate = DateTime.now();
    String date = DateFormat.yMMMMd().format(DateTime.now());
    Size mediaquery = MediaQuery.of(context).size;
    var box = Hive.box('user');

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        toolbarHeight: mediaquery.height * .075,
        backgroundColor: AppColor.whiteColor,
        title: TitleAppBar(),
        actions: [
          ActionAppBar(),
          SizedBox(
            width: mediaquery.width * .02,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                          color: AppColor.blackColor,
                          fontSize: mediaquery.width * .06,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        (DateFormat.E().format(focusDate)) ==
                                (DateFormat.E().format(focusDate))
                            ? "Today"
                            : DateFormat.E().format(focusDate),
                        style: TextStyle(
                            color: ThemeMode.light == ThemeMode.light
                                ? AppColor.blackColor
                                : AppColor.whiteColor,
                            fontSize: mediaquery.width * .06,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  width: mediaquery.width * .1,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: AppColor.purpleColor,
                      foregroundColor: AppColor.whiteColor,
                    ),
                    onPressed: () {
                      pushTo(context, AddNewTask());
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Task")),
              ],
            ),
            SizedBox(
              height: mediaquery.height * .02,
            ),
            EasyInfiniteDateTimeLine(
              activeColor: AppColor.purpleColor,

              //controller: _controller,
              showTimelineHeader: false,
              dayProps: EasyDayProps(
                width: mediaquery.width * .22,
                dayStructure: DayStructure.monthDayNumDayStr,
                activeDayStyle: DayStyle(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: AppColor.purpleColor,
                  ),
                ),
              ),
              firstDate: DateTime(2024),
              focusDate: focusDate,
              lastDate: DateTime(2025, 12, 31),
              onDateChange: (selectedDate) {
                setState(() {
                  // focusDate = selectedDate;
                  selectedDate = focusDate;
                });
              },
            ),
            SizedBox(
              height: mediaquery.height * .02,
            ),
            //  Lottie.asset('assets/images/empty.json'),

            ////////////////////////////////////////////////////////listView tasks
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaquery.width * .02),
              child: SizedBox(
                height: mediaquery.height,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        child: TaskItem(),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            print("start to end");
                          } else if (direction == DismissDirection.endToStart) {
                            print("end to start");
                          }
                        },
                        secondaryBackground: Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.redColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColor.whiteColor,
                              ),
                              Text("Delete  ",
                                  style: gettitleTextStyle(
                                      color: AppColor.whiteColor))
                            ],
                          ),
                        ),
                        background: Container(
                          padding: EdgeInsets.all(10),
                          margin:
                              EdgeInsets.only(bottom: 10, left: 5, right: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColor.whiteColor,
                              ),
                              Text("Complete",
                                  style: gettitleTextStyle(
                                      color: AppColor.whiteColor))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
