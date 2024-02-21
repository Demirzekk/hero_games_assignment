import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/extension/validator_extensions.dart';
import 'package:hero_games_assingment/init/service/account_service.dart';

import '../../init/custom_widgets/custom_button.dart';
import '../../init/custom_widgets/custom_text_form_field.dart';
import '../../init/util/toast_messenger.dart';
import '../password_recovery_page/password_reset_page.dart';
import '../register_page/register_page.dart';

class LoginPageWithEmail extends StatefulWidget {
  const LoginPageWithEmail({super.key});

  @override
  State<LoginPageWithEmail> createState() => _LoginPageWithEmailState();
}

class _LoginPageWithEmailState extends State<LoginPageWithEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  late final AccountService _accountService;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
    _accountService = AccountService(context);
  }

  init() async {
    if (kDebugMode) {
      _emailController.text = "zekk@gmail.com";
      _passwordController.text = "123456";
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginForm.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _loginForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(
                    text: "Giriş Yap",
                    textAlign: TextAlign.center,
                    textStyle: textTheme.titleLarge
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Email",
                      textAlign: TextAlign.start,
                      style: textTheme.titleLarge?.copyWith(fontSize: 18),
                    ),
                  ),
                  CustomTextFormField(
                      obscuretext: false,
                      //doğrulayıcı fonksiyon
                      validator: (val) => val?.isValEmpty,
                      margin: EdgeInsets.zero,
                      controller: _emailController,
                      hintText: "Kullanıcı adınız",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Şifre",
                      style: textTheme.titleLarge?.copyWith(fontSize: 18),
                    ),
                  ),
                  CustomTextFormField(
                      obscuretext: false,
                      validator: (val) {
                        if (val == "" || val == null) {
                          return "Lütfen şifrenizi giriniz!";
                        }
                        return null;
                      },
                      margin: EdgeInsets.zero,
                      controller: _passwordController,
                      hintText: "*******",
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: CustomButton(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(12),
                        isLoading: isLoading,
                        icon: const Icon(
                          Icons.login,
                          size: 18,
                          color: Colors.white,
                        ),
                        radius: 10,
                        title: "Giriş Yap!",
                        textStyle: textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (_loginForm.currentState?.validate() == false) {
                            ToastMessenger.instance.showToastMessage(
                                "Lütfen kullanıcı adı ve şifre girdiğinizden emin olun!",
                                isError: _loginForm.currentState?.validate() ==
                                    false);
                            return;
                          }
                          if (isLoading) return;
                          _accountService.signInwithEmail(
                              _emailController.text, _passwordController.text);
                        }),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomTextButton(
                      title: "Hesabın yok mu?",
                      title2: "Hemen Kayıt Ol!",
                      textStyle2: textTheme.titleMedium?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                      textStyle: textTheme.titleMedium,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registerpage()));
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextButton(
                      title: "Şifreni mi unuttun?",
                      title2: "Kurtar!",
                      textStyle2: textTheme.titleMedium?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                      textStyle: textTheme.titleMedium,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PasswordResetPage()));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
