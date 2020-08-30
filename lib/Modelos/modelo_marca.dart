// To parse this JSON data, do
//
//     final marca = marcaFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mixercon_assistance/Utils/enpoints.dart';

Marca marcaFromJson(String str) => Marca.fromJson(json.decode(str));

String marcaToJson(Marca data) => json.encode(data.toJson());

final String URLBase =
    "https://telonetavo.000webhostapp.com/Conexion/Metodos_Marca/";

class Post {
  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["userId"] = userId;
    map["title"] = title;
    map["body"] = body;

    return map;
  }
}

class Marca {
  int marcaId;
  int usuarioId;
  int tipoMarca;
  DateTime horaMarca;
  String respuesta;
  int minutosDiferencia;
  double latitud;
  double longitud;

  Marca({
    this.marcaId,
    this.usuarioId,
    this.tipoMarca,
    this.horaMarca,
    this.respuesta,
    this.minutosDiferencia,
    this.latitud,
    this.longitud,
  });

//  factory Marca.fromJson(Map<String, dynamic> json) => new Marca(
//    marcaId: json["MarcaID"],
//    usuarioId: json["UsuarioID"],
//    tipoMarca: json["Tipo_Marca"],
//    horaMarca: json["Hora_Marca"],
//    respuesta: json["Respuesta"],
//    minutosDiferencia: json["Minutos_Diferencia"],
//    latitud: json["Latitud"].toDouble(),
//    longitud: json["Longitud"].toDouble(),
//  );

  factory Marca.fromJson(Map<String, dynamic> json) => new Marca(
        marcaId: int.parse(json["MarcaID"]),
        usuarioId: int.parse(json["UsuarioID"]),
        tipoMarca: int.parse(json["Tipo_Marca"]),
        horaMarca: DateTime.parse(json["Hora_Marca"]),
        respuesta: json["Respuesta"],
        minutosDiferencia: int.parse(json["Minutos_Diferencia"]),
        latitud: double.parse(json["Latitud"]),
        longitud: double.parse(json["Longitud"]),
      );

  Map<String, dynamic> toJson() => {
        "UsuarioID": usuarioId,
        "Tipo_Marca": tipoMarca,
        "Hora_Marca": horaMarca.toString(),
        "Respuesta": respuesta,
        "Minutos_Diferencia": minutosDiferencia,
        "Latitud": latitud,
        "Longitud": longitud
      };
}

Future<Marca> getFromDBbyId(int marcaId) async {
  Marca marca = Marca();

  return marca;
}

Future<Marca> createPost(String url, {Map body}) async {
  return http
      .post(url,
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"},
          encoding: Encoding.getByName("utf-8"))
      .then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    return Marca.fromJson(json.decode(response.body));
  });
}

Future<List<Marca>> getFromDBbyUsuarioId(String usuarioId) async {
  List<Marca> marcas = List<Marca>();

  final response = await http.get(URLBase + EndPoints.OBTENER_MARCAS_POR_USUARIOID + usuarioId);

  if (response.statusCode == 200){
    final data = json.decode(response.body);
    Marca marca = Marca();
    List<dynamic> result = data["resultado"];

    result.forEach((d){
      marca = Marca.fromJson(d);
      marcas.add(marca);
    });
  } else {
    throw Exception('Fallo al conseguir datos de la base de datos');
  }

  return marcas;
}

List<Marca> getFromDBAll() {
  List<Marca> marcas = List<Marca>();
  return marcas;
}
