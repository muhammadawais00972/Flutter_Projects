import 'package:flashchat/controllers/auth_Controller.dart';
import 'package:flashchat/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/themes/app_theme.dart';
import 'package:get/get.dart';
class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formkey=GlobalKey<FormState>();
  final _email=TextEditingController();
  final _name=TextEditingController();
  final _password=TextEditingController();
  final _confirmpassword=TextEditingController();
  final AuthController _authController=Get.put(AuthController());
  bool _obsecuredPassword=true;
  bool _obsecuredconfirmPassword=true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
    _confirmpassword.dispose();
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
                    SizedBox(height: 20,),
                    
                      Row(
                     
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: ()=>Get.back(), 
                            icon: Icon(Icons.arrow_back)),
                        SizedBox(width: 8,),
                        Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.
                          headlineLarge,
                        ),

                       ]
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Fill in your detail to get started',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),

                        SizedBox(height: 40,),
                        TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(

                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your Name',
                            filled: true,
                            fillColor: Colors.white60,

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the name';
                            }



                            return null;
                          },

                        ),

                        SizedBox(height: 16,),
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



                        SizedBox(height: 16,),


                        TextFormField(
                          controller: _confirmpassword,
                          keyboardType: TextInputType.text,

                          decoration: InputDecoration(

                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outlined),
                            hintText: 'Enter your Confirm Password',
                            filled: true,
                            fillColor: Colors.white60,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obsecuredconfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obsecuredconfirmPassword = !_obsecuredconfirmPassword;
                                });
                              },
                            ),

                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _password.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },

                          obscureText: _obsecuredconfirmPassword,
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
                                _authController.register(
                                  _email.text.trim(),
                                  _password.text.trim(),
                                  _name.text.trim(),
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
                              "Create Account",
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
                                  color: AppTheme.successColor,

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
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodyMedium,

                            ),
                            SizedBox(width:5 ),
                            GestureDetector(
                              onTap: (){

                                Get.back();
                              },
                              child: Text(
                                'Sign In',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.successColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],)
                  ],
                )
            ),
          )
      ),

    );
  }
}
