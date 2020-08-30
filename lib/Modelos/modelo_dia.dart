// To parse this JSON data, do
//
//     final dia = diaFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixercon_assistance/Utils/enpoints.dart';

Dia diaFromJson(String str) => Dia.fromJson(json.decode(str));

String diaToJson(Dia data) => json.encode(data.toJson());

final String URLBase = "https://telonetavo.000webhostapp.com/Conexion/Metodos_Dia/";

class Dia {
  int diaId;
  String nombre;
  DateTime fechaActual;
  DateTime horaIngreso;
  DateTime horaSalida;
  int minutosTolerancia;
  int horarioId;

  Dia({
    this.diaId,
    this.nombre,
    this.fechaActual,
    this.horaIngreso,
    this.horaSalida,
    this.minutosTolerancia,
    this.horarioId,
  });

  factory Dia.fromJson(Map<String, dynamic> json) => new Dia(
    diaId: int.parse(json["DiaID"]),
    nombre: json["Nombre"],
    fechaActual: DateTime.parse(json["Fecha_Actual"]),
    horaIngreso: DateTime.parse(json["Hora_Ingreso"]),
    horaSalida: DateTime.parse(json["Hora_Salida"]),
    minutosTolerancia: int.parse(json["Minutos_Tolerancia"]),
    horarioId: int.parse(json["HorarioID"]),
  );

  Map<String, dynamic> toJson() => {
    "DiaID": diaId,
    "Nombre": nombre,
    "Fecha_Actual": fechaActual,
    "Hora_Ingreso": horaIngreso,
    "Hora_Salida": horaSalida,
    "Minutos_Tolerancia": minutosTolerancia,
    "HorarioID": horarioId,
  };
}

Dia getFromDBbyId(int diaId){
  Dia dia = Dia();

  return dia;
}

Future<List<Dia>> getFromDBbyHorarioId(int horarioId) async {
  List<Dia> dias = List<Dia>();

  final response =
      await http.get(URLBase + EndPoints.OBTENER_DIA_POR_HORARIO + horarioId.toString());
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    Dia dia = Dia();
    List<dynamic> result = data["resultado"];

    result.forEach((d){
      dia = Dia.fromJson(d);
      dias.add(dia);
    });
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return dias;
}

List<Dia> getFromDBAll(){
  List<Dia> dias = List<Dia>();
  return dias;
}

int updateDiaToDB(){
  return 0;
}

int modifyDiaToDB(){
  return 0;
}