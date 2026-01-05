import 'package:flashchat/controllers/auth_Controller.dart';
import 'package:flashchat/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/themes/app_theme.dart';
import 'package:get/get.dart';
class LoginView extends StatefulWidget {
   LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey=GlobalKey<FormState>();
  final _email=TextEditingController();
  final _password=TextEditingController();
  // final AuthController _authController=Get.find<AuthController>();
  final AuthController _authController=Get.put(AuthController());
  bool _obsecuredPassword=true;
  bool isPasswordHidden = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor:  Colors.white,
      body: SafeArea(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Form(
            key: _formkey,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: Offset(0,10),
                            )
                          ]
                      ),
                      child: Icon(Icons.chat_bubble_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: Theme.of(context).textTheme.
                        headlineLarge,
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Sign in to continue chatting with friends & family",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 40,),
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,

                        decoration: InputDecoration(

                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.white60,

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the email';
                          }

                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },

                      ),
                      SizedBox(height: 16,),
                      TextFormField(
                        controller: _password,
                        keyboardType: TextInputType.text,

                        decoration: InputDecoration(

                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outlined),
                          hintText: 'Enter your Password',
                          filled: true,
                          fillColor: Colors.white60,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obsecuredPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obsecuredPassword = !_obsecuredPassword;
                              });
                            },
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          }

                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }

                          return null;
                        },
                        obscureText: _obsecuredPassword,
                        obscuringCharacter: '●',

                      ),
                      SizedBox(height: 25,),
                     Obx(()=>SizedBox(
                       width: double.infinity,
                       child: ElevatedButton(
                         onPressed: _authController.isLoading
                             ? null
                             : () {
                           if (_formkey.currentState!.validate()) {
                             _authController.login(
                               _email.text.trim(),
                               _password.text.trim(),
                             );
                           }
                         },

                         child: _authController.isLoading
                           ?SizedBox(
                             height: 20,
                             width: 20,
                             child: CircularProgressIndicator(
                               color: Colors.white,
                               strokeWidth: 2,
                             ),
                           )
                               :Text(
                                 "Sign In",
                               ),
                         
                       ),
                     )),
                      SizedBox(height: 16,),
                      Center(
                        child: TextButton(
                            onPressed: (){
                              Get.toNamed(AppRoutes.forgotPassword);
                            } ,
                            child:Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppTheme.primaryColor,

                              ),
                            )
                        ),
                      ),
                      SizedBox(height: 32,),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppTheme.borderColor,
                              endIndent: 16,
                            ),
                          ),
                          Text(
                            "OR",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Expanded(
                            child: Divider(
                              color: AppTheme.borderColor,
                              indent: 16,
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 32,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                           "Don't have an account?",
                            style: Theme.of(context).textTheme.bodyMedium,

                          ),
                          SizedBox(width:5 ),
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(AppRoutes.register);
                            },
                            child: Text(
                              'Sign Up',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),




                    ],
                  )
                ],
              )
          ),
        )
      ),

    );
  }
}
