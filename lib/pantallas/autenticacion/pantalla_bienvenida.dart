import 'package:flutter/material.dart';

class PantallaBienvenida extends StatelessWidget {
  const PantallaBienvenida({super.key});

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

              Expanded(
                flex: 6,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_adoptly.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Título y subtítulo
              const Text(
                "Adoptly",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Conectando huellitas con hogares",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Barra de carga
              SizedBox(
                width: 180,
                child: LinearProgressIndicator(
                  value: 0.33,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: const AlwaysStoppedAnimation<Color>( Colors.black),
                  minHeight: 4,
                ),
              ),
              const SizedBox(height: 20),

              const Spacer(), // empuja el botón abajo

              // Botón siguiente
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/presentacion');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

                ),
                child: const Text(
                  "Siguiente",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
