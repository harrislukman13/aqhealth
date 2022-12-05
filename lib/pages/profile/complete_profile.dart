import 'dart:math';

import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:aqhealth/styles/app_color.dart';

class completProfile extends StatefulWidget {
  const completProfile({Key? key, required this.email, required this.password})
      : super(key: key);
  final String email;
  final String password;

  @override
  State<completProfile> createState() => _completProfileState();
}

class _completProfileState extends State<completProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phonenumController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  String _gender = '';
  String error = '';
  final List<String> gender = ['Male', 'Female'];

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _phonenumFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();

  final AuthController _auth = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            padding: EdgeInsets.all(5.w),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Setup profile',
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Name',
                      focusNode: _nameFocus,
                      controller: _nameController,
                      validator: (value) =>
                          value!.length <= 10 ? 'less than 30 character' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'IC',
                      focusNode: _icFocus,
                      controller: _icController,
                      validator: (value) => value!.length <= 11
                          ? 'Ic need to have 12 digits'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 6.h,
                      width: 100.w,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColor.primary, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(2.w, 0, 0, 0),
                          child: DropdownButton(
                              alignment: AlignmentDirectional.centerStart,
                              style: TextStyle(color: AppColor.primary),
                              hint: _gender == null
                                  ? const Text(
                                      'Gender',
                                    )
                                  : Text(
                                      _gender,
                                      style: TextStyle(color: AppColor.primary),
                                    ),
                              items: gender.map((e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (e) {
                                setState(
                                  () {
                                    _gender = e as String;
                                  },
                                );
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Phone Number',
                      focusNode: _phonenumFocus,
                      controller: _phonenumController,
                      validator: (value) =>
                          value!.length <= 30 ? 'less than 30 character' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Address',
                      focusNode: _addressFocus,
                      controller: _addressController,
                      validator: (value) =>
                          value!.length <= 30 ? 'less than 30 character' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'State',
                      focusNode: _stateFocus,
                      controller: _stateController,
                      validator: (value) =>
                          value!.length <= 30 ? 'less than 30 character' : null,
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
                          dynamic result = _auth.register(
                              widget.email,
                              widget.password,
                              _nameController.text,
                              _icController.text,
                              _phonenumController.text,
                              _gender,
                              _addressController.text,
                              _stateController.text);

                          if (result == null) {
                            setState(() {
                              error = 'cannot Register';
                              isLoading = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Complete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
