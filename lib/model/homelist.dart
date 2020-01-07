import 'package:best_flutter_ui_templates/designCourse/homeDesignCourse.dart';
import 'package:best_flutter_ui_templates/fitnessApp/fitnessAppHomeScreen.dart';
import 'package:best_flutter_ui_templates/hotelBooking/hotelHomeScreen.dart';
import 'package:best_flutter_ui_templates/school/TabAbsences.dart';
import 'package:best_flutter_ui_templates/school/TabgetFees.dart';
import 'package:best_flutter_ui_templates/school/TabgetMarks.dart';
import 'package:best_flutter_ui_templates/school/TabgetNotes.dart';
import 'package:best_flutter_ui_templates/school/homeworks.dart';
import 'package:best_flutter_ui_templates/school/messagesTab3.dart';
import 'package:best_flutter_ui_templates/school/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  Widget navigateScreen;
  String imagePath;
  String title;

  HomeList({
    this.navigateScreen,
    this.imagePath = '',
    this.title
  });

  static List<HomeList> homeList = [
    HomeList(
      imagePath: "assets/hotel/hotel_booking.png",
      navigateScreen: HotelHomeScreen(),
      title: '',
    ),
    HomeList(
      imagePath: "assets/fitness_app/fitness_app.png",
      navigateScreen: FitnessAppHomeScreen(),
      title: '',
    ),
    HomeList(
      imagePath: "assets/design_course/design_course.png",
      navigateScreen: DesignCourseHomeScreen(),
      title: '',
    ),
    HomeList(
      imagePath: "assets/images/messages.jpg",
    title: 'messages',
        navigateScreen: Scaffold(
          body: messages(),
        ),
    ),
    HomeList(
      imagePath: "assets/images/absences.jpg",
      navigateScreen: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: getAbsences(),
      ),
      title: 'absences',
    ),
    HomeList(
      imagePath: "assets/images/marks.jpg",
        navigateScreen: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: getMarks(),
        ),
      title: 'Marks'
    ),
    HomeList(
      imagePath: "assets/images/homework.jpg",
      //  navigateScreen: DesignCourseHomeScreen(),
        navigateScreen: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: homework(),
        ),
      title: 'Homeworks'
    ),

    HomeList(
        imagePath: "assets/images/notifications.jpg",
        navigateScreen: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: notification(),
        ),
        title: 'notifications'
    ),
    HomeList(
        imagePath: "assets/images/notes.jpg",
        navigateScreen: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: getNotes(),
        ),
        title: 'notes'
    ),
    HomeList(
        imagePath: "assets/images/fees.png",
        navigateScreen: Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: getFees(),
        ),
        title: 'fees'
    ),
  ];
}
