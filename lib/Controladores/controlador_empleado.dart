import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart' as ModeloDia;
import 'package:mixercon_assistance/Modelos/modelo_horario.dart' as ModeloHorario;
import 'package:mixercon_assistance/Modelos/modelo_marca.dart' as ModeloMarca;
import 'package:mixercon_assistance/Modelos/modelo_sede.dart' as ModeloSede;
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart' as ModeloUsuario;
import 'package:mixercon_assistance/Utils/controlador_vistas.dart';
import 'package:mixercon_assistance/Utils/nombre_vistas.dart';
import 'package:mixercon_assistance/Utils/validators.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class EmpleadoBloc implements BlocBase{

  BehaviorSubject<ModeloUsuario.Usuario> _controladorUsuario = BehaviorSubject<ModeloUsuario.Usuario>();
  Function(ModeloUsuario.Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<ModeloUsuario.Usuario> get streamUsuario => _controladorUsuario;

  BehaviorSubject<List<ModeloUsuario.Usuario>> _controladorUsuarios = BehaviorSubject<List<ModeloUsuario.Usuario>>();
  Function(List<ModeloUsuario.Usuario>) get pushUsuarios => _controladorUsuarios.sink.add;
  Stream<List<ModeloUsuario.Usuario>> get streamUsuarios => _controladorUsuarios;

  BehaviorSubject<ModeloSede.Sede> _controladorSede = BehaviorSubject<ModeloSede.Sede>();
  Function(ModeloSede.Sede) get pushSede => _controladorSede.sink.add;
  Stream<ModeloSede.Sede> get streamSede => _controladorSede;

  BehaviorSubject<ModeloHorario.Horario> _controladorHorario = BehaviorSubject<ModeloHorario.Horario>();
  Function(ModeloHorario.Horario) get pushHorario => _controladorHorario.sink.add;
  Stream<ModeloHorario.Horario> get streamHorario => _controladorHorario;

  BehaviorSubject<List<ModeloDia.Dia>> _controladorDias = BehaviorSubject<List<ModeloDia.Dia>>();
  Function(List<ModeloDia.Dia>) get pushDias => _controladorDias.sink.add;
  Stream<List<ModeloDia.Dia>> get streamDias => _controladorDias;

  BehaviorSubject<ModeloDia.Dia> _controladorDia = BehaviorSubject<ModeloDia.Dia>();
  Function(ModeloDia.Dia) get pushDia => _controladorDia.sink.add;
  Stream<ModeloDia.Dia> get streamDia => _controladorDia;

  BehaviorSubject<ModeloMarca.Marca> _controladorMarca = BehaviorSubject<ModeloMarca.Marca>();
  Function(ModeloMarca.Marca) get pushMarca => _controladorMarca.sink.add;
  Stream<ModeloMarca.Marca> get streamMarca => _controladorMarca;

  BehaviorSubject<List<ModeloMarca.Marca>> _controladorMarcas = BehaviorSubject<List<ModeloMarca.Marca>>();
  Function(List<ModeloMarca.Marca>) get pushMarcas => _controladorMarcas.sink.add;
  Stream<List<ModeloMarca.Marca>> get streamMarcas => _controladorMarcas;

  BehaviorSubject<String> _controladorMensaje = BehaviorSubject<String>();
  Function(String) get pushMensaje => _controladorMensaje.sink.add;
  Stream<String> get streamMensaje => _controladorMensaje;

  BehaviorSubject<int> _controladorStatus = BehaviorSubject<int>();
  Function(int) get pushStatus => _controladorStatus.sink.add;
  Stream<int> get streamStatus => _controladorStatus;

  BehaviorSubject<String> _controladorUsuarioID = BehaviorSubject<String>();
  Function(String) get pushUsuarioID => _controladorUsuarioID.sink.add;
  Stream<String> get streamUsuarioID => _controladorUsuarioID;

  obtenerListMarcas(String usuarioID) async {
    List<ModeloMarca.Marca> marcas = List<ModeloMarca.Marca>();

    marcas = await ModeloMarca.getFromDBbyUsuarioId(usuarioID);

    pushMarcas(marcas);
  }

  obtenerSede(int SedeID) async {
    ModeloSede.Sede sede = ModeloSede.Sede();

    sede = await ModeloSede.getFromDBbyId(SedeID);

    if (sede.sedeId != null){
      pushSede(sede);
    }
  }

  obtenerDiasPorHorario(int horarioID) async {
    List<ModeloDia.Dia> dias = List<ModeloDia.Dia>();

    dias = await ModeloDia.getFromDBbyHorarioId(horarioID);

    if (dias.length > 0){
      pushDias(dias);
      dias.forEach((d){
        if (validateSameDays(d.fechaActual, DateTime.now())){
          pushDia(d);
        }
      });
    }
  }

  obtenerHorario(int horarioID) async {
    ModeloHorario.Horario horario = ModeloHorario.Horario();

    horario = await ModeloHorario.getFromDBbyId(horarioID);

    if (horario.horarioId != null){
      pushHorario(horario);
      obtenerDiasPorHorario(horario.horarioId);
    }
  }

  obtenerEmpleado(int codigo, BuildContext context) async {
    ModeloUsuario.Usuario usuario = ModeloUsuario.Usuario();

    usuario = await ModeloUsuario.getFromDBbyId(codigo);

    if (usuario.usuarioId != null){
      obtenerHorario(usuario.horarioId);
      obtenerSede(usuario.sedeId);
      pushUsuario(usuario);
      controladorVistas.pushVista(NombreVistas.VISTA_INICIO);
    }
  }

  obtenerEmpleadoLogin(String codigo, String contrasena, BuildContext context) async {
    String usuarioID = "-1";
    usuarioID = await ModeloUsuario.getFromDBbyLogin(codigo, contrasena);

    if (usuarioID != "-1"){
      Navigator.pop(context);
      obtenerEmpleado(int.parse(codigo), context);
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Text('El usuario no existe', textAlign: TextAlign.center,),
                ),
              ],
            );
          });
    }

  }

  obtenerEmpleados() async {
    List<ModeloUsuario.Usuario> usuarios = List<ModeloUsuario.Usuario>();

    usuarios = await ModeloUsuario.getFromDBAll();

  }

  limpiarDatos(){
    pushStatus(0);
    pushDia(null);
    pushSede(null);
    pushDias(null);
    pushHorario(null);
    pushMarca(null);
    pushMarcas(null);
    pushMensaje(null);
    pushUsuario(null);
    pushUsuarios(null);
    pushUsuarioID(null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorUsuario.close();
    _controladorSede.close();
    _controladorDias.close();
    _controladorMarca.close();
    _controladorMarcas.close();
    _controladorMensaje.close();
    _controladorUsuarios.close();
    _controladorDia.close();
    _controladorStatus.close();
    _controladorUsuarioID.close();
  }

}

EmpleadoBloc controladorEmpleado = EmpleadoBloc();