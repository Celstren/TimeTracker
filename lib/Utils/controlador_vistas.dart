import 'package:mixercon_assistance/Controladores/bloc_base.dart';
import 'package:rxdart/rxdart.dart';

class ControladorVistas implements BlocBase {

  BehaviorSubject<String> _controladorVista = BehaviorSubject<String>();
  Function(String) get pushVista => _controladorVista.sink.add;
  Stream<String> get streamVista => _controladorVista;

  @override
  void dispose() {
    _controladorVista.close();
    // TODO: implement dispose
  }

}

ControladorVistas controladorVistas = ControladorVistas();