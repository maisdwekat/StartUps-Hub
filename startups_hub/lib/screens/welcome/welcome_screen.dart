import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../screens/login/login_screen.dart';
import 'Ideas.dart';
import 'Projects.dart';
import 'Search.dart';
import 'WhoWeAre.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  final TextEditingController _searchController = TextEditingController();

  int _currentPage = 1;
  bool _isHoveringIdeas = false;
  bool _isHoveringProjects = false;
  bool _isHoveringAboutUs = false;
  bool _isHoveringHome = false;
  bool _isHoveringSearch = false;
  bool _isSearching = false;

  final List<Map<String, String>> _items = [
    {
      'image': 'assets/images/home1.jpeg',
      'text': 'تطوير الفرص للأفكار الإبداعية وريادة الأعمال ودعم جهود التوسع والوصول إلى أسواق جديدة.',
    },
    {
      'image': 'assets/images/home2.jpeg',
      'text': 'تعزيز الآليات والمتطلبات للتوسع وتطوير قطاع الاستثمار الريادي لتمويل الشركات الناشئة.',
    },
    {
      'image': 'assets/images/home3.jpeg',
      'text': 'تمكين بيئة الأعمال من خلال العمل على تطوير البرامج والحصول على الاستثمارات.',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_currentPage);
    });
    Future.delayed(const Duration(seconds: 3), _nextPage);
  }

  void _nextPage() {
    _currentPage++;
    if (_currentPage >= _items.length + 1) {
      _currentPage = 1;
      _pageController.jumpToPage(1);
    } else {
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
    Future.delayed(const Duration(seconds: 3), _nextPage);
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // المستطيل العلوي
            _buildHeader(),
            // المستطيل الثاني
            _buildNavigationBar(),
            // مستطيل البحث
            _isSearching ? _buildSearchField() : const SizedBox(),
            const SizedBox(height: 30),
            // مستطيل سكني تحت المستطيل الثاني
            _buildInfoSection(),
            const SizedBox(height: 30),
            // عرض الصور
            _buildImageCarousel(),
            const SizedBox(height: 40),
            // الجملة بعد عرض الصور
            _buildMotivationText(),
            const SizedBox(height: 40),
            // زر التسجيل
            _buildRegisterButton(),
            const SizedBox(height: 40),
            _buildIncubationSection(),
            const SizedBox(height: 40),
            // إضافة جملة "فترة الاحتضان" والأيقونات
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 80,
      color: kPrimaryColor,
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            child: Image.asset(
              'assets/images/image500500.png',
              width: 170,
              height: 170,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'حاضنة ستارت أب',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      width: double.infinity,
      color: kLightCreamColor,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          _buildLoginButton(), // زر تسجيل الدخول في أقصى اليسار
          const Spacer(), // استخدام Spacer لفصل العناصر
          Row(
            mainAxisAlignment: MainAxisAlignment.end, // محاذاة العناصر في أقصى اليمين
            children: [
              _buildHoverableText('الأفكار', IdeasScreen(), _isHoveringIdeas, (value) => setState(() => _isHoveringIdeas = value)),
              const SizedBox(width: 16),
              _buildHoverableText('المشاريع', ProjectsScreen(), _isHoveringProjects, (value) => setState(() => _isHoveringProjects = value)),
              const SizedBox(width: 16),
              _buildHoverableText('من نحن', WhoWeAreScreen(), _isHoveringAboutUs, (value) => setState(() => _isHoveringAboutUs = value)),
              const SizedBox(width: 16),
              _buildHoverableText('الرئيسية', WelcomeScreen(), _isHoveringHome, (value) => setState(() => _isHoveringHome = value)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Align( // استخدام Align لضبط المحاذاة
      alignment: Alignment.centerLeft, // محاذاة الزر إلى أقصى اليسار

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            'تسجيل الدخول',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return MouseRegion(
      onEnter: (_) => setState(() { _isHoveringSearch = true; }),
      onExit: (_) => setState(() { _isHoveringSearch = false; }),
      child: GestureDetector(
        onTap: _startSearch,
        child: Text(
          '🔍 بحث',
          style: TextStyle(
            color: _isHoveringSearch ? Colors.blue : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHoverableText(String text, Widget screen, bool isHovering, Function(bool) onHover) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
        child: Text(
          text,
          style: TextStyle(
            color: isHovering ? Colors.blue : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: isHovering ? [const Shadow(color: Colors.grey, blurRadius: 5.0)] : null,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'ابحث عن...',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _stopSearch,
          ),
        ),
        onSubmitted: (value) {
          _stopSearch();
        },
      ),
    );
  }
  // Widget _buildInfoSection() {
  //   return Container(
  //     width: double.infinity,
  //     height: 300,
  //     color: Colors.grey[200],
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         // استخدام صورة بدلاً من Container
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(10), // إضافة زوايا مدورة للصورة
  //           child: Image.asset(
  //             'assets/images/welcome.jpg', // مسار الصورة
  //             width: 350,
  //             height: 400,
  //             fit: BoxFit.cover, // جعل الصورة تغطي الحيز بالكامل
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.end, // محاذاة المحتوى إلى اليمين
  //             children: [
  //               const Text(
  //                 'نحن نحتضن مشروعك مجانًا، ونقدم لك الإرشادات، ثم نساعدك في الحصول على التمويل.',
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.black,
  //                 ),
  //                 textDirection: TextDirection.rtl,
  //               ),
  //               const SizedBox(height: 20), // إضافة مسافة بين النص والزر
  //               _buildRegisterButton(), // زر التسجيل
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildInfoSection() {
    return Stack(
      children: [
        // الصورة في الخلفية
        Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/welcome.jpg'), // مسار الصورة
              fit: BoxFit.cover, // جعل الصورة تغطي الحيز بالكامل
            ),
          ),
        ),
        // المحتوى فوق الصورة
        Container(
          width: double.infinity,
          height: 300,
          color: Colors.black54, // خلفية داكنة مع شفافية للنص
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // محاذاة المحتوى في المنتصف
            children: [
              const Text(
                'أهلاً بك في منصتنا! سجل الآن للحصول على المزيد من المعلومات.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // لون النص
                ),
                textAlign: TextAlign.center, // محاذاة النص في المنتصف
              ),
              const SizedBox(height: 20), // مسافة بين النص والزر
              ElevatedButton(
                onPressed: () {
                  // هنا يمكنك إضافة وظيفة الزر
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent, // لون الخلفية للزر
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
                child: const Text(
                  'سجل الآن',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildImageCarousel() {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _items.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == _items.length + 1) {
            return Container();
          } else {
            return Row(
              children: [
                Expanded(
                  child: Image.asset(
                    _items[index - 1]['image']!,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    _items[index - 1]['text']!,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xE2131313),
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMotivationText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'هل أنت مستعد لتحويل فكرتك المبتكرة إلى عمل مزدهر؟',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: const Color(0xE2122088),
              fontWeight: FontWeight.bold,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 10),
          Text(
            'انضم إلى *مركز الشركات الناشئة* اليوم!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Center(
        child: SizedBox(
          width: 100,
          child: ElevatedButton(
            onPressed: () {
              // هنا يمكنك إضافة وظيفة الزر
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xE2122088),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            child: const Text('سجل الآن'),
          ),
        ),
      ),
    );
  }

  Widget _buildIncubationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // محاذاة المحتوى إلى اليسار
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end, // محاذاة المحتوى إلى اليمين
            children: [
              Icon(Icons.flag, size: 40), // أيقونة العلم
              SizedBox(width: 8), // مسافة بين الأيقونة والنص
              Text(
                'فترة الاحتضان',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textDirection: TextDirection.rtl,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // الصورة على اليسار
              Image.asset(
                'assets/images/one.PNG', // ضع مسار الصورة هنا
                height: 100, // ارتفاع الصورة
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20), // مسافة بين الصورة والأيقونات
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // هنا يمكنك إضافة وظيفة الزر
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // اللون الأخضر
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              textStyle: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            child: const Text('ابدأ الآن'),
          ),
          const SizedBox(height: 40), // مسافة قبل إضافة الصورة في الوسط
          // إضافة الصورة في وسط الصفحة
          Center(
            child: Image.asset(
              'assets/images/two.PNG', // ضع مسار الصورة هنا
              height: 120, // ارتفاع الصورة
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFooter() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/image400400.png',
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(
            'نحن نحتضن مشروعك مجانًا، ونقدم لك الإرشادات، ثم نساعدك في الحصول على التمويل.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xE2122088),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'اتصل بنا\n'
                'فلسطين – نابلس\n'
                'البريد الإلكتروني: StartupsHub@gmail.com\n'
                'الهاتف: 97022945845+\n'
                'الفاكس: 97022946947+\n'
                'حقوق الطبع والنشر © 2024',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          // أزرار التواصل الاجتماعي
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(FontAwesomeIcons.facebook),
                onPressed: () {
                  // رابط فيسبوك
                },
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.instagram),
                onPressed: () {
                  // رابط إنستجرام
                },
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.twitter),
                onPressed: () {
                  // رابط تويتر
                },
              ),
              IconButton(
                icon: const Icon(FontAwesomeIcons.linkedin),
                onPressed: () {
                  // رابط لينكدإن
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}