import 'package:flutter/material.dart';
import 'package:mixercon_assistance/Controladores/controlador_empleado.dart';
import 'package:mixercon_assistance/Utils/screen_utils.dart';

class VistaInicioSesion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VistaInicioSesionState();
}

class VistaInicioSesionState extends State<VistaInicioSesion> {

  String codigoEmpleado = "", contrasena = "";

  bool validarCodigo(String value) {
    Pattern pattern = "[0-9]";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {

    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;

    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: hp(5)),
              child: Center(
                child: Text('INICIAR SESIÓN', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(10)),),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: wp(4)),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Código de empleado'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            onChanged: (value){
                              setState(() {
                                codigoEmpleado = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Ingresar código de empleado"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: hp(2)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Contraseña'),
                          ),
                        ),
                        Container(
                          child: TextField(
                            obscureText: true,
                            onChanged: (value){
                              setState(() {
                                contrasena = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Ingresar contraseña"
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                if (codigoEmpleado.trim().isNotEmpty && contrasena.trim().isNotEmpty){

                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      });

                  if (validarCodigo(codigoEmpleado.trim())){
                    controladorEmpleado.obtenerEmpleadoLogin(codigoEmpleado, contrasena, context);
                  }else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            children: <Widget>[
                              Center(
                                child: Text('Codigo no válido\nEn caso no recordar consultar con su administrador', textAlign: TextAlign.center,),
                              ),
                            ],
                          );
                        });
                  }
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          children: <Widget>[
                            Center(
                              child: Text('Falta completar campos obligatorios', textAlign: TextAlign.center,),
                            ),
                          ],
                        );
                      });
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: wp(4), vertical: hp(5)),
                color: Colors.blue,
                child: Center(
                  child: Text('INGRESAR', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(10), color: Colors.white),),
                ),
              ),
            ),
            Container(
              child: Center(
                child: Text('OLVIDÉ MI CONTRASEÑA', textAlign: TextAlign.center, style: TextStyle(fontSize: wp(4), color: Colors.blue),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
