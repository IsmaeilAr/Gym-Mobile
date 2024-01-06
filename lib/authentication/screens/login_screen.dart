import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/authentication/provider/auth_provider.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/profile/screens/add_info_screen.dart';
import 'package:gym/utils/extensions/sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Gap(
                  h: 108,
                ),
                const Logo().sizer(h: 55, w: 116),
                const Gap(
                  h: 60,
                ),
                const WelcomeText(),
                const Gap(
                  h: 64,
                ),
                const LoginForm(),
                const Gap(
                  h: 50,
                ),
              ],
            ),
          ),
        ),
        // persistentFooterButtons:
      ),
    );
  }
}

BoxDecoration backgroundDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        'assets/images/background-login.png',
      ),
      fit: BoxFit.cover,
    ),
  );
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/Logo.svg',
      semanticsLabel: 'Gym Logo',
      // height: 100,
      // width: 70,
    );
  }
}

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(color: lightGrey, fontSize: 30.sp),
          ).sizer(h: 47, w: 128),
          const Gap(
            h: 12,
          ),
          Text(
            'Enter your number and password',
            textAlign: TextAlign.center,
            style: TextStyle(color: grey, fontSize: 16.sp),
          ).sizer(
            w: 252,
            h: 31,
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscured = true;
  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: MyDecorations.myInputDecoration(
                  hint: "Mobile Number",
                  icon: Icon(
                    Icons.phone,
                    size: 20.sp,
                    color: iconColor,
                  )),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile number';
                }
                return null;
              },
            ), // .sizer(h: 42, w: 332),
            const Gap(h: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: obscured,
              decoration: MyDecorations.myInputDecoration(
                  hint: "Password",
                  icon: Icon(
                    Icons.lock,
                    size: 20.sp,
                    color: iconColor,
                  ),
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          obscured = !obscured;
                        });
                      },
                      icon: Icon(
                        obscured
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20.sp,
                        color: iconColor,
                      ))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(
              width: 242.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    doLogin(context);
                  }
                },
                style: MyDecorations.myButtonStyle(red),
                child: Text(
                  'Login',
                  style: MyDecorations.myButtonTextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doLogin(BuildContext context) {
    context
        .read<AuthProvider>()
        .callLoginApi(
          context,
          _phoneController.text,
          _passwordController.text,
        )
        .then((value) {
      if (value) {
        log("view status: $value");
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const AddInfoScreen()));
        // _phoneController.clear();
        // _passwordController.clear();
        dispose();
      }
    });
  }
}
