class RoleModel {
  final int roleId;
  final String roleKode;
  final String roleNama;

  RoleModel({
    required this.roleId,
    required this.roleKode,
    required this.roleNama,
  });

  // Membuat factory method untuk memparsing JSON
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      roleId: json['role_id'] ?? 0,
      roleKode: json['role_kode'] ?? '',
      roleNama: json['role_nama'] ?? '',
    );
  }

  // Untuk konversi objek RoleModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'role_kode': roleKode,
      'role_nama': roleNama,
    };
  }

  // Method untuk mendapatkan role name jika diperlukan
  String getRoleName() {
    return roleNama;
  }
}
