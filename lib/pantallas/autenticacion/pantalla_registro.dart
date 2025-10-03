import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/usuarios_provider.dart';

class PantallaRegistro extends StatefulWidget {
  const PantallaRegistro({super.key});

  @override
  State<PantallaRegistro> createState() => _PantallaRegistroState();
}

class _PantallaRegistroState extends State<PantallaRegistro> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Expresión regular mejorada para correos válidos
  final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"
  );

  void registrarUsuario() {
    if (!_formKey.currentState!.validate()) return;

    final nombre = nombreController.text.trim();
    final correo = emailController.text.trim();
    final contrasena = passwordController.text.trim();

    final usuariosProvider = Provider.of<UsuariosProvider>(context, listen: false);

    final exito = usuariosProvider.registrarUsuario(nombre, correo, contrasena);
    if (exito) {
      Navigator.pushReplacementNamed(context, '/registroExitoso');
    } else {
      mostrarMensaje(context, 'El correo ya está registrado.');
    }
  }

  void mostrarMensaje(BuildContext context, String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Información'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(child: Image.asset('assets/images/logo_adoptly.png', height: 100)),
                const SizedBox(height: 20),
                const Text("Crear una cuenta", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 30),

                const Align(alignment: Alignment.centerLeft, child: Text("Nombre y Apellido")),
                TextFormField(
                  controller: nombreController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
                    if (value.trim().length < 3) return 'Debe tener al menos 3 caracteres';
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Correo Electrónico")),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
                    if (!emailRegExp.hasMatch(value.trim())) return 'Correo inválido';
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Contraseña")),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
                    if (value.length < 8) return 'Debe tener al menos 8 caracteres';
                    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Debe contener al menos una mayúscula';
                    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Debe contener al menos una minúscula';
                    if (!RegExp(r'\d').hasMatch(value)) return 'Debe contener al menos un número';
                    if (!RegExp(r'[@$!%*?&]').hasMatch(value)) return 'Debe contener al menos un carácter especial';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                const Align(alignment: Alignment.centerLeft, child: Text("Confirmar contraseña")),
                TextFormField(
                  controller: confirmController,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Confirma tu contraseña';
                    if (value != passwordController.text) return 'Las contraseñas no coinciden';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '••••••••',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: registrarUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 76, 172, 175),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text("Registrarse", style: TextStyle(fontSize: 16, color: Colors.black)),
                ),

                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text("¿Ya tienes cuenta? Iniciar sesión"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
