class TasksModel {
  String? sId;
  String? name;
  int? age;
  String? colour;

  TasksModel({this.sId, this.name, this.age, this.colour});

  TasksModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    age = json['age'];
    colour = json['colour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['_id'] = this.sId;
    data['name'] = this.name;
    data['age'] = this.age;
    data['colour'] = this.colour;
    return data;
  }
}
