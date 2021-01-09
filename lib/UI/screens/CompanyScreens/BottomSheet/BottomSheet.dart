import 'package:cargoconveyers/UI/Helpers/CustomMaterialButton.dart';
import 'package:cargoconveyers/UI/Helpers/CustomTextFormFields.dart';
import 'package:cargoconveyers/UI/Helpers/LoadInputValueCard.dart';
import 'package:cargoconveyers/UI/Helpers/SelectableList.dart';
import 'package:cargoconveyers/UI/Helpers/constants.dart';
import 'package:cargoconveyers/businessLogics/models/LoadInputModel.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class BottomSheetPageBuilder extends ChangeNotifier {
  int _index = 0;
  int get index => _index;
  set index(_value) {
    _index = _value;
    notifyListeners();
  }
}

class BottomSheetInput extends StatefulWidget {
  @override
  _BottomSheetInputState createState() => _BottomSheetInputState();
}

class _BottomSheetInputState extends State<BottomSheetInput> {
  final GlobalKey<FormState> _lorryMarketFormKey = new GlobalKey<FormState>();
  TextEditingController _controllerFrom;
  TextEditingController _controllerTo;
  TextEditingController _controllerGoodsDetail;
  TextEditingController _controllerCapacity;
  TextEditingController _controllerRate;
  int index = 0;
  int selectedIndexTruck;
  int selectedIndexPrice;
  @override
  void initState() {
    _controllerFrom = TextEditingController();
    _controllerCapacity = TextEditingController();
    _controllerRate = TextEditingController();
    _controllerTo = TextEditingController();
    _controllerGoodsDetail = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controllerCapacity.dispose();
    _controllerFrom.dispose();
    _controllerTo.dispose();
    _controllerRate.dispose();
    _controllerGoodsDetail.dispose();
    super.dispose();
  }

  Widget firstScreen() {
    return Form(
      key: this._lorryMarketFormKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        children: [
          TextFormFieldProfileEdit(
              controller: _controllerFrom,
              hintText: 'From location',
              labelText: 'Starting Point '),
          TextFormFieldProfileEdit(
              controller: _controllerTo,
              hintText: 'To Location',
              labelText: 'Destination'),
          TextFormFieldProfileEdit(
              controller: _controllerGoodsDetail,
              hintText: 'Type of Goods',
              labelText: 'Goods details'),
          TextFormField(
              controller: _controllerCapacity,
              validator: (value) {
                if (value.isNotEmpty) {
                  if (value.length > 2) {
                    return 'Only less than 100 tonnes is accepted ';
                  }
                  return null;
                }
                return 'Please enter some text';
              },
              decoration: InputDecoration(
                  hintText: 'In Tonne(s)', labelText: 'Quantity')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Select Lorry',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 80,
                child: SelectableList(
                  itemColor: Colors.grey.shade100,
                  preselected: selectedIndexTruck,
                  radius: 15,
                  getSelectedItem: (index) {
                    setState(() {
                      selectedIndexTruck = index;
                    });
                  },
                  list: consValues.truckList,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Text("Cancle"),
                colorBrightness: Brightness.dark,
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
              CustomMaterialBtn(
                btnText: 'Cancle',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CustomMaterialBtn(
                onPressed: () {
                  var _data = context.read<MarketViewModel>();

                  if (_lorryMarketFormKey.currentState.validate() &&
                      selectedIndexTruck != null) {
                    _data.loadInputData = LoadInputData(
                      capacity: _controllerCapacity.text,
                      details: _controllerGoodsDetail.text,
                      from: _controllerFrom.text,
                      lorryType: consValues.truckList[selectedIndexTruck],
                      to: _controllerTo.text,
                    );

                    setState(() {
                      index = 1;
                    });
                  }
                },
                btnText: "Next",
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: index == 0 ? firstScreen() : secondScreen(),
    );
  }

  Widget secondScreen() {
    var txtStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 18);

    print('bulding again');

    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      children: [
        Consumer<MarketViewModel>(builder: (_, _value, __) {
          return LoadInputDataCard(
            loadInputData: _value.loadInputData,
          );
        }),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '2. PAYMENT DETAILS',
                    style: txtStyle,
                  )
                ],
              ),
              TextFormField(
                  controller: _controllerRate,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Expected Price (Optional)',
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: SelectableList(
                  preselected: selectedIndexPrice,
                  radius: 25,
                  itemColor: Colors.blueGrey.shade100,
                  list: consValues.priceTypeList,
                  getSelectedItem: (index) {
                    setState(() {
                      selectedIndexPrice = index;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomMaterialBtn(
              btnText: "Back",
              onPressed: () {
                setState(() {
                  index = 0;
                });
              },
            ),
            CustomMaterialBtn(
              btnText: 'Post',
              onPressed: () {
                var _data = context.read<MarketViewModel>();
                String priceType;
                if (_controllerRate.text.isNotEmpty) {
                  priceType = consValues.priceTypeList[selectedIndexPrice];
                }
                User _user = FirebaseAuth.instance.currentUser;

                LoadModel _loads = LoadModel(
                    capacity: _data.loadInputData.capacity,
                    from: _data.loadInputData.from,
                    to: _data.loadInputData.to,
                    goodDetail: _data.loadInputData.details,
                    ownerId: _user.uid,
                    posTime: Timestamp.now(),
                    rate: _controllerRate.text,
                    priceFlexible: priceType,
                    requestId: Uuid().v4(),
                    payMode: consValues.truckList[selectedIndexTruck]);

                _data.postLoadInMarket(_loads).then((value) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
