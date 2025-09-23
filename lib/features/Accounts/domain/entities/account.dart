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
  final int mainAccountId;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double totalAccountBalance;
  @HiveField(5)
  final double debtor;
  @HiveField(6)
  final double creditor;
  @HiveField(7)
  final String? currencyCode;
  @HiveField(8)
  final DateTime createdAt;
  @HiveField(9)
  final String? note;
  @HiveField(10)
  final String? image;

  @HiveField(11)
  final String? phoneNumber;

  const Account({
    required this.id,
    required this.name,
    required this.mainAccountId,
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
      mainAccountId: mainAccountId ==unchanged ? this.mainAccountId : mainAccountId as int,
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

 final List<Account>  mockAccounts = [
  Account(
    id: '1',
    name: 'محمد على',
    mainAccountId: 3,
    category: 'موردين',
    totalAccountBalance: -1200,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'USD',
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    note: 'مصاريف المنزل الشهريّة',
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '2',
    name: 'العميل محمد',
    mainAccountId: 2,
    category: 'العملاء',
    totalAccountBalance: 5000,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'SAR',
    createdAt: DateTime.now().subtract(Duration(days: 3)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '3',
    name: 'اخي احمد',
    mainAccountId: 4,
    category: 'مصروفات',
    totalAccountBalance: 2500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'EUR',
    createdAt: DateTime.now().subtract(Duration(days: 25)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '4',
    name: 'المورد سعيد صالح',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'JPY',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '5',
    name: 'صديق علي',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'GBP',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '6',
    name: 'بكر محمد صالح الاثوري',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'AED',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '7',
    name: 'سالم ابو البيض',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'EGP',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '8',
    name: 'عبدالله محمد',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'KWD',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '9',
    name: 'علي احمد',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'OMR',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '10',
    name: 'يوسف علي',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'QAR',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '11',
    name: 'علي محمد',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'BHD',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '12',
    name: 'عبدالله صالح',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'YER',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '13',
    name: 'علي صالح',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'SYP',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '14',
    name: 'محمد علي',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'LBP',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  Account(
    id: '15',
    name: 'احمد محمد',
    mainAccountId: 2,
    category: 'موردين',
    totalAccountBalance: -500,
    debtor: 0,
    creditor: 1200,
    currencyCode: 'JOD',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    phoneNumber: '0123456789 ',
  ),
  
];
