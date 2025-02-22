import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/config/theme/app_font.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/core/utils/constants/constants.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/banners.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/provider/home_provider.dart';

class DaftarBanner extends StatelessWidget {
  const DaftarBanner({super.key});

  @override
  Widget build(BuildContext context) {
    List<Banners> banner = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.bannerTxt,
          style: reguler12_5.copyWith(fontWeight: FontWeight.w500),
        ),
        Consumer<HomeProvider>(builder: (context, provider, _) {
          banner = provider.banner ?? [];
          return Visibility(
            visible: !(provider.status == HomeStatus.loading),
            replacement:
                SizedBox(height: 165, child: Center(child: const Loader())),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: banner.map((item) {
                  return Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10, right: 10),
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image.network(item.bnrImage),
                  );
                }).toList(),
              ),
            ),
          );
        }),
      ],
    );
  }
}
