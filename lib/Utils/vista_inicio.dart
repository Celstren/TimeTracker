import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_horario.dart';
import 'package:mixercon_assistance/Modelos/modelo_sede.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:mixercon_assistance/Utils/validators.dart' as Validators;

import 'controlador_vistas.dart';
import 'nombre_vistas.dart';

class VistaInicio extends StatefulWidget {

  bool cerrarSesion;

  VistaInicio({this.cerrarSesion});

  @override
  State<StatefulWidget> createState() => VistaInicioState();
}

class VistaInicioState extends State<VistaInicio> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    // TODO: implement build
    return widget.cerrarSesion? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: hp(10), horizontal: wp(4)),
          child: Text('¿Seguro que quiere cerrar sesión?', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(5)),),
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  controladorEmpleado.limpiarDatos();
                  controladorVistas.pushVista(NombreVistas.VISTA_INICIAR_SESION);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  padding: EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(16)),
                  child: Text('Sí', textAlign: TextAlign.center,style: TextStyle(fontSize: wp(5), color: Colors.white)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    widget.cerrarSesion = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  padding: EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(16)),
                  child: Text('No', textAlign: TextAlign.center,style: TextStyle(fontSize: wp(5), color: Colors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    ) : StreamBuilder<Usuario>(
      stream: controladorEmpleado.streamUsuario,
      builder: (context, usuarioSnapshot){
        return StreamBuilder<Horario>(
          stream: controladorEmpleado.streamHorario,
          builder: (context, horarioSnapshot){
            return StreamBuilder<Sede>(
              stream: controladorEmpleado.streamSede,
              builder: (context, sedeSnapshot){
                return StreamBuilder<List<Dia>>(
                  stream: controladorEmpleado.streamDias,
                  builder: (context, diasSnapshot){

                    String nombre = usuarioSnapshot.hasData && usuarioSnapshot.data != null? usuarioSnapshot.data.nombre : "";

                    String fin = "";
                    String inicio = "";
                    bool datosCargados = usuarioSnapshot.hasData && horarioSnapshot.hasData && sedeSnapshot.hasData && diasSnapshot.hasData;

                    if (diasSnapshot.hasData && diasSnapshot.data.length > 0){
                      diasSnapshot.data.forEach((d){
                        if (Validators.validateSameDays(d.fechaActual, DateTime.now()) || Validators.validateSameDays(d.horaSalida, DateTime.now())){
                          fin = DateFormat('kk:mm').format(d.horaSalida);
                        }
                      });
                    }

                    if (diasSnapshot.hasData && diasSnapshot.data.length > 0){
                      diasSnapshot.data.forEach((d){
                        if (Validators.validateSameDays(d.fechaActual, DateTime.now())){
                          inicio = DateFormat('kk:mm').format(d.horaIngreso);
                        }
                      });
                    }

                    return datosCargados? Container(
                      height: hp(100),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: <Widget>[
                          Card(
                            margin: EdgeInsets.symmetric(vertical: hp(3)),
                            elevation: 10.0,
                            child: Container(
                              color: Colors.yellow,
                              padding: EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(4)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: AutoSizeText(
                                      "Bienvenido $nombre!",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: wp(10)),
                                    ),
                                  ),
                                  Container(
                                    child: AutoSizeText(
                                      "Inicio de jornada: $inicio",
                                      style: TextStyle(fontSize: wp(5)),
                                    ),
                                  ),
                                  Container(
                                    child: AutoSizeText(
                                      "Fin de jornada: $fin",
                                      style: TextStyle(fontSize: wp(5)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
