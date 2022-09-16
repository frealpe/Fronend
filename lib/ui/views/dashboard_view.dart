import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AuthProvider>(context).user!;

    //TODO INICIAR CATEGORIAS 

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Tienda en Articulos de Cuero',style: CustomLabels.h1),
          SizedBox(height: 10),
          WhiteCard(
            title:user.nombre,
            child:Text(user.correo)
          )
        ],
      ),
    );
  }
}