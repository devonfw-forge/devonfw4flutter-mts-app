import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/widgets/asset_container.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SizedBox(
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
              child: Text(
                "MY THAI STAR",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline,
              ),
            )
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
