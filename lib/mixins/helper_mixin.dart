mixin HelperMixin {
  static int getTimestamp() {
    return (DateTime.now().millisecondsSinceEpoch / 1000).round();
  }
}
