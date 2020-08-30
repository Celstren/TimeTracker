// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mixercon_assistance/Utils/enpoints.dart';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

final String URLBase = "https://telonetavo.000webhostapp.com/Conexion/Metodos_Usuario/";

class Usuario {
  int usuarioId;
  String nombre;
  String estado;
  String sector;
  String contrasena;
  String area;
  int codigoEmpleado;
  int horarioId;
  int sedeId;

  Usuario({
    this.usuarioId,
    this.nombre,
    this.estado,
    this.sector,
    this.contrasena,
    this.area,
    this.codigoEmpleado,
    this.horarioId,
    this.sedeId,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => new Usuario(
    usuarioId: int.parse(json["UsuarioID"]),
    nombre: json["Nombre"],
    estado: json["Estado"],
    sector: json["Sector"],
    contrasena: json["Contrasena"],
    area: json["Area"],
    codigoEmpleado: int.parse(json["Codigo_Empleado"]),
    horarioId: int.parse(json["HorarioID"]),
    sedeId: int.parse(json["SedeID"]),
  );

  Map<String, dynamic> toJson() => {
    "UsuarioID": usuarioId,
    "Nombre": nombre,
    "Estado": estado,
    "Sector": sector,
    "Contrasena": contrasena,
    "Area": area,
    "Codigo_Empleado": codigoEmpleado,
    "HorarioID": horarioId,
    "SedeID": sedeId,
  };


}

Future<Usuario> getFromDBbyId(int usuarioId) async {
  Usuario usuario = Usuario();

  final response =
  await http.get(URLBase + EndPoints.OBTENER_USUARIO + usuarioId.toString());
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    usuario = Usuario.fromJson(data["resultado"][0]);
    print(usuario.nombre);
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return usuario;
}

Future<String> getFromDBbyLogin(String codigo, String contrasena) async {
  String result = "-1";

  final response =
  await http.get(URLBase + EndPoints.OBTENER_USUARIO_LOGIN + "Codigo=$codigo&Contrasena=$contrasena");
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    if (data["resultado"] != 'El usuario no existe'){
      result = data["resultado"][0]["UsuarioID"];
    }
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return result;
}

Future<List<Usuario>> getFromDBAll() async {
  List<Usuario> usuarios = List<Usuario>();

  final response =
  await http.get(URLBase + EndPoints.OBTENER_TODOS_USUARIO);
  if (response.statusCode == 200){
    final data = json.decode(response.body);
    Usuario usuario = Usuario();
    List<dynamic> result = data["resultado"];
    result.forEach((u){
      usuario = Usuario.fromJson(u);
      usuarios.add(usuario);
    });
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return usuarios;
}