import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookkeeping_flutter_app/viewmodels/transaction_viewmodel.dart';
import 'package:bookkeeping_flutter_app/views/transaction_view.dart';
import 'package:bookkeeping_flutter_app/utils/responsive.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive.init(context); // Initialize ScreenUtil

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(
          Responsive.responsivePadding(context, 10),
        ),

        title: Text(
          'Bookkeeping App',
          style: TextStyle(
            fontSize: Responsive.responsiveFontSize(context, 20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionView()),
              );
            },
          ),
        ],
      ),
      body: Consumer<TransactionViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            itemCount: viewModel.transactions.length,
            itemBuilder: (context, index) {
              final transaction = viewModel.transactions[index];
              return ListTile(
                title: Text(
                  transaction.title,
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 16),
                  ),
                ),
                subtitle: Text(
                  transaction.date.toString(),
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 14),
                  ),
                ),
                trailing: Text(
                  '\$${transaction.amount.toString()}',
                  style: TextStyle(
                    fontSize: Responsive.responsiveFontSize(context, 16),
                  ),
                ),
                onTap: () {
                  viewModel.removeTransaction(transaction.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
