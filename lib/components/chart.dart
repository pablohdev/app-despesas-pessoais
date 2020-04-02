import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';


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


		  return {
			  'day': DateFormat.E().format(weekDay)[0],
			  'value': totalSum
			};
	  }).reversed.toList();
  }

  double get _weekTotalValue{
	  return groupedTransaction.fold(0.0,(sum,tr){
		  return sum+tr['value'];
	  });
  }

  @override
  Widget build(BuildContext context) {
	return Card(
	  elevation: 6,
	  margin: EdgeInsets.all(20),
	  child: Padding(
	    padding: const EdgeInsets.all(10),
	    child: Row(
		  mainAxisAlignment: MainAxisAlignment.spaceAround,
		  children: groupedTransaction.map((tr){
			  return Flexible(
				  		fit: FlexFit.tight,
						child: ChartBar(
						label: tr['day'],
						value: tr['value'],
						percentege: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue,
						),
					);
		  }).toList(),

	    ),
	  )
	);
  }
}