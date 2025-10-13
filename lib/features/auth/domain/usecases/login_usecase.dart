// lib/features/auth/domain/usecases/login_usecase.dart

import '../repositories/auth_repository.dart';

/// حالة استخدام لتسجيل الدخول
/// تحتوي على منطق العمل (Business Logic) لعملية تسجيل الدخول
class LoginUseCase {
  final AuthRepository repository;

  // تعتمد حالة الاستخدام على واجهة المستودع وليس على تطبيقها مباشرة (Dependency Inversion)
  LoginUseCase(this.repository);

  /// دالة لتنفيذ حالة الاستخدام
  Future<bool> execute(String phoneNumber, String password) async {
    // يمكن إضافة منطق إضافي هنا مثل التحقق المبدئي
    return await repository.login(phoneNumber, password);
  }
}