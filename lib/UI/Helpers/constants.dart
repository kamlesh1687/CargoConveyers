import 'package:flutter/cupertino.dart';

ConstantValues consValues = ConstantValues();

class ConstantValues {
  List<String> truckList = [
    'Truck',
    'LCV',
    'Container',
    'Hyva',
    'Trailor',
    'Tanker'
  ];
  List<String> priceTypeList = ['Fixed price', 'Per tonne'];
}

VariableProperties varProp = VariableProperties();

class VariableProperties {
  var borderRadius = BorderRadius.circular(5);
}
