// lib/features/auth/data/datasources/auth_remote_datasource.dart

import 'package:shared_preferences/shared_preferences.dart';

/// واجهة مجردة لمصدر البيانات
abstract class AuthRemoteDataSource {
  Future<bool> login(String phoneNumber, String password);
}

/// تطبيق وهمي (Mock) لمصدر البيانات يقرأ من SharedPreferences
/// يحاكي استجابة من سيرفر حقيقي
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  final SharedPreferences sharedPreferences;

  MockAuthRemoteDataSource(this.sharedPreferences);

  @override
  Future<bool> login(String phoneNumber, String password) async {
    // محاكاة تأخير الشبكة لمدة ثانيتين
    await Future.delayed(const Duration(milliseconds: 1000));

    // جلب بيانات المستخدم المحفوظة
    final String? savedPhoneNumber = sharedPreferences.getString('userPhoneNumber');
    final String? savedPassword = sharedPreferences.getString('userPassword');

    // التحقق من البيانات المرسلة
    if (phoneNumber == savedPhoneNumber && password == savedPassword) {
      // إرجاع 'true' في حالة نجاح المصادقة
      return true;
    } else {
      // إطلاق استثناء في حالة فشل المصادقة
      throw Exception('بيانات التسجيل غير صحيحة');
    }
  }
}