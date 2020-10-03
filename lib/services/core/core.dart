import 'coreBuilder.dart';
import 'environment.dart';

class Core {
  static final Core _instance = new Core._internal();

  factory Core() {
    return _instance;
  }

  static CoreBuilder _builder = new CoreBuilder();

  Core._internal() {
    _builder.environment = BuildEnvironment.TEST_API;
  }

  set builder(CoreBuilder coreBuilder) => _builder = coreBuilder;

  String get server => _builder.environment.value;
}
