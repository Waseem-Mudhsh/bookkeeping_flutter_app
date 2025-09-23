import 'package:bookkeeping_flutter_app/features/Accounts/domain/entities/account.dart';
import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/Transactions/domain/entities/transaction_type.dart';

class HiveConfig {
  static Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      // استخدام Hive لتخزين البيانات
      // قم بتسجيل الصناديق
      // قم بفتح الصناديق
      //قم باغلاق الصناديق


      // تسجيل Adapters
      _registerAdapters();

      // فتح الصناديق
      await _openBoxes();
    } catch (e) {
      debugPrint('Hive initialization failed: $e');
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  static void _registerAdapters() {
   
    if (!Hive.isAdapterRegistered(AccountAdapter().typeId)) {
      Hive.registerAdapter(AccountAdapter());
    }
    if (!Hive.isAdapterRegistered(TransactionAdapter().typeId)) {
      Hive.registerAdapter(TransactionAdapter());
    }
    if (!Hive.isAdapterRegistered(TransactionTypeAdapter().typeId)) {
      Hive.registerAdapter(TransactionTypeAdapter());
    }
  }

  static Future<void> _openBoxes() async {
   

    try {
      if (!Hive.isBoxOpen(HiveBoxNames.accounts)) {
        await Hive.openBox<Account>(HiveBoxNames.accounts);
      }
    } catch (e) {
      debugPrint('Failed to open accounts box: $e');
    }
    try {
      if (!Hive.isBoxOpen(HiveBoxNames.transactions)) {
        await Hive.openBox<Transaction>(HiveBoxNames.transactions);
      }
    } catch (e) {
      debugPrint('Failed to open transactions box: $e');
      // يمكنك هنا إعادة المحاولة أو اتخاذ إجراء آخر
    }
    }
  


  static Future<void> closeBoxes() async {
    try {
      if (Hive.isBoxOpen(HiveBoxNames.customers)) {
        await Hive.box(HiveBoxNames.customers).close();
      }
      if (Hive.isBoxOpen(HiveBoxNames.accounts)) {
        await Hive.box(HiveBoxNames.accounts).close();
      }
      if (Hive.isBoxOpen(HiveBoxNames.transactions)) {
        await Hive.box(HiveBoxNames.transactions).close();
      }
    } catch (e) {
      debugPrint('Error closing Hive boxes: $e');
    }
  }
}


class HiveBoxNames {
  static const customers = 'customers';
  static const accounts = 'accounts';
  static const transactions = 'transactions';
  static const transactionType = 'transactionType';
}
