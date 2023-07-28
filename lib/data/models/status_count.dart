class StatusCount {
  String? status;
  List<TaskStatusModel>? data;

  StatusCount({this.status, this.data});

  StatusCount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskStatusModel>[];
      json['data'].forEach((v) {
        data!.add(TaskStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaskStatusModel {
  String? sId;
  int? sum;

  TaskStatusModel({this.sId, this.sum});

  TaskStatusModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
