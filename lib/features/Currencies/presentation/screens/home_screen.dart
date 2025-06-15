// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart'; // For currency formatting

// // // Transaction model (should be in a separate file)
// // class Transaction {
// //   final String id;
// //   final String title;
// //   final double amount;
// //   final DateTime date;
// //   final String category;

// //   Transaction({
// //     required this.id,
// //     required this.title,
// //     required this.amount,
// //     required this.date,
// //     required this.category,
// //   });
// // }
// // class HomeScreen extends StatelessWidget {
// //   final List<Transaction> transactions;
// //   final double balance;

// //   const HomeScreen({required this.transactions, required this.balance, Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: CustomScrollView(
// //         physics: const BouncingScrollPhysics(),
// //         slivers: [
// //           // Primary AppBar
// //           SliverAppBar(
// //             expandedHeight: 220,
// //             pinned: true,
// //             flexibleSpace: FlexibleSpaceBar(
// //               title: Text('My Finance'),
// //               background: BalanceSummaryCard(balance: balance),
// //             ),
// //           ),

// //           // Secondary TabBar
// //           // SliverPersistentHeader(
// //           //   pinned: true,
// //           //   delegate: _SecondaryAppBarDelegate(),
// //           // ),

// //           // Recent Transactions Header
// //           SliverPadding(
// //             padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
// //             sliver: SliverToBoxAdapter(
// //               child: Text(
// //                 'Recent Transactions',
// //                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Transactions List
// //           SliverPadding(
// //             padding: EdgeInsets.symmetric(horizontal: 16),
// //             sliver: SliverList.separated(
// //               itemCount: transactions.length,
// //               separatorBuilder: (context, index) => SizedBox(height: 12),
// //               itemBuilder: (context, index) {
// //                 return TransactionCard(transaction: transactions[index]);
// //               },
// //             ),
// //           ),

// //           // Empty space filler with "Load More" button
// //           SliverFillRemaining(
// //             hasScrollBody: false,
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.end,
// //               children: [
// //                 if (transactions.isEmpty)
// //                   Text('No transactions yet',
// //                     style: Theme.of(context).textTheme.bodyMedium),
// //                 ElevatedButton(
// //                   onPressed: () {/* Load more */},
// //                   child: Text('Load More'),
// //                 ),
// //                 SizedBox(height: 24),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:bookkeeping_flutter_app/core/app_scaffold/app_scroll_view.dart';
// import 'package:bookkeeping_flutter_app/core/app_scaffold/build_tab_view.dart';
// import 'package:bookkeeping_flutter_app/core/app_scaffold/page_builder.dart';
// import 'package:bookkeeping_flutter_app/core/widgets/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// import '../../../../core/providers/responsive_notifier.dart';

// class Transaction {
//   final String id;
//   final String title;
//   final double amount;
//   final DateTime date;
//   final String category;

//   Transaction({
//     required this.id,
//     required this.title,
//     required this.amount,
//     required this.date,
//     required this.category,
//   });
// }

// class HomeScreen extends ConsumerWidget {
//   final List<Transaction> transactions;
//   final double balance;

//   const HomeScreen({
//     required this.transactions,
//     required this.balance,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     // return DefaultTabController(
//     //   length: 3, // عدد التبويبات
//     //   child: Scaffold(
//     //     floatingActionButton: FloatingActionButton(
//     //       child: Icon(Icons.add),
//     //       backgroundColor: Theme.of(context).primaryColor,
//     //       onPressed: () {/* Add transaction */},
//     //     ),
//     //     body: NestedScrollView(

//     //       physics: const BouncingScrollPhysics(),
//     //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//     //         return [
//     //           // AppBar الرئيسية
//     //           SliverAppBar(
//     //             title: Text('My Finance'),

//     //             expandedHeight: 260,
//     //             pinned: true,
//     //             floating: false,

//     //             flexibleSpace: FlexibleSpaceBar(

//     //               background: BalanceSummaryCard(balance: balance),
//     //             ),
//     //             bottom: TabBar(
//     //               tabs: [
//     //                 Tab(text: 'Overview'),
//     //                 Tab(text: 'Transactions'),
//     //                 Tab(text: 'Stats'),
//     //               ],
//     //               indicatorColor: Colors.white,
//     //               labelColor: Colors.white,
//     //               unselectedLabelColor: Colors.white70,
//     //             ),
//     //           ),
//     //         ];
//     //       },
//     //       body: TabBarView(
//     //         children: [

//     //           // تبويب Overview
//     //           _buildOverviewTab(context),

//     //           // تبويب Transactions
//     //           _buildTransactionsTab(context),

//     //           // تبويب Stats
//     //           _buildStatsTab(context),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
//     final responsive = ref.watch(responsiveProvider);
//     return AppScrollView(
      
      
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         backgroundColor: Theme.of(context).primaryColor,
//         onPressed: () {
//           /* Add transaction */
//         },
//       ),
      
      
//       child: BuildTabView(
//         lenghtTabController: 
//         3, 
//         tabs: PreferredSize(
//           preferredSize: Size.fromHeight(responsive.h(20)), 
//           child: TabBar(
//             indicatorColor: Colors.white,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white70,
//             tabs: [
//               Tab(text: 'Overview'),
//               Tab(text: 'Transactions'),
//               Tab(text: 'Stats'),
//             ],
//           )), 
//         tabViews: [
//           _buildOverviewTab(context),
//           _buildTransactionsTab(context),
//           _buildStatsTab(context),
//         ]),
//     );
//   }

//   Widget _buildOverviewTab(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: EdgeInsets.all(16),
//           sliver: SliverToBoxAdapter(
//             child: Column(
//               children: [
//                 _buildSummaryCard('Total Income', '\$3,250.00', Colors.green),
//                 SizedBox(height: 16),
//                 _buildSummaryCard('Total Expenses', '\$1,004.80', Colors.red),
//                 SizedBox(height: 16),
//                 _buildSummaryCard('Savings', '\$2,245.20', Colors.blue),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTransactionsTab(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverPadding(
//           padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
//           sliver: SliverToBoxAdapter(
//             child: Text(
//               'Recent Transactions',
//               style: Theme.of(
//                 context,
//               ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//         SliverPadding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           sliver: SliverList.separated(
//             itemCount: transactions.length,
//             separatorBuilder: (context, index) => SizedBox(height: 12),
//             itemBuilder: (context, index) {
//               return TransactionCard(transaction: transactions[index]);
//             },
//           ),
//         ),
//         SliverFillRemaining(
//           hasScrollBody: false,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               if (transactions.isEmpty)
//                 Text(
//                   'No transactions yet',
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ElevatedButton(
//                 onPressed: () {
//                   /* Load more */
//                 },
//                 child: Text('Load More'),
//               ),
//               SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatsTab(BuildContext context) {
//     return Center(
//       child: Text(
//         'Statistics will be displayed here',
//         style: Theme.of(context).textTheme.titleMedium,
//       ),
//     );
//   }

//   Widget _buildSummaryCard(String title, String amount, Color color) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               amount,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // باقي الكلاسات (BalanceSummaryCard, TransactionCard) تبقى كما هي بدون تغيير

// class BalanceSummaryCard extends StatelessWidget {
//   final double balance;

//   const BalanceSummaryCard({required this.balance, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

//     return Container(
//       color: Theme.of(context).primaryColor,
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Current Balance',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//           SizedBox(height: 4),
//           Text(
//             formatter.format(balance),
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: _buildIncomeOutcome(
//                   context,
//                   title: 'Income',
//                   amount: 3250.00,
//                   isIncome: true,
//                 ),
//               ),
//               SizedBox(width: 8),
//               Expanded(
//                 child: _buildIncomeOutcome(
//                   context,
//                   title: 'Expenses',
//                   amount: 1004.80,
//                   isIncome: false,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildIncomeOutcome(
//     BuildContext context, {
//     required String title,
//     required double amount,
//     required bool isIncome,
//   }) {
//     final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min, // Use min to avoid taking extra space
//       children: [
//         Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
//         SizedBox(height: 4),
//         Text(
//           formatter.format(amount),
//           style: TextStyle(
//             color: isIncome ? Colors.greenAccent : Colors.redAccent,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget _buildIncomeOutcome(
//   BuildContext context, {
//   required String title,
//   required double amount,
//   required bool isIncome,
// }) {
//   final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
//       SizedBox(height: 4),
//       Text(
//         formatter.format(amount),
//         style: TextStyle(
//           color: isIncome ? Colors.greenAccent : Colors.redAccent,
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   );
// }

// class _SecondaryAppBarDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Container(
//       color: Theme.of(context).appBarTheme.backgroundColor ?? Colors.white,
//       child: TabBar(
//         indicatorColor: Theme.of(context).primaryColor,
//         labelColor: Theme.of(context).primaryColor,
//         unselectedLabelColor: Colors.grey,
//         tabs: [
//           Tab(text: 'Overview'),
//           Tab(text: 'Transactions'),
//           Tab(text: 'Stats'),
//         ],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 48; // Height of TabBar

//   @override
//   double get minExtent => 48;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       false;
// }

// class TransactionCard extends StatelessWidget {
//   final Transaction transaction;

//   const TransactionCard({required this.transaction, Key? key})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isIncome = transaction.amount >= 0;
//     final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

//     return Card(
//       elevation: 1,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color:
//                     isIncome
//                         ? Colors.green.withOpacity(0.1)
//                         : Colors.red.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 isIncome ? Icons.arrow_upward : Icons.arrow_downward,
//                 color: isIncome ? Colors.green : Colors.red,
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     transaction.title,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     transaction.category,
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               formatter.format(transaction.amount),
//               style: TextStyle(
//                 color: isIncome ? Colors.green : Colors.red,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
