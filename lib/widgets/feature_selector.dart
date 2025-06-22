import 'package:flutter/material.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class FeaturesSelector extends StatefulWidget {
  final List<String> allFeatures;
  final List<String> selectedFeatures;
  final void Function(List<String>) onChanged;

  const FeaturesSelector({
    super.key,
    required this.allFeatures,
    required this.selectedFeatures,
    required this.onChanged,
  });

  @override
  State<FeaturesSelector> createState() => _FeaturesSelectorState();
}

class _FeaturesSelectorState extends State<FeaturesSelector> {
  late List<String> _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedFeatures;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ویژگی ها',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.grey600,
          ),
        ),
        const SizedBox(height: 4),
        Wrap(
          direction: Axis.horizontal,
          spacing: 8,
          runSpacing: 8,
          children:
              widget.allFeatures.map((feature) {
                final isSelected = _selected.contains(feature);
                return ChoiceChip(
                  label: Text(
                    feature,
                    style: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.grey600,
                    ),
                  ),
                  selectedColor: AppColors.primary800,
                  checkmarkColor: AppColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color:
                          isSelected ? AppColors.primary800 : AppColors.grey500,
                      width: 1.5,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (value) {
                    setState(() {
                      if (isSelected) {
                        _selected.remove(feature);
                      } else {
                        _selected.add(feature);
                      }
                      widget.onChanged(_selected);
                    });
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
