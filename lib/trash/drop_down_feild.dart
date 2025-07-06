import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class DropDownField<T> extends StatefulWidget {
  final List<T> list;
  final String label;
  final T? initialValue;
  final void Function(T?)? onChanged;
  final String Function(T) getLabel; // تابع گرفتن اسم از هر آیتم

  const DropDownField({
    super.key,
    required this.list,
    required this.label,
    this.initialValue,
    this.onChanged,
    required this.getLabel,
  });

  @override
  State<DropDownField<T>> createState() => _DropDownFieldState<T>();
}

class _DropDownFieldState<T> extends State<DropDownField<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null &&
        widget.list.contains(widget.initialValue)) {
      selectedValue = widget.initialValue;
    } else {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: TextStyle(color: AppColors.grey500),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary800,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.grey600, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.primary800, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
      ),
      value: selectedValue,
      items:
          widget.list.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(widget.getLabel(item)),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      menuMaxHeight: 300,
    );
  }
}
