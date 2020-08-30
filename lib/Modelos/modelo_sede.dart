// To parse this JSON data, do
//
//     final sede = sedeFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixercon_assistance/Utils/enpoints.dart';

Sede sedeFromJson(String str) => Sede.fromJson(json.decode(str));

String sedeToJson(Sede data) => json.encode(data.toJson());

final String URLBase = "https://telonetavo.000webhostapp.com/Conexion/Metodos_Sede/";

class Sede {
  int sedeId;
  String nombre;
  double latitud;
  double longitud;

  Sede({
    this.sedeId,
    this.nombre,
    this.latitud,
    this.longitud,
  });

  factory Sede.fromJson(Map<String, dynamic> json) => new Sede(
    sedeId: int.parse(json["SedeID"]),
    nombre: json["Nombre"],
    latitud: double.parse(json["Latitud"]),
    longitud: double.parse(json["Longitud"]),
  );

  Map<String, dynamic> toJson() => {
    "SedeID": sedeId,
    "Nombre": nombre,
    "Latitud": latitud,
    "Longitud": longitud,
  };
}

Future<Sede> getFromDBbyId(int sedeId) async {
  Sede sede = Sede();

  final response =
      await http.get(URLBase + EndPoints.OBTENER_SEDE + sedeId.toString());
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    sede = Sede.fromJson(data["resultado"][0]);
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return sede;
}

List<Sede> getFromDBAll(){
  List<Sede> sedes = List<Sede>();
  return sedes;
}

int updateSedeToDB(){
  return 0;
}

int deleteSedeToDB(){
  return 0;
}