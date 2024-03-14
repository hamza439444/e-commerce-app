
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import '../../routes/routes.dart';
import '../../signup/signup_screen.dart';
import '../appColors/app_colors.dart';
import '../mybottombar/my_bottom_bar.dart';
import '../styles/login_screen_styles.dart';
import '../widgets/my_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool _isLoading = false;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );
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
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No user found with that email.'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect password'),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later'),
          ),
        );
      }
    }
  }

  Widget buildTopPart(isLoading) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset(
            "images/Logo.png",
            width: 350,
            height: 300,
          ),
          Column(
            children: [
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
            ],
          ),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: MyButtonWidget(
                          text: "Sign in",
                          color: AppColors.baseBlackColor,
                          onPress: _submit,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: MyButtonWidget(
                          text: "Sign up",
                          color: AppColors.baseDarkPinkColor,
                          onPress: () {
                            PageRouting.goToNextPage(
                              context: context,
                              navigateTo: const SignupScreen(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Forget Password?",
            style: LoginScreenStyles.forgotPasswordStyles,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTopPart(_isLoading),
              ],
            )
          ],
        ),
      )),
    );
  }
}
