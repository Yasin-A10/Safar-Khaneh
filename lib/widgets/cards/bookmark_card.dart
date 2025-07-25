import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/features/profile/data/services/bookmark_sevice.dart';
import 'package:safar_khaneh/features/search/data/models/bookmark_residence_model.dart';
// import 'package:safar_khaneh/features/search/data/residence_model.dart';

class BookmarkCard extends StatefulWidget {
  final BookmarkedResidenceModel bookmark;

  const BookmarkCard({super.key, required this.bookmark});

  @override
  State<BookmarkCard> createState() => _BookmarkCardState();
}

class _BookmarkCardState extends State<BookmarkCard> {
  BookmarkedResidenceModel get bookmark => widget.bookmark;

  final BookmarkService _bookmarkService = BookmarkService();
  int? _bookmarkId;

  @override
  void initState() {
    super.initState();
    setState(() {
      _bookmarkId = widget.bookmark.id;
    });
  }

  void _handleBookmark(context) async {
    try {
      final isBookmarked = bookmark.residence.isBookmark;

      if (isBookmarked == true) {
        if (_bookmarkId != null) {
          await _bookmarkService.removeBookmark(_bookmarkId!);
          setState(() {
            bookmark.residence.isBookmark = false;
            _bookmarkId = null;
          });
        }
      } else {
        final response = await _bookmarkService.addBookmark(
          bookmark.residence.id!,
        );
        final bookmarked = BookmarkedResidenceModel.fromJson(response);
        setState(() {
          bookmark.residence.isBookmark = true;
          _bookmarkId = bookmarked.id;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'خطا در تغییر وضعیت بوکمارک. دوباره تلاش کنید.',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: Colors.red.shade300,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/residence/${bookmark.residence.id}',
          extra: bookmark.residence,
        );
      },
      child: Container(
        width: 180,
        height: 250,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: bookmark.residence.id!,
                child: Image.network(
                  bookmark.residence.imageUrl!,
                  fit: BoxFit.cover,
                  color: Colors.black.withValues(alpha: 0.3),
                  colorBlendMode: BlendMode.darken,
                  cacheWidth: 180,
                  cacheHeight: 250,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          _handleBookmark(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            bookmark.residence.isBookmark ?? false
                                ? Iconsax.heart5
                                : Iconsax.heart,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookmark.residence.title!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bookmark.residence.location!.city!.name}, ${bookmark.residence.location!.city!.province!.name}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            formatNumberToPersian(
                              bookmark.residence.pricePerNight!,
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatNumberToPersianWithoutSeparator(
                                bookmark.residence.avgRating,
                              ),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Iconsax.star1,
                              color: Colors.yellow,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         residence.isFavorite = !residence.isFavorite!;
                    //       });
                    //     },
                    //     child: Container(
                    //       padding: const EdgeInsets.all(6),
                    //       decoration: const BoxDecoration(
                    //         color: Colors.white,
                    //         shape: BoxShape.circle,
                    //       ),
                    //       child: Icon(
                    //         residence.isFavorite ?? false
                    //             ? Iconsax.heart5
                    //             : Iconsax.heart,
                    //         color: Colors.red,
                    //         size: 18,
                    //       ),
                    //     ),
                    //   ),
                    // ),