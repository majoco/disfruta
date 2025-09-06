import 'package:flutter/material.dart';
import 'productPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ Espera 3 segundos y va a ProductPage
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProductPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 Imagen de fondo
          Image.asset(
            "lib/assets/images/portada.png",
            fit: BoxFit.cover,
          ),

          // 🔹 Texto o logo encima
          /*Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.beach_access, size: 80, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  "Bienvenido a Disfruta",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}
