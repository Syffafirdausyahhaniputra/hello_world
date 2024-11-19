class DosenModel {
  final int dosenId;
  final int userId;
  final int bidangId;
  final int mkId;

  DosenModel({
    required this.dosenId,
    required this.userId,
    required this.bidangId,
    required this.mkId,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      dosenId: json['dosen_id'],
      userId: json['user_id'],
      bidangId: json['bidang_id'],
      mkId: json['mk_id'],
    );
  }
}
