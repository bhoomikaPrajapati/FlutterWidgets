import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StateFullWidgetExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FavoriteCityState();
  }
}

class FavoriteCityState extends State<StateFullWidgetExample> {
  String nameCity = "";
  var _currencies = ['Rupees', 'Dollar', 'Pounds', 'Other'];
  var _selectedCurrencies = "Rupees";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statefull widget example"),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              onChanged: (String userInput) {
                setState(() {
                  nameCity = userInput;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Your entered city is $nameCity. ",
                style: TextStyle(fontSize: 20),
              ),
            ),
            DropdownButton<String>(
              items: _currencies.map((String selectedDropdownValue) {
                return DropdownMenuItem<String>(
                  value: selectedDropdownValue,
                  child: new Text(selectedDropdownValue),
                );
              }).toList(),
              onChanged: (var newSelectedValue) {
                setSelectedValue(context, newSelectedValue.toString());
              },
              value: _selectedCurrencies,
            )
          ],
        ),
      ),
    );
  }

  void setSelectedValue(BuildContext context, String selectedValue) {
    setState(() {
      _selectedCurrencies = selectedValue;
    });
  }
}
