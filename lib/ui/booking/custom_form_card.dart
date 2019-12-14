import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class CustomFormCard extends StatelessWidget {
  final String headerImageLocation;
  final String title;
  final String subTitle;
  final Widget form;
  const CustomFormCard({
    Key key,
    @required this.headerImageLocation,
    @required this.title,
    this.subTitle,
    @required this.form,
  }) : super(key: key);

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(UiHelper.standart_padding),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CropImage(
                assetImage: headerImageLocation,
              ),
              Padding(
                  padding: EdgeInsets.all(UiHelper.card_margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      (subTitle != null)
                          ? Text(
                              subTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle
                                  .copyWith(color: Colors.grey),
                            )
                          : null,
                      form,
                    ].where(notNull).toList(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
