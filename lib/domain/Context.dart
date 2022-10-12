import 'package:capstone/domain/Web/WebService.dart';

class Context {

  final webService = WebServiceImpl();

  static final instants = Context._internal();

  factory Context() {
    return instants;
  }

  Context._internal();
}