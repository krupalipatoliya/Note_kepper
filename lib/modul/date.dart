import 'package:flutter/cupertino.dart';

class MyDate {
  static var date = DateTime.now();
  static var day;
  static var month;
  static var weekday;
  static TextStyle textStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static initDate() {
    day = date.day;

    if (date.weekday == DateTime.monday) {
      weekday = "Monday";
    } else if (date.weekday == DateTime.tuesday) {
      weekday = "Tuesday";
    } else if (date.weekday == DateTime.wednesday) {
      weekday = "Wednesday";
    } else if (date.weekday == DateTime.thursday) {
      weekday = "Thursday";
    } else if (date.weekday == DateTime.friday) {
      weekday = "Friday";
    } else if (date.weekday == DateTime.saturday) {
      weekday = "Saturday";
    } else if (date.weekday == DateTime.sunday) {
      weekday = "Sunday";
    }

    if (date.month == DateTime.january) {
      month = "January";
    } else if (date.month == DateTime.february) {
      month = "February";
    } else if (date.month == DateTime.march) {
      month = "March";
    } else if (date.month == DateTime.april) {
      month = "April";
    } else if (date.month == DateTime.may) {
      month = "May";
    } else if (date.month == DateTime.june) {
      month = "June";
    } else if (date.month == DateTime.july) {
      month = "Juli";
    } else if (date.month == DateTime.august) {
      month = "August";
    } else if (date.month == DateTime.september) {
      month = "September";
    } else if (date.month == DateTime.october) {
      month = "October";
    } else if (date.month == DateTime.november) {
      month = "November";
    } else if (date.month == DateTime.december) {
      month = "December";
    }
  }
}
