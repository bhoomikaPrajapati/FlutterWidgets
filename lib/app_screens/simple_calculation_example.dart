import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SimpleCalculation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Calculation();
  }
}

class Calculation extends State<SimpleCalculation> {
  var _currencies = ['Rupees', 'Dollar', 'Pounds', 'Other'];
  var _selectedCurrencies;
  var _displayText = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var _formKay = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this._selectedCurrencies = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.subtitle1;

    return Scaffold(
      appBar: AppBar(title: Text("Simple Calculation")),
      body: Form(
          key: _formKay,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                getImageLogo(),
                TextFormField(
                  validator: (var value) {
                    if (value.toString().isEmpty) return "Please enter principal amount.";
                  },
                  style: textStyle,
                  controller: principalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "Enter principal eg. 2000",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
                  style: textStyle,
                  validator: (var value) {
                    if (value.toString().isEmpty) return "Please enter interest rate.";
                  },
                  keyboardType: TextInputType.number,
                  controller: rateController,
                  decoration: InputDecoration(
                      labelStyle: textStyle,
                      labelText: "Rate of Interest",
                      hintText: "In percent eg. 20%",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      style: textStyle,
                      validator: (var value) {
                        if (value.toString().isEmpty) return "Please enter term";
                      },
                      controller: termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: textStyle,
                          labelText: "Term",
                          hintText: "In Year eg. 2 year",
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
                    )),
                    Padding(padding: EdgeInsets.all(5)),
                    Expanded(
                        child: DropdownButton(
                      items: _currencies
                          .map((selectedValue) => DropdownMenuItem(
                                child: Text(selectedValue),
                                value: selectedValue,
                              ))
                          .toList(),
                      onChanged: (var newSelectedValue) {
                        setState(() {
                          this._selectedCurrencies = newSelectedValue.toString();
                        });
                      },
                      value: _selectedCurrencies,
                    ))
                  ],
                ),
                Padding(padding: EdgeInsets.all(10)),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (this._formKay.currentState?.validate() == true) this._displayText = _calculateSimpleInterest();
                          });
                        },
                        child: Text("Calculate")),
                    Padding(padding: EdgeInsets.all(5)),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            principalController.text = "";
                            rateController.text = "";
                            termController.text = "";
                            _selectedCurrencies = _currencies[0];
                          });
                        },
                        child: Text("Reset")),
                  ],
                ),
                Text(
                  _displayText,
                  style: textStyle,
                )
              ],
            ),
          )),
    );
  }

  String _calculateSimpleInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double year = double.parse(termController.text);
    double totalAmount = principal + (principal * rate * year) / 100;
    return "After $year Years, your investment will be worth $totalAmount $_selectedCurrencies";
  }

  Widget getImageLogo() {
    AssetImage assetImage = AssetImage("images/simple_interest.png");
    Image image = new Image(
      image: assetImage,
      height: 125,
      width: 125,
    );
    return image;
  }
}
