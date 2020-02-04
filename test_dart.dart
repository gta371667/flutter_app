void main() {
  print("main main main main main000");

  String abc = "123AA5";
  print("main ${abc.parseInt()}");
  print("main ${abc < 5}");
  print("main ${abc.split("")}");

  abc.split("0");
}

extension ADuck on String {
  int parseInt() {
    return int.tryParse(this);
  }

  String operator <(int shift) {
    return this.substring(shift, this.length) + this.substring(0, shift);
  }

  @override
  List<String> split(Pattern pattern) {
    return ["asdasjdlasd"];
  }
}
