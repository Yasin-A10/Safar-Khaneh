import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final Function(List<String>) onSelectionChanged;
  final String? label;

  const MultiSelectDropdown({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChanged,
    this.label,
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = List.from(widget.selectedOptions); // برای sync اولیه
  }

  void _showMultiSelectDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(widget.label ?? 'انتخاب امکانات'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateDialog) {
              return SingleChildScrollView(
                child: Column(
                  children:
                      widget.options.map((item) {
                        return CheckboxListTile(
                          value: _selected.contains(item),
                          title: Text(item),
                          onChanged: (bool? checked) {
                            setStateDialog(() {
                              if (checked == true) {
                                _selected.add(item);
                              } else {
                                _selected.remove(item);
                              }
                            });
                          },
                        );
                      }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              child: const Text('تأیید'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {}); // برای بروزرسانی نمایش در InputDecorator
                widget.onSelectionChanged(_selected); // اطلاع به والد
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void didUpdateWidget(covariant MultiSelectDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedOptions != oldWidget.selectedOptions) {
      _selected = List.from(widget.selectedOptions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showMultiSelectDialog,
      child: InputDecorator(
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
        child: Text(
          _selected.isNotEmpty ? _selected.join(', ') : 'انتخاب کنید',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
