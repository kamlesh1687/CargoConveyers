import 'package:cargoconveyers/UI/Helpers/LoadCard.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadMarketCompany extends StatefulWidget {
  @override
  _LoadMarketCompanyState createState() => _LoadMarketCompanyState();
}

class _LoadMarketCompanyState extends State<LoadMarketCompany>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('building again');
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [],
          ),
          Expanded(
            child: RefreshIndicator(
              color: Colors.blue,
              onRefresh: () =>
                  Provider.of<MarketViewModel>(context, listen: false)
                      .getLoadsFromMarket(),
              child: Consumer<MarketViewModel>(
                builder: (_, _value, __) {
                  if (_value.loadFromMarketList == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: _value.loadFromMarketList.length,
                    itemBuilder: (context, index) {
                      if (_value.loadFromMarketList.length > 0) {
                        LoadModel _loadList = _value.loadFromMarketList[index];
                        return LoadCard(
                          indexFromList: index,
                          isMarketLoad: true,
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
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
