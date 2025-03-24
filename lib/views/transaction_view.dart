import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookkeeping_flutter_app/viewmodels/transaction_viewmodel.dart';
import 'package:bookkeeping_flutter_app/models/transaction.dart';
import 'package:bookkeeping_flutter_app/utils/responsive.dart';

class TransactionView extends StatelessWidget {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Responsive.init(context); // Initialize ScreenUtil

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Transaction',
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 20),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Responsive.responsivePadding(context, 20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 16),
                ),
              ),
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 16),
              ),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 16),
                ),
              ),
              style: TextStyle(
                fontSize: Responsive.responsiveFontSize(context, 16),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: Responsive.responsiveHeight(context, 20)),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final amount = double.tryParse(_amountController.text) ?? 0.0;
                if (title.isNotEmpty && amount > 0) {
                  final transaction = Transaction(
                    id: DateTime.now().toString(),
                    title: title,
                    amount: amount,
                    date: DateTime.now(),
                  );
                  Provider.of<TransactionViewModel>(
                    context,
                    listen: false,
                  ).addTransaction(transaction);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontSize: Responsive.responsiveFontSize(context, 16),
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
