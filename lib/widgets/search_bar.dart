import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.onSearch,
    this.hintText = 'جستجو کنید...',
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.grey200, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: AppColors.grey500),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _isSearching = value.isNotEmpty;
                });
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  widget.onSearch(value);
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              _isSearching ? Iconsax.close_circle : Iconsax.search_normal,
              color: AppColors.grey600,
              size: 22,
            ),
            onPressed: () {
              if (_isSearching) {
                setState(() {
                  _controller.clear();
                  _isSearching = false;
                });
              } else if (_controller.text.isNotEmpty) {
                widget.onSearch(_controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}
