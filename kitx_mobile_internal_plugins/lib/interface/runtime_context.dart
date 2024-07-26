class RuntimeContext {
  RuntimeContext(this.id);

  final String id;

  late Function(String)? logInf;

  late Function(String)? logWan;

  late Function(String)? logErr;
}
