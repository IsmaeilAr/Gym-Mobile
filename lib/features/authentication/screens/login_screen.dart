import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/utils/extensions/sizer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../profile/screens/add_info_screen.dart';
import '../provider/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  bool isClear = false;
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: isClear,
      onPopInvoked: (didPop) {
        _onPop();
      },
      child: Container(
        decoration: backgroundDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Center(
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
          ),
          // persistentFooterButtons:
        ),
      ),
    );
  }

  Future<void> _onPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      showMessage('press again to exit', true);
      isClear = false;
    }
    isClear = true;
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
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.loginWelcomeKey,
          textAlign: TextAlign.center,
          style: TextStyle(color: lightGrey, fontSize: 30.sp),
        ).sizer(h: 47, w: 140),
        const Gap(
          h: 12,
        ),
        Text(
          AppLocalizations.of(context)!.loginEnterNumberAndPasswordKey,
          textAlign: TextAlign.center,
          style: TextStyle(color: grey, fontSize: 16.sp),
        ).sizer(
          w: 260,
          h: 31,
        ),
      ],
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
  final TextEditingController _phoneController =
      TextEditingController(text: '0935622246');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456789');
  bool obscured = true;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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
                hint: AppLocalizations.of(context)!.loginMobileNumberKey,
                icon: Icon(
                  Icons.phone,
                  size: 20.sp,
                  color: iconColor,
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!
                      .loginEnterMobileNumberKey;
                } else if (value.length < 10) {
                  return 'phone number is short';
                }
                return null;
              },
            ),
            const Gap(h: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: obscured,
              textInputAction: TextInputAction.go,
              decoration: MyDecorations.myInputDecoration(
                hint: AppLocalizations.of(context)!.loginPasswordKey,
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
                    )),
              ),
              onFieldSubmitted: (_) => {
                if (_formKey.currentState!.validate()) {doLogin(context)}
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.loginEnterPasswordKey;
                } else if (value.length < 8) {
                  return 'password must be 8 characters at least';
                }
                return null;
              },
            ),
            const Gap(h: 30),
            SizedBox(
              width: 242.w,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  if (!context.read<AuthProvider>().isLoading &&
                      _formKey.currentState!.validate()) {
                    doLogin(context);
                  }
                },
                style: MyDecorations.myButtonStyle(red),
                child: !context.watch<AuthProvider>().isLoading
                    ? Text(
                        AppLocalizations.of(context)!.loginButtonKey,
                  style: MyDecorations.myButtonTextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16.sp),
                      )
                    : SizedBox(
                        height: 20.w,
                        width: 20.w,
                        child: const CircularProgressIndicator.adaptive(
                          strokeWidth: 1,
                          valueColor: AlwaysStoppedAnimation<Color>(lightGrey),
                        ),
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
        .callLogin(
          context,
          _phoneController.text,
          _passwordController.text,
        )
        .then((value) {
      if (value) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: AddInfoScreen()));
      }
    });
  }
}
