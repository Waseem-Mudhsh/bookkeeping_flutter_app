// import 'package:hive/hive.dart';

// part 'customer.g.dart';

// @HiveType(typeId: 0)
// class Customer {
//   @HiveField(0)
//   final String id;
//   @HiveField(1)
//   final String name;
//   @HiveField(2)
//   final double balance;

//   Customer({required this.id, required this.name, required this.balance});

//   factory Customer.fromJson(Map<String, dynamic> json) {
//     return Customer(
//       id: json['id'],
//       name: json['name'],
//       balance: json['balance'].toDouble(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'balance': balance,
//     };
//   }
// }


import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final double balance;
  
  @HiveField(3)
  final String? phone;
  
  @HiveField(4)
  final DateTime? taskStartDate;
  
  @HiveField(5)
  final int? taskTotalDays;
  
  @HiveField(6)
  final String? currency;

  Customer({
    required this.id,
    required this.name,
    required this.balance,
    this.phone,
    this.taskStartDate,
    this.taskTotalDays,
    this.currency,
  });

  Customer copyWith({
   Object? id = unchanged,
    Object? name = unchanged,
    Object? balance = unchanged,
    Object? phone = unchanged,
    Object? taskStartDate= unchanged,
    Object? taskTotalDays = unchanged,
    Object? currency= unchanged,
  }) {
    return Customer(
      id: id == unchanged ? this.id : id as String,
      name: name== unchanged ? this.name : name as String,
      balance: balance ==unchanged ? this.balance : balance as double,
      phone: phone ==unchanged ? this.phone : phone as String,
      taskStartDate: taskStartDate == unchanged ? this.taskStartDate : taskStartDate as DateTime,
      taskTotalDays: taskTotalDays == unchanged ? this.taskTotalDays : taskTotalDays as int,
      currency: currency == unchanged ? this.currency : currency as String,
    );
  }
  static const unchanged = Object(); // استخدام طريقة Sentinel Pattern لتعبئة القيم الخالية
  // لحل مشكلة عند تمرير قيمة null للكونستركتور
  // اذا مررت قيمة: بيظل المعامل قيمته uncganded فسينسخ الحقل الاصلي (this.field).
  // اذا مررت قيمة null: المعامل بيصير null مش unchanged, فبيصير المعامل قيمة null.
}