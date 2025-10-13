// lib/features/auth/data/datasources/auth_remote_datasource.dart

/// واجهة مجردة لمصدر البيانات
abstract class AuthRemoteDataSource {
  Future<bool> login(String phoneNumber, String password);
}

/// تطبيق وهمي (Mock) لمصدر البيانات
/// يحاكي استجابة من سيرفر حقيقي
class MockAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<bool> login(String phoneNumber, String password) async {
    // محاكاة تأخير الشبكة لمدة ثانيتين
    await Future.delayed(const Duration(milliseconds: 1000));

    // بيانات وهمية للتحقق
    const String dummyPhoneNumber = '123456789';
    const String dummyPassword = '123';

    // التحقق من البيانات المرسلة
    if (phoneNumber == dummyPhoneNumber && password == dummyPassword) {
      // إرجاع 'true' في حالة نجاح المصادقة
      return true;
    } else {
      // إطلاق استثناء في حالة فشل المصادقة
      throw Exception('بيانات التسجيل غير صحيحة');
    }
  }
}