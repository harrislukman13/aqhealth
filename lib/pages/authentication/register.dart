import 'package:flutter/material.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

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
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     AppColor.secondary,
                    //     AppColor.primary,
                    //   ],
                    // ),
                    color: Colors.white54,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Ionicons.close,
                            color: AppColor.primary,
                            size: 28,
                          ),
                        ),
                      ),
                      Expanded(
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
                              const SizedBox(height: 20),
                              CustomTextFormField(
                                hintText: 'Name',
                                focusNode: _nameFocus,
                                controller: _nameController,
                                validator: (value) => value!.length <= 30
                                    ? 'less than 30 character'
                                    : null,
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
                                validator: (value) => value!.length <= 5
                                    ? 'at least 6 character'
                                    : null,
                              ),
                              const SizedBox(height: 10),
                              CustomTextFormField(
                                hintText: 'Conform Password',
                                focusNode: _confirmPasswordFocus,
                                controller: _confirmPasswordController,
                                isObscured: true,
                                validator: (value) =>
                                    value! != _passwordController.text
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

                                  //if (_formKey.currentState!.validate()) {
                                  //await widget.userDAO.register(
                                  //    _emailController.text,
                                  //    _icController.text,
                                  //   _passwordController.text);
                                  //}

                                  setState(() {
                                    isLoading = false;
                                  });

                                  Navigator.pop(context);
                                  Navigator.pop(context);
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
                                    onTap: () => Navigator.pop(context),
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            !isLoading
                ? const SizedBox.shrink()
                : Container(
                    color: Colors.white.withOpacity(0.4),
                    alignment: Alignment.center,
                    //child: SpinKitChasingDots(color: AppColor.primary),
                  ),
          ],
        ),
      ),
    );
  }
}