import 'package:hive/hive.dart';
part 'transaction_type.g.dart';
@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  debit, //مدين - يستخدم لتسجيل المصروفات والاموال التي تدفعها / الاموال التي يسددها العميل لك  / له
  
  @HiveField(1)
  credit, //دائن - يستخدم لتسجيل المداخيل والاموال التي تستلمها / الاموال التي تدينها للعميل / عليه
}