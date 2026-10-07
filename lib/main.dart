import 'package:flutter/material.dart';

void main() {
  runApp(const SaboresMayabApp());
}

class SaboresMayabApp extends StatefulWidget {
  const SaboresMayabApp({super.key});

  @override
  State<SaboresMayabApp> createState() => _SaboresMayabAppState();
}

class _SaboresMayabAppState extends State<SaboresMayabApp> {
  // Estado inicial del idioma (Español por defecto)
  String idiomaActual = 'es'; 
  
  // Estado para el modo de accesibilidad visual
  bool modoAltoContraste = false;

  // Diccionario multilingüe (Español, Inglés y Maya)
  final Map<String, Map<String, String>> textos = {
    'es': {
      'titulo': 'Sabores del Mayab',
      'idioma': 'Idioma',
      'contraste': 'Alto Contraste',
      'exp_1': 'Taller de Cochinita Pibil',
      'exp_2': 'Recorrido del Cacao',
      'hint_tarjeta': 'Toca para ver los detalles de la experiencia',
    },
    'en': {
      'titulo': 'Mayab Flavors',
      'idioma': 'Language',
      'contraste': 'High Contrast',
      'exp_1': 'Cochinita Pibil Workshop',
      'exp_2': 'Cacao Tour',
      'hint_tarjeta': 'Tap to view experience details',
    },
    'myn': { 
      'titulo': "Ki'iki' janal Mayab",
      'idioma': "T'aan",
      'contraste': 'Jach sáasil',
      'exp_1': 'Káanbal Cochinita Pibil',
      'exp_2': 'Xíimbal Cacao',
      'hint_tarjeta': "T'ox utia'al u yila'al u ch'enkanil",
    },
  };

  @override
  Widget build(BuildContext context) {
    // Tema ligero optimizado
    final ThemeData temaNormal = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    );

    // Tema de accesibilidad para personas con debilidad visual
    final ThemeData temaAltoContraste = ThemeData(
      colorScheme: const ColorScheme.highContrastDark(),
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: textos[idiomaActual]!['titulo']!,
      theme: modoAltoContraste ? temaAltoContraste : temaNormal,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: modoAltoContraste 
              ? temaAltoContraste.colorScheme.primary 
              : temaNormal.colorScheme.primary,
          title: Semantics(
            header: true,
            child: Text(
              textos[idiomaActual]!['titulo']!, 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: modoAltoContraste 
                    ? temaAltoContraste.colorScheme.onPrimary 
                    : temaNormal.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // Panel superior con las herramientas de accesibilidad e idioma
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: modoAltoContraste ? Colors.grey[900] : Colors.teal.shade50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Selector de Idiomas (Español, Inglés, Maya)
                  Row(
                    children: [
                      const Icon(Icons.language),
                      const SizedBox(width: 8),
                      DropdownButton<String>(
                        value: idiomaActual,
                        underline: const SizedBox(),
                        items: const [
                          DropdownMenuItem(value: 'es', child: Text('Español')),
                          DropdownMenuItem(value: 'en', child: Text('English')),
                          DropdownMenuItem(value: 'myn', child: Text('Maya')),
                        ],
                        onChanged: (nuevoIdioma) {
                          if (nuevoIdioma != null) {
                            setState(() => idiomaActual = nuevoIdioma);
                          }
                        },
                      ),
                    ],
                  ),
                  // Interruptor de Alto Contraste accesible
                  Row(
                    children: [
                      const Icon(Icons.contrast),
                      const SizedBox(width: 4),
                      Semantics(
                        label: textos[idiomaActual]!['contraste'],
                        toggled: modoAltoContraste,
                        child: Switch(
                          value: modoAltoContraste,
                          onChanged: (valor) {
                            setState(() => modoAltoContraste = valor);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Catálogo de experiencias
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _crearTarjetaExperiencia(
                    textos[idiomaActual]!['exp_1']!, 
                    Icons.restaurant, 
                    modoAltoContraste,
                    textos[idiomaActual]!['hint_tarjeta']!,
                  ),
                  const SizedBox(height: 12),
                  _crearTarjetaExperiencia(
                    textos[idiomaActual]!['exp_2']!, 
                    Icons.eco, 
                    modoAltoContraste,
                    textos[idiomaActual]!['hint_tarjeta']!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget optimizado para crear tarjetas accesibles y reutilizables
  Widget _crearTarjetaExperiencia(
      String titulo, IconData icono, bool altoContraste, String hintText) {
    return Semantics(
      button: true,
      hint: hintText,
      child: Card(
        elevation: altoContraste ? 0 : 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: altoContraste 
            ? const BorderSide(color: Colors.white, width: 2) 
            : BorderSide.none,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: Icon(icono, size: 36),
          title: Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Acción futura
          },
        ),
      ),
    );
  }
}