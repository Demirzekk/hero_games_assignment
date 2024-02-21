import 'dart:developer';

enum Status {
  idle,
  waiting,
  done,
  error,
}

extension StatusExtension on Status {
  String get name {
    switch (this) {
      case Status.idle:
        return 'idle';
      case Status.waiting:
        return 'waiting';
      case Status.done:
        return 'done';
      case Status.error:
        return 'error';
      default:
        return 'idle';
    }
  }
}

extension LogExtension on String {
  void logger() {
    log(this);
  }
}

extension StringToListX on String {
  List<String> stringToList() {
    return split(",").map((e) => e.trim()).toList();
  }
}
