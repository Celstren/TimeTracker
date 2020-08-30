import 'package:mixercon_assistance/Modelos/modelo_usuario.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_base.dart';

class ControladorSesion implements BlocBase {

  BehaviorSubject<Usuario> _controladorUsuario = BehaviorSubject<Usuario>();
  Function(Usuario) get pushUsuario => _controladorUsuario.sink.add;
  Stream<Usuario> get streamUsuario => _controladorUsuario;

  validarFormatoDatos(){}

  validarEmpleadoRegistrado(){}

  obtenerEmpleado() async {
    Usuario usuario = Usuario();

    usuario = await getFromDBbyId(71625040);

    if (usuario.usuarioId != null){
      pushUsuario(usuario);
    }
  }

  obtenerEmpleados() async {
    List<Usuario> usuarios = List<Usuario>();

    usuarios = await getFromDBAll();

    print(usuarios[0].nombre);

  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}

ControladorSesion controladorSesion = ControladorSesion();