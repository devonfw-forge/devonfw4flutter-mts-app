import 'package:flutter/material.dart';

class AuthenticationAlert extends StatelessWidget {
  static const double width = 800;
  static const double height = 200;
  static const double padding = 20;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'LOGIN'),
    Tab(text: 'SIGN UP'),
  ];

  const AuthenticationAlert({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabBar(
              indicatorColor: Theme.of(context).accentColor,
              labelColor: Colors.black,
              labelStyle: Theme.of(context).textTheme.title,
              tabs: tabs,
            ),
            Container(
              height: height,
              width: width,
              child: TabBarView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(labelText: 'Username *'),
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Password *'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Username *'),
                          ),
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'Password *'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
