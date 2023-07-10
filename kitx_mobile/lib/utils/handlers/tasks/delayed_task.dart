/// [DelayedTask] Class
class DelayedTask {
  /// Function of this task
  Function? function;

  /// Milliseconds before execution
  int delayMilliseconds = 2000;

  /// Execute
  DelayedTask execute() {
    Future.delayed(Duration(milliseconds: delayMilliseconds)).then((value) => function?.call());

    return this;
  }

  /// Execute by async way
  Future<DelayedTask> executeAsync() async {
    await Future.delayed(Duration(milliseconds: delayMilliseconds));
    function?.call();

    return this;
  }
}

/// Extensions of [DelayedTask] class
extension DelayedTaskExtensions on Function {
  /// To create a [DelayedTask] with delay duration in milliseconds way
  DelayedTask delay({int milliseconds = 2000}) {
    return DelayedTask()
      ..delayMilliseconds = milliseconds
      ..function = this;
  }
}
