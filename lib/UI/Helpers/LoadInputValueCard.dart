import 'package:cargoconveyers/businessLogics/models/LoadInputModel.dart';
import 'package:flutter/material.dart';

class LoadInputDataCard extends StatelessWidget {
  final LoadInputData loadInputData;
  final txtStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  final txtStyle2 = TextStyle(fontSize: 16);
  final txtStyle3 = TextStyle(
    fontSize: 13,
    color: Colors.grey,
  );

  LoadInputDataCard({Key key, this.loadInputData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), topLeft: Radius.circular(5))),
            height: 40,
            child: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  '1. LOAD DETAILS',
                  textAlign: TextAlign.left,
                  style: txtStyle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      loadInputData.from ?? '',
                      style: txtStyle2,
                    ),
                    Text(
                      ' - ',
                      style: txtStyle2,
                    ),
                    Text(
                      loadInputData.to ?? '',
                      style: txtStyle2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Material: " + loadInputData.details ?? '',
                      style: txtStyle3,
                    ),
                    Text(
                      ", Quantity: " + loadInputData.capacity ?? '',
                      style: txtStyle3,
                    ),
                    Text(
                      ' tonne(s)',
                      style: txtStyle3,
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Lorry type: " + loadInputData.lorryType ?? '',
                      style: txtStyle3,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
