import 'dart:ui';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:safar_khaneh/core/constants/colors.dart';
import 'package:safar_khaneh/features/home/data/home_page_model.dart';
import 'package:safar_khaneh/features/home/data/home_page_service.dart';
// import 'package:safar_khaneh/widgets/button.dart';
import 'package:safar_khaneh/widgets/cards/home_page_card.dart';
import 'package:safar_khaneh/widgets/footer.dart';
import 'package:safar_khaneh/widgets/search_bar.dart';

// final List<ResidenceCardModel> residenceCardList = [
//   ResidenceCardModel(
//     id: '1',
//     title: 'خانه بزرگ',
//     city: 'کاشان',
//     province: 'مرکز',
//     price: 120000,
//     rating: 4.5,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'دختر', 'بازم دختر', 'عدم وجود پسر'],
//     isFavorite: true,
//     backgroundImage: 'assets/images/Residences/3.jpg',
//     capacity: 4,
//     cleaningFee: 20000,
//     serviceFee: 20000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
//   ResidenceCardModel(
//     id: '2',
//     title: 'ویلا کوهستانی',
//     city: 'قم',
//     province: 'قم',
//     price: 150000,
//     rating: 4.7,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'پسر', 'بازم پسر', 'عدم وجود دختر'],
//     isFavorite: true,
//     backgroundImage: 'assets/images/Residences/1.jpg',
//     capacity: 3,
//     cleaningFee: 10000,
//     serviceFee: 30000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
//   ResidenceCardModel(
//     id: '3',
//     title: 'آپارتمان لوکس',
//     city: 'تهران',
//     province: 'سعادت آباد',
//     price: 200000,
//     rating: 4.8,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
//     isFavorite: false,
//     backgroundImage: 'assets/images/Residences/2.jpg',
//     capacity: 1,
//     cleaningFee: 50000,
//     serviceFee: 20000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
//   ResidenceCardModel(
//     id: '4',
//     title: 'خانه سنتی',
//     city: 'کاشان',
//     province: 'مرکز',
//     price: 100000,
//     rating: 4.3,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
//     isFavorite: false,
//     backgroundImage: 'assets/images/Residences/4.jpg',
//     capacity: 5,
//     cleaningFee: 15000,
//     serviceFee: 20000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
//   ResidenceCardModel(
//     id: '5',
//     title: 'ویلا کوهستانی',
//     city: 'کاشان',
//     province: 'مرکز',
//     price: 100000,
//     rating: 4.3,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
//     isFavorite: true,
//     backgroundImage: 'assets/images/Residences/4.jpg',
//     capacity: 8,
//     cleaningFee: 25000,
//     serviceFee: 20000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
//   ResidenceCardModel(
//     id: '6',
//     title: 'ویلا کویری',
//     city: 'قم',
//     province: 'قم',
//     price: 100000,
//     rating: 4.3,
//     latitude: 35.6895,
//     longitude: 51.3892,
//     manager: 'مهدی حسومی',
//     roomCount: 4,
//     description:
//         'لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.',
//     facilities: ['استخر', 'غذا', 'حسوم', 'عدم وجود پسر'],
//     isFavorite: false,
//     backgroundImage: 'assets/images/Residences/2.jpg',
//     capacity: 4,
//     cleaningFee: 50000,
//     serviceFee: 20000,
//     startDate: '1400/01/01',
//     endDate: '1400/01/01',
//     phoneNumber: 912345678,
//   ),
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomePageService homePageService = HomePageService();
  late Future<HomePageModel> _homePageData;
  @override
  void initState() {
    super.initState();
    _homePageData = homePageService.fetchHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/Residences/main-page.webp',
                        color: Colors.black.withValues(alpha: 0.1),
                        colorBlendMode: BlendMode.darken,
                        fit: BoxFit.cover,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.1),
                      ),
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'اجاره آنلاین ویلا در سراسر کشور با سفرخانه',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Transform.translate(
                        offset: const Offset(0, 24),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.1,
                                        ),
                                        offset: const Offset(0, 2),
                                        blurRadius: 9,
                                      ),
                                    ],
                                  ),
                                  child: CustomSearchBar(
                                    onSearch: (value) {},
                                    hintText: 'جستجو کنید...',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary800,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                    horizontal: 20.0,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Vazir',
                                  ),
                                ),
                                child: const Text('جستجو'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              // Button(
              //   label: 'جستجو',
              //   onPressed: () {
              //     context.go('/reset-password');
              //   },
              //   width: double.infinity,
              // ),
              // const SizedBox(height: 24),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'محبوب ترین‌ها',
                          style: TextStyle(
                            fontFamily: 'Vazir',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'مشاهده همه',
                            style: TextStyle(
                              color: AppColors.primary800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Vazir',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  FutureBuilder(
                    future: _homePageData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('خطا در دریافت اطلاعات'),
                        );
                      } else {
                        final residenceCardList =
                            snapshot.data!.topRatedResidences;
                        return SizedBox(
                          height: 250,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: residenceCardList.length,
                            itemBuilder: (context, index) {
                              final item = residenceCardList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: HomePageCard(residence: item),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 24),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'جدید ترین‌ها',
                              style: TextStyle(
                                fontFamily: 'Vazir',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'مشاهده همه',
                                style: TextStyle(
                                  color: AppColors.primary800,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Vazir',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder(
                        future: _homePageData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('خطا در دریافت اطلاعات'),
                            );
                          } else {
                            final residenceCardList =
                                snapshot.data!.newestResidences;
                            return SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: residenceCardList.length,
                                itemBuilder: (context, index) {
                                  final item = residenceCardList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: HomePageCard(residence: item),
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  FooterWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
