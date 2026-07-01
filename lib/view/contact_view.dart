import 'dart:developer';

import 'package:contact_app/database/database.dart';
import 'package:contact_app/model/contact_model.dart';
import 'package:flutter/material.dart';

class ContactViewPage extends StatefulWidget {
  const ContactViewPage({super.key});

  @override
  State<ContactViewPage> createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  List<ContactModel>contacts=[];
  final formKey=GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  Future<void>getContact()async{
    contacts= await ContactDatabase.getContact();
    setState(() {

    });
  }
  Future<void> addContact()async{
    await ContactDatabase.insertData(ContactModel(name: nameC.text, phone: phoneC.text));
    await getContact();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff5C798A),
        title: Text("Contact List", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "enter name";
                  }
                },
                controller: nameC,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "name"
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "enter phone";
                  }
                },
                controller: phoneC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "phone",
                ),
              ),
              SizedBox(height: 10,),
              InkWell(
                onTap: ()async{
                  if(formKey.currentState!.validate()){
                    await addContact();
                    nameC.clear();
                    phoneC.clear();
                    log("radhesh");
                  }
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff5C798A),
                    borderRadius: BorderRadius.circular(5),

                  ),
                  child: Center(
                    child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffF2F3F4),
                    elevation: 0.5,
                    child: ListTile(
                      title: Text("${contacts[index].name}", style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.w400),),
                      leading: CircleAvatar(
                        backgroundColor: Color(0xffF2F3F4),
                        child: Icon(Icons.person, size: 35,),
                      ),
                      subtitle: Text("${contacts[index].phone}", style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.w400),),
                      trailing: Icon(Icons.phone, color: Colors.blue,),
                    ),
                  );
                },),
              )


            ],
          ),
        ),
      ),
    );
  }
}
