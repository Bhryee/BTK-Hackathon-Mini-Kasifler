import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled1/Screen/HomeScreen2.dart';
import 'package:untitled1/Screen/UserProfileScreen.dart';
import 'Screen/SavePin_Screen.dart';
import 'Screen/CheckPin_Screen.dart';
import 'Screen/Login.dart';
import 'Screen/Navigation.dart';
import 'Screen/sign_in_screen.dart';
import 'auth/auth_methods.dart';
import 'executive/data/Informations_service.dart';
import 'executive/data/informations_provider.dart';
import 'firebase_options.dart';

final storage = FlutterSecureStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  // Check if there's a saved user ID
  String? userId = await storage.read(key: "userId");

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({Key? key, this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            Provider<FlutterFireAuthService>(
              create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
            ),
            StreamProvider<User?>(
              create: (context) =>
                  context.read<FlutterFireAuthService>().authStateChanges,
              initialData: null,
            ),
            Provider<InformationsService>(
              create: (_) => InformationsService(),
            ),
            ChangeNotifierProvider(create: (context) => InformationsProvider()),
          ],
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: {
              "/login": (context) => LoginScreen(),
              "/signIn": (context) => SignInScreen(),
              "/SavePinScreen": (context) => SavePinScreen(),
              "/ChenkPinScreen": (context) => CheckPinScreen(),
              "/HomeScreen2":(context)=>HomeScreen2(),
              "/navigation": (context) => NavigationsScreen(userId: userId!),
              "/userProfile": (context) => UserProfileScreen(userId: userId!),
            },
           home: userId == null ? LoginScreen() : CheckPinScreen(),
          //    home:SignInScreen(),
          ),
        );
      },
    );
  }
}
