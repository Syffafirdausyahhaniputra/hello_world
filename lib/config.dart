class Config {
  // URL dasar API

  static const String baseUrl = 'http://103.126.226.59';

  // Endpoint untuk login
  static const String loginEndpoint = '$baseUrl/api/login';

  // Endpoint untuk mendapatkan data user
  static const String userEndpoint = '$baseUrl/api/user';

  // Endpoint untuk dashboard
  static const String dashboardEndpoint = '$baseUrl/api/dashboard';

  // Endpoint untuk dashboard
  static const String dashboar2dEndpoint = '$baseUrl/api/dashboard2';

  // Endpoint untuk mendapatkan data dosen
  static const String dosenProfile = '$baseUrl/api/profiledosen';

  // Endpoint untuk mendapatkan semua data
  static const String listAllDataEndpoint = '$baseUrl/api/listData';

  static const String profile = '$baseUrl/api/profile';

  static const String detailSertifikasiEndpoint =
      '$baseUrl/api/sertifikasi/show';
  static const String detailPelatihanEndpoint = '$baseUrl/api/pelatihan/show';

  // kompetensi prodi
  static const String kompetensiList = '$baseUrl/api/kompetensi/list';
  static const String kompetensiEndpoint =
      '$baseUrl/api/kompetensi/{prodi_kode}/show_ajax';
  static const String kompetensi = '$baseUrl/api/kompetensi';

  static const String inputPelatihan = '$baseUrl/api/pelatihan/create';
  static const String inputpelatihan = '$baseUrl/api/pelatihan/store';

  // Endpoint untuk mendapatkan data bidang
  static const String bidangList = '$baseUrl/api/bidang';

  // Endpoint untuk mendapatkan data matkul
  static const String matkulList = '$baseUrl/api/matakuliah';

  static const String detailBidang = '$baseUrl/api/bidang/show';
  static const String detailBidangDosen = '$baseUrl/api/bidang/infodosen';

  static const String golonganList = '$baseUrl/api/golongan';
  static const String pangkatList = '$baseUrl/api/pangkat';
  static const String jabatanList = '$baseUrl/api/jabatan';
}
