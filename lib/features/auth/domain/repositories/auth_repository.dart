// lib/features/auth/domain/repositories/auth_repository.dart

/// واجهة مجردة (Abstract Interface) لمستودع المصادقة
/// تحدد العقود التي يجب أن يلتزم بها أي تطبيق للمستودع في طبقة البيانات
abstract class AuthRepository {
  /// دالة لتسجيل دخول المستخدم
  /// تستقبل رقم الهاتف وكلمة المرور
  
  Future<bool> login(String phoneNumber, String password);
}