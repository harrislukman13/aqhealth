import 'dart:developer';
import 'dart:io';
import 'dart:async';

import 'package:aqhealth/controller/Authcountroller.dart';
import 'package:aqhealth/pages/authentication/login.dart';
import 'package:aqhealth/pages/dashboard/mainpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:aqhealth/styles/custom_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:aqhealth/styles/app_color.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

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

  XFile? pickImage;
  File? imageFile;
  String? downloadURL;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _icFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _phonenumFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();

  final AuthController _auth = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool isLoading = false;

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose Option",
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(height: 1, color: Colors.black),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text('Gallery'),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future UploadImage() async {
    var filename = _nameController.text.toString();
    Reference ref = FirebaseStorage.instance.ref().child('/File/${filename}');
    await ref.putFile(imageFile!);
    downloadURL = await ref.getDownloadURL();
  }

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
                    GestureDetector(
                      onTap: () async {
                        _showChoiceDialog(context);
                      },
                      child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.1,
                          backgroundColor: Colors.white,
                          backgroundImage: imageFile == null
                              ? null
                              : FileImage(File(imageFile!.path)),
                          child: imageFile == null
                              ? Icon(
                                  CupertinoIcons.camera_circle,
                                  color: Colors.blueAccent,
                                )
                              : null),
                    ),
                    // OutlinedButton.icon(
                    //   style: OutlinedButton.styleFrom(
                    //       side: BorderSide(color: AppColor.primary, width: 2),
                    //       shape: const RoundedRectangleBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(23)))),
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     CupertinoIcons.camera_circle,
                    //     color: Colors.blueAccent,
                    //   ),
                    //   label: Text('Add Your Profile Picture'),
                    // ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Name',
                      focusNode: _nameFocus,
                      controller: _nameController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please fill the blank' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'IC Number',
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
                          value!.isEmpty ? 'please fill the blank' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Address',
                      focusNode: _addressFocus,
                      controller: _addressController,
                      validator: (value) =>
                          value!.isEmpty ? 'please fill the blank' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'State',
                      focusNode: _stateFocus,
                      controller: _stateController,
                      validator: (value) =>
                          value!.isEmpty ? 'please fill the blank' : null,
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
                          await UploadImage();
                          dynamic result = await _auth.register(
                              widget.email,
                              widget.password,
                              _nameController.text,
                              _icController.text,
                              _phonenumController.text,
                              _gender,
                              _addressController.text,
                              _stateController.text,
                              downloadURL.toString());

                          if (result == null) {
                            setState(() {
                              error = 'cannot Register';
                              isLoading = false;
                            });
                          }
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
                )),
          ),
        ],
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    try {
      pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      setState(() {
        imageFile = File(pickImage!.path);
      });
    } catch (e) {
      log(e.toString());
    }
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    try {
      pickImage = await ImagePicker().pickImage(source: ImageSource.camera);
      setState(() {
        imageFile = File(pickImage!.path);
      });
    } catch (e) {
      log(e.toString());
    }

    Navigator.pop(context);
  }
}
