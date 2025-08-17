import 'package:hive/hive.dart';
part 'transaction_type.g.dart';
@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  debit, //مدين - اللون الاحمر/ الاموال التي تدينها للعميل  / عليه
  
  @HiveField(1)
  credit, //دائن - اللون الاخضر / الاموال التي يسددها العميل لك / له
}