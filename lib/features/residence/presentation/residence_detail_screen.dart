import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/core/network/secure_token_storage.dart';
import 'package:safar_khaneh/core/utils/number_formater.dart';
import 'package:safar_khaneh/data/service/chat_services.dart';
import 'package:safar_khaneh/trash/models/comment_model.dart';
import 'package:safar_khaneh/features/profile/data/bookmark_sevice.dart';
import 'package:safar_khaneh/features/search/data/bookmark_residence_model.dart';
import 'package:safar_khaneh/features/search/data/residence_model.dart';
import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/inputs/text_field.dart';
import 'package:safar_khaneh/widgets/map.dart';
import 'package:safar_khaneh/widgets/comment_widget.dart';
import 'package:url_launcher/url_launcher.dart';

final List<CommentModel> comments = [
  CommentModel(
    id: 1,
    name: 'جعفر غلام‌حسینی',
    residenceId: 1,
    text:
        'اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن و اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن',
    rating: 5,
    createdAt: '2022-11-09T12:38:51.082843Z',
  ),
  CommentModel(
    id: 2,
    name: 'محمد کارگر',
    residenceId: 1,
    text:
        'اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن',
    rating: 5,
    createdAt: '2021-06-09T12:38:51.082843Z',
  ),
  CommentModel(
    id: 3,
    name: 'محمد حسینی',
    residenceId: 1,
    text:
        'اقامتگاه خوبی فقط یکم سقفش چکه میکرد که گفتم درست کنن و در اسرع وقت درستش کردن',
    rating: 5,
    createdAt: '2024-09-09T12:38:51.082843Z',
  ),
];

class ResidenceDetailScreen extends StatefulWidget {
  final ResidenceModel residence;
  final BookmarkedResidenceModel? bookmark;

  const ResidenceDetailScreen({
    super.key,
    required this.residence,
    this.bookmark,
  });

  @override
  State<ResidenceDetailScreen> createState() => _ResidenceDetailScreenState();
}

class _ResidenceDetailScreenState extends State<ResidenceDetailScreen> {
  final TextEditingController textController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final BookmarkService _bookmarkService = BookmarkService();
  final ChatService _chatService = ChatService();

  int? _bookmarkId;

  @override
  void initState() {
    super.initState();
    textController.text = '';
    ratingController.text = '';
    _loadBookmarkStatus();
  }

  //*گرفتن لیست کل بوکمارک ها و تطبیقشون با اقامتگاه مربوطه
  void _loadBookmarkStatus() async {
    final hasToken = await TokenStorage.hasAccessToken();

    if (!hasToken) return;

    try {
      final bookmarks = await _bookmarkService.fetchBookmarks();

      final match = bookmarks.where(
        (b) => b.residence.id == widget.residence.id,
      );

      if (match.isNotEmpty) {
        setState(() {
          _bookmarkId = match.first.id;
          widget.residence.isBookmark = true;
        });
      }
    } catch (e) {
      return;
    }
  }

  @override
  void dispose() {
    textController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  void _handleBookmark(context) async {
    final hasRefreshToken = await TokenStorage.hasRefreshToken();

    if (!hasRefreshToken) {
      showDialog(
        context: context,
        builder:
            (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('ورود به حساب'),
                content: const Text('ابتدا وارد حساب کاربری خود شوید.'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'انصراف',
                      style: TextStyle(color: AppColors.error200, fontSize: 16),
                    ),
                  ),
                  Button(onPressed: () => context.go('/login'), label: 'ورود'),
                ],
              ),
            ),
      );
      return;
    }

    try {
      final isBookmarked = widget.residence.isBookmark ?? false;

      if (isBookmarked) {
        if (_bookmarkId != null) {
          await _bookmarkService.removeBookmark(_bookmarkId!);
          setState(() {
            widget.residence.isBookmark = false;
            _bookmarkId = null;
          });
        }
      } else {
        final response = await _bookmarkService.addBookmark(
          widget.residence.id!,
        );

        final bookmarked = BookmarkedResidenceModel.fromJson(response);
        setState(() {
          widget.residence.isBookmark = true;
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
          backgroundColor: AppColors.error200,
        ),
      );
    }
  }

  void _handlePhone(context) async {
    final phone = widget.residence.owner?.phoneNumber.toString();
    if (phone != null) {
      final Uri phoneUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            content: Text('متاسفانه امکان تماس با این شماره وجود ندارد'),
            backgroundColor: AppColors.error200,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ثبت نظر',
                style: TextStyle(color: AppColors.primary800),
              ),
              IconButton(
                icon: const Icon(
                  Iconsax.close_circle,
                  color: AppColors.primary800,
                ),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTextField(
                label: 'امتیاز (۱ تا ۵)',
                initialValue: ratingController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              InputTextField(
                label: 'متن نظر خود را وارد کنید',
                maxLines: 4,
                initialValue: textController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'انصراف',
                style: TextStyle(color: AppColors.error200),
              ),
            ),
            Button(onPressed: () => Navigator.pop(context), label: 'ثبت'),
          ],
        );
      },
    );
  }

  void _handleChat(context) async {
    final hasRefreshToken = await TokenStorage.hasRefreshToken();

    if (!hasRefreshToken) {
      showDialog(
        context: context,
        builder:
            (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('ورود به حساب'),
                content: const Text('ابتدا وارد حساب کاربری خود شوید.'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text(
                      'انصراف',
                      style: TextStyle(color: AppColors.error200, fontSize: 16),
                    ),
                  ),
                  Button(onPressed: () => context.go('/login'), label: 'ورود'),
                ],
              ),
            ),
      );
      return;
    }

    try {
      final roomData = await _chatService.createRoom(widget.residence.id!);
      final roomId = roomData['room_id'];
      final currentUserId = await TokenStorage.getUserId();
      GoRouter.of(context).push(
        '/chat/$roomId',
        extra: {
          'roomId': roomId,
          'receiverName': widget.residence.owner?.fullName ?? 'نامشخص',
          'currentUserId': currentUserId,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('خطا : $e', textDirection: TextDirection.rtl),
          backgroundColor: AppColors.error200,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.white,
          leading: IconButton(
            onPressed: () {
              _handleBookmark(context);
            },
            icon: Icon(
              widget.residence.isBookmark ?? false
                  ? Iconsax.heart5
                  : Iconsax.heart,
              color: AppColors.primary800,
            ),
          ),
          title: const Text('اطلاعات اقامتگاه'),
          actions: [
            IconButton(
              icon: const Icon(Iconsax.arrow_left),
              onPressed: () => context.pop(),
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.residence.id!,
                    child: Image.network(
                      widget.residence.imageUrl!,
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -32),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(32),
                        topLeft: Radius.circular(32),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(top: 0),
                        color: AppColors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            widget.residence.title!,
                                            style: TextStyle(
                                              color: AppColors.grey900,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                formatNumberToPersianWithoutSeparator(
                                                  widget.residence.avgRating
                                                      .toString(),
                                                ),
                                                style: TextStyle(
                                                  color: AppColors.grey800,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              const Icon(
                                                Iconsax.star1,
                                                color: AppColors.accentColor,
                                                size: 24,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Iconsax.location5,
                                            color: AppColors.primary800,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${widget.residence.location?.city?.name}, ${widget.residence.location?.city?.province?.name}',
                                            style: TextStyle(
                                              color: AppColors.grey700,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primary800,
                                        width: 2,
                                      ),
                                      color: AppColors.primary800,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(
                                            alpha: 0.2,
                                          ),
                                          offset: const Offset(0, -2),
                                          blurRadius: 16,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Iconsax.message5,
                                        color: AppColors.white,
                                      ),
                                      onPressed: () {
                                        _handleChat(context);
                                      },
                                      tooltip: 'شروع گفتگو',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.primary700,
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.15,
                                      ),
                                      offset: const Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.personalcard,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'مدیر:',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          widget.residence.owner?.fullName ??
                                              'نامشخص',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.call,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'شماره تماس:',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 79,
                                          height: 30,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.primary800,
                                              backgroundColor: AppColors.white,
                                              side: BorderSide(
                                                color: AppColors.primary800,
                                              ),
                                            ),
                                            child: const Text(
                                              'تماس',
                                              style: TextStyle(
                                                color: AppColors.primary800,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: () {
                                              _handlePhone(context);
                                            },
                                          ),
                                        ),
                                        Text(
                                          formatNumberToPersianWithoutSeparator(
                                            widget
                                                    .residence
                                                    .owner
                                                    ?.phoneNumber ??
                                                'نامشخص',
                                          ),
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Divider(
                                      color: AppColors.primary700,
                                      thickness: 1,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.profile_2user,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'ظرفیت نفرات: ',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${formatNumberToPersianWithoutSeparator(widget.residence.capacity.toString())} نفر',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.house,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'تعداد اتاق:',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${formatNumberToPersianWithoutSeparator(widget.residence.roomCount!.toString())} اتاق',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.moon,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'تعداد شب:',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${formatNumberToPersianWithoutSeparator(widget.residence.maxNightsStay.toString())} شب',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Divider(
                                      color: AppColors.primary700,
                                      thickness: 1,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.money,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'قیمت نظافت',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${formatNumberToPersian(widget.residence.cleaningPrice!)} تومان',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Iconsax.money_3,
                                              color: AppColors.primary800,
                                              size: 22,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'قیمت خدمات',
                                              style: TextStyle(
                                                color: AppColors.grey500,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${formatNumberToPersian(widget.residence.servicesPrice!)} تومان',
                                          style: TextStyle(
                                            color: AppColors.grey800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 32),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'امکانات',
                                    style: TextStyle(
                                      color: AppColors.grey800,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children:
                                        (widget.residence.features ?? [])
                                            .map(
                                              (facility) => Chip(
                                                backgroundColor:
                                                    AppColors.secondary100,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  side: BorderSide(
                                                    color: AppColors.primary700,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                label: Text(
                                                  facility.name,
                                                  style: TextStyle(
                                                    color: AppColors.primary700,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'توضیحات',
                                    style: TextStyle(
                                      color: AppColors.grey800,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.residence.description ??
                                        'توضیحات ندارد',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: AppColors.grey700,
                                      fontSize: 14,
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              if (widget.residence.location?.lat != null &&
                                  widget.residence.location?.lng != null)
                                SizedBox(
                                  height: 300,
                                  child: MapWidget(
                                    latitude: widget.residence.location!.lat!,
                                    longitude: widget.residence.location!.lng!,
                                  ),
                                )
                              else
                                const Text('مختصات موجود نیست'),
                              const SizedBox(height: 32),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'نظرات',
                                    style: TextStyle(
                                      color: AppColors.grey800,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 152,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: comments.length,
                                      itemBuilder: (context, index) {
                                        final comment = comments[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: CommentWidget(
                                            comment: comment,
                                            maxLines: 3,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Button(
                                    onPressed: () {
                                      showCommentDialog(context);
                                    },
                                    label: 'ثبت نظر',
                                    width: double.infinity,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 72),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Positioned(
            //   bottom: 100,
            //   right: 16,
            //   child: Container(
            //     width: 56,
            //     height: 56,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       border: Border.all(color: AppColors.primary800, width: 2),
            //       color: AppColors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withValues(alpha: 0.2),
            //           offset: const Offset(0, -2),
            //           blurRadius: 16,
            //           spreadRadius: 2,
            //         ),
            //       ],
            //     ),
            //     child: IconButton(
            //       icon: const Icon(
            //         Iconsax.message,
            //         color: AppColors.primary800,
            //       ),
            //       onPressed: () {
            //         _handleChat(context);
            //       },
            //       tooltip: 'شروع گفتگو',
            //     ),
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(0, -2),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          formatNumberToPersian(
                            widget.residence.pricePerNight!,
                          ),
                          style: TextStyle(
                            color: AppColors.grey900,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'تومان',
                          style: TextStyle(
                            color: AppColors.grey900,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Button(
                      label: 'همین الان رزرو کنید',
                      onPressed: () {
                        context.push(
                          '/residence/${widget.residence.id}/request_to_book',
                          extra: widget.residence,
                        );
                      },
                      enabled: widget.residence.isActive!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
