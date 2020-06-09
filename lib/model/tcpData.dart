class TCPData {
  String name, ip;
  int port;

  TCPData({this.ip, this.name, this.port});

  TCPData.fromJson(Map<String, dynamic> json) {
    ip = json['ip'];
    name = json['name'];
    port = json['port'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ip'] = this.ip;
    data['name'] = this.name;
    data['port'] = this.port;
    return data;
  }
}