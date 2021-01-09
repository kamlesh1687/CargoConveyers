import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MyLorries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(FontAwesomeIcons.plus),
        label: Text('Add Lorry'),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 400,
                  color: Colors.red,
                ),
              );
            },
          );
        },
      ),
      body: RefreshIndicator(
        color: Colors.blue,
        onRefresh: () {
          return null;
        },
        child: Consumer<MarketViewModel>(
          builder: (_, _value, __) {
            // if (_value.loadList == null) {
            //   return Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            // if (_value.loadList.isEmpty) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Manage Lorries',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                        String.fromCharCode(
                          FontAwesomeIcons.truck.codePoint,
                        ),
                        style: TextStyle(
                            fontSize: 120,
                            fontFamily: FontAwesomeIcons.truck.fontFamily,
                            color: Theme.of(context).primaryColor,
                            package: FontAwesomeIcons.truck.fontPackage)),
                  ],
                ),
              ),
            );
            // }
            // return ListView.builder(
            //   padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            //   itemCount: 0,
            //   itemBuilder: (context, index) {
            //     if (_value.loadList.length > 0) {
            //       LoadModel _loadList = _value.loadList[index];
            //       return LoadCard(
            //         indexFromList: index,
            //         isMarketLoad: false,
            //         loadModel: _loadList,
            //       );
            //     }
            //     return Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }
}
