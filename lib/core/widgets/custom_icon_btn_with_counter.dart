import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/responsive_notifier.dart';
import '../providers/theme_data_provider.dart';

class CustomIconBtnWithCounter extends ConsumerWidget {
  const CustomIconBtnWithCounter({
    super.key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  });

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: responsive.paddingAll(12.0),
            // height: responsive.w(46),
            // width: responsive.w(46),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -5,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: responsive.w(20),
                width: responsive.w(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: CustomAutoSizeText(
                    text: "$numOfitem",
                    style: theme.textTheme.bodySmall,
                    colorText: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center, 
                    
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}