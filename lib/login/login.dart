import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../Controller/LoginController.dart';
import '../dosen.dart';
import '../pimpinan.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0D47A1),
                  Color(0xFF1565C0),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Enhanced Logo Container
                  Container(
                    width: 200,
                    height: 200,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background with subtle gradient
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Color(0xFFF5F5F5),
                              ],
                            ),
                          ),
                        ),
                        // Logo Image
                        Center(
                          child: Container(
                            width: 250,
                            height: 250,
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              'lib/assets/logo_jti_certify.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // Subtle border highlight
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.8),
                              width: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Title and Subtitle
                  SizedBox(height: 30),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController _loginController = LoginController(Config.baseUrl);
  bool _obscurePassword = true;

  Future<void> _handleLogin(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorSnackbar(context, 'Username dan password wajib diisi');
      return;
    }

    final result = await _loginController.login(username, password);

    if (result['success']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', result['data']['token']);

      int roleId = result['data']['user']['role_id'];
      if (roleId == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PimpinanPage()),
        );
      } else if (roleId == 3) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DosenPage(token: result['data']['token']),
          ),
        );
      } else {
        _showErrorSnackbar(context, 'Role tidak valid');
      }
    } else {
      _showErrorSnackbar(context, result['message'] ?? 'Login gagal');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // JTI Certify Logo
          SizedBox(height: screenHeight * 0.03),
          Container(
            width: screenWidth * 0.85,
            padding: const EdgeInsets.all(20.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'LOGIN',
                  style: GoogleFonts.poppins(
                    color: Color(0xFF0D47A1),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _usernameController,
                  label: 'Username',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _passwordController,
                  label: 'Password',
                  icon: Icons.lock,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword 
                        ? Icons.visibility_off 
                        : Icons.visibility,
                      color: Color(0xFF0D47A1),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFEFB509),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(screenWidth * 0.6, 50),
                  ),
                  onPressed: () {
                    _handleLogin(context);
                  },
                  child: Text(
                    'MASUK',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.montserrat(
          color: Color(0xFF0D47A1),
        ),
        prefixIcon: Icon(
          icon,
          color: Color(0xFF0D47A1),
        ),
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xFF0D47A1),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xFFEFB509),
            width: 2,
          ),
        ),
      ),
    );
  }
}