
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../appColors/app_colors.dart';
import '../mybottombar/my_bottom_bar.dart';
import '../styles/signup_screen_styles.dart';
import '../svgimages/svg_images.dart';
import '../widgets/my_button_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _fullName, _email, _password, _confirmPassword;
  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
        // update user's display name
        await userCredential.user!.updateDisplayName(_fullName);

        // navigate to home screen
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => MyBottomBar(),
          ),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The password is too weak.'),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('The email is already in use.'),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }
    }
  }

  Widget buildTopPart() {
    return Column(
      children: [
        Image.asset(
          "images/Logo.png",
          width: 350,
          height: 150,
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: TextFormField(
            validator: (input) {
              if (input!.isEmpty) {
                return 'Please enter your full name.';
              }
              return null;
            },
            onSaved: (input) => _fullName = input,
            obscureText: false,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'Full Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: TextFormField(
            validator: (input) {
              if (input!.isEmpty) {
                return 'Please enter an email';
              }
              return null;
            },
            onSaved: (input) => _email = input,
            obscureText: false,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'E-mail',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: TextFormField(
            validator: (input) {
              if (input!.length < 6) {
                return 'Password must be at least 6 characters.';
              }
              return null;
            },
            onSaved: (input) => _password = input,
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: TextFormField(
            // validator: (input) {
            //   if (input != _password) {
            //     return 'Passwords do not match.';
            //   }
            //   return null;
            // },
            onSaved: (input) => _confirmPassword = input,
            obscureText: true,
            decoration: InputDecoration(
                fillColor: Colors.grey[100],
                filled: true,
                hintText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10.0),
                )),
          ),
        ),
        _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: MyButtonWidget(
                  onPress: _submit,
                  color: AppColors.baseDarkPinkColor,
                  text: "Create an account",
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        RichText(
          text: const TextSpan(
              text: "By Signing up you agreed to our\n\t",
              style: SignupScreenStyles.signInAgreesStyle,
              children: <TextSpan>[
                TextSpan(
                  text: "Terms",
                  style: SignupScreenStyles.termsTextStyle,
                ),
                TextSpan(
                  text: "and\t",
                  style: SignupScreenStyles.andTextStyle,
                ),
                TextSpan(
                  text: "Conditions of Use",
                  style: SignupScreenStyles.conditionsOfUseStyle,
                ),
              ]),
        ),
      ],
    );
  }

  Widget buildSocialButton(
      {required Widget child, required Function onPressed}) {
    return MaterialButton(
      shape: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 0.5,
          color: AppColors.baseGrey40Color,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      onPressed: () {},
      child: child,
    );
  }

  Widget buildBottomPart() {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            " Or signin with social accounts",
            style: SignupScreenStyles.signInSocialStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSocialButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    SvgImages.facebook,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
                buildSocialButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    SvgImages.google,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
                buildSocialButton(
                  onPressed: () {},
                  child: SvgPicture.asset(
                    SvgImages.twitter,
                    color: AppColors.baseBlackColor,
                    width: 45,
                  ),
                ),
                // Material(
                //     shape: OutlineInputBorder(
                //     borderSide:  const BorderSide(
                //       width: 0.5,
                //       color: AppColors.baseGrey40Color,
                //     ),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: SvgPicture.asset(
                //       SvgImages.facebook,
                //     color: AppColors.baseBlackColor,
                //     width: 45,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: MaterialButton(
              onPressed: () {},
              color: AppColors.baseGrey10Color,
              height: 55,
              elevation: 0,
              child: const Center(
                child: Text(
                  "Sign up",
                  style: SignupScreenStyles.signUpButtonTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.baseBlackColor,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            buildTopPart(),
            buildBottomPart(),
          ],
        ),
      )),
    );
  }
}
