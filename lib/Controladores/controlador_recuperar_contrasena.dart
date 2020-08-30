import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class ControladorRecuperarContrasena implements BlocBase {

  BehaviorSubject<Usuario> _controladorUsuario = BehaviorSubject<Usuario>();
  Function(Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<Usuario> get streamUsuario => _controladorUsuario;

  actualizarEmpleado(){}

  @override
  void dispose() {
    // TODO: implement dispose
    _controladorUsuario.close();
  }

}