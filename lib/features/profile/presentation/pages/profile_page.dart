import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/routes/routes_name.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/provider/profile_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/back_btn.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/features/auth/presentation/provider/auth_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/pick_image.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/show_snackbar.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/widgets/input_field.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/widgets/profile_button.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback toHome;
  const ProfilePage({super.key, required this.toHome});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late AuthProvider _authProfider;
  late ProfileProvider _profileProvider;
  String? token;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  bool _edit = false;

  @override
  void initState() {
    super.initState();
    _authProfider = context.read<AuthProvider>();
    _profileProvider = context.read<ProfileProvider>();
    token = _authProfider.getToken();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      await context.read<ProfileProvider>().updateUser(
            firstName: _firstController.text.trim(),
            lastName: _lastController.text.trim(),
            token: token ?? '',
          );
    }
  }

  void _logout() async {
    await _authProfider.logout().then((v) {
      _authProfider.resetState();
    });
    final token = _authProfider.getToken();
    if (token == null && mounted) {
      context.goNamed(RoutesName.login);
    }
  }

  Future<void> _uploadImage() async {
    File? imageFile = await pickImage(context);

    if (imageFile != null) {
      if (token != null) {
        await _profileProvider.uploadImages(imageFile, token: token!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        final user = value.user;
        _emailController.text = user?.email ?? '';
        _firstController.text = user?.firstName ?? '';
        _lastController.text = user?.lastName ?? '';
        String imgUrl = user != null ? user.imgUrl : '';

        if (value.status == ProfileStatus.updateSuccess ||
            value.status == ProfileStatus.imageSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBarSuccess(context: context, message: value.message ?? '');
            value.resetState();
          });
        } else if (value.status == ProfileStatus.error) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBarError(context: context, message: value.message ?? '');
            value.resetState();
          });
        }
        return Column(
          children: [
            BackBtn(
              label: AppStrings.akun,
              toHome: widget.toHome,
            ),
            GestureDetector(
              onTap: () {
                _uploadImage();
              },
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: AppPallete.transparentColor,
                      border: Border.all(color: AppPallete.greyColor),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: !imgUrl.contains('null')
                        ? Image.network(imgUrl)
                        : Image.asset('assets/icons/Profile Photo-1.png'),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: AppPallete.whiteColor,
                            border: Border.all(color: AppPallete.greyColor),
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: AppPallete.black,
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user != null ? '${user.firstName} ${user.lastName}' : '',
              style: semibold14.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 16),
            InputField(
              enable: false,
              hintText: 'Email',
              controller: _emailController,
              prefixIcon: Icons.alternate_email,
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(
                    enable: _edit,
                    hintText: 'Nama Depan',
                    controller: _firstController,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InputField(
                    enable: _edit,
                    hintText: 'Nama Belakang',
                    controller: _lastController,
                    prefixIcon: Icons.person_outline,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Visibility(
              visible: value.status != ProfileStatus.loading,
              replacement: const Loader(),
              child: ProfileButton(
                switcher: _edit,
                text: _edit ? AppStrings.save : AppStrings.edit,
                onPressed: () {
                  setState(() {
                    _edit = !_edit;
                    if (_edit == false) {
                      _saveChanges();
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            ProfileButton(
                switcher: !_edit,
                text: _edit ? AppStrings.cancel : AppStrings.logout,
                onPressed: () {
                  setState(() {
                    if (_edit == false) {
                      _logout();
                    } else {
                      _edit = !_edit;
                    }
                  });
                }),
          ],
        );
      },
    );
  }
}
