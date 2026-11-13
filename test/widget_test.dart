import 'package:flutter_test/flutter_test.dart';
import 'package:pm_tugas05_4242550001/main.dart';

void main() {
  testWidgets('Aplikasi menampilkan halaman menu', (tester) async {
    await tester.pumpWidget(const MenuUmkmApp());
    expect(find.text('Halo'), findsOneWidget);
  });
}
