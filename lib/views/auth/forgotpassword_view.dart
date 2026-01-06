import 'package:flashchat/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flashchat/themes/app_theme.dart';
class ForgotpasswordView extends StatefulWidget {
   ForgotpasswordView({super.key});
  @override
  State<ForgotpasswordView> createState() => _ForgotpasswordViewState();
}

class _ForgotpasswordViewState extends State<ForgotpasswordView> {
  // final controller = Get.find<ForgotPasswordController>();
  final controller = Get.put(ForgotPasswordController());


  // final TextEditingController _email=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.email.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsetsGeometry.all(24),
            child: Form(
              key: controller.formkey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      IconButton(
                          // onPressed: controller.goBackToLogin,
                         onPressed: Get.back,

                          icon:Icon(Icons.arrow_back)),
                      SizedBox(width: 8,),
                      Text(
                        'Forgot Password',
                        style: Theme.of(context).textTheme.headlineLarge,
                      )
                    ],
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding:  EdgeInsets.only(left: 56),
                    child: Text(
                      "Enter your email to recieve a password reset link",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
                  Center(child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Icon(Icons.lock_reset_rounded,
                      size: 50,
                      color: AppTheme.successColor,
                    ),
                  ),),
                  SizedBox(height: 60,),

                  TextFormField(
                    controller: controller.email,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(

                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Enter your email',
                      filled: true,
                      fillColor: Colors.white60,

                    ),
                    validator: controller.validateEmail,

                  ),
                  SizedBox(height: 32,),
                  // Obx(()=>SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton.icon(
                  //       onPressed: ()=>controller.isLoading?null:controller.sentPassword(),
                  //
                  //       label: Text(
                  //         controller.isLoading?
                  //       )),
                  // ))
                  Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: controller.isLoading
                          ? null
                          : () {
                        if (controller.formkey.currentState!.validate()) {
                          controller.sentPassword();
                        }
                      },
                      icon: controller.isLoading
                          ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Icon(Icons.send),
                      label: Text(
                        controller.isLoading ? "Sending..." : "Send Link",
                      ),
                    ),
                  )),
                  SizedBox(height: 32,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your Password",
                        style: Theme.of(Get.context!).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 8,),
                      GestureDetector(
                        onTap: controller.goBackToLogin,
                        child: Text(
                          "Sign in?",
                          style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.successColor,
                          )
                        ),
                      )
                    ],
                  )

                ],
              ),
            ),
      ))
    );
  }
}
