import 'package:cargoconveyers/UI/Helpers/CustomMaterialButton.dart';
import 'package:cargoconveyers/UI/screens/CompanyScreens/LoadDetailPage.dart';
import 'package:cargoconveyers/businessLogics/models/LoadModel.dart';
import 'package:cargoconveyers/businessLogics/viewModels/MarketViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoadCard extends StatelessWidget {
  final LoadModel loadModel;
  final bool isMarketLoad;
  final int indexFromList;

  const LoadCard(
      {Key key,
      this.loadModel,
      this.isMarketLoad,
      @required this.indexFromList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime time = loadModel.posTime.toDate();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: ListTile(
          contentPadding: EdgeInsets.all(10),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Opacity(
                    opacity: 0.6,
                    child: Icon(
                      FontAwesomeIcons.route,
                      color: Colors.deepOrange,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    loadModel.from ?? '',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    loadModel.to ?? '',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              !isMarketLoad
                  ? MoreBtn(
                      indexFromList: indexFromList,
                      loadId: loadModel.requestId,
                    )
                  : Container()
            ],
          ),
          subtitle: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [Text(DateFormat().format(time))],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Dash(
                  dashColor: Colors.blueGrey,
                  length: MediaQuery.of(context).size.width - 50,
                ),
              ),
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.boxOpen,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            loadModel.goodDetail ?? '',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.truckMoving,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                loadModel.capacity ?? '',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              ),
                              Text(
                                'tonnes, ',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              ),
                              Text(
                                loadModel.payMode ?? '',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black87),
                              )
                            ],
                          )
                        ]),
                        SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Opacity(
                            opacity: 0.5,
                            child: Icon(
                              FontAwesomeIcons.creditCard,
                              color: Colors.blue,
                              size: 15,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black87),
                          )
                        ])
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          loadModel.rate.isEmpty
                              ? Container()
                              : Chip(
                                  labelPadding: EdgeInsets.all(1),
                                  autofocus: true,
                                  backgroundColor: Colors.blue.shade100,
                                  shadowColor: Colors.orange,
                                  label: Text(
                                    "Expected Rate",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                          Text(
                            loadModel.rate ?? '',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(loadModel.priceFlexible ?? ''),
                          isMarketLoad
                              ? BookNowBtn(
                                  loadModel: loadModel,
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dash(
                    dashColor: Colors.blueGrey,
                    length: MediaQuery.of(context).size.width - 50,
                  )),
              isMarketLoad
                  ? Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('OwnerName')
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomMaterialBtn(
                            btnText: 'Show Lorries',
                            onPressed: () {},
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class BookNowBtn extends StatelessWidget {
  final LoadModel loadModel;

  const BookNowBtn({Key key, this.loadModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      colorBrightness: Brightness.dark,
      padding: EdgeInsets.all(5),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LoadDetailPage(
              loadModel: loadModel,
            );
          },
        ));
      },
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FontAwesomeIcons.phone,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text('Book Now'),
        ],
      ),
    );
  }
}

class ShowLorriesBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MoreBtn extends StatelessWidget {
  final int indexFromList;
  final String loadId;

  const MoreBtn({
    Key key,
    this.indexFromList,
    this.loadId,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          context: context,
          builder: (context) {
            return ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: [
                TextButton(
                  child: Text('Update'),
                  onPressed: () {},
                ),
                FlatButton(
                  textColor: Colors.red.shade400,
                  child: Text('Delete'),
                  onPressed: () {
                    context
                        .read<MarketViewModel>()
                        .deleteLoad(indexFromList, loadId);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  textColor: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.whatsapp),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Share on whatsapp'),
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
