import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'components/chart.dart';
import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';


main() => {runApp(ExpensesApp())};

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
	  theme: ThemeData(
		  primarySwatch: Colors.purple,
		  accentColor: Colors.amber,
		  fontFamily: 'Quicksand',
		  appBarTheme: AppBarTheme(
			  textTheme: ThemeData.light().textTheme.copyWith(
				  title: TextStyle(
					fontFamily: 'OpenSans',
					fontSize: 20,
					fontWeight: FontWeight.w700
				  )
			  )
		  )
	  ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _transactions = [
    Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now().subtract(Duration(days: 3))
	),
    Transaction(
        id: 't2', 
		title: 'Conta de Luz', 
		value: 211.30, 
		date: DateTime.now().subtract(Duration(days: 4))
	),
	Transaction(
        id: 't3', 
		title: 'Conta de Luz', 
		value: 211.30, 
		date: DateTime.now().subtract(Duration(days: 33))
	),
  ];

  List<Transaction> get _recentTransactions{
	  return _transactions.where((tr) {
		  return tr.date.isAfter(DateTime.now().subtract(
			  Duration(days:7),
		  ));
	  }).toList();
  }

   _addTransaction(String title, double value){
	  
	  final newTransaction = Transaction(
		  id:Random().nextDouble().toString(),
		  title: title,
		  value: value,
		  date: DateTime.now()
	  );

	  setState((){
		_transactions.add(newTransaction);
	  });

	  Navigator.of(context).pop();

  }

  _openTransactionFormModal(BuildContext context){
	  showModalBottomSheet(
		  context: context, 
		  builder: (_) {
			return TransactionForm(_addTransaction);
		  }
	);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
			title: Text(
				'Despesas Pessoais'
				),
			actions: <Widget>[
				IconButton(
					icon: Icon(Icons.add),
					onPressed: () => _openTransactionFormModal(context),
				)
			],
		),
        body: SingleChildScrollView(
				  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Chart(_recentTransactions),
				  TransactionList(_transactions),
                ]),
        ),
		floatingActionButton: FloatingActionButton(
			child: Icon(Icons.add),
			onPressed: () => _openTransactionFormModal(context),
		),
		floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
	);
		
  }
}
