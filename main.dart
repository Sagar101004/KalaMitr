import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:iconsax/iconsax.dart';
import 'login_screen.dart'; // Adjust path if needed
import 'signup_page.dart'; // Make sure this path is correct
import 'home_pg.dart';
import 'reels_pg.dart';
import 'sales_pg.dart';
import 'create_pg.dart';
import 'profile_pg.dart'; // Make sure this path is correct
import 'splash_screen.dart'; // Assuming this exists
import 'services/auth_service.dart'; // Import AuthService to get user ID

// Global cameras list
List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize cameras with proper error handling
  await _initializeCameras();

  runApp(const KalaMitrApp());
}

Future<void> _initializeCameras() async {
  try {
    // Request permissions
    final cameraPermission = await Permission.camera.request();
    final microphonePermission = await Permission.microphone.request();

    if (cameraPermission.isGranted) {
      // Get available cameras
      cameras = await availableCameras();
      print('Cameras initialized: ${cameras.length} cameras found');
    } else {
      print('Camera permission denied');
    }
  } catch (e) {
    print('Error initializing cameras: $e');
    cameras = []; // Ensure cameras list is empty on error
  }
}

class KalaMitrApp extends StatelessWidget {
  const KalaMitrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalaMitr',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins', // Ensure you have this font configured
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
        ),
      ),
      // --- Updated Initial Route ---
      // Pass isLoggedIn: false initially. SplashScreen will handle the check.
      home: const SplashScreen(isLoggedIn: false), // Pass false initially
      routes: {
        // --- Named Routes for Login/Signup Flow ---
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        // --- Named Route for Main App Screen (Bottom Nav) ---
        '/home': (context) => const MainScreen(), // Use '/home' as the key
        // Keep '/main' if other parts use it, but '/home' is clearer for the bottom nav screen
        // '/main': (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late PageController _pageController;
  int? _currentUserId; // Store the current user's ID

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    WidgetsBinding.instance.addObserver(this);
    _fetchCurrentUserId(); // Fetch the user ID when the screen initializes
  }

  // Function to fetch the current user's ID
  Future<void> _fetchCurrentUserId() async {
    try {
      final profileData = await AuthService().getProfile();
      if (profileData != null && profileData.containsKey('user')) {
        final user = profileData['user'];
        setState(() {
          _currentUserId = user['id']; // Assuming 'id' is the key for user ID
        });
      } else {
        // Handle case where profile data is not available
        print("Could not fetch user ID from profile data.");
        // Potentially navigate back to login if token is invalid
      }
    } catch (e) {
      print("Error fetching user ID: $e");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes for camera
    if (state == AppLifecycleState.resumed) {
      // Reinitialize cameras if needed when app resumes
      _reinitializeCamerasIfNeeded();
    }
  }

  Future<void> _reinitializeCamerasIfNeeded() async {
    if (cameras.isEmpty) {
      await _initializeCameras();
      setState(() {}); // Refresh UI
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create the list of pages for the PageView
    List<Widget> pages = [
      const HomePage(),
      ReelsPage(), // Assuming these constructors are correct
      CreatePage(),
      SalesPage(),
      // Pass the current user ID to the ProfilePage
      if (_currentUserId != null)
        ProfilePage(userId: _currentUserId!) // Pass the fetched user ID
      else
        const Center(child: CircularProgressIndicator()), // Show loading if ID not fetched yet
    ];

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: pages, // Use the dynamic list of pages
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Iconsax.home),
              activeIcon: Icon(Iconsax.home_15),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.play_circle),
              activeIcon: Icon(Iconsax.play_circle5),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.add_square),
              activeIcon: Icon(Iconsax.add_square5),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.shop),
              activeIcon: Icon(Iconsax.shop5),
              label: 'Sales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Iconsax.user),
              activeIcon: Icon(Iconsax.user5),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Utility class for app-wide camera management (unchanged)
class CameraManager {
  static List<CameraDescription> _cameras = [];

  static List<CameraDescription> get cameras => _cameras;

  static Future<bool> initializeCameras() async {
    try {
      final cameraPermission = await Permission.camera.request();

      if (cameraPermission.isGranted) {
        _cameras = await availableCameras();
        return true;
      }
      return false;
    } catch (e) {
      print('Error initializing cameras: $e');
      return false;
    }
  }

  static Future<bool> hasPermissions() async {
    final cameraPermission = await Permission.camera.status;
    return cameraPermission.isGranted;
  }
}