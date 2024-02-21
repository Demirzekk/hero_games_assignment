import 'package:flutter/material.dart';
import 'package:hero_games_assingment/init/extension/validator_extensions.dart';
import 'package:hero_games_assingment/init/models/reqister_model.dart';
import 'package:hero_games_assingment/init/service/account_service.dart';

import '../../init/custom_widgets/custom_button.dart';
import '../../init/custom_widgets/custom_text_form_field.dart';
import '../../init/util/toast_messenger.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  static const SizedBox spaceHeight6 = SizedBox(height: 6);
  bool privatePassword = false;

  bool? genderman = true;
  String? gendergrupvalue;
  bool privacyPolicy = false;

  final GlobalKey<FormState> registerkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    passwordAgainController.dispose();
    dateController.dispose();
    bioController.dispose();

    super.dispose();
  }

  _register() async {
    if (registerkey.currentState?.validate() == false) {
      ToastMessenger.instance
          .showToastMessage("Lütfen tüm alanları kontrol ediniz!");
      return;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
      final RegisterModel registerModel = RegisterModel(
          email: emailController.text,
          name: nameController.text,
          password: passwordController.text,
          bio: bioController.text,
          birthDate: dateController.text);

      await AccountService(context)
          .register(registerModel)
          .whenComplete(() => isLoading.value = false);
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
          "Yeni hesap oluştur",
          style: textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
        children: [
          spaceHeight6,
          Form(
            key: registerkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: "Ad Soyad",
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                    margin: EdgeInsets.zero,
                    controller: nameController,
                    hintText: "Adınız ve soyadınızı giriniz..",
                    validator: (val) {
                      if (val == "") {
                        return "Lütfen isminizi giriniz";
                      }
                      return null;
                    },
                    prefixIcon: const Icon(Icons.person, color: Colors.black)),
                spaceHeight6,
                const CustomTextWidget(
                  text: "E-Posta",
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                    margin: EdgeInsets.zero,
                    controller: emailController,
                    hintText: "Email adresinizi giriniz..",
                    validator: (val) => val?.isValidEmail(),
                    prefixIcon: const Icon(Icons.email, color: Colors.black)),
                spaceHeight6,
                CustomTextWidget(
                  text: "Şifre",
                  textAlign: TextAlign.start,
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                      ),
                ),
                CustomTextFormField(
                    margin: EdgeInsets.zero,
                    controller: passwordController,
                    obscuretext: privatePassword == true ? false : true,
                    hintText: "Şifre belirleyin..",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          privatePassword = !privatePassword;
                        });
                      },
                      icon: privatePassword == true
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : const Icon(
                              Icons.visibility_off,
                            ),
                    ),
                    validator: (passwordval) {
                      if ((passwordval?.length ?? 0) < 6) {
                        return "Şifreniz en az 6 karakter olmalıdır!";
                      }

                      return passwordval
                          ?.isSamePassword(passwordAgainController.text);
                    },
                    prefixIcon: const Icon(Icons.lock, color: Colors.black)),
                spaceHeight6,
                const CustomTextWidget(
                  text: "Şifre Tekrar",
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                    controller: passwordAgainController,
                    margin: EdgeInsets.zero,
                    obscuretext: privatePassword == true ? false : true,
                    hintText: "Şifreyi tekrar girin..",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          privatePassword = !privatePassword;
                        });
                      },
                      icon: privatePassword == true
                          ? const Icon(Icons.visibility)
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                    ),
                    validator: (val) {
                      if ((val?.length ?? 0) < 6) {
                        return "Şifreniz en az 6 karakter olmalıdır!";
                      }

                      return val?.isSamePassword(passwordController.text);
                    },
                    prefixIcon: const Icon(Icons.lock, color: Colors.black)),
                spaceHeight6,
                const CustomTextWidget(
                  text: "Doğum Tarihi",
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                    controller: dateController,
                    margin: EdgeInsets.zero,
                    hintText: "Doğum tarihinizi girin",
                    validator: (val) => val?.isValEmpty,
                    prefixIcon:
                        const Icon(Icons.date_range, color: Colors.black)),
                spaceHeight6,
                const CustomTextWidget(
                  text: "Hakkımda",
                  textAlign: TextAlign.start,
                ),
                CustomTextFormField(
                    maxLines: 4,
                    controller: bioController,
                    margin: EdgeInsets.zero,
                    hintText: "Kendinizden bahsedin!",
                    validator: (val) => val?.isValEmpty,
                    prefixIcon: const Icon(Icons.abc, color: Colors.black)),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 72),
                  height: 50,
                  width: 150,
                  child: ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, val, child) {
                        return CustomButton(
                            isLoading: isLoading.value,
                            title: "Kaydol".toUpperCase(),
                            backgroundColor: Colors.blue,
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                            onTap: _register);
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
