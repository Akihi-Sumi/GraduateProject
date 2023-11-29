import 'package:flutter/material.dart';

class DatePickerState {
  Future showCustomDatePicker(BuildContext context) async {
    DateTime? changeDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 21),
    );
    return changeDate;
  }
}
