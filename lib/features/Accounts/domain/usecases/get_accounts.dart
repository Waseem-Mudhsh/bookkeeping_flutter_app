import 'package:flutter/rendering.dart';

import '../entities/account.dart';
import '../repositories/account_repository.dart';

class GetAccounts {
  final AccountRepository accountRepository;

  GetAccounts(this.accountRepository);

  Future<List<Account>> execute() async {
     try {
    final accounts = await accountRepository.getAccounts();
    // تأكد من إرجاع قائمة فارغة وليس null
    debugPrint('تم تحميل ${accounts.length} حساب');
    return accounts ; 
  } catch (e) {
    throw 'فشل في تحميل الحسابات';
  }
    
  }
}