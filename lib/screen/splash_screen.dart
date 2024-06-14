// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   // final ConnectivityService connectivityService;
//   final GlobalKey<NavigatorState> navigatorKey;

//   const SplashScreen({Key? key, required this.navigatorKey}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   List<dynamic> _spec = [];
//   bool skip = true;
//   DateTime completionTime = DateTime.now().add(Duration(hours: 1));

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     );
//     // DependencyInjection.init();
    
//     _animation = CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.bounceOut, 
//     );

//     _animationController.forward();

//     Timer(Duration(seconds: 4), () {
      
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Pallets.backgroundcolor,
//       body: Padding(
//         padding: EdgeInsets.only(top: 70),
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (BuildContext context, Widget? child) {
//               return Transform.scale(
//                 scale: _animation.value,
//                 child: Container(
//                   child: Image.asset(
//                     'assets/logo2.png',
//                     width: 200,
//                     height: 200,
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }