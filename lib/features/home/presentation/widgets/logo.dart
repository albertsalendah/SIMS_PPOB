import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/provider/profile_provider.dart';

class Logo extends StatelessWidget {
  final VoidCallback voidCall;
  const Logo({
    super.key,
    required this.voidCall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    'assets/icons/Logo.png',
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  AppStrings.title,
                  style: reguler14.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Consumer<ProfileProvider>(builder: (context, provider, _) {
            if (provider.status == ProfileStatus.imageSuccess) {
              return const Loader();
            }
            return GestureDetector(
              onTap: () {
                voidCall();
              },
              child: CircleAvatar(
                radius: 18,
                backgroundImage: provider.user != null
                    ? NetworkImage(provider.user!.imgUrl)
                    : AssetImage('assets/icons/Profile Photo-1.png'),
                backgroundColor: AppPallete.transparentColor,
              ),
            );
          })
        ],
      ),
    );
  }
}
