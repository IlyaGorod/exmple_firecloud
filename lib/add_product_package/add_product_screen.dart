import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth_package/auth_screen.dart';



class AddingProductsPage extends StatefulWidget {

  @override
  _AddingProductsPageState createState() => _AddingProductsPageState();
}

class _AddingProductsPageState extends State<AddingProductsPage> {

  TextEditingController _idController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    CollectionReference products = FirebaseFirestore.instance.collection('products');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthScreen()));
          },
        ),
        title: Text('Adding Products'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: products.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
                child: ListView(
              children: snapshot.data!.docs.map((product){
                return Card(
                  child: InkWell(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) => Stack(
                              children: <Widget>[
                          Dialog(
                            backgroundColor: Colors.white,
                             child: Container(
                               height: 400.0,
                               width: 350.0,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child:
                            Text(product['comment'],
                              style: TextStyle(fontSize: 20.0),
                            ),
                        ),
                            ),
                          ),
                          ],
                        ),
                        );
                      },
                    child: ListTile(
                    title: Text(product['name']),
                     trailing: IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: (){
                        product.reference.delete();
                         },
                     ),
                    ),
                  ),
                );
              }).toList(),
                ),
            );
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(
              context: context,
              builder: (_)=>  Stack(
                 children: <Widget>[
                   Dialog(
                      backgroundColor: Colors.white,
                      child: Container(
                          height: 400.0,
                          width: 350.0,
                        child: Column(
                          children: <Widget> [
                            Padding(
                          padding:  EdgeInsets.all(30),
                            child: TextFormField(
                              controller: _idController,
                             keyboardType: TextInputType.text,
                             decoration: InputDecoration(
                              labelText: "Name product",
                              focusColor: Colors.white,
                             ),
                           ),
                         ),
                         Padding(
                          padding:  EdgeInsets.all(30),
                          child: TextFormField(
                            controller: _commentController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Comments",
                              border: OutlineInputBorder(),
                                ),
                            maxLines: 5,
                              ),
                            ),
                            ElevatedButton(
                              child: Text('Save'),
                              onPressed: (){
                                products.add({
                                  'name': _idController.text,
                                  'comment': _commentController.text,
                                });
                                Navigator.of(context).pop();
                                _idController.clear();
                                _commentController.clear();
                              },
                            )
                   ],
               ),
              ),
                 ),
                ]
              ),
            );
          }
         ),
       );
    }

}

