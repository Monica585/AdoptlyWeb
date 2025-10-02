import 'package:flutter/material.dart';


class PantallaEntradaAutenticacion extends StatelessWidget {
  const PantallaEntradaAutenticacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              Image.asset(
                'assets/images/perrito_gatito_inicio.png',
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 40),

              const Text(
                "Tu compañero ideal te está esperando",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // Espacio extra entre el texto y los botones
              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Iniciar sesión", style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 20),

              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black26),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Registrarse", style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
