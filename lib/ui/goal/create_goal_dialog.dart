import 'package:flutter/material.dart';

class CreateGoalDialog extends StatefulWidget {
  final Function createGoal;

  CreateGoalDialog({this.createGoal});

  @override
  _CreateGoalDialogState createState() => _CreateGoalDialogState();
}

class _CreateGoalDialogState extends State<CreateGoalDialog> {
  TextEditingController _titleCtrl = TextEditingController();
  FocusNode _titleFocus = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _titleFocus.addListener(() {
      if (_titleFocus.hasFocus) {
        setState(() {
          _hasFocus = true;
        });
      } else {
        setState(() {
          _hasFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: _hasFocus ? MainAxisSize.max : MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'Create a New Goal',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _titleCtrl,
              focusNode: _titleFocus,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  String title = _titleCtrl.text;
                  if (title.isNotEmpty) {
                    widget.createGoal(title);
                    _titleCtrl.text = '';
                    Navigator.of(context).pop();
                  }
                },
                child: Icon(
                  Icons.check,
                ),
                backgroundColor: Colors.green,
                elevation: 1,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                ),
                backgroundColor: Colors.red,
                elevation: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
