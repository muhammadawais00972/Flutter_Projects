

import 'package:flashchat/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flashchat/routes/app_routes.dart';
import 'package:flashchat/controllers/auth_Controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<double>_fadeanimation;
  late Animation<double>_scaleanimation;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this, //
      duration:  Duration(seconds: 2), // Set the duration of the animation
    );
    _fadeanimation= Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController,
          curve: Curves.easeIn)
    );

    _scaleanimation= Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _animationController,
            curve: Curves.elasticOut)
    );
    _animationController.forward();
    _checkAuthAndNavigation();
  //

  }
  void _checkAuthAndNavigation() async{

  await Future.delayed(Duration(seconds: 2));
  final  authController=Get.put(AuthController());
  await Future.delayed(Duration(milliseconds: 500));
  if(authController.isAuthenticated){
    Get.offAllNamed(AppRoutes.main);
  }else{
    Get.offAllNamed(AppRoutes.login);
  }

  }

@override
  void dispose() {

    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppTheme.successColor,
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context,child){
              return FadeTransition(opacity: _fadeanimation,
              child: ScaleTransition(scale: _scaleanimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0,10),
                            )
                          ]
                      ),
                      child: Icon(Icons.chat_bubble_outlined,
                        color: AppTheme.successColor,
                        size: 60,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      'Chat App',
                      style: Theme.of(context).textTheme.
                      headlineLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 20,),
                    Text("Connect with Friends Instantly",
                        style: Theme.of(context).textTheme.
                        headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,

                        ),
                    ),
                    SizedBox(height: 60,),
                    CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )

                ],
                ),
              ),

              );
            }
        ),
      ),

    );
  }
}
