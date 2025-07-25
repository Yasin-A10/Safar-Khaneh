import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/config/router/app_router.dart';
import 'package:safar_khaneh/features/residence/data/services/comments_service.dart';
import 'package:safar_khaneh/features/residence/data/models/residence_comments_model.dart';
import 'package:safar_khaneh/widgets/comment_widget.dart';

class CommentsScreen extends StatefulWidget {
  final ResidenceContextModel contextModel;
  const CommentsScreen({super.key, required this.contextModel});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final CommentsService _commentService = CommentsService();
  late Future<List<CommentModel>> _comments;

  @override
  void initState() {
    super.initState();
    _comments = _commentService.getComments(
      residenceId: widget.contextModel.residence.id!,
    );
  }

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
              child: FutureBuilder(
                future: _comments,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final comments = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CommentWidget(comment: comment, maxLines: 5),
                      );
                    },
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
