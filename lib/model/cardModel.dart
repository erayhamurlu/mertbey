class CardModel {
  int id;
  int taskId;
  String teknikUzman;
  String tahminiSure;
  String gerceklesenSure;
  String isinAciklamasi;
  String notlar;

  CardModel(
      {this.id,
      this.taskId,
      this.teknikUzman,
      this.tahminiSure,
      this.gerceklesenSure,
      this.isinAciklamasi,
      this.notlar});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskId = json['taskId'];
    teknikUzman = json['teknikUzman'];
    tahminiSure = json['tahminiSure'];
    gerceklesenSure = json['gerceklesenSure'];
    isinAciklamasi = json['isinAciklamasi'];
    notlar = json['notlar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskId'] = this.taskId;
    data['teknikUzman'] = this.teknikUzman;
    data['tahminiSure'] = this.tahminiSure;
    data['gerceklesenSure'] = this.gerceklesenSure;
    data['isinAciklamasi'] = this.isinAciklamasi;
    data['notlar'] = this.notlar;
    return data;
  }
}
