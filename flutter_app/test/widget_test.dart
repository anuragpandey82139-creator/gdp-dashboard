import 'package:flutter_test/flutter_test.dart';
import 'package:gdp_logistics_dashboard/app.dart';

void main() {
  testWidgets(
      'dashboard renders and navigation opens the shipments placeholder',
      (tester) async {
    await tester.pumpWidget(const GdpLogisticsApp());

    expect(find.text('GDP Logistics'), findsOneWidget);
    expect(find.text('GDP tracked'), findsOneWidget);

    await tester.tap(find.text('Shipments').last);
    await tester.pumpAndSettle();

    expect(find.textContaining('Shipment tracking will live here'), findsOneWidget);
    expect(find.text('Starter area'), findsOneWidget);
  });
}
