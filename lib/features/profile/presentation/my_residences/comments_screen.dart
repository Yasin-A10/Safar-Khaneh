import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/trash/models/comment_model.dart';
import 'package:safar_khaneh/trash/models/my_residence_model.dart';
import 'package:safar_khaneh/widgets/comment_widget.dart';

final List<CommentModel> comments = [
  CommentModel(
    id: 1,
    name: 'محمد حسینی',
    text: 'ممنونم، امیدوارم که امروز هم خوشحال شدم.',
    rating: 5,
    createdAt: '2025-06-09T12:38:51.082843Z',
    residenceId: 1,
  ),
  CommentModel(
    id: 2,
    name: 'محمد کارگر',
    text: 'ممنونم، امیدوارم که امروز هم خوشحال شدم.',
    rating: 4.3,
    createdAt: '2025-06-09T12:38:51.082843Z',
    residenceId: 1,
  ),
  CommentModel(
    id: 5,
    name: 'عباس حسینی',
    residenceId: 1,
    text:
        'اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن',
    rating: 5,
    createdAt: '2024-09-09T12:38:51.082843Z',
  ),
  CommentModel(
    id: 4,
    name: 'جعفر غلامی',
    residenceId: 1,
    text:
        'اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن و اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن',
    rating: 4.5,
    createdAt: '2022-11-09T12:38:51.082843Z',
  ),
];

class CommentsScreen extends StatelessWidget {
  final MyResidenceModel residence;
  const CommentsScreen({super.key, required this.residence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرات و امتیازات'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              // این خط اضافه شد
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CommentWidget(comment: comment, maxLines: 5),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
