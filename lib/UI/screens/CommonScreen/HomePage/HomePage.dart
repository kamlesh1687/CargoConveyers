import 'package:cargoconveyers/UI/Helpers/SelectableList.dart';
import 'package:cargoconveyers/UI/Helpers/Theming.dart';
import 'package:cargoconveyers/UI/screens/CommonScreen/EditProfile.dart';
import 'package:cargoconveyers/UI/screens/CompanyScreens/Companytabs/CompanyTab2.dart';
import 'package:cargoconveyers/UI/screens/CompanyScreens/Companytabs/CompanyTab1.dart';
import 'package:cargoconveyers/UI/screens/userScreens/Usertabs/UserTab2.dart';
import 'package:cargoconveyers/UI/screens/userScreens/Usertabs/UserTab1.dart';
import 'package:cargoconveyers/businessLogics/viewModels/ProfileViewMode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final bool isServiceProvider;
  final String userId;

  const HomePage({Key key, this.isServiceProvider, @required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('here at homePage');
    return DefaultTabController(
      length: 2,
      initialIndex: context.watch<TabsIndexState>().selectedIndex,
      child: Scaffold(
        drawer: Drawer(
          semanticLabel: "Cargo ",
          child: ListView(
            children: [
              ListTile(
                title: CircleAvatar(
                  backgroundColor: Colors.red,
                  minRadius: 35,
                ),
                onTap: () {
                  var _data = context.read<ProfileViewModel>();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditProfile(
                        userProfileData: _data.userData,
                      );
                    },
                  ));
                },
                subtitle: ListTile(
                  title: Text(FirebaseAuth.instance.currentUser.email),
                  subtitle: Text('UserName'),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ColorSelectionBox();
                    },
                  );
                },
                title: Text("Customize"),
                trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("this is something"),
                trailing: Icon(Icons.arrow_forward),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: MaterialButton(
                  onPressed: () {
                    var _profile = context.read<ProfileViewModel>();
                    _profile.signoutFunc().then((value) {
                      _profile.userData = null;
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Theme.of(context).primaryColor,
                  colorBrightness: Brightness.dark,
                  child: Text("Logout"),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Cargo Conveyers"),
        ),
        bottomNavigationBar: TabBar(
          onTap: (index) {
            context.read<TabsIndexState>().selectedIndex = index;
          },
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: false,
          physics: NeverScrollableScrollPhysics(),
          indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Theme.of(context).primaryColor),
          tabs: [
            Tab(
              text: isServiceProvider ? "My Lorries" : "My Loads",
            ),
            Tab(
              text: isServiceProvider ? "Load Market" : "Lorry Market",
            ),
          ],
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            isServiceProvider
                ? MyLorries()
                : MyLoads(
                    userId: userId,
                  ),
            !isServiceProvider ? LoadMarketCompany() : LorryMarketUser()
          ],
        ),
      ),
    );
  }
}

class TabsIndexState extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(value) {
    _selectedIndex = value;
  }
}

class ColorSelectionBox extends StatefulWidget {
  @override
  _ColorSelectionBoxState createState() => _ColorSelectionBoxState();
}

class _ColorSelectionBoxState extends State<ColorSelectionBox> {
  int selectedIndex;
  @override
  void initState() {
    selectedIndex = colorsList.indexOf(
        Provider.of<ThemeProvider>(context, listen: false).currentColor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select Color',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: colorsList[selectedIndex])),
          ],
        ),
        contentPadding: EdgeInsets.all(0),
        subtitle: Container(
          height: 150,
          child: SelectableList(
            builder: (index) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                    color: colorsList[index],
                    boxShadow: selectedIndex == index
                        ? [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black45,
                                spreadRadius: 0.5)
                          ]
                        : [],
                    borderRadius: BorderRadius.circular(20)),
                duration: Duration(milliseconds: 100),
                width: index == selectedIndex ? 80 : 70,
                height: index == selectedIndex ? 80 : 70,
              );
            },
            color: Colors.transparent,
            radius: 20,
            preselected: colorsList.indexOf(Theme.of(context).primaryColor),
            getSelectedItem: (index) {
              context.read<ThemeProvider>().selectedColor = colorsList[index];
              setState(() {
                selectedIndex = index;
              });
            },
            list: colorsList,
          ),
        ),
      ),
    );
  }
}
