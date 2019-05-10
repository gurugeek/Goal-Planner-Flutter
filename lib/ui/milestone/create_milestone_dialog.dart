import 'package:flutter/material.dart';

import '../../models/goal.dart';

class CreateMilestoneDialog extends StatefulWidget {
  final Goal currentGoal;
  final Function createMilestone;

  CreateMilestoneDialog({this.currentGoal, this.createMilestone});

  @override
  _CreateMilestoneDialogState createState() => _CreateMilestoneDialogState();
}

class _CreateMilestoneDialogState extends State<CreateMilestoneDialog> {
  TextEditingController _descCtrl = TextEditingController();
  FocusNode _descFocus = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _descFocus.addListener(() {
      if (_descFocus.hasFocus) {
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
              'Add a New Milestone for \'${widget.currentGoal.title}\'',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue),
            ),
          ),
          ListTile(
            title: TextField(
              controller: _descCtrl,
              focusNode: _descFocus,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  String desc = _descCtrl.text;
                  if (desc.isNotEmpty) {
                    widget.createMilestone(desc, widget.currentGoal.id);
                    _descCtrl.text = '';
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
