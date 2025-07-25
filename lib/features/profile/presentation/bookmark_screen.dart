import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/features/profile/data/services/bookmark_sevice.dart';
import 'package:safar_khaneh/features/search/data/bookmark_residence_model.dart';
import 'package:safar_khaneh/widgets/cards/bookmark_card.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final BookmarkService _bookmarkService = BookmarkService();

  late Future<List<BookmarkedResidenceModel>> _futureBookmark;

  Future<void> _handleRefresh() async {
    setState(() {
      _futureBookmark = _bookmarkService.fetchBookmarks();
    });
  }

  @override
  void initState() {
    super.initState();
    _futureBookmark = _bookmarkService.fetchBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          title: const Text('پسندیده‌ها'),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          color: AppColors.primary800,
          backgroundColor: AppColors.white,
          elevation: 1,
          edgeOffset: 10,
          strokeWidth: 2.5,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FutureBuilder(
              future: _futureBookmark,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data!.isEmpty || snapshot.data == null) {
                  return const Center(child: Text('هیچ اقامتگاهی یافت نشد'));
                }
                final bookmarks = snapshot.data ?? [];
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: bookmarks.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // یعنی ۲ آیتم در هر ردیف
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio:
                                  0.8, // نسبت طول به عرض آیتم (بسته به طراحی تو تنظیم کن)
                            ),
                        itemBuilder: (context, index) {
                          final item = bookmarks[index];
                          return BookmarkCard(bookmark: item);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
