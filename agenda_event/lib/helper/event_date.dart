import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

final String eventDateTable ="eventDateTable";
final String idColumn ="idColumn";
final String nameColumn = "nameColumn";
final String dateStartColumn ="dateStartColumn";
final String dateEndColumn ="dateEndColumn";
final String locColumn ="locColumn";
final String descColumn ="descColumn";


class eventDateHelper{
  //objeto dentro da própria class que não muda e só e da classe =
  //chama um construtor interno.
  static final eventDateHelper _instance = eventDateHelper.internal();

  factory eventDateHelper() => _instance;
  //so pode se chamado daqui.
  eventDateHelper.internal();

  //declarando o banco de dados sem acesso de fora da class.
  Database _dbEventDate;

  Future<Database> get db async {
    if(_dbEventDate != null){
      return _dbEventDate;
    }else{
      _dbEventDate =await initDb();
      return _dbEventDate;
    }
  }

  //inicializando o DB
  Future<Database> initDb() async{
    //local onde vai armazenar o banco de dados.
    final databasesPath = await getDatabasesPath();

    //arquivo onde ta o DB.
    final path = join(databasesPath, "eventDateTest.db");

    //Abrir o db e criar o db
    return await openDatabase(path, version: 1, onCreate:(Database db, int newerVersion)async{
      await db.execute(
          "CREATE TABLE $eventDateTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $dateStartColumn TEXT, $dateEndColumn TEXT, $locColumn TEXT, $descColumn TEXT)"
      );
    } );
  }

  Future<EventDate> saveEventDate(EventDate eventDate) async {
    Database dbEventDate = await db;
    //inserindo evento.
    //retorna o id e salva no id dele.
    eventDate.id = await dbEventDate.insert(eventDateTable, eventDate.toMap());
    return eventDate;
  }

  Future<EventDate> getEventDate(int id) async {
    Database dbEventDate = await db;
    //where passa a regra.
    //regra procura o evento com o id passado.
    List<Map> maps= await dbEventDate.query(eventDateTable,
        columns: [idColumn, nameColumn, dateStartColumn, dateEndColumn, locColumn, descColumn],
        where: "$idColumn = ?",
        whereArgs: [id]
    );
    if(maps.length > 0){
      //retornando evento em forma de map.
      //maps.first -> pega o primeiro mapa.
      return EventDate.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<int> deleteEventDate(int id)async{
    Database dbEventDate = await db;
    //.delete -> retorna um número inteiro
    return await dbEventDate.delete(eventDateTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateEventDate(EventDate eventDate) async{
    Database dbEventDate = await db;
    //.update -> retorna um número inteiro
    return await dbEventDate.update(eventDateTable, eventDate.toMap(), where: "$idColumn = ?", whereArgs: [eventDate.id]);
  }

  Future<List> getAllEventDate()async{
    Database dbEventDate = await db;
    List listMap = await dbEventDate.rawQuery("SELECT * FROM $eventDateTable");
    List<EventDate> listEventDate = List();
    for(Map m in listMap){
      //transformando em eventDate e jogando na lista do tipo EventDate.
      listEventDate.add(EventDate.fromMap(m));
    }
    return listEventDate;
  }

  Future<int> getNumber()async {
    Database dbEventDate = await db;
    return Sqflite.firstIntValue(await dbEventDate.rawQuery("SELECT COUNT(*) FROM $eventDateTable"));
  }

  Future close()async {
    Database dbEventDate = await db;
    dbEventDate.close();
  }

}

class EventDate {
  int id;
  String name;
  String dateStart;
  String dateEnd;
  String loc;
  String desc;

  EventDate();

  //armazena no formato de mapa
  EventDate.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    dateStart = map[dateStartColumn];
    dateEnd = map[dateEndColumn];
    loc = map[locColumn];
    desc = map[descColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      nameColumn: name,
      dateStartColumn: dateStart,
      dateEndColumn: dateEnd,
      locColumn: loc,
      descColumn: desc
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString(){
    return "EventDate(id: $id, name: $name, dateStart: $dateStart, dateEnd: $dateEnd, loc: $loc, desc: $desc)";
  }

}

