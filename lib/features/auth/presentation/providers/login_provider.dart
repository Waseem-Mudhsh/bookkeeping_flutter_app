

import 'package:bookkeeping_flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookkeeping_flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookkeeping_flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bookkeeping_flutter_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// 1. Provider لمصدر البيانات الوهمي
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return MockAuthRemoteDataSource();
});

// 2. Provider لمستودع المصادقة الذي يعتمد على مصدر البيانات
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource);
});

// 3. Provider لحالة الاستخدام التي تعتمد على المستودع
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

// 4. Provider لإدارة حالة رؤية كلمة المرور
final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

// 5. Provider لإدارة حالة التحميل (عند الضغط على زر الدخول)
final loadingStateProvider = StateProvider<bool>((ref) => false);