import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sims_ppob_richard_albert_salendah/core/shared/widgets/loader.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/domain/entities/menu.dart';
import 'package:sims_ppob_richard_albert_salendah/features/home/presentation/provider/home_provider.dart';

import '../../../../config/theme/app_font.dart';

class DaftarMenu extends StatelessWidget {
  final Function(Menus) onTap;
  const DaftarMenu({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    List<Menus> listMenu = [];
    bool isOverflowing = false;
    return SizedBox(
      height: 165,
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          listMenu = provider.menu ?? [];
          return Visibility(
            visible: !(provider.status == HomeStatus.loading),
            replacement: Center(child: const Loader()),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                mainAxisSpacing: 6,
                childAspectRatio: .9,
              ),
              itemCount: listMenu.length,
              itemBuilder: (BuildContext context, int index) {
                final item = listMenu[index];
                return LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                  final TextPainter textPainter = TextPainter(
                    text: TextSpan(
                        text: item.menuName,
                        style: reguler12_5.copyWith(fontSize: 10.5)),
                    maxLines: 1,
                    textDirection: TextDirection.ltr,
                  )..layout(maxWidth: constraints.maxWidth);

                  isOverflowing = textPainter.didExceedMaxLines ||
                      textPainter.width > constraints.maxWidth;

                  String name = '';
                  List<String> parts = item.menuName.split(' ');

                  if (isOverflowing) {
                    if (parts.isNotEmpty) {
                      if (listMenu.indexOf(item) > 6 && parts.length > 1) {
                        name = parts[1];
                      } else {
                        name = parts[0];
                      }
                    } else {
                      name = item.menuName;
                    }
                  } else {
                    name = item.menuName;
                  }
                  return GestureDetector(
                    onTap: () {
                      onTap(item.copyWith(menuName: name));
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4)),
                            child: Image.network(item.menuIcon),
                          ),
                          Text(
                            name,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: reguler12_5.copyWith(fontSize: 10.5),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          );
        },
      ),
    );
  }
}
