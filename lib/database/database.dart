import 'package:contact_app/model/contact_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
class ContactDatabase{

  static Database? database;

  static Future<Database>getDB()async{
    if(database!=null)return database!;
    
    database= await openDatabase(p.join(await getDatabasesPath(), "contact.db"),
    onCreate: (database, version){

      return database.execute("create table contact(id integer primary key autoincrement, name Text, phone Text )",);
    }, version: 2

    );
return database!;
  }

  static Future<void> insertData(ContactModel contactModel)async{
    final db= await getDB();
    db.insert("contact", contactModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<List<ContactModel>>getContact()async{
    final db= await getDB();
    final List<Map<String, dynamic>> maps=await db.query("contact");
    return List.generate(maps.length, (index) => ContactModel.fromMap(maps[index]),);
  }


}