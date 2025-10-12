import 'package:hive/hive.dart';

import '../../../../core/utils/id_generator.dart';

part 'account.g.dart';
@HiveType(typeId: 1)
class Account {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String category;
  @HiveField(3)
  final double totalAccountBalance;
  @HiveField(4)
  final double debtor;
  @HiveField(5)
  final double creditor;
  @HiveField(6)
  final String? currencyCode;
  @HiveField(7)
  final DateTime createdAt;
  @HiveField(8)
  final String? note;
  @HiveField(9)
  final String? image;

  @HiveField(10)
  final String? phoneNumber;

  const Account({
    required this.id,
    required this.name,
    
    required this.category,
    required this.totalAccountBalance,
    required this.debtor,
    required this.creditor,
    required this.currencyCode,
    required this.createdAt,
    required this.phoneNumber,
    this.note,
    this.image,
  });

  Account copyWith({
    Object? id= unchanged,
    Object? name,
    Object? mainAccountId,
    Object? category,
    Object? totalAccountBalance,
    Object? debtor,
    Object? creditor,
    Object? currencyCode,
    Object? createdAt,
    Object? note,
    Object? image,
    Object? phoneNumber
  }) {
    return Account(
      id: id == unchanged? IdGenerator.generateCompactId(prefix: 'acc_'):id as String,
      name: name == unchanged ? this.name : name as String,
      
      category: category == unchanged ? this.category : category as String,
      totalAccountBalance: totalAccountBalance == unchanged ? this.totalAccountBalance : totalAccountBalance as double,
      debtor: debtor == unchanged ? this.debtor : debtor as double,
      creditor: creditor == unchanged ? this.creditor : creditor as double,
      currencyCode: currencyCode == unchanged ? this.currencyCode : currencyCode as String,
      createdAt: createdAt == unchanged ? this.createdAt : createdAt as DateTime,
      note: note == unchanged ? this.note : note as String,
      image: image == unchanged ? this.image : image as String,
      phoneNumber: phoneNumber == unchanged ? this.phoneNumber : phoneNumber as String
    );
  }
  static const unchanged = Object(); // استخدام طريقة Sentinel Pattern لتعبئة القيم الخالية
  // لحل مشكلة عند تمرير قيمة null للكونستركتور
  // اذا مررت قيمة: بيظل المعامل قيمته uncganded فسينسخ الحقل الاصلي (this.field).
  // اذا مررت قيمة null: المعامل بيصير null مش unchanged, فبيصير المعامل قيمة null.
}

 
