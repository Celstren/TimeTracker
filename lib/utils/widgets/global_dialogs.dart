import 'package:TimeTracker/utils/widgets/custom_dialog.dart';
import 'package:TimeTracker/utils/widgets/loading_screen.dart';
import 'package:TimeTracker/utils/widgets/ok_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalDialogs {
  static GlobalDialogs _instance;
  static BuildContext _context;

  GlobalDialogs._();

  factory GlobalDialogs() => _getInstance();

  static GlobalDialogs _getInstance() {
    if (_instance == null) {
      _instance = GlobalDialogs._();
    }
    return _instance;
  }

  static initContext(BuildContext context) => _context = context;

  static displayConnectionError(int statusCode) {
    if (_context != null) {
      showCustomDialog(
        context: _context,
        child: CustomDialog(
          backgroundColor: Colors.transparent,
          child: OkDialog(
            title: _determinarMensajeRespuesta(statusCode),
            okText: "Cerrar",
            onPress: () => Navigator.pop(_context),
          ),
        ),
      );
    }
  }

  static String _determinarMensajeRespuesta(int statusCode) {
    switch (statusCode) {
      case 501:
        return "Falla del servidor";
      case 401:
        return "Falla de autorización";
      case 201: case 200:
        return "Solicitud éxitosa";
      default:
        return "Respuesta no manejada";
    }
  }

  static displayLoading() {
    if (_context != null) {
      displayLoadingScreen(_context);
    }
  }

  static popContext() {
    if (_context != null && Navigator.canPop(_context)) {
      Navigator.pop(_context);
    }
  }
}
