import 'package:material_ui/material_ui.dart';

// Satu-satunya warna yang ditulis langsung; semua warna lain turunan tema.
const Color _warnaDasar = Color(0xFFB5451B);

void main() => runApp(const MenuUmkmApp());

class MenuUmkmApp extends StatelessWidget {
  const MenuUmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu UMKM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _warnaDasar),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _warnaDasar,
          brightness: Brightness.dark,
        ),
      ),
      home: const HalamanMenu(),
    );
  }
}

class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu UMKM')),
      body: const Center(child: Text('Halo')),
    );
  }
}
