import 'package:bookkeeping_flutter_app/features/Transactions/domain/entities/transaction_type.dart';
import 'package:hive/hive.dart';

import '../../../../core/utils/id_generator.dart';

part 'transaction.g.dart';
@HiveType(typeId: 2)
class Transaction {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String accountId; // Account ID reference
  
  @HiveField(2)
  final double amount;
  
  @HiveField(3)
  final DateTime date;
  
  @HiveField(4)
  final String description;
  
  @HiveField(5)
  final TransactionType type;
  
  @HiveField(6)
  final String? category;
  
  @HiveField(7)
  final String? referenceNumber;
  
  @HiveField(8)
  final String? image;
  
  Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
    this.category,
    this.referenceNumber,
    this.image,
  });
  
  Transaction copyWith({
    String? id,
    String? accountId,
    double? amount,
    DateTime? date,
    String? description,
    TransactionType? type,
    String? category,
    String? referenceNumber,
    String? image,
  }) {
    return Transaction(
      id: id ?? IdGenerator.generateCompactId(prefix: 'txn_'),
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      type: type ?? this.type,
      category: category ?? this.category,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      image: image ?? this.image,
    );
  }
}