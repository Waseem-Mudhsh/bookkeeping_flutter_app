import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_debts_of_client_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../Transactions/presentation/widgets/custom_last_transations_item.dart';

// نموذج متجر بسيط
class StoreModel {
  final String name;
  final String imageUrl;
  final String status;
  final String type;

  const StoreModel({
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.type,
  });
}

// Provider وهمي للمتاجر
final storesProvider = Provider<List<StoreModel>>((ref) {
  return [
    const StoreModel(
      name: 'متجر النور',
      imageUrl: 'assets/images/store.png',
      status: 'نشط',
      type: 'متجر',
    ),
    const StoreModel(
      name: 'سوبرماركت الوفاء',
      imageUrl: 'assets/images/store.png',
      status: 'مغلق مؤقتًا',
      type: 'سوبرماركت',
    ),
    const StoreModel(
      name: 'صيدلية الشفاء',
      imageUrl: 'assets/images/store.png',
      status: 'نشط',
      type: 'صيدلية',
    ),
    const StoreModel(
      name: 'صيدلية ظمران',
      imageUrl: 'assets/images/store.png',
      status: 'نشط',
      type: 'صيدلية',
    ),
  ];
});

// Provider وهمي لعدد الطلبات الجديدة
final newRequestsCountProvider = Provider<int>((ref) => 10); // عدل القيمة للتجربة

class DebtsOfClientScreen extends ConsumerWidget {
  const DebtsOfClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    return AdaptiveScaffold(
      // drawer: const CustomDrawer(),
      body: BuildNonTabbarLayout(
        titleWidget: const _HeaderWidget(),
        
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          const SliverToBoxAdapter(child: CustomDebtsOfClientCard()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(child: _RequestsNotificationButton()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          const SliverToBoxAdapter(child: _StoresPreviewWidget()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          const SliverToBoxAdapter(child: _TransactionsListWidget()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
        ],
      ),
     
    );
  }
}

class _HeaderWidget extends ConsumerWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    return CustomAutoSizeText(
      text: 'الديون الشخصية',
      style: theme.textTheme.bodyMedium,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      colorText: theme.colorScheme.primary,
    );
  }
}

/// زر إشعار الطلبات الجديدة (يظهر فقط إذا كان هناك طلبات)
class _RequestsNotificationButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    final newRequests = ref.watch(newRequestsCountProvider);

    if (newRequests == 0) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        // انتقل إلى صفحة الطلبات الجديدة
      },
      child: Container(
        padding: responsive.paddingSym(h: 16, v: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
         
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              
              children: [
                CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedNotification01,
                  color: theme.colorScheme.onSecondary,
                  size: 24,
                ),
                if (newRequests > 0)
                  Positioned(
                    right: -4,
                    top:-4,
                    child: Container(
                     
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: CustomAutoSizeText(
                        text: '$newRequests',
                        
                          colorText: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        
                      ),
                    ),
                  ),
              ],
            ),
            const ResponsiveSpace(width: 8),
            CustomAutoSizeText(
              text: 'لديك $newRequests طلب جديد لمشاركة الديون',
              style: theme.textTheme.bodySmall,
              fontWeight: FontWeight.bold,
              colorText: theme.colorScheme.onSecondary,
              fontSize: 10,
            ),
            const Spacer(),
            CustomHugeIcon(
              icon: HugeIcons.strokeRoundedArrowLeft01,
              color: theme.colorScheme.onSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/// عرض أفقي لأهم المتاجر مع زر "عرض الكل"
class _StoresPreviewWidget extends ConsumerWidget {
  const _StoresPreviewWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final stores = ref.watch(storesProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAutoSizeText(
              text: 'المتاجر',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
              fontSize: 12,
            ),
            TextButton(
              onPressed: () {
                // انتقل إلى صفحة كل المتاجر
              },
              child: Text(
                'عرض الكل',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 10

                ),
              ),
            ),
          ],
        ),
        ResponsiveSpace(height: 12,),
        ResponsiveSpace(
          height: 120,
          child: ListView.separated(
            // padding: EdgeInsets.symmetric(horizontal: responsive.w(16)),
            scrollDirection: Axis.horizontal,
            itemCount: stores.length > 3 ? 3 : stores.length,
            separatorBuilder: (_, _) => const ResponsiveSpace(width: 12),
            itemBuilder: (context, index) {
              final store = stores[index];
              return _StoreCard(store: store);
            },
          ),
        ),
      ],
    );
  }
}

class _StoreCard extends ConsumerWidget {
  final StoreModel store;
  const _StoreCard({required this.store});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RouteNames.merchantLedgerScreen.screen));
      },
      child: Container(
        width: responsive.w(100),
        height: responsive.h(100),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width:1),
        ),
        child: Padding(
          padding: responsive.paddingSym(h: 8, v: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                
                backgroundImage: Image.asset(store.imageUrl,
                fit: BoxFit.scaleDown,
                ).image,
                radius: 22,
              ),
              
              CustomAutoSizeText(
                text:  store.name,
                style: theme.textTheme.bodySmall,
                fontWeight: FontWeight.w800,
                colorText: theme.colorScheme.primary,
                maxLines: 1,
                fontSize: 10,
                
              ),
              // const ResponsiveSpace(height: 2),
              CustomAutoSizeText(
                text:  store.status,
                style: theme.textTheme.labelSmall,
                colorText: store.status == 'نشط'
                      ? Colors.green
                      : Colors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

/// قائمة العمليات الأخيرة (كما هي)
class _TransactionsListWidget extends ConsumerWidget {
  const _TransactionsListWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;

    // For a real app, this would use a provider to get a list of transactions.
    const transactionCount = 5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            CustomAutoSizeText(
              text: 'ديون الاخيرة ',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.primary,
              fontSize: 12,
            ),
            // dropdown for deys filter
            GestureDetector(
              onTap: () {
                
             
            },
              child: Row(
                children: [
                  CustomAutoSizeText(
                    text: 'اليوم ',
                    style: theme.textTheme.bodyMedium,
                    fontWeight: FontWeight.w600,
                    colorText: theme.colorScheme.primary,
                    fontSize: 12,
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            )
          ],
        ),
        // const ResponsiveSpace(height: 8),
        ListView.separated(
          padding: responsive.paddingOnly(top: 8),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactionCount,
          separatorBuilder: (context, index) => const ResponsiveSpace(height: 8),
          itemBuilder: (context, index) => const CustomLastTransationsItem(),
        ),
      ],
    );
  }
}