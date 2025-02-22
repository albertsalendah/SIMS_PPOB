import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/routes/routes_name.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_pallet.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/domain/entities/user.dart';
import 'package:sims_ppob_richard_albert_salendah/features/profile/presentation/provider/profile_provider.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/widgets/daftar_banner.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/widgets/daftar_menu.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/widgets/logo.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/saldo_card.dart';

import '../../../../core/utils/constants/constants.dart';

class HomePage extends StatelessWidget {
  final VoidCallback toProfile;
  const HomePage({super.key, required this.toProfile});

  @override
  Widget build(BuildContext context) {
    User? user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Logo(voidCall: toProfile),
        Consumer<ProfileProvider>(
          builder: (context, value, _) {
            if (value.status == ProfileStatus.getSuccess) {
              user = value.user;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.welcome,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  style: reguler14.copyWith(fontSize: 18),
                ),
                Visibility(
                  visible: user != null,
                  child: Text(
                    '${user?.firstName} ${user?.lastName}',
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: semibold14.copyWith(
                        fontSize: 24, color: AppPallete.black),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        SaldoCard(
          showHideBtn: true,
        ),
        const SizedBox(
          height: 20,
        ),
        DaftarMenu(
          onTap: (p0) {
            context.pushNamed(RoutesName.paymentPage, extra: p0);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        DaftarBanner(),
      ],
    );
  }
}
