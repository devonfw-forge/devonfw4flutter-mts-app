import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class ResponseDialoge extends StatelessWidget {
  final String headline;
  final String body;
  final String copyableText;

  const ResponseDialoge({
    Key key,
    @required this.headline,
    @required this.body,
    this.copyableText,
  }) : super(key: key);

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        headline,
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        margin: EdgeInsets.all(UiHelper.card_margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(body),
            SizedBox(height: UiHelper.standard_padding),
            copyableText != null
                ? Wrap(
                    alignment: WrapAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(UiHelper.standard_padding / 2),
                        child: SelectableText(copyableText),
                        decoration: new BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius:
                                BorderRadius.all(const Radius.circular(2))),
                      ),
                      IconButton(
                        icon: Icon(Icons.content_copy),
                        onPressed: () => Clipboard.setData(
                          ClipboardData(text: copyableText),
                        ),
                      )
                    ],
                  )
                : null,
          ].where(notNull).toList(),
        ),
      ),
    );
  }
}
