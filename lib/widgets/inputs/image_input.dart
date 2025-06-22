import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';

class ImageUploadInput extends StatefulWidget {
  final void Function(File? imageFile)? onImageSelected;

  const ImageUploadInput({super.key, this.onImageSelected});

  @override
  State<ImageUploadInput> createState() => _ImageUploadInputState();
}

class _ImageUploadInputState extends State<ImageUploadInput> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      if (widget.onImageSelected != null) {
        widget.onImageSelected!(_imageFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                  _imageFile!,
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.cover,
                )
                : const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.camera, color: AppColors.grey300, size: 40),
                      SizedBox(height: 8),
                      Text(
                        'برای انتخاب تصویر کلیک کنید',
                        style: TextStyle(color: AppColors.grey400),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
