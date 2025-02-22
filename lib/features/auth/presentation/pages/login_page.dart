import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/red_button.dart';
import '../../../../config/routes/routes_name.dart';
import '../../../auth/presentation/widgets/auth_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      provider.login(
          _emailController.text.trim(), _passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Form(
              key: _formKey,
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
                          child: Image.asset(
                            'assets/icons/Logo.png',
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          AppStrings.title,
                          style: bold18.copyWith(fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(AppStrings.loginTitle,
                        textAlign: TextAlign.center,
                        style: bold18.copyWith(fontSize: 30)),
                    const SizedBox(height: 50),
                    AuthField(
                      hintText: AppStrings.emailHint,
                      controller: _emailController,
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
                    const SizedBox(height: 20),
                    AuthField(
                      hintText: AppStrings.passHint,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
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
                    const SizedBox(height: 30),
                    Consumer<AuthProvider>(
                      builder: (context, provider, _) {
                        if (provider.status == AuthStatus.loading) {
                          return const Loader();
                        }

                        if (provider.status == AuthStatus.error ||
                            provider.status == AuthStatus.unauthenticated) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            showSnackBarError(
                              context: context,
                              message: provider.message ?? '',
                            );
                            provider.resetState();
                          });
                        } else if (provider.status == AuthStatus.loginSuccess) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            // showSnackBarSuccess(
                            //   context: context,
                            //   message: provider.message ?? '',
                            // );
                            provider.resetState();
                            context.goNamed(RoutesName.navBar);
                          });
                        }
                        return RedButton(
                          disable: false,
                          text: AppStrings.loginbtn,
                          onPressed: () {
                            _login();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(RoutesName.signup);
                      },
                      child: RichText(
                          text: TextSpan(
                        text: AppStrings.blmPnyAkun,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppPallete.greyColor),
                        children: [
                          TextSpan(
                            text: AppStrings.disini,
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
          ),
        ),
      ),
    );
  }
}
