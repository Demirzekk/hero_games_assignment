import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/extension/validator_extensions.dart';
import 'package:hero_games_assingment/init/service/account_service.dart';

import '../../init/custom_widgets/custom_button.dart';
import '../../init/custom_widgets/custom_text_form_field.dart';
import '../../init/util/toast_messenger.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  static const SizedBox spaceHeight6 = SizedBox(height: 6);

  final GlobalKey<FormState> registerkey = GlobalKey<FormState>();

  TextEditingController controlEmail = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    controlEmail.dispose();

    super.dispose();
  }

  Future sendRecoveryMail() async {
    if (registerkey.currentState?.validate() == false) {
      ToastMessenger.instance
          .showToastMessage("Lütfen tüm alanları kontrol ediniz!");
      return;
    } else {
      if (isLoading) return;
      await AccountService(context).passwordReset(
        controlEmail.text,
      );

      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Şifremi Unuttum",
          style: textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spaceHeight6,
                CustomTextWidget(
                  text: "E-Posta Adresinizi Giriniz",
                  textStyle: textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                  ),
                ),
                CustomTextWidget(
                  text:
                      "Şifrenizi sıfırlamanız için kurtarma maili gönderilecektir.",
                  textStyle: textTheme.bodySmall
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                spaceHeight6,
                CustomTextFormField(
                    margin: EdgeInsets.zero,
                    obscuretext: false,
                    controller: controlEmail,
                    hintText: "Email adresinizi giriniz..",
                    validator: (mailval) => mailval?.isValidEmail(),
                    prefixIcon: const Icon(Icons.email, color: Colors.black)),
                spaceHeight6,
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 72),
                  height: 50,
                  width: 150,
                  child: CustomButton(
                      isLoading: isLoading,
                      title: "Şifremi unuttum".toUpperCase(),
                      backgroundColor: Colors.blue,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white),
                      onTap: sendRecoveryMail),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
