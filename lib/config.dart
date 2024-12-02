class Config {
  // URL dasar API
  static const String baseUrl = 'http://172.16.14.81:8000';

  // Endpoint untuk login
  static const String loginEndpoint = '$baseUrl/api/login';

  // Endpoint untuk mendapatkan data user
  static const String userEndpoint = '$baseUrl/api/user';

  // Endpoint untuk dashboard
  static const String dashboardEndpoint = '$baseUrl/api/dashboard';

  // Endpoint untuk dashboard
  static const String dashboar2dEndpoint = '$baseUrl/api/dashboard2';

  static const String dosenProfile = '$baseUrl/api/profiledosen';

  // Endpoint untuk mendapatkan semua data
  static const String listAllDataEndpoint = '$baseUrl/api/listData';

  static const String Profile = '$baseUrl/api/profile';

  static const String detailSertifikasiEndpoint =
      '$baseUrl/api/sertifikasi/show';
  static const String detailPelatihanEndpoint =
      '$baseUrl/api/pelatihan/show';

}
