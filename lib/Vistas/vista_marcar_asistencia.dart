import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Controladores/controlador_marcar_asistencia.dart';
import 'package:mixercon_assistance/Modelos/modelo_dia.dart';
import 'package:mixercon_assistance/Modelos/modelo_marca.dart';
import 'package:mixercon_assistance/Modelos/modelo_sede.dart';
import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaMarcarAsistencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaMarcarAsistenciaState();
}

class VistaMarcarAsistenciaState extends State<VistaMarcarAsistencia> {
  LocationData _startLocation;
  LocationData _currentLocation;

  StreamSubscription<LocationData> _locationSubscription;

  Location _locationService = new Location();
  bool _permission = false;
  String error;

  bool currentWidget = true;

  GoogleMapController mapController;

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _currentCameraPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 4,
  );
  LatLng posicionEmpleado;

  GoogleMap googleMap;

  LocationData location;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _controller.complete(controller);
    initPlatformState();
  }

  @override
  void initState() {
    super.initState();
  }

  initPlatformState() async {
    await _locationService.changeSettings(
        accuracy: LocationAccuracy.HIGH, interval: 1000);

    LocationData location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await _locationService.serviceEnabled();
      if (serviceStatus) {
        _permission = await _locationService.requestPermission();
        if (_permission) {
          location = await _locationService.getLocation();

          _locationSubscription = _locationService
              .onLocationChanged()
              .listen((LocationData result) async {
            _currentCameraPosition = CameraPosition(
                target: LatLng(result.latitude, result.longitude), zoom: 16);
            posicionEmpleado = LatLng(result.latitude, result.longitude);
          });
        }
      } else {
        bool serviceStatusResult = await _locationService.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      location = null;
    }

    setState(() {
      _startLocation = location;
    });
  }

  actualizarPosicionMapa(double _latitud, double _longitud) async {
    final GoogleMapController controller = await _controller.future;
    _currentCameraPosition =
        CameraPosition(target: LatLng(_latitud, _longitud), zoom: 16);
    controller
        .animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition));
  }

  realizarMarca(Usuario usuario, Dia dia, Sede sede) {
    Marca nuevaMarca = Marca();

    nuevaMarca.usuarioId = usuario.usuarioId;
    nuevaMarca.respuesta = "Prueba desde flutter";
    nuevaMarca.longitud = posicionEmpleado.longitude;
    nuevaMarca.latitud = posicionEmpleado.latitude;
    nuevaMarca.horaMarca = DateTime.now();
    nuevaMarca.minutosDiferencia = 30;
    nuevaMarca.tipoMarca = 1;

    if (controladorMarcarAsistencia.validarMarca(nuevaMarca, dia)) {
      nuevaMarca.minutosDiferencia = controladorMarcarAsistencia.obtenerMinutosDiferencia(nuevaMarca, dia);
      nuevaMarca.respuesta = controladorMarcarAsistencia.obtenerRespuesta(nuevaMarca, dia);
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Text('Asistencia marcada correctamente!\nMinutos de Diferencia: ${nuevaMarca.minutosDiferencia}\nRespuesta: ${nuevaMarca.respuesta}', textAlign: TextAlign.center,),
                ),
              ],
            );
          });
      controladorMarcarAsistencia.guardarMarca(nuevaMarca);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Text('Fuera de tiempo', textAlign: TextAlign.center,),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    googleMap = GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      initialCameraPosition: _currentCameraPosition,
      onMapCreated: _onMapCreated,
    );

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build
    return Stack(
      children: <Widget>[
        googleMap,
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: hp(10),
            margin: EdgeInsets.symmetric(vertical: hp(5), horizontal: wp(1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      actualizarPosicionMapa(posicionEmpleado.latitude,
                          posicionEmpleado.longitude);
                    });
                  },
                  child: Container(
                    height: hp(10),
                    width: wp(20),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: wp(.5))),
                    child: Center(
                      child: Text(
                        'Yo',
                        style: TextStyle(fontSize: wp(3), color: Colors.white),
                      ),
                    ),
                  ),
                ),
                StreamBuilder<Usuario>(
                  stream: controladorEmpleado.streamUsuario,
                  builder: (context, empleadoSnapshot) {
                    return StreamBuilder<Dia>(
                      stream: controladorEmpleado.streamDia,
                      builder: (context, diaSnapshot) {
                        return StreamBuilder<Sede>(
                          stream: controladorEmpleado.streamSede,
                          builder: (context, sedeSnapshot) {
                            bool dataComplete = empleadoSnapshot.hasData &&
                                diaSnapshot.hasData &&
                                sedeSnapshot.hasData;
                            bool ubicacionValida = false;
                            double distancia = 0;

                            return GestureDetector(
                              onTap: () {
                                if (dataComplete) {
                                  if (dataComplete &&
                                      posicionEmpleado != null) {
                                    double difLats = sedeSnapshot.data.latitud -
                                        posicionEmpleado.latitude;
                                    double difLongs =
                                        sedeSnapshot.data.longitud -
                                            posicionEmpleado.longitude;
                                    double distancia = sqrt(
                                        pow(difLats, 2) + pow(difLongs, 2));
                                    ubicacionValida =
                                        distancia <= 0.00135364775;
                                    if (ubicacionValida) {
                                      realizarMarca(empleadoSnapshot.data,
                                          diaSnapshot.data, sedeSnapshot.data);
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              children: <Widget>[
                                                Center(
                                                  child: Text('Usted se encuentra fuera de la empresa\nPor favor acérquese para marcar su asistencia', textAlign: TextAlign.center,),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: hp(2), horizontal: wp(4)),
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    border: Border.all(
                                        color: Colors.white, width: wp(.5))),
                                child: Center(
                                  child: Text(
                                    dataComplete ? 'Marcar' : 'Cargando',
                                    style: TextStyle(
                                        fontSize: wp(8), color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<Sede>(
                  stream: controladorEmpleado.streamSede,
                  builder: (context, sedeSnapshot) {
                    return GestureDetector(
                      onTap: () {
                        if (sedeSnapshot.hasData) {
                          setState(() {
                            actualizarPosicionMapa(sedeSnapshot.data.latitud,
                                sedeSnapshot.data.longitud);
                          });
                        }
                      },
                      child: Container(
                        height: hp(10),
                        width: wp(20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: Colors.white, width: wp(.5))),
                        child: Center(
                          child: Text(
                            sedeSnapshot.hasData ? 'Ir a sede' : 'Buscando...',
                            style:
                                TextStyle(fontSize: wp(3), color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
