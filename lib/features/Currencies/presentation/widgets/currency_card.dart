import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';

class GradientCreditCard extends ConsumerWidget {
  final String balance;
  final String cardNumber;
  final Function onTopRightButtonClicked;
  final Gradient backgroundGradient;
  final Widget cardIcon;

  const GradientCreditCard({
    super.key,
    required this.onTopRightButtonClicked,
    required this.cardIcon,
    this.balance = "\$2,850.00",
    this.cardNumber = "****  ****  ****  3799",
    this.backgroundGradient =
        const LinearGradient(colors: [Colors.black87, Colors.black54]),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    return Container(
      
      margin: EdgeInsets.all(responsive.w(16)),
      width: responsive.w(300),
      height: responsive.h(150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: backgroundGradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: const Offset(0, 15),
            blurRadius: 45,
          )
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: responsive.paddingAll(5),
              child: IconButton(
                icon: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  onTopRightButtonClicked();
                },
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: responsive.paddingAll(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardNumber,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/mastercard.png?alt=media&token=1ae51e14-5a60-4dbf-8a42-47cb9c3c1dfe",
                      width: 30,
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    balance,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    "Balance",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
