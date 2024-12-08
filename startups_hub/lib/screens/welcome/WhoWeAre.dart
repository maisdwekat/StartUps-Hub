import 'package:flutter/material.dart';
import 'package:startups_hub/screens/welcome/welcome_screen.dart';
import '../../../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Login/login_screen.dart';
import 'Ideas.dart';
import 'Projects.dart';
import 'Search.dart';

class WhoWeAreScreen extends StatefulWidget {
  const WhoWeAreScreen({super.key});

  @override
  _WhoWeAreScreenState createState() => _WhoWeAreScreenState();
}

class _WhoWeAreScreenState extends State<WhoWeAreScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isHoveringIdeas = false;
  bool _isHoveringProjects = false;
  bool _isHoveringAboutUs = false;
  bool _isHoveringHome = false;
  bool _isHoveringSearch = false;
  bool _isSearching = false;




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
            //اضافة صور في بداية صفحة من نحن
            _buildImageWithText (),
            const SizedBox(height: 30),
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
//بداية محتوى الصفحة
  Widget _buildImageWithText() {
    return Stack(
      alignment: Alignment.center, // محاذاة العناصر في المنتصف
      children: [
        // الصورة في الخلفية
        Container(
          width: double.infinity,
          height: 300,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BG9.jpg'), // استبدلها بمسار الصورة الخاص بك
              fit: BoxFit.cover, // جعل الصورة تغطي الحيز بالكامل
            ),
          ),
        ),

      ],
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

