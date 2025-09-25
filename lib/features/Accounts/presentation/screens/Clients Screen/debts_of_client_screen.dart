// import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
// import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
// import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart'
//     show ResponsiveSpace;
// import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_debts_of_client_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hugeicons/hugeicons.dart';

// import '../../../../Transactions/presentation/widgets/custom_list_transation_item.dart';

// /// A simple data model for a service item.
// class ServiceModel {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final int count;

//   const ServiceModel({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     this.count = 0,
//   });
// }

// // A Riverpod provider to simulate fetching service data.
// final servicesProvider = Provider<List<ServiceModel>>((ref) {
//   return [
//     const ServiceModel(
//       title: 'قائمة الطلبات',
//       subtitle: 'عدد الطلبات الجديدة',
//       icon: HugeIcons.strokeRoundedProfile,
//       count: 12, // Example hardcoded value
//     ),
//     const ServiceModel(
//       title: 'قائمة المتاجر',
//       subtitle: 'عدد المتاجر',
//       icon: HugeIcons.strokeRoundedStore01,
//       count: 5, // Example hardcoded value
//     ),
//   ];
// });

// /// Represents the screen for displaying client debts and related services.
// class DebtsOfClientScreen extends ConsumerWidget {
//   const DebtsOfClientScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final responsive = ref.responsive;

//     return BaseLayoutScreen(
//       drawer: const CustomDrawer(),
//       body: BuildNonTabbarLayout(
//         titleWidget: const _HeaderWidget(),
//         toolbarHeight: responsive.h(60),
//         slivers: const [
//           SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
//           SliverToBoxAdapter(child: CustomDebtsOfClientCard()),
//           SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
//           SliverToBoxAdapter(child: _ServicesButtonsRow()),
//           SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
//           SliverToBoxAdapter(child: _TransactionsListWidget()),
//           SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
//         ],
//       ),
//     );
//   }
// }

// /// A dedicated widget for the screen header.
// class _HeaderWidget extends ConsumerWidget {
//   const _HeaderWidget();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.theme;
//     return CustomAutoSizeText(
//       text: 'اسم المستخدم كعميل',
//       style: theme.textTheme.bodyMedium,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//       colorText: theme.colorScheme.primary,
//     );
//   }
// }

// /// A reusable widget for a single service item button.
// class _ServiceItemWidget extends ConsumerWidget {
//   final ServiceModel service;

//   const _ServiceItemWidget({required this.service});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.theme;
//     final responsive = ref.responsive;

//     return Expanded(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           padding: responsive.paddingSym(h: 12, v: 16),
//         ),
//         onPressed: () {
//           // Add navigation logic here
//         },
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 CustomAutoSizeText(
//                   text: service.title,
//                   style: theme.textTheme.bodyMedium,
//                   fontWeight: FontWeight.bold,
//                   colorText: theme.colorScheme.onPrimary,
//                   fontSize: 12,
//                 ),
//                 const Spacer(),
//                 CircleAvatar(
//                   backgroundColor: theme.colorScheme.onPrimary,
//                   child: CustomHugeIcon(
//                     icon: service.icon,
//                     size: 20,
//                     color: theme.colorScheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//             const ResponsiveSpace(height: 8),
//             CustomAutoSizeText(
//               text: '${service.subtitle}: ${service.count}',
//               style: theme.textTheme.bodySmall,
//               fontSize: 10,
//               colorText: theme.colorScheme.onPrimary,
//               fontWeight: FontWeight.w600,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// A widget to display the row of service buttons.
// class _ServicesButtonsRow extends ConsumerWidget {
//   const _ServicesButtonsRow();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.theme;
//     final services = ref.watch(servicesProvider);

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomAutoSizeText(
//           text: 'الخدمات',
//           style: theme.textTheme.bodyMedium,
//           fontWeight: FontWeight.w600,
//           colorText: theme.colorScheme.primary,
//           fontSize: 12,
//         ),
//         const ResponsiveSpace(height: 12),
//         Row(
//           children: [
//             _ServiceItemWidget(service: services[0]),
//             const ResponsiveSpace(width: 8),
//             _ServiceItemWidget(service: services[1]),
//           ],
//         ),
//       ],
//     );
//   }
// }

// /// A widget for displaying the list of transactions.
// class _TransactionsListWidget extends ConsumerWidget {
//   const _TransactionsListWidget();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.theme;
//     // For a real app, this would use a provider to get a list of transactions.
//     const transactionCount = 5;

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         CustomAutoSizeText(
//           text: 'العمليات الأخيرة',
//           style: theme.textTheme.bodyMedium,
//           fontWeight: FontWeight.w600,
//           colorText: theme.colorScheme.primary,
//           fontSize: 12,
//         ),
//         const ResponsiveSpace(height: 12),
//         ListView.separated(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: transactionCount,
//           separatorBuilder: (context, index) => const ResponsiveSpace(height: 8),
//           itemBuilder: (context, index) => const CustomListTransationItem(),
//         ),
//       ],
//     );
//   }
// }



import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_drawer.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/custom_debts_of_client_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../Transactions/presentation/widgets/custom_list_transation_item.dart';

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
  ];
});

// Provider وهمي لعدد الطلبات الجديدة
final newRequestsCountProvider = Provider<int>((ref) => 1); // عدل القيمة للتجربة

class DebtsOfClientScreen extends ConsumerWidget {
  const DebtsOfClientScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;

    return BaseLayoutScreen(
      drawer: const CustomDrawer(),
      body: BuildNonTabbarLayout(
        titleWidget: const _HeaderWidget(),
        toolbarHeight: responsive.h(60),
        slivers: [
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          const SliverToBoxAdapter(child: CustomDebtsOfClientCard()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(child: _RequestsNotificationButton()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 16)),
          const SliverToBoxAdapter(child: _StoresPreviewWidget()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 24)),
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
      text: 'اسم المستخدم كعميل',
      style: theme.textTheme.bodyMedium,
      fontWeight: FontWeight.bold,
      fontSize: 14,
      colorText: theme.colorScheme.primary,
    );
  }
}

/// زر إشعار الطلبات الجديدة (يظهر فقط إذا كان هناك طلبات)
class _RequestsNotificationButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    
    final newRequests = ref.watch(newRequestsCountProvider);

    if (newRequests == 0) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        // انتقل إلى صفحة الطلبات الجديدة
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.secondary, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CustomHugeIcon(
                  icon: HugeIcons.strokeRoundedNotification01,
                  color: theme.colorScheme.secondary,
                  size: 24,
                ),
                if (newRequests > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$newRequests',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const ResponsiveSpace(width: 8),
            CustomAutoSizeText(
              text: 'لديك $newRequests طلب جديد لمشاركة الديون',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
              colorText: theme.colorScheme.secondary,
              fontSize: 12,
            ),
            const Spacer(),
            CustomHugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: theme.colorScheme.secondary,
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
    final responsive = ref.responsive;
    final stores = ref.watch(storesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAutoSizeText(
              text: 'أهم المتاجر',
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
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
      onTap: () {},
      child: Container(
        width: responsive.w(120),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.5), width:1),
        ),
        child: Padding(
          padding: responsive.paddingSym(h: 8, v: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                
                backgroundImage: Image.asset(store.imageUrl).image,
                radius: 22,
              ),
              
              CustomAutoSizeText(
                text:  store.name,
                style: theme.textTheme.bodySmall,
                fontWeight: FontWeight.w800,
                colorText: theme.colorScheme.primary,
                maxLines: 1,
                fontSize: 12,
                
              ),
              // const ResponsiveSpace(height: 2),
              CustomAutoSizeText(
                text:  store.type,
                style: theme.textTheme.bodySmall,
                fontWeight: FontWeight.w600,
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
    // For a real app, this would use a provider to get a list of transactions.
    const transactionCount = 5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAutoSizeText(
          text: 'العمليات الأخيرة',
          style: theme.textTheme.bodyMedium,
          fontWeight: FontWeight.w600,
          colorText: theme.colorScheme.primary,
          fontSize: 12,
        ),
        const ResponsiveSpace(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: transactionCount,
          separatorBuilder: (context, index) => const ResponsiveSpace(height: 8),
          itemBuilder: (context, index) => const CustomListTransationItem(),
        ),
      ],
    );
  }
}