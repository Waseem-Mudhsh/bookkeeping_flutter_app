


import 'package:bookkeeping_flutter_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookkeeping_flutter_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

/// تطبيق لمستودع المصادقة
/// يقوم بتنسيق البيانات من مصادر البيانات المختلفة (هنا، مصدر بيانات وهمي واحد)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> login(String phoneNumber, String password) async {
    try {
      // استدعاء دالة تسجيل الدخول من مصدر البيانات
      return await remoteDataSource.login(phoneNumber, password);
    } catch (e) {
      // التعامل مع الأخطاء وإرجاع فشل العملية
      debugPrint('Error during login: $e');
      return false;
    }
  }
}