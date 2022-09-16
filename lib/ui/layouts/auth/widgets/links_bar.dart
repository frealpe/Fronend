import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:flutter/material.dart';

class LinksBar extends StatelessWidget {
  const LinksBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.brown[900],
      height: (size.height>1000) ? size.height*0.07 :null,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text:'About',onPressed: ()=>print('About'),setcolor: Colors.white),
          LinkText(text:'Privacy Policy',setcolor: Colors.white),
          LinkText(text:'Cookie Policy',setcolor: Colors.white),
          LinkText(text:'Blog',setcolor: Colors.white),
          LinkText(text:'Careers',setcolor: Colors.white),
          LinkText(text:'Marketing',setcolor: Colors.white),                                                  
        ],
      ),
    );
  }
}