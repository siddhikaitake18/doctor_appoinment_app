import 'package:flutter/material.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();

  int currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'icon': Icons.search,
      'title': 'Find Your Doctor',
      'text': 'Find the right doctor for your needs.',
    },
    {
      'icon': Icons.calendar_month,
      'title': 'Choose Date & Time',
      'text': 'Select your preferred appointment date and time.',
    },
    {
      'icon': Icons.check_circle,
      'title': 'Book Easily',
      'text': 'Book your appointment quickly and easily.',
    },
  ];

  void nextPage() {
    if (currentPage < pages.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      goToLogin();
    }
  }

  void goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: goToLogin,
                child: const Text('Skip'),
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        pages[index]['icon'],
                        size: 100,
                      ),

                      const SizedBox(height: 30),

                      Text(
                        pages[index]['title'],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Text(
                          pages[index]['text'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            Text(
              '${currentPage + 1} / ${pages.length}',
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextPage,
                  child: Text(
                    currentPage == pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}