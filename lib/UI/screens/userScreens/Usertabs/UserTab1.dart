import 'package:cargoconveyers/UI/Helpers/LoadCard.dart';
import 'package:cargoconveyers/UI/screens/userScreens/BottomSheet/BottomSheet.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyLoads extends StatefulWidget {
  final String userId;

  const MyLoads({Key key, @required this.userId}) : super(key: key);
  @override
  _MyLoadsState createState() => _MyLoadsState();
}

class _MyLoadsState extends State<MyLoads> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Theme.of(context).primaryColor,
          icon: Icon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
          label: Text('Add Loads',
              style: TextStyle(
                fontSize: 16,
              )),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: false,
              context: context,
              builder: (context) {
                return BottomSheetInput();
              },
            );
          },
        ),
        body: RefreshIndicator(
          color: Colors.blue,
          onRefresh: () => Provider.of<MarketViewModel>(context, listen: false)
              .getMyLoads(widget.userId),
          child: Consumer<MarketViewModel>(
            builder: (_, _value, __) {
              if (_value.loadList == null) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (_value.loadList.isEmpty) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Manage Loads',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                            String.fromCharCode(
                              FontAwesomeIcons.boxOpen.codePoint,
                            ),
                            style: TextStyle(
                                fontSize: 120,
                                fontFamily: FontAwesomeIcons.boxOpen.fontFamily,
                                color: Theme.of(context).primaryColor,
                                package: FontAwesomeIcons.boxOpen.fontPackage))
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                itemCount: _value.loadList.length,
                itemBuilder: (context, index) {
                  if (_value.loadList.length > 0) {
                    LoadModel _loadList = _value.loadList[index];
                    return LoadCard(
                      indexFromList: index,
                      isMarketLoad: false,
                      loadModel: _loadList,
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
