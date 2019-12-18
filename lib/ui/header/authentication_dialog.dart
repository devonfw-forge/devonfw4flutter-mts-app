import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';

class AuthenticationDialog extends StatelessWidget {
  static const double _width = 800;
  static const double _height = 200;

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = <Tab>[
      Tab(text: LocalizationBloc.of(context).get("buttons/login")),
      Tab(text: LocalizationBloc.of(context).get("buttons/register")),
    ];

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
              height: _height,
              width: _width,
              child: TabBarView(
                children: <Widget>[
                  _AuthenticationTab(),
                  _AuthenticationTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AuthenticationTab extends StatelessWidget {
  static const double _padding = 20;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                labelText:
                    LocalizationBloc.of(context).get("formFields/username") +
                        ' *'),
          ),
          TextField(
            decoration: InputDecoration(
                labelText:
                    LocalizationBloc.of(context).get("formFields/password") +
                        ' *'),
          ),
        ],
      ),
    );
  }
}
