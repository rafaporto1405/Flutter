import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String contactTable ="contactTable";
final String idColumn ="idColumn";
final String nameColumn = "nameColumn";
final String emailColumn ="emailColumn";
final String phoneColumn ="phoneColumn";
final String imgColumn ="imgColumn";

//declarando a classe
class ContactHelper{
  //objeto dentro da própria class que não muda e só e da classe =
  //chama um construtor interno.
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;
  //so pode se chamado daqui.
  ContactHelper.internal();

  //declarando o banco de dados sem acesso de fora da class.
  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    }else{
      _db =await initDb();
      return _db;
    }
  }

  //inicializando o DB
  Future<Database> initDb() async{
    //local onde vai armazenar o banco de dados.
    final databasesPath = await getDatabasesPath();

    //arquivo onde ta o DB.
    final path = join(databasesPath, "contactsnew.db");

    //Abrir o db e criar o db
    return await openDatabase(path, version: 1, onCreate:(Database db, int newerVersion)async{
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)"
      );
    } );
  }
  
  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;
    //inserindo contato.
    //retorna o id e salva no id dele. 
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    //where passa a regra.
    //regra procura o contato com o id passado.
    List<Map> maps= await dbContact.query(contactTable,
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );
    if(maps.length > 0){
      //retornando contato em forma de map.
      //maps.first -> pega o primeiro mapa.
      return Contact.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deleteContact(int id)async{
    Database dbContact = await db;
    //.delete -> retorna um número inteiro
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async{
    Database dbContact = await db;
    //.update -> retorna um número inteiro
    return await dbContact.update(contactTable, contact.toMap(), where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts()async{
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for(Map m in listMap){
      //transformando em contact e jogando na lista do tipo Contact.
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber()async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close()async {
    Database dbContact = await db;
    dbContact.close();
  }

}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact();

  //armazena no formato de mapa
  Contact.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString(){
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }

}

