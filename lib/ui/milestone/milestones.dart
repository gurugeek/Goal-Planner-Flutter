import 'package:flutter/material.dart';

import '../../models/milestone.dart';

class Milestones extends StatelessWidget {
  final List<Milestone> milestones;
  final Function updateMilestone;

  Milestones({this.milestones, this.updateMilestone});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: milestones.map((Milestone milestone) {
      return Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                backgroundColor:
                    !milestone.completed ? Colors.yellow : Colors.blue,
                child: Icon(
                  !milestone.completed ? Icons.remove : Icons.check,
                  color: Colors.white,
                  size: 14,
                ),
                radius: 12),
            title: Text(milestone.description),
            trailing: IconButton(
                icon: Icon(
                  !milestone.completed ? Icons.check : Icons.remove,
                  color: !milestone.completed ? Colors.blue : Colors.yellow,
                  size: 20,
                ),
                onPressed: () => updateMilestone(milestone.id)),
          )
        ],
      );
    }).toList());
  }
}
