import 'package:material_ui/material_ui.dart';

// Satu-satunya warna yang ditulis langsung: seed color (sesuai spesifikasi #1).
const Color _warnaDasar = Color.fromARGB(99, 230, 81, 0);

const String _urlGambar = 'https://picsum.photos/800/400';

void main() => runApp(const MenuUmkmApp());

/// Data satu menu. Immutable, jadi cocok dibuat const.
class Menu {
  const Menu({required this.nama, required this.harga, required this.kategori});

  final String nama;
  final int harga;
  final String kategori;
}

const List<Menu> daftarMenu = [
  Menu(nama: 'Birthday Cake', harga: 150000, kategori: 'Cake'),
  Menu(nama: 'Donat', harga: 10000, kategori: 'Bread'),
  Menu(nama: 'Cookies', harga: 15000, kategori: 'Cookies'),
  Menu(nama: 'Brownies', harga: 45000, kategori: 'Cake'),
  Menu(nama: 'Croissant', harga: 22000, kategori: 'Pastry'),
];


/// Mengubah 25000 menjadi "Rp 25.000".
String formatRupiah(int angka) {
  final titik = angka.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (_) => '.',
  );
  return 'Rp $titik';
}

// ---------------------------------------------------------------------------
// STATELESS: akar aplikasi. Hanya mengatur tema, tidak punya data yang berubah.
// ---------------------------------------------------------------------------
class MenuUmkmApp extends StatelessWidget {
  const MenuUmkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu UMKM Kuliner Medan',
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
      themeMode: ThemeMode.system,
      home: const HalamanMenu(),
    );
  }
}

// ---------------------------------------------------------------------------
// STATELESS: seluruh halaman. Tidak ada data yang berubah di level ini;
// bagian yang berubah (favorit) diisolasi di TombolFavorit.
// ---------------------------------------------------------------------------
class HalamanMenu extends StatelessWidget {
  const HalamanMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bakery N Pastry')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const KepalaUsaha(),
            const SizedBox(height: 16),
            const BagianKontak(),
            const SizedBox(height: 24),
            Text('Daftar Menu', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            for (final menu in daftarMenu)
              KartuMenu(
                nama: menu.nama,
                harga: menu.harga,
                kategori: menu.kategori,
              ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// STATELESS: kepala halaman (gambar, nama usaha, deskripsi).
// ---------------------------------------------------------------------------
class KepalaUsaha extends StatelessWidget {
  const KepalaUsaha({super.key});

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: Image.network(
              _urlGambar,
              fit: BoxFit.cover,
              // Jika gambar gagal dimuat (offline/URL salah), tampilkan ikon.
              errorBuilder: (context, error, stackTrace) => ColoredBox(
                color: skema.surfaceContainerHighest,
                child: Icon(
                  Icons.restaurant,
                  size: 64,
                  color: skema.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text('Bakery N Pastry', style: teks.headlineSmall),
        const SizedBox(height: 4),
        Text(
          'Aneka roti dan pastry hangat dengan resep keluarga. '
              'Tekstur lembut dengan isian melimpah, harga tetap ramah di kantong mahasiswa.',
          style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// STATELESS: kontak (Card + ListTile) dan tombol aksi.
// ---------------------------------------------------------------------------
class BagianKontak extends StatelessWidget {
  const BagianKontak({super.key});

  void _info(BuildContext context, String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.phone_outlined),
                title: Text('+62 812-0000-0000'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.location_on_outlined),
                title: Text('Jl. Willem Iskandar No. 10, Medan'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.schedule_outlined),
                title: Text('Buka setiap hari, 07.00 - 21.00'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.icon(
              onPressed: () => _info(context, 'Membuka WhatsApp...'),
              icon: const Icon(Icons.chat),
              label: const Text('Pesan'),
            ),
            OutlinedButton.icon(
              onPressed: () => _info(context, 'Membuka peta...'),
              icon: const Icon(Icons.map_outlined),
              label: const Text('Lokasi'),
            ),
            TextButton(
              onPressed: () => _info(context, 'Membagikan menu...'),
              child: const Text('Bagikan'),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// STATELESS: kartu satu menu (spesifikasi #3).
// Tampilannya hanya bergantung pada parameter dari luar.
// ---------------------------------------------------------------------------
class KartuMenu extends StatelessWidget {
  const KartuMenu({
    super.key,
    required this.nama,
    required this.harga,
    required this.kategori,
  });

  final String nama;
  final int harga;
  final String kategori;

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nama, style: teks.titleMedium),
                  const SizedBox(height: 4),
                  Text(formatRupiah(harga), style: teks.bodyMedium),
                  const SizedBox(height: 8),
                  Chip(label: Text(kategori)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}