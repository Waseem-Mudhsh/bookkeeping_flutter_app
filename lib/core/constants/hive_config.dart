import 'package:bookkeeping_flutter_app/features/Customers/domain/entities/customer.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveConfig {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }
    await Hive.openBox<Customer>('customers');
  }
}