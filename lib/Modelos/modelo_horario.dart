// To parse this JSON data, do
//
//     final horario = horarioFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixercon_assistance/Utils/enpoints.dart';

Horario horarioFromJson(String str) => Horario.fromJson(json.decode(str));

String horarioToJson(Horario data) => json.encode(data.toJson());

final String URLBase = "https://telonetavo.000webhostapp.com/Conexion/Metodos_Horario/";

class Horario {
  int horarioId;
  DateTime fechaInicio;
  DateTime fechaFin;

  Horario({
    this.horarioId,
    this.fechaInicio,
    this.fechaFin
  });

  factory Horario.fromJson(Map<String, dynamic> json) => new Horario(
    horarioId: int.parse(json["HorarioID"]),
    fechaInicio: DateTime.parse(json["Fecha_Inicio"]),
    fechaFin: DateTime.parse(json["Fecha_Fin"]),
  );

  Map<String, dynamic> toJson() => {
    "HorarioID": horarioId,
    "Fecha_Inicio": fechaInicio,
    "Fecha_Fin": fechaFin
  };
}

Future<Horario> getFromDBbyId(int horarioId) async {
  Horario horario = Horario();

  final response =
  await http.get(URLBase + EndPoints.OBTENER_HORARIO + horarioId.toString());
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    horario = Horario.fromJson(data["resultado"][0]);
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return horario;
}

Horario getFromDBbyUsuarioId(int usuarioId){
  Horario horario = Horario();
  return horario;
}

List<Horario> getFromDBAll(){
  List<Horario> horarios = List<Horario>();
  return horarios;
}

int updateHorarioToDB(){
  return 0;
}

int deleteHorarioToDB(){
  return 0;
}
