import 'dart:ffi';

import 'package:aqhealth/controller/DatabaseController.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key, required this.data}) : super(key: key);
  final Map<dynamic, dynamic> data;
  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  String error = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _icController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final db = DatabaseController(uid: user!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.indigo[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(5.h),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.indigo,
                        backgroundImage: NetworkImage(widget.data['url']),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.h),
                              color: Colors.indigo),
                          child: Icon(
                            CupertinoIcons.camera,
                            color: Colors.white,
                            size: 2.h,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                CustomTextFormField(
                  hintText: 'name',
                  focusNode: _nameFocus,
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill the blank' : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Phone',
                  focusNode: _phoneFocus,
                  controller: _phoneController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill the blank' : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'ic Number',
                  focusNode: _icFocus,
                  controller: _icController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill the blank' : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'Address',
                  focusNode: _addressFocus,
                  controller: _addressController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill the blank' : null,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  hintText: 'state',
                  focusNode: _stateFocus,
                  controller: _stateController,
                  validator: (value) =>
                      value!.isEmpty ? 'Please fill the blank' : null,
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
                    if (_formKey.currentState!.validate()) {
                      await db.updatePatient(
                          Patient(
                              name: _nameController.text,
                              address: _addressController.text,
                              state: _stateController.text,
                              phonenum: _phoneController.text,
                              url: widget.data['url'],
                              role: widget.data['role'],
                              gender: widget.data['role'],
                              ic: _icController.text),
                          user.uid);

                      Future.delayed(
                        const Duration(seconds: 3),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Complete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
