import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/data/models/bookmark_model.dart';
import 'package:safar_khaneh/widgets/cards/most_popular_card.dart';

// final List<Map<String, dynamic>> jsonList = [
//   {
//     "id": 2,
//     "residence": {
//       "id": 2,
//       "title": "ویلا حسامی",
//       "price_per_night": 2,
//       "image_url": "sfdgsfgs",
//       "location": {
//         "id": 1,
//         "city_name": "قم",
//         "province_name": "قم",
//         "address": "انسجام",
//         "lat": "100.160000",
//         "lng": "165.650000",
//       },
//     },
//     "created_at": "2025-06-09T12:38:51.082843Z",
//   },
//   {
//     "id": 1,
//     "residence": {
//       "id": 1,
//       "title": "ویلا حسومی",
//       "price_per_night": 100000,
//       "image_url": "affsfaf",
//       "location": {
//         "id": 1,
//         "city_name": "قم",
//         "province_name": "قم",
//         "address": "انسجام",
//         "lat": "100.160000",
//         "lng": "165.650000",
//       },
//     },
//     "created_at": "2025-06-09T12:24:19.256910Z",
//   },
// ];

// List<BookmarkModel> bookmarks =
//     jsonList.map((json) => BookmarkModel.fromJson(json)).toList();

final List<BookmarkModel> bookmarks = [
  BookmarkModel(
    id: '1',
    title: 'خانه بزرگ',
    city: 'اصفهان',
    province: 'کاشان',
    price: 120000,
    rating: 4.5,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'دختر', 'بازم دختر', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/3.jpg',
    capacity: 4,
    cleaningFee: 20000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '2',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 150000,
    rating: 4.7,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'پسر', 'بازم پسر', 'عدم وجود دختر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/1.jpg',
    capacity: 3,
    cleaningFee: 10000,
    serviceFee: 30000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '3',
    title: 'آپارتمان لوکس',
    city: 'تهران',
    province: 'سعادت آباد',
    price: 200000,
    rating: 4.8,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/2.jpg',
    capacity: 2,
    cleaningFee: 20000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '4',
    title: 'خانه سنتی',
    city: 'کاشان',
    province: 'کاشان',
    price: 100000,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    rating: 4.3,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/4.jpg',
    capacity: 5,
    cleaningFee: 15000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '5',
    title: 'ویلا کوهستانی',
    city: 'قم',
    province: 'قم',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/4.jpg',
    capacity: 4,
    cleaningFee: 25000,
    serviceFee: 20000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '6',
    title: 'ویلا کویری',
    city: 'قم',
    province: 'قم',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/2.jpg',
    capacity: 10,
    cleaningFee: 10000,
    serviceFee: 30000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
  BookmarkModel(
    id: '7',
    title: 'ویلا کویری',
    city: 'قم',
    province: 'قم',
    price: 100000,
    rating: 4.3,
    latitude: 35.6895,
    longitude: 51.3892,
    manager: 'مهدی حسومی',
    roomCount: 4,
    description:
        'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
    facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
    isFavorite: true,
    backgroundImage: 'assets/images/Residences/2.jpg',
    capacity: 10,
    cleaningFee: 10000,
    serviceFee: 30000,
    startDate: '1400/01/01',
    endDate: '1400/01/01',
    phoneNumber: 912345678,
  ),
];

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

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
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookmarks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // یعنی ۲ آیتم در هر ردیف
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio:
                  0.8, // نسبت طول به عرض آیتم (بسته به طراحی تو تنظیم کن)
            ),
            itemBuilder: (context, index) {
              final item = bookmarks[index];
              return MostPopularCard(residence: item.toResidenceCardModel());
            },
          ),
        ),
      ),
    );
  }
}
