import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/localization.dart';
import 'package:my_thai_star_flutter/annotation.dart';

///Defines [AlertDialog] with 2 [Tab]s: One for login, one for register
///
///Authentication was out of the scope of this implementation.
///So at the moment the [AuthenticationDialog] is just visual.
@notFullyImplemented
class AuthenticationDialog extends StatelessWidget {
  static const double _width = 800;
  static const double _height = 200;

  @override
  Widget build(BuildContext context) {
    //Tabs aren't members, banause they need context fo the localized text
    List<Tab> tabs = _buildTabs(context);

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

List<Tab> _buildTabs(BuildContext context) => <Tab>[
      Tab(text: Translation.of(context).get('buttons/login')),
      Tab(text: Translation.of(context).get('buttons/register')),
    ];

///Defines a single [Tab] of the [AuthenticationDialog]
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
                    Translation.of(context).get('formFields/username') + ' *'),
          ),
          TextField(
            decoration: InputDecoration(
                labelText:
                    Translation.of(context).get('formFields/password') + ' *'),
          ),
        ],
      ),
    );
  }
}
