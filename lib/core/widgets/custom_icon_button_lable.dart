import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../providers/responsive_notifier.dart';

class CustomIconButtonLable extends ConsumerWidget {
  const CustomIconButtonLable({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: responsive.paddingAll(12.0),
            height:responsive.w(40),
            width: responsive.w(40),
            decoration: BoxDecoration(
              color: const Color(0xFFFFECDF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.string(icon,
              width: responsive.w(24),
              height: responsive.w(24),
              fit: BoxFit.fill,)
          ),
          ResponsiveSpace(
            height: 4.0,
          ),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}