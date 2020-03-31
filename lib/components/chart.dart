import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';


class Chart extends StatelessWidget {

  final List<Transaction> recentsTransaction;

  Chart(this.recentsTransaction);
  
  List<Map<String,Object>> get groupedTransaction{
	  return List.generate(7,(index){
		  final weekDay = DateTime.now().subtract(
			  Duration(days:index),
		  );

		  double totalSum = 0.0;

		  for(var i = 0; i < recentsTransaction.length; i++){
			  bool sameDay   = recentsTransaction[i].date.day == weekDay.day;
			  bool sameMonth = recentsTransaction[i].date.month == weekDay.month;
			  bool sameYear  = recentsTransaction[i].date.year == weekDay.year;

			 if(sameDay && sameMonth && sameYear){
				 totalSum += recentsTransaction[i].value;
				 
			 }

		  }

			print(DateFormat.E().format(weekDay)[0]);
			print(totalSum);

		  return {
			  'day': DateFormat.E().format(weekDay)[0],
			  'value': 9.99
			};
	  });
  }

  @override
  Widget build(BuildContext context) {
	return Card(
	  elevation: 6,
	  margin: EdgeInsets.all(20),
	  child: Row(
		  children: <Widget>[],

	  )
	);
  }
}