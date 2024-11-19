class UserModel {
  final int userId;
  final int roleId;
  final String username;
  final String nama;
  final String nip;
  final String avatar;

  UserModel({
    required this.userId,
    required this.roleId,
    required this.username,
    required this.nama,
    required this.nip,
    required this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      username: json['username'] ?? '-',
      nama: json['nama'] ?? '-',
      nip: json['nip'] ?? '-',
      avatar: json['avatar'] ?? '-',
    );
  }
}
