import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/profile/complete_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({
    Key? key,
    required this.toggleView,
  }) : super(key: key);
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(2.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'AQhealth',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/hospital.png'),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'Emeil',
                        focusNode: _emailFocus,
                        controller: _emailController,
                        validator: (value) =>
                            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)
                                ? null
                                : 'Emeil is not valid!',
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'Password',
                        focusNode: _passwordFocus,
                        controller: _passwordController,
                        isObscured: true,
                        validator: (value) =>
                            value!.length <= 5 ? 'at least 6 character' : null,
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        hintText: 'Confirm Password',
                        focusNode: _confirmPasswordFocus,
                        controller: _confirmPasswordController,
                        isObscured: true,
                        validator: (value) => value! != _passwordController.text
                            ? 'Password is not correct'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            isLoading = true;
                          });

                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => completProfile(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                        )));
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account?',
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                widget.toggleView();
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          /*!isLoading
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.white.withOpacity(0.4),
                  alignment: Alignment.center,
                  child: SpinKitChasingDots(color: AppColor.primary),
                ), */
        ],
      ),
    );
  }
}
