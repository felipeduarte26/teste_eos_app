import 'package:dependencies/dependencies.dart';
import 'package:flutter/widgets.dart';

class CustomScrollDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  const CustomScrollDatePicker({required this.onDateTimeChanged, super.key});

  @override
  State<CustomScrollDatePicker> createState() => _CustomScrollDatePickerState();
}

class _CustomScrollDatePickerState extends State<CustomScrollDatePicker> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) => ScrollDatePicker(
        selectedDate: _selectedDate,
        locale: const Locale('pt', 'BR'),
        onDateTimeChanged: (date) {
          setState(() {
            _selectedDate = date;
            widget.onDateTimeChanged(date);
          });
        },
      );
}
