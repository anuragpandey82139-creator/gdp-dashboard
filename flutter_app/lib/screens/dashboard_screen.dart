import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _metrics = [
    _Metric(
      label: 'GDP tracked',
      value: '\$2.84T',
      change: '+4.2%',
      icon: Icons.public_rounded,
      color: Color(0xFF2864D8),
    ),
    _Metric(
      label: 'Active shipments',
      value: '1,284',
      change: '+8.1%',
      icon: Icons.local_shipping_outlined,
      color: Color(0xFF138A72),
    ),
    _Metric(
      label: 'On-time delivery',
      value: '96.8%',
      change: '+1.6%',
      icon: Icons.schedule_rounded,
      color: Color(0xFF7652C7),
    ),
    _Metric(
      label: 'In transit',
      value: '342',
      change: '28 arriving today',
      icon: Icons.route_rounded,
      color: Color(0xFFD18626),
    ),
  ];

  static const _shipments = [
    _Shipment('SH-2048', 'Shanghai, CN', 'Los Angeles, US', 'In transit', 0.72),
    _Shipment('SH-2047', 'Hamburg, DE', 'Rotterdam, NL', 'On schedule', 0.48),
    _Shipment('SH-2046', 'Mumbai, IN', 'Singapore, SG', 'Customs', 0.89),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1320),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeading(context),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 1000
                      ? 4
                      : constraints.maxWidth >= 650
                          ? 2
                          : 1;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _metrics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: 142,
                    ),
                    itemBuilder: (context, index) =>
                        _MetricCard(metric: _metrics[index]),
                  );
                },
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 760) {
                    return const Column(
                      children: [
                        _ActivityCard(),
                        SizedBox(height: 16),
                        _RegionalCard(),
                      ],
                    );
                  }
                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _ActivityCard()),
                      SizedBox(width: 16),
                      Expanded(flex: 2, child: _RegionalCard()),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildShipments(context),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Sample dashboard data | Connect your data source to see live metrics',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFF8290A3)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 12,
      spacing: 16,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good morning, Alex', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 5),
            const Text('Here is your global operations snapshot.'),
          ],
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.calendar_today_outlined, size: 17),
          label: const Text('Last 30 days'),
        ),
      ],
    );
  }

  Widget _buildShipments(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Recent shipments',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('View all')),
              ],
            ),
            const SizedBox(height: 4),
            for (var index = 0; index < _shipments.length; index++) ...[
              _ShipmentRow(shipment: _shipments[index]),
              if (index != _shipments.length - 1)
                const Divider(height: 1, indent: 54),
            ],
          ],
        ),
      ),
    );
  }
}

class _Metric {
  const _Metric({
    required this.label,
    required this.value,
    required this.change,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final String change;
  final IconData icon;
  final Color color;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.metric});

  final _Metric metric;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(metric.label)),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: metric.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(metric.icon, size: 18, color: metric.color),
                ),
              ],
            ),
            const Spacer(),
            Text(
              metric.value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 25),
            ),
            const SizedBox(height: 4),
            Text(
              metric.change,
              style: TextStyle(
                fontSize: 12,
                color: metric.change.startsWith('+')
                    ? const Color(0xFF138A72)
                    : const Color(0xFF59677B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard();

  static const _series = [
    0.24,
    0.32,
    0.28,
    0.44,
    0.4,
    0.54,
    0.49,
    0.68,
    0.63,
    0.81,
    0.76,
    0.94,
  ];
  static const _months = ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Global trade activity', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            const Text('Monthly index - 2025'),
            const SizedBox(height: 24),
            SizedBox(
              height: 156,
              width: double.infinity,
              child: CustomPaint(
                painter: _ActivityChartPainter(
                  values: _series,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _months
                  .map((month) => Text(month, style: const TextStyle(fontSize: 11)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityChartPainter extends CustomPainter {
  const _ActivityChartPainter({required this.values, required this.color});

  final List<double> values;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFEAEFF5)
      ..strokeWidth = 1;
    for (var row = 0; row < 4; row++) {
      final y = size.height * row / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final points = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(
          size.width * i / (values.length - 1),
          size.height * (1 - values[i]),
        ),
    ];
    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final middleX = (previous.dx + current.dx) / 2;
      line.cubicTo(middleX, previous.dy, middleX, current.dy, current.dx, current.dy);
    }

    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.01)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
    for (final point in [points.first, points.last]) {
      canvas.drawCircle(point, 4, Paint()..color = color);
      canvas.drawCircle(
        point,
        7,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ActivityChartPainter oldDelegate) {
    return oldDelegate.values != values || oldDelegate.color != color;
  }
}

class _RegionalCard extends StatelessWidget {
  const _RegionalCard();

  static const _regions = [
    ('North America', 0.82, '82%'),
    ('Europe', 0.68, '68%'),
    ('Asia Pacific', 0.56, '56%'),
    ('Latin America', 0.39, '39%'),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Regional volume', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            const Text('Share of tracked trade'),
            const SizedBox(height: 22),
            for (final region in _regions) ...[
              Row(
                children: [
                  Expanded(child: Text(region.$1)),
                  Text(
                    region.$3,
                    style: const TextStyle(
                      color: Color(0xFF142B4A),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: LinearProgressIndicator(
                  value: region.$2,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFEDF1F6),
                ),
              ),
              const SizedBox(height: 17),
            ],
          ],
        ),
      ),
    );
  }
}

class _Shipment {
  const _Shipment(
    this.id,
    this.origin,
    this.destination,
    this.status,
    this.progress,
  );

  final String id;
  final String origin;
  final String destination;
  final String status;
  final double progress;
}

class _ShipmentRow extends StatelessWidget {
  const _ShipmentRow({required this.shipment});

  final _Shipment shipment;

  @override
  Widget build(BuildContext context) {
    final color = shipment.status == 'Customs'
        ? const Color(0xFFD18626)
        : const Color(0xFF138A72);
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 620;
        final details = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(shipment.id, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 3),
            Text(
              '${shipment.origin} to ${shipment.destination}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        );
        final status = Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            shipment.status,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
        final progress = LinearProgressIndicator(
          value: shipment.progress,
          minHeight: 6,
          backgroundColor: const Color(0xFFEDF1F6),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  size: 20,
                  color: Color(0xFF2864D8),
                ),
              ),
              const SizedBox(width: 12),
              if (compact)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: details),
                          const SizedBox(width: 8),
                          status,
                        ],
                      ),
                      const SizedBox(height: 12),
                      progress,
                    ],
                  ),
                )
              else ...[
                Expanded(flex: 2, child: details),
                const SizedBox(width: 16),
                Expanded(flex: 2, child: progress),
                const SizedBox(width: 16),
                status,
              ],
            ],
          ),
        );
      },
    );
  }
}
