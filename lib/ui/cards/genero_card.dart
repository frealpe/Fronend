
import 'package:admin_dashboard/providers/providers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

  class Genero_card extends StatelessWidget {

final List genderItems;

const Genero_card({
  super.key, 
  
   required this.genderItems,
  });


@override
Widget build(BuildContext context) {
      final productoFormProvider = Provider.of<ProductoFormProvider>(context);
//      final data = genderItems![1];
  return ConstrainedBox(
    constraints: BoxConstraints( maxWidth: 500 ),
    child: Container(
  
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              DropdownButtonFormField2(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                hint: Text(
                  '${genderItems![0]}',
//                  'Seleccione el Género',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                        .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Seleccione el Género';
                  }
                },
                onChanged: (value) {

                  productoFormProvider.copyProductoWith(genero: value.toString());
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  //selectedValue = value.toString();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
 }