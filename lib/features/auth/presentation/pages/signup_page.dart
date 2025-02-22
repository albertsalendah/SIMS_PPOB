import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/widgets/auth_field.dart';

import '../../../../config/routes/routes_name.dart';
import '../../../../config/theme/app_pallet.dart';
import '../../../../core/shared/widgets/red_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final namaDpnController = TextEditingController();
  final namaBlkngController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passConfirmController = TextEditingController();
  bool obscureText = true;
  bool obscureTextConfirm = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    namaDpnController.dispose();
    namaBlkngController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passConfirmController.dispose();
    super.dispose();
  }

  void _signUp() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    await provider.signUp(
      emailController.text.trim(),
      namaDpnController.text.trim(),
      namaBlkngController.text.trim(),
      passConfirmController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: Image.asset('assets/icons/Logo.png'),
                          ),
                          const SizedBox(width: 8),
                          Text(AppStrings.title,
                              style: bold18.copyWith(fontSize: 22))
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(AppStrings.signUpTitle,
                          textAlign: TextAlign.center,
                          style: bold18.copyWith(fontSize: 30)),
                      const SizedBox(height: 50),
                      AuthField(
                        hintText: AppStrings.emailHint,
                        controller: emailController,
                        prefixIcon: Icons.alternate_email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          if (!RegExp(r'^[\w -\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return AppStrings.formatEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      AuthField(
                        hintText: AppStrings.namaDpnHint,
                        controller: namaDpnController,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 8),
                      AuthField(
                        hintText: AppStrings.namaBlkngHint,
                        controller: namaBlkngController,
                        prefixIcon: Icons.person_outline,
                      ),
                      const SizedBox(height: 8),
                      AuthField(
                        hintText: AppStrings.buatPassHint,
                        controller: passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: obscureText,
                        suffixIcon: IconButton(
                          icon: Icon(obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          if (value.length < 8) {
                            return AppStrings.passLength;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      AuthField(
                        hintText: AppStrings.passConfirmHint,
                        controller: passConfirmController,
                        prefixIcon: Icons.lock_outline,
                        obscureText: obscureTextConfirm,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          if (value.length < 8) {
                            return AppStrings.passLength;
                          }
                          if (value != passwordController.text) {
                            return AppStrings.passtdksama;
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(obscureTextConfirm
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              obscureTextConfirm = !obscureTextConfirm;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30),
                      Consumer<AuthProvider>(
                        builder: (context, provider, _) {
                          if (provider.status == AuthStatus.loading) {
                            return const Loader();
                          }
                          if ((provider.status == AuthStatus.error ||
                              provider.status == AuthStatus.unauthenticated)) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showSnackBarError(
                                context: context,
                                message: provider.message ?? '',
                              );
                            });
                          }

                          if (provider.status == AuthStatus.signupSuccess) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              showSnackBarSuccess(
                                context: context,
                                message: provider.message.toString(),
                              );
                              provider.resetState();
                              context.goNamed(RoutesName.login);
                            });
                          }
                          return RedButton(
                            disable: false,
                            text: AppStrings.regisbtn,
                            onPressed: () {
                              _signUp();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          context.goNamed(RoutesName.login);
                        },
                        child: RichText(
                            text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppPallete.greyColor),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      color: AppPallete.red,
                                      fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
