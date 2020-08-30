import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';
import 'package:mixercon_assistance/Utils/vista_inicio.dart';
import 'package:mixercon_assistance/Vistas/vista_gestion_empleado.dart';
import 'package:mixercon_assistance/Vistas/vista_incio_sesion.dart';
import 'package:mixercon_assistance/Vistas/vista_marcar_asistencia.dart';

import 'IconDrawer.dart';
import 'controlador_vistas.dart';
import 'nombre_vistas.dart';

class BaseScaffold extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BaseScaffoldState();

}

class BaseScaffoldState extends State<BaseScaffold>{

  @override
  void initState() {
    // TODO: implement initState
    controladorVistas.pushVista(NombreVistas.VISTA_INICIAR_SESION);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    Widget _opcionDrawer(String nombreOpcion){
      return GestureDetector(
        onTap: (){
          controladorVistas.pushVista(nombreOpcion);
          Navigator.pop(context);
        },
        child: Container(
          height: hp(10),
          color: Colors.yellow,
          margin: EdgeInsets.symmetric(horizontal: wp(5)),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(nombreOpcion, style: TextStyle(fontSize: wp(5)))
          ),
        ),
      );
    }

    Widget _construirTituloDrawer(){
      return Container(
        height: hp(20),
        width: wp(100),
        child: Image(image: AssetImage("assets/Resources/Icons/MixerconLogo.png"),),
      );
    }

    Widget _construirCuerpoDrawer(){
      return Container(
        height: hp(80),
        width: wp(100),
        color: Colors.yellow,
        child: ListView(
          children: <Widget>[
            _opcionDrawer(NombreVistas.VISTA_INICIO),
            _opcionDrawer(NombreVistas.VISTA_MARCAR_ASISTENCIA),
            _opcionDrawer(NombreVistas.VISTA_PERFIL),
            _opcionDrawer(NombreVistas.VISTA_CERRAR_SESION),
          ],
        ),
      );
    }

    // TODO: implement build
    return Scaffold(
      drawer: StreamBuilder(stream: controladorVistas.streamVista,builder: (context, vistaSnapshot){
        if (vistaSnapshot.hasData && vistaSnapshot.data != NombreVistas.VISTA_INICIAR_SESION){
          return Drawer(
            child: Container(
              child: Column(
                children: <Widget>[
                  _construirTituloDrawer(),
                  _construirCuerpoDrawer(),
                ],
              ),
            ),
          );
        } else {
          return Drawer(
            child: Container(
              child: Center(
                child: _construirTituloDrawer(),
              ),
            ),
          );
        }
      }),
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("MIXERCON APP",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20)),
      ),
      body: StreamBuilder<String>(stream: controladorVistas.streamVista,
          builder: (context, vistaSnapshot){
            if (vistaSnapshot.hasData){
              switch (vistaSnapshot.data){
                case NombreVistas.VISTA_INICIO: return VistaInicio(cerrarSesion: false,);
                case NombreVistas.VISTA_INICIAR_SESION: return VistaInicioSesion();
                case NombreVistas.VISTA_MARCAR_ASISTENCIA: return VistaMarcarAsistencia();
                case NombreVistas.VISTA_PERFIL: return VistaGestionEmpleado();
                case NombreVistas.VISTA_CERRAR_SESION:  return VistaInicio(cerrarSesion: true,);
                default: return Container();
              }
            } else {
              return Container();
            }
          }),
    );
  }

}