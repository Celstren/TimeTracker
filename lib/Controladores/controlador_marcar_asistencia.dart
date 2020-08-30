import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:mixercon_assistance/Modelos/modelo_sede.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class ControladorMarcarAsistencia implements BlocBase {

  final RadioTierraKm = 6378.0;

  BehaviorSubject<Marca> _controladorMarca = BehaviorSubject<Marca>();
  Function(Marca) get pushMarca => _controladorMarca.sink.add;
  Stream<Marca> get streamMarca => _controladorMarca;

  BehaviorSubject<List<Marca>> _controladorMarcas = BehaviorSubject<List<Marca>>();
  Function(List<Marca>) get pushMarcas => _controladorMarcas.sink.add;
  Stream<List<Marca>> get streamMarcas => _controladorMarcas;

  bool validarMarca(Marca _marca, Dia _dia){
    return _marca.horaMarca.isBefore(_dia.horaSalida.add(Duration(minutes: _dia.minutosTolerancia))) && _marca.horaMarca.isAfter(_dia.horaIngreso.add(Duration(minutes: -_dia.minutosTolerancia)));
  }

  guardarMarca(Marca _marca) async {

    Marca p = await createPost('https://telonetavo.000webhostapp.com/Conexion/Metodos_Marca/Registrar_Marca.php',
        body: _marca.toJson());

  }
  
  int obtenerMinutosDiferencia(Marca _marca, Dia _dia){
    return min((_marca.horaMarca.difference(_dia.horaIngreso).inMinutes).abs(), (_marca.horaMarca.difference(_dia.horaSalida).inMinutes).abs());
  }

  String obtenerRespuesta(Marca _marca, Dia _dia){
      int absDifIngreso = (_marca.horaMarca.difference(_dia.horaIngreso).inMinutes).abs();
      int absDifSalida = (_marca.horaMarca.difference(_dia.horaSalida).inMinutes).abs();

      int difIngreso = _marca.horaMarca.difference(_dia.horaIngreso).inMinutes;
      int difSalida = _marca.horaMarca.difference(_dia.horaSalida).inMinutes;

      if (absDifIngreso < absDifSalida){
        if (difIngreso < 0){
          return "ANTES DE TIEMPO";
        } else if(difIngreso > 0){
          return "TARDANZA";
        } else {
          return "A TIEMPO";
        }
      } else {
        if (difSalida < 0){
          return "ANTES DE TIEMPO";
        } else if(difSalida > 0){
          return "FUERA DE TIEMPO";
        } else {
          return "A TIEMPO";
        }
      }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorMarca.close();
    _controladorMarcas.close();
  }

}

ControladorMarcarAsistencia controladorMarcarAsistencia = ControladorMarcarAsistencia();