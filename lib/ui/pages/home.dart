import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/widgets/asset_container.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            _ImageBanner(),
            _CardDisplay(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.list, color: Colors.white)),
      title: Text("My Thai Star"),
      elevation: 20,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.person, color: Colors.white)),
        IconButton(icon: Icon(Icons.shopping_basket, color: Colors.white)),
        IconButton(icon: Icon(Icons.flag, color: Colors.white)),
      ],
    );
  }
}

class _CardDisplay extends StatelessWidget {
  const _CardDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10, top: 180, bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6.0, // has the effect of softening the shadow
            spreadRadius: 0.1, // has the effect of extending the shadow
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(image: AssetImage('assets/images/thai-restaurant.jpg')),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "OUR RESTAURANT",
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text("this is some text"),
                      RaisedButton(
                        child: Text(
                          "BOOK TABLE",
                          style: Theme.of(context).textTheme.button,
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(image: AssetImage('assets/images/thai-restaurant.jpg')),
                Container(
                  margin: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "OUR RESTAURANT",
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text("this is some text"),
                      RaisedButton(
                        child: Text(
                          "BOOK TABLE",
                          style: Theme.of(context).textTheme.button,
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageBanner extends StatelessWidget {
  const _ImageBanner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: <Widget>[
          AssetContainer(
            assetLocation: "assets/images/Wood2.jpg",
            fit: BoxFit.fill,
          ),
          AssetContainer(
            assetLocation: "assets/images/background-dish.png",
            fit: BoxFit.fitHeight,
          ),
          AssetContainer(
            height: 80,
            assetLocation: "assets/images/star.png",
            fit: BoxFit.fitHeight,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  "MY THAI STAR",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  "More then just delicious food",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
