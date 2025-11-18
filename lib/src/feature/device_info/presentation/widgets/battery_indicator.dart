import 'package:flutter/material.dart';

class BatteryIndicator extends StatelessWidget {
  final int batteryLevel;
  final String batteryStatus;

  const BatteryIndicator({
    super.key,
    required this.batteryLevel,
    required this.batteryStatus,
  });

  Color _getBatteryColor() {
    if (batteryLevel >= 80) return Colors.green;
    if (batteryLevel >= 50) return Colors.amber;
    if (batteryLevel >= 20) return Colors.orange;
    return Colors.red;
  }

  IconData _getBatteryIcon() {
    if (batteryLevel >= 80) return Icons.battery_full;
    if (batteryLevel >= 50) return Icons.battery_5_bar;
    if (batteryLevel >= 20) return Icons.battery_3_bar;
    return Icons.battery_0_bar;
  }

  String _getStatusLabel() {
    switch (batteryStatus) {
      case 'charging':
        return 'Charging';
      case 'discharging':
        return 'Discharging';
      case 'full':
        return 'Fully Charged';
      case 'not_charging':
        return 'Not Charging';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final batteryColor = _getBatteryColor();
    final batteryIcon = _getBatteryIcon();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Battery Status',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: batteryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: batteryColor, width: 1.5),
                  ),
                  child: Text(
                    _getStatusLabel(),
                    style: TextStyle(
                      color: batteryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(batteryIcon, size: 48, color: batteryColor),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Battery Level',
                        style: Theme.of(
                          context,
                        ).textTheme.labelSmall?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$batteryLevel%',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              color: batteryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: batteryLevel / 100,
                minHeight: 8,
                backgroundColor: batteryColor.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(batteryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
