import 'package:flutter/material.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/crop_image.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class CustomFormCard extends StatelessWidget {
  final String _headerImageLocation;
  final Widget _form;
  final String _title;
  final String _subTitle;

  const CustomFormCard({
    Key key,
    @required headerImageLocation,
    @required form,
    @required title,
    subTitle,
  })  : _headerImageLocation = headerImageLocation,
        _form = form,
        _title = title,
        _subTitle = subTitle,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(UiHelper.standard_padding),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CropImage(assetImage: _headerImageLocation),
              _Titles(
                title: _title,
                subTitle: _subTitle,
                form: _form,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  final String _title;
  final String _subTitle;
  final Widget _form;

  const _Titles({
    Key key,
    @required title,
    @required subTitle,
    @required form,
  })  : _title = title,
        _subTitle = subTitle,
        _form = form,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UiHelper.card_margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _title,
            textAlign: TextAlign.left,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.black, fontWeight: FontWeight.normal),
          ),
          _subTitle != null
              ? Text(
                  _subTitle,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle
                      .copyWith(color: Colors.grey),
                )
              : SizedBox(),
          _form,
        ],
      ),
    );
  }
}
