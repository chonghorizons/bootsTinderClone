class Cluster {
  // Don't need id. Autogenerated from the backend (?)
  String needer1;
  String caretaker1;
  String caretaker2;
  String caretaker3;
  List<String> watchers;

  Cluster({
    this.needer1,
    this.caretaker1,
    this.caretaker2,
    this.caretaker3,
    this.watchers=const [],
  });
}