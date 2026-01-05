import 'package:flashchat/routes/app_routes.dart';
import 'package:flashchat/views/auth/login_view.dart';
import 'package:flashchat/views/auth/register_view.dart';
import 'package:get/get.dart';
import '../controllers/forgot_password_controller.dart';
import '../views/auth/forgotpassword_view.dart';
import '../views/auth/splash_screen.dart';
class AppPages {
  static const initial= AppRoutes.login;
  static final routes=[
     GetPage(name: AppRoutes.splash, page: ()=>SplashScreen()),
    // GetPage(name: AppRoutes.main,
    //     page: ()=>MainScreen(),
    //     binding: BindingsBuilder((){
    //       Get.put(MainController());
    //     })
    // ),
    // GetPage(name: AppRoutes.home,
    //     page: ()=>HomeScreen(),
    //     binding: BindingsBuilder((){
    //       Get.put(HomeController());
    //     })
    // ),
    GetPage(name: AppRoutes.login,
        page: ()=>LoginView()),
    //
    // ),
    // GetPage(name: AppRoutes.chat,
    //     page: ()=>ChatScreen(),
    //     binding: BindingsBuilder((){
    //       Get.put(ChatController());
    //     })
    // ),
    GetPage(name: AppRoutes.forgotPassword,
        page: ()=>ForgotpasswordView(),
        binding: BindingsBuilder((){
          Get.put(ForgotPasswordController());
        })
    ),
    // GetPage(name: AppRoutes.changePassword,
    //     page: ()=>ChangePassword(),
    //     binding: BindingsBuilder((){
    //       Get.put(ChangePasswordController());
    //     })
    // ),
    // GetPage(name: AppRoutes.userList,
    //     page: ()=>UserList(),
    //     binding: BindingsBuilder((){
    //       Get.put(UserListController());
    //     })
    // ),
    // GetPage(name: AppRoutes.profile,
    //     page: ()=>ProfileScreen(),
    //     binding: BindingsBuilder((){
    //       Get.put(ProfileController());
    //     })
    // ),
    // GetPage(name: AppRoutes.friends,
    //     page: ()=>FriendsScreen(),
    //     binding: BindingsBuilder((){
    //       Get.put(FriendsController());
    //     })
    // ),
    // GetPage(name: AppRoutes.friendsRequest,
    //     page: ()=>FriendsRequests(),
    //     binding: BindingsBuilder((){
    //       Get.put(FriendsRequestsController());
    //     })
    // ),
    // GetPage(name: AppRoutes.notifications,
    //   page: ()=>NotificationScreen(),
    //   binding: BindingsBuilder((){
    //     Get.put(NotificationsController());
    //   })
    // ),
    GetPage(name: AppRoutes.register,
        page: ()=>RegisterView(),

   ),

  ];
}