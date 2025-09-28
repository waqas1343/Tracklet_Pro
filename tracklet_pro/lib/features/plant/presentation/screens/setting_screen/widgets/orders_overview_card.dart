import 'package:flutter/material.dart';

class OrdersOverviewCard extends StatelessWidget {
  final String title;
  final String period;
  final List<int> data;
  final int highlightIndex;
  final ValueChanged<String> onPeriodChanged;
  const OrdersOverviewCard({
    super.key,
    required this.title,
    required this.period,
    required this.data,
    required this.highlightIndex,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryDark = const Color(0xff1f3f6a);
    final labels = const ['MON','TUE','WED','THU','FRI','SAT','SUN'];
    final maxY = (data.isEmpty ? 0 : data.reduce((a,b) => a > b ? a : b)).toDouble() + 10;
    final yTicks = const [60, 50, 40, 30];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: period,
                  items: const [
                    DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                    DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                    DropdownMenuItem(value: 'Yearly', child: Text('Yearly')),
                  ],
                  onChanged: (v) => v == null ? null : onPeriodChanged(v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 180,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Y-axis labels
                SizedBox(
                  width: 28,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: yTicks
                        .map((v) => Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                v.toString(),
                                style: const TextStyle(fontSize: 10, color: Colors.black54),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 8),

                // Chart area with grid + bars
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          // Grid lines
                          Positioned.fill(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                yTicks.length,
                                (index) => Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                          // Bars
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (int i = 0; i < data.length; i++) ...[
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        if (i == highlightIndex)
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: primaryDark,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              data[i].toString(),
                                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        const SizedBox(height: 4),
                                        Flexible(
                                          child: Container(
                                            width: 16,
                                            height: maxY == 0 ? 0 : (data[i] / maxY) * 120,
                                            decoration: BoxDecoration(
                                              color: i == highlightIndex ? primaryDark : primaryDark.withOpacity(0.15),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(labels[i], style: const TextStyle(fontSize: 10, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
