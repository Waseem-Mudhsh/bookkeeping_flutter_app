

import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_tab_bar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_tab_view_container.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:bookkeeping_flutter_app/features/Accounts/presentation/widgets/action_buttons_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/utils/route_names.dart';
import '../../../../Transactions/domain/entities/transaction_type.dart';
import '../../../../Transactions/presentation/widgets/custom_transaction_item_of_client.dart';
import '../../widgets/financial_bottom_navbar.dart';

// --- Mock Data Structures (Replace with your actual entity models) ---

class TransactionModel {
  final double amount;
  final String description;
  final String buyer;
  final DateTime date;
  final TransactionType isDebit; // true for "له" (to client), false for "عليه" (from client)

  TransactionModel({
    required this.amount,
    required this.description,
    required this.buyer,
    required this.date,
    required this.isDebit,
  });
}
class MerchantProfileEntity {
  final String storeName;
  final String storeType;
  final String phone;
  final String address;
  final String logoUrl;
  final double debitBalance;
  final double creditBalance;
  final double? ceilingAmount;

  MerchantProfileEntity({
    required this.storeName,
    required this.storeType,
    required this.phone,
    required this.address,
    required this.logoUrl,
    required this.debitBalance,
    required this.creditBalance,
    this.ceilingAmount,
  });
}

// --- Main Screen Widget ---

class MerchantLedgerScreen extends ConsumerWidget {
  

  const MerchantLedgerScreen({
    super.key,
    
  });

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final MerchantProfileEntity merchantProfile = MerchantProfileEntity(
      storeName: 'متجر الحسني',
      storeType: 'متجر',
      phone: '01123456789',
      address: 'مكة المكرمة - المملكة العربية السعودية',
      logoUrl: 'https://example.com/logo.png',
      debitBalance: 5000, 
      creditBalance: 5000000,
      ceilingAmount: 1000000,
    );
    final List<Tab> tabs = [
      Tab(text: 'يمني'),
      Tab(text: 'سعودي'),
      Tab(text: 'دولار'),
      
    ];
    // Mock transaction data for demonstration
  final List<TransactionModel> transactions = [
    TransactionModel(
        amount: 500000,
        description: 'سداد من سعد الحسني',
        buyer: 'سعد الحسني',
        date: DateTime.parse('2025-03-03 23:00'),
        isDebit: TransactionType.credit), // عليه (Credit)
    TransactionModel(
        amount: 500000,
        description: 'دبة زيت 8 لتر + 6 كيلو بطاط + كيلو طماط + سلطة',
        buyer: 'احمد الحسني',
        date: DateTime.parse('2025-03-03 23:00'),
        isDebit: TransactionType.debit), // له (Debit)
    TransactionModel(
        amount: 50000000,
        description: 'دبة زيت 8 لتر + 6 كيلو بطاط + كيلو طماط + سلطة',
        buyer: 'بحر السياحة',
        date: DateTime.parse('2025-03-03 23:00'),
        isDebit: TransactionType.debit),
    TransactionModel(
        amount: 500000,
        description: 'دبة زيت 8 لتر + 6 كيلو بطاط + كيلو طماط + سلطة',
        buyer: 'احمد الحسني',
        date: DateTime.parse('2025-03-03 23:00'),
        isDebit: TransactionType.debit),
    TransactionModel(
        amount: 500000,
        description: 'دبة زيت 8 لتر + 6 كيلو بطاط + كيلو طماط + سلطة',
        buyer: 'ياسر العرفان',
        date: DateTime.parse('2025-03-03 23:00'),
        isDebit: TransactionType.debit),
  ];
    final theme = ref.theme;
    final double? ceilingAmount = merchantProfile.ceilingAmount ;
    final double balance = merchantProfile.debitBalance - merchantProfile.creditBalance;
    final String textCeilingAmount = balance > ceilingAmount!  ? 'تجاوزت حد السقف': 'ضمن حد السقف';
    final Color colorText = balance > ceilingAmount  ? theme.colorScheme.error : theme.colorScheme.primary;

   
    return BaseLayoutScreen(
      
      body: BuildTabBarLayout(
        
             titleWidget: _buildHeader(theme,merchantProfile),
             actions: [
              _buildBalanceOverviewSection(ref,ceilingAmount.toString(), textCeilingAmount,colorText),
             ],
         tabs: tabs,
        tabViews: [
          CustomTabViewContainer(
          responsive: ref.responsive,
          child: _buildMershantListByCurrency( transactions)),
         CustomTabViewContainer(
          responsive: ref.responsive,
          child: _buildMershantListByCurrency(transactions)),
          CustomTabViewContainer(
          responsive: ref.responsive,
          child: _buildMershantListByCurrency(transactions)),
         
        ],
          initialTabIndex: 0,
           hasLeading: false,
            toolbarHeight: 90,),
       bottomNavigationBar: FinancialBottomNavBar( creditBalance: merchantProfile.creditBalance, debitBalance: merchantProfile.debitBalance,),
    );
  }
   Widget _buildHeader( ThemeData theme,MerchantProfileEntity merchantProfile){
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomAutoSizeText(
              text:  merchantProfile.storeName ,
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              colorText: theme.colorScheme.primary,
            ),
             ResponsiveSpace(height: 4),
             CustomAutoSizeText(
              text: 'هاتف: ${merchantProfile.phone} ',
              style: theme.textTheme.bodyMedium,
              
              fontSize: 10,
              colorText: theme.colorScheme.onSurfaceVariant,
            ),
          ],
        );
  }
  Widget _buildBalanceOverviewSection(WidgetRef ref, String ceilingAmount, String textCeilingAmount,Color colorText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        CustomAutoSizeText(text: 'سقف الحساب: $ceilingAmount',
        fontSize: 8,
        style: ref.theme.textTheme.bodySmall,
        colorText: ref.theme.colorScheme.onSurfaceVariant,
        fontWeight: FontWeight.w700,

        ),
        ResponsiveSpace(height: 4),
        CustomAutoSizeText(text: textCeilingAmount,
        fontSize: 8,
        style: ref.theme.textTheme.bodySmall,
        colorText: colorText,
        fontWeight: FontWeight.w700,
        )

    ],);
  }
  Widget _buildMershantListByCurrency( List<TransactionModel> transactions){
    return Column(
      children: [
        // 1. Remaining Balance Card (The "Countdown" section)
         ResponsiveSpace(height: 8),
             

                // 2. Client Actions Row
                _ClientActionsRow(
                  
                ),
                ResponsiveSpace(height: 16),
                
                // 4. Transaction History Table
                _TransactionTable(
                  transactions: transactions,
                  
                ),
                 ResponsiveSpace(height: 8),

      ],
    );
  }
}

// ====================================================================
// --- MODULAR WIDGETS ---
// ====================================================================




// --- 2. Client Actions Row ---
class _ClientActionsRow extends ConsumerWidget {
  
  

 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    return ActionButtonsRow(
      actionButtons: [
        ActionButton(label: 'اتصال', icon: HugeIcons.strokeRoundedCall02, onPressed: (){},isCompact: true,),
        ActionButton(label: 'رسالة', icon: HugeIcons.strokeRoundedMessage01, onPressed: (){},isCompact: true,),
        ActionButton(label: 'المستفيدين', icon: HugeIcons.strokeRoundedUserGroup03, onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => RouteNames.beneficiariesScreen.screen));


        },isCompact: true,),
        ActionButton(label: 'سداد', icon: HugeIcons.strokeRoundedCash01, onPressed: (){},isCompact: true,),
        ActionButton(label: 'تقرير', icon: HugeIcons.strokeRoundedPdf01, onPressed: (){},isCompact: true,),
      ],
    );
  }
  }





// --- 5. Transaction History Table (UPDATED: Removed Header) ---
class _TransactionTable extends ConsumerWidget {
  final List<TransactionModel> transactions;
  

  const _TransactionTable({
    required this.transactions,
    
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    
    return Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: responsive.h(8),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomAutoSizeText(
              text: 'عدد العمليات: ${transactions.length}',
              style: theme.textTheme.bodyMedium,
              fontWeight: FontWeight.w600,
              colorText: theme.colorScheme.secondary,
              fontSize: 10,
            ),
            Spacer(),
            CustomIconButton(
              hugeIcon:  HugeIcon(icon:HugeIcons.strokeRoundedSearch01,
               color: theme.colorScheme.secondary,
               size: responsive.h(20),),
             
              
              onPressed: (){},
             
            ),
            ResponsiveSpace(width: 8),
            CustomIconButton(
              hugeIcon: HugeIcon(icon: HugeIcons.strokeRoundedSorting01,
               color: theme.colorScheme.secondary,
               size: responsive.h(20),),
            
              onPressed:(){},
              
            ),
     
          ],
        ),
       

        // Transaction Rows
        ...transactions.map((txn) {
          return CustomTransactionItemOfClient(
            transaction: txn,
            
            // Subtle Animation: On tap to view details/edit
            onTap: () {
              // Navigate to transaction details screen
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: CustomAutoSizeText(text: 'Viewing Transaction ${txn.buyer}',
                fontSize: 10,
                style: theme.textTheme.bodySmall,
                fontWeight: FontWeight.w500,
                colorText: theme.colorScheme.onPrimary
                
                ),
                backgroundColor: theme.colorScheme.primary,
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

// --- 7. Single Transaction Row (REFАCTORED to use ListTile) ---

