import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:aqhealth/DAO/patientDAO.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key, required this.patientDAO}) : super(key: key);

  final PatientDAO patientDAO;
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

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
                    color: Colors.white54,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Ionicons.close,
                            color: Colors.indigo,
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
                                  color: Colors.indigo,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
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
                                    ? 'Password need to have 6 digit character'
                                    : null,
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.indigo,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  if (_formKey.currentState!.validate()) {
                                    await widget.patientDAO.login(
                                        _emailController.text,
                                        _passwordController.text);
                                  }

                                  setState(() {
                                    isLoading = false;
                                  });

                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.indigo,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Create Account',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.indigo,
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
            //!isLoading
            //? const SizedBox.shrink()
            //: Container(
            //  color: Colors.white.withOpacity(0.4),
            // alignment: Alignment.center,
            //  child: SpinKitChasingDots(color: AppColor.primary),
            //)
            //)
          ],
        ),
      ),
    );
  }
}
