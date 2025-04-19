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

  Customer({
    required this.id,
    required this.name,
    required this.balance,
    this.phone,
    this.taskStartDate,
    this.taskTotalDays,
  });

  Customer copyWith({
    String? id,
    String? name,
    double? balance,
    String? phone,
    DateTime? taskStartDate,
    int? taskTotalDays,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      phone: phone ?? this.phone,
      taskStartDate: taskStartDate ?? this.taskStartDate,
      taskTotalDays: taskTotalDays ?? this.taskTotalDays,
    );
  }
}