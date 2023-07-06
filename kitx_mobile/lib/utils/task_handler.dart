/// [TaskHandler] Class
class TaskHandler {
  /// Execute task after specified time milliseconds
  TaskHandler delay(Function func, int milliseconds) {
    Future.delayed(Duration(milliseconds: milliseconds)).then((value) => func.call());
    return this;
  }
}
