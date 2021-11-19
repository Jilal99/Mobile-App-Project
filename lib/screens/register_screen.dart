import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_group_project/components/snackbar.dart';
import 'package:mobile_app_group_project/services/firebase_service.dart';
import 'package:mobile_app_group_project/constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final picker = ImagePicker();
  File? _imageFile;
  late TextEditingController _emailController,
      _reemailController,
      _passwordController,
      _repasswordController,
      _firstnameController,
      _lastnameController,
      _bioController,
      _hometownController,
      _yearController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _reemailController = TextEditingController();
    _passwordController = TextEditingController();
    _repasswordController = TextEditingController();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _bioController = TextEditingController();
    _hometownController = TextEditingController();
    _yearController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _reemailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _bioController.dispose();
    _hometownController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(padding: const EdgeInsets.all(8), children: [
              _imageFile == null
                  ? const Image(
                      image: AssetImage("assets/blank-profile-picture.png"))
                  : Image(image: FileImage(_imageFile!)),
              const SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedFile != null) {
                        _imageFile = File(pickedFile.path);
                        snackbar(context, "Loaded Image", 3);
                      }
                    });
                  },
                  child: const Text("Upload Profile Photo"),
                ),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.envelope,
                      color: kAppColor,
                    )),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                controller: _reemailController,
                validator: (value) {
                  if (value == null || value != _emailController.text) {
                    return 'Email addresses do not match';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Verify Email',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.envelope,
                      color: kAppColor,
                    )),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.key,
                      color: kAppColor,
                    )),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                controller: _repasswordController,
                validator: (value) {
                  if (value == null || value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Verify Password',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.key,
                      color: kAppColor,
                    )),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                  autocorrect: false,
                  controller: _firstnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name cannot be empty';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'First Name',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.user,
                        color: kAppColor,
                      ))),
              const SizedBox(height: 5.0),
              TextFormField(
                  autocorrect: false,
                  controller: _lastnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name cannot be empty';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Last Name',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.user,
                        color: kAppColor,
                      ))),
              const SizedBox(height: 5.0),
              TextFormField(
                autocorrect: false,
                controller: _bioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bio cannot be empty';
                  }
                  return null;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Bio',
                    prefixIcon: const Icon(
                      FontAwesomeIcons.pen,
                      color: kAppColor,
                    )),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                  autocorrect: false,
                  controller: _hometownController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hometown cannot be empty';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Hometown',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.home,
                        color: kAppColor,
                      ))),
              const SizedBox(height: 5.0),
              TextFormField(
                  autocorrect: false,
                  controller: _yearController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Year cannot be empty';
                    }
                    return null;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Year of Birth',
                      prefixIcon: const Icon(
                        FontAwesomeIcons.birthdayCake,
                        color: kAppColor,
                      ))),
              const SizedBox(height: 5.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      snackbar(context, "Adding User", 3);
                      FirebaseService.register(
                          context,
                          _imageFile,
                          _emailController.text,
                          _passwordController.text,
                          _firstnameController.text,
                          _lastnameController.text,
                          _bioController.text,
                          _hometownController.text,
                          _yearController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Register"),
                ),
              ),
            ])));
  }
}
