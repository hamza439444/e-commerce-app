import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../appColors/app_colors.dart';
import '../../loginScreen/login_screen.dart';
import '../../widgets/my_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _paymentController = TextEditingController();

  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _nameController.text = _user!.displayName ?? '';
    _emailController.text = _user!.email ?? '';
    // _paymentController.text = _user!.paymentController ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    try {
      await _user!.updateDisplayName(_nameController.text);
      await _user!.updateEmail(_emailController.text);
      await _user!.reload();
      _user = _auth.currentUser!;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _logout(BuildContext context) async {
    await _auth.signOut();
    // navigate to login screen
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (route) => false,
    );
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _imageFile;
  Future<void> _uploadImage(File imageFile) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle this case appropriately, e.g. show an error message
      return;
    }

    // Upload the image file to Firebase Storage
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child(user.uid);
    UploadTask uploadTask = storageRef.putFile(imageFile);
    await uploadTask.whenComplete(() {});

    // Get the download URL of the uploaded file
    String downloadURL = await storageRef.getDownloadURL();

    // Update the user's profile picture URL in Firebase Authentication
    await user.updatePhotoURL(downloadURL);

    // Update the profile picture in your app's user interface
    setState(() {
      // Do something to update the profile picture in your app's UI
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    // Pick an image from the camera or gallery
    final pickedFile = await ImagePicker().getImage(source: source);

    if (pickedFile != null) {
      // Upload the selected image to Firebase Storage
      _uploadImage(File(pickedFile.path));
    }
  }

  // final Reference storageRef =
  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.70,
      centerTitle: true,
      backgroundColor: AppColors.baseWhiteColor,
      foregroundColor: AppColors.baseBlackColor,
      title: const Text(
        "Account",
        style: TextStyle(
          color: AppColors.baseBlackColor,
        ),
      ),
      actions: [IconButton(onPressed: _updateProfile, icon: Icon(Icons.done))],
      shadowColor: AppColors.baseGrey10Color,
    );
  }

  Widget buildBottomListTile(
      {required String leading, required String trailing}) {
    return ListTile(
      onTap: () {},
      tileColor: AppColors.baseWhiteColor,
      leading: Text(
        leading,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Wrap(
        spacing: 5,
        children: [
          Text(
            trailing,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? name = user?.displayName;
    String? email = user?.email;
    return Scaffold(
      backgroundColor: AppColors.baseGrey10Color,
      appBar: buildAppBar(),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.only(bottom: 10),
            color: AppColors.baseWhiteColor,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Change profile picture'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Take a photo'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Choose from gallery'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.transparent,
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : NetworkImage(FirebaseAuth
                                          .instance.currentUser?.photoURL ??
                                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
                                  as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '$name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "",
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            color: AppColors.baseWhiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: '$name',
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: '$email',
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                              hintText: "", hintStyle: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: TextFormField(
                          controller: _paymentController,
                          decoration: InputDecoration(
                              hintText: '', hintStyle: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            color: AppColors.baseWhiteColor,
            child: Column(
              children: [
                buildBottomListTile(
                  leading: "Wish-list",
                  trailing: "5",
                ),
                const Divider(),
                buildBottomListTile(
                  leading: "My bag",
                  trailing: "3",
                ),
                const Divider(),
                buildBottomListTile(
                  leading: "My orders",
                  trailing: "1 in transit",
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: MyButtonWidget(
              color: AppColors.baseDarkPinkColor,
              onPress: () {
                _logout(context);
              },
              text: "Log out",
            ),
          ),
        ],
      ),
    );
  }
}
