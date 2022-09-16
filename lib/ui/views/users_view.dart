import 'package:admin_dashboard/datatables/users_datasource.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/providers/providers.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);

    final usersDataSource= new UsersDataSource(usersProvider.users);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text('Users View',style: CustomLabels.h1),
          SizedBox(height: 10),

          PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnIndex,
            columns: [
              DataColumn(label: Text('Imagen')),
              DataColumn(label: Text('Referencia'),onSort:(colIndex,_){
                usersProvider.sortColumnIndex=colIndex;
                usersProvider.sort<String>((user) => user.nombre);
              }),
              DataColumn(label: Text('Precio'),onSort:(colIndex,_){
                usersProvider.sortColumnIndex=colIndex;                
                usersProvider.sort<String>((user) => user.correo);
              }),
              DataColumn(label: Text('Cantidad'),onSort:(colIndex,_){
                usersProvider.sort<String>((user) => user.uid);
              }),
              DataColumn(label: Text('Acciones')),                                                        
            ],
            source: usersDataSource,
            onPageChanged: (page){

            },
            )
        ],
      ),
    );
  }
}