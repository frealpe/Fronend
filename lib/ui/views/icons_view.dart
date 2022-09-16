import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

class IconsView extends StatelessWidget {
  const IconsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Icons',style: CustomLabels.h1),
          SizedBox(height: 10),

          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: [
              WhiteCard(
                title: 'Ac',
                child: Center(child: Icon(Icons.access_time_outlined)),
                width:170,
                ),
              WhiteCard(
                title: 'Ac',
                child: Center(child: Icon(Icons.access_alarm_rounded)),
                width:170,
                ),
              WhiteCard(
                title: 'Ac',
                child: Center(child: Icon(Icons.access_time)),
                width:170,
                ),
              WhiteCard(
                title: 'Ac',
                child: Center(child: Icon(Icons.access_time_filled_rounded)),
                width:170,
                ),

            ],
          )
          
        ],
      ),
    );
  }
}