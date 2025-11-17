import 'package:bookkeeping_flutter_app/core/custom_slivers/custom_sliver_persistent_header_delegate.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../features/Accounts/presentation/widgets/action_buttons_row.dart';

class AdvancedSliverAppBar extends ConsumerWidget {
  const AdvancedSliverAppBar({super.key});

  @override
  Widget build(BuildContext context , WidgetRef ref) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(

                ref: ref,
                 title: CustomAutoSizeText(
        text: "title",
        style: ref.theme.textTheme.bodyMedium,
        fontSize: 12,
        colorText: ref.theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
        
     ),
                 leading: CustomHugeIcon(icon: HugeIcons.strokeRoundedMenuTwoLine),
                 expandedHeight: 200,
                background: buildBackground(context),
                floating: buildFloating(context, ref),

                ),
              pinned: true,
            ),
            buildImages(),
          ],
        ),
      );

  Widget buildBackground( BuildContext context){
    return Container(
      color: Colors.cyanAccent,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child:  CustomHugeIcon(icon: HugeIcons.strokeRoundedWallet01),),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAutoSizeText(text: 'اسم العميل: محمد صالح', fontSize: 12, colorText: Colors.blue,),
                const SizedBox(height: 5,),
                CustomAutoSizeText(text: 'احمد', fontSize: 12, fontWeight: FontWeight.bold, colorText: Colors.blue,),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFloating( BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return ActionButtonsRow(
      actionButtons: [
        ActionButton(
          // label: 'إضافة عملية',
           icon: HugeIcons.strokeRoundedMoneyAdd01,
         onPressed: (){
          
         },isCompact: true,backgroundColor:theme.colorScheme.primary,iconColor: theme.colorScheme.onPrimary,),
        ActionButton(
          // label: 'اتصال',
           icon: HugeIcons.strokeRoundedCall02, onPressed: (){
          // Show call dialog
          
        },isCompact: true,),
        ActionButton(
          // label: 'رسالة', 
          icon: HugeIcons.strokeRoundedMessage01, onPressed: (){
          // Show message dialog
          
        },isCompact: true,),
        ActionButton(
          // label: 'سقف الحساب',
           icon: HugeIcons.strokeRoundedLimitOrder, onPressed: (){
         
        },isCompact: true,),
        ActionButton(
          // label: 'تقرير',
           icon: HugeIcons.strokeRoundedPdf01, onPressed: (){
          // Show report dialog
        
        },isCompact: true,),
      ],
    );

  }
    
  

  Widget buildImages() => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => ImageWidget(index: index),
          childCount: 20,
        ),
      );
}


class ImageWidget extends StatelessWidget {
  final int index;

  const ImageWidget(
    {super.key, 
    
    required this.index,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 150,
        width: double.infinity,
        child: Card(
          child: ListTile(
            title: Text('Image $index'),
            subtitle: Text('Subtitle $index'),
          )
        ),
      );
}