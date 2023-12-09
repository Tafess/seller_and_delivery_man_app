import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:sellers/constants/theme.dart';
import 'package:sellers/controllers/firebase_auth_helper.dart';
import 'package:sellers/firebase_options.dart';
import 'package:sellers/providers/app_provider.dart';
import 'package:sellers/screens/welcome.dart';
import 'package:sellers/widgets/bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51OFnrbL5s11I9QDMOFtPyDVhgwlglgvExwrsPoeZwvmFJa3hv6kdqMY06muBIWP3OgnqOGeQpMwmzOocYcWECL8k00hpdzUzvM';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        
        title: 'Belkis ',
        theme: themeData,
        darkTheme: themeData,
        
        
        home: StreamBuilder(
            stream: FirebaseAuthHelper.instance.getAuthChange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const CustomBottomBar();
              } else {
                return const Welcome();
              }
            }),
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sellers/constants/theme.dart';
// import 'package:sellers/controllers/firebase_firestore_helper.dart';
// import 'package:sellers/firebase_options.dart';
// import 'package:sellers/provider/app_provider.dart';
// import 'package:sellers/screens/home_page.dart';
// import 'package:sellers/screens/login.dart';
// import 'package:sellers/screens/welcome_screen.dart';
// import 'controllers/firebase_auth_helper.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AppProvider()),
//         // Provider<FirebaseAuthHelper>(
//         //     create: (_) => FirebaseAuthHelper.instance),
//         // Provider<FirebaseFirestoreHelper>(
//         //     create: (_) => FirebaseFirestoreHelper.instance),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Dashboard',
//         theme: themeData,
//         home: StreamBuilder(
//             stream: FirebaseAuthHelper.instance.getAuthChange,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return const LoginScreen();
//               } else {
//                 return const WelcomeScreen();
//               }
//             }),
//       ),
//     );
//   }
// }
