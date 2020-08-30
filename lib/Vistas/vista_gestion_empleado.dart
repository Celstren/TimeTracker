import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaGestionEmpleado extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaGestionEmpleadoState();
}

class VistaGestionEmpleadoState extends State<VistaGestionEmpleado> {
  bool mostrarHistorialMarcas = false;

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build

    Widget _construirDatosPersonales(
        String _nombre, String _sector, String _area, int _codigoEmpleado) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: wp(2)),
        padding: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey[400],
                offset: Offset(0.0, 5.0),
                blurRadius: 5.0,
              )
            ]),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: hp(2)),
                child: Text(
                  'Datos Personales',
                  style: TextStyle(fontSize: wp(6)),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Nombre',
                    style: TextStyle(fontSize: wp(5)),
                  ),
                  Text(
                    _nombre,
                    style: TextStyle(fontSize: wp(5)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Sector',
                    style: TextStyle(fontSize: wp(5)),
                  ),
                  Text(
                    _sector,
                    style: TextStyle(fontSize: wp(5)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Area',
                    style: TextStyle(fontSize: wp(5)),
                  ),
                  Text(
                    _area,
                    style: TextStyle(fontSize: wp(5)),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Código Empleado',
                    style: TextStyle(fontSize: wp(5)),
                  ),
                  Text(
                    '$_codigoEmpleado',
                    style: TextStyle(fontSize: wp(5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _construirHorarios() {
      return StreamBuilder<List<Dia>>(
        stream: controladorEmpleado.streamDias,
        builder: (context, diasSnapshot) {
          String Dia = "";

          return Container(
            margin: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
            padding: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[400],
                    offset: Offset(0.0, 5.0),
                    blurRadius: 5.0,
                  )
                ]),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: Text(
                      'Horario Asignado',
                      style: TextStyle(fontSize: wp(6)),
                    ),
                  ),
                ),
                diasSnapshot.hasData && diasSnapshot.data.length > 0
                    ? Container(
                        height: hp(16) * diasSnapshot.data.length,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: hp(1)),
                              padding: EdgeInsets.symmetric(horizontal: wp(2)),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              height: hp(14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        diasSnapshot.data[index].nombre,
                                        style: TextStyle(
                                            fontSize: wp(3.5), color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'Hora de ingreso',
                                                  style: TextStyle(
                                                      fontSize: wp(3.5), color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                DateFormat('kk:mm').format(
                                                    diasSnapshot.data[index].horaIngreso),
                                                style: TextStyle(
                                                    fontSize: wp(5), color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'Hora de salida',
                                                  style: TextStyle(
                                                      fontSize: wp(3.5), color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                DateFormat('kk:mm').format(
                                                    diasSnapshot.data[index].horaSalida),
                                                style: TextStyle(
                                                    fontSize: wp(5), color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  'Tolerancia',
                                                  style: TextStyle(
                                                      fontSize: wp(3.5), color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Text(
                                                diasSnapshot.data[index].minutosTolerancia.toString(),
                                                style: TextStyle(
                                                    fontSize: wp(5), color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: diasSnapshot.data.length,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      );
    }

    Widget _construirHistorialMarcas(String usuarioID) {
      return mostrarHistorialMarcas
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: wp(2), vertical: hp(4)),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[400],
                      offset: Offset(0.0, 5.0),
                      blurRadius: 5.0,
                    )
                  ]),
              child: Center(
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          mostrarHistorialMarcas = !mostrarHistorialMarcas;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[400],
                                offset: Offset(0.0, 5.0),
                                blurRadius: 5.0,
                              )
                            ]),
                        margin: EdgeInsets.symmetric(vertical: hp(2)),
                        padding: EdgeInsets.symmetric(
                            vertical: hp(2), horizontal: wp(4)),
                        child: Text(
                          'Ocultar marcas de empleado',
                          style:
                              TextStyle(fontSize: wp(4), color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: wp(1), vertical: hp(4)),
                          child: Text(
                            'Marcas registradas del empleado',
                            style: TextStyle(fontSize: wp(6)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: StreamBuilder<List<Marca>>(
                          stream: controladorEmpleado.streamMarcas,
                          builder: (context, marcasSnapshot) {
                            return marcasSnapshot.hasData &&
                                    marcasSnapshot.data.length > 0
                                ? Container(
                                    height: hp(16) * marcasSnapshot.data.length,
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: hp(1), horizontal: wp(1)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: wp(2)),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          height: hp(14),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    marcasSnapshot
                                                        .data[index].respuesta,
                                                    style: TextStyle(
                                                        fontSize: wp(5),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    DateFormat('yyyy-MM-dd hh:mm').format(marcasSnapshot
                                                        .data[index].horaMarca),
                                                    style: TextStyle(
                                                        fontSize: wp(5),
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: marcasSnapshot.data.length,
                                    ),
                                  )
                                : Container(
                              height: hp(10),
                              width: wp(20),
                              margin: EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(2)),
                              padding: EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(8)),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0))),
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
          : GestureDetector(
              onTap: () {
                setState(() {
                  mostrarHistorialMarcas = !mostrarHistorialMarcas;
                  controladorEmpleado.obtenerListMarcas(usuarioID);
                });
              },
              child: Container(
                padding:
                    EdgeInsets.symmetric(vertical: hp(4), horizontal: wp(10)),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                ),
                child: Center(
                  child: Text(
                    'Mostrar historial de marcas',
                    style: TextStyle(fontSize: wp(6)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
    }

    return ListView(
      children: <Widget>[
        StreamBuilder<Usuario>(
          stream: controladorEmpleado.streamUsuario,
          builder: (context, empleadoSnapshot) {
            String _nombre = "", _sector = "", _area = "", _usuarioID = "";
            int _codigoEmpleado = 0;

            if (empleadoSnapshot.hasData) {
              _nombre = empleadoSnapshot.data.nombre;
              _sector = empleadoSnapshot.data.sector;
              _area = empleadoSnapshot.data.area;
              _codigoEmpleado = empleadoSnapshot.data.codigoEmpleado;
              _usuarioID = empleadoSnapshot.data.usuarioId.toString();
            }

            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        'PERFIL',
                        style: TextStyle(
                          fontSize: wp(10),
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: hp(4)),
                    ),
                  ),
                  _construirDatosPersonales(
                      _nombre, _sector, _area, _codigoEmpleado),
                  _construirHorarios(),
                  _construirHistorialMarcas(_usuarioID),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
