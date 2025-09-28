import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Dialog state for Download Report
class DownloadReportDialogModel extends ChangeNotifier {
  bool isDaily = true;
  DateTime selectedDate = DateTime.now();

  void toggle(bool daily) {
    if (isDaily == daily) return;
    isDaily = daily;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}

/// Result returned from the dialog
class DownloadReportResult {
  final bool isDaily;
  final DateTime date;
  const DownloadReportResult({required this.isDaily, required this.date});
}

/// Public helper to show the dialog and get the result
Future<DownloadReportResult?> showDownloadReportDialog(BuildContext context) {
  return showDialog<DownloadReportResult>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return ChangeNotifierProvider(
        create: (_) => DownloadReportDialogModel(),
        child: const _DownloadReportDialog(),
      );
    },
  );
}

class _DownloadReportDialog extends StatelessWidget {
  const _DownloadReportDialog();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.watch<DownloadReportDialogModel>();
    final primaryDark = const Color(0xff1f3f6a);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'Download Report',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Center(
              child: Text(
                'Select Date Range for Orders History',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Toggle: Daily / Custom
            Row(
              children: [
                _PillToggle(
                  text: 'Daily',
                  isActive: model.isDaily,
                  onTap: () => model.toggle(true),
                  activeColor: primaryDark,
                ),
                const SizedBox(width: 10),
                _PillToggle(
                  text: 'Custom',
                  isActive: !model.isDaily,
                  onTap: () => model.toggle(false),
                  activeColor: primaryDark,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date selector label
            Text(
              'Select Date:',
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 8),

            // Date field (readOnly)
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: model.selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) model.setDate(picked);
              },
              child: AbsorbPointer(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: _formatDate(model.selectedDate),
                    hintStyle: const TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    suffixIcon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryDark, width: 1.5),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Actions: Cancel / Export Report
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(null),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      side: BorderSide(color: Colors.grey.shade400),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(
                        DownloadReportResult(isDaily: model.isDaily, date: model.selectedDate),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryDark,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    child: const Text('Export Report'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // e.g., 27-Sep-25
    const months = [
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final dd = date.day.toString().padLeft(2, '0');
    final mmm = months[date.month - 1];
    final yy = (date.year % 100).toString().padLeft(2, '0');
    return '$dd-$mmm-$yy';
  }
}

class _PillToggle extends StatelessWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  const _PillToggle({
    required this.text,
    required this.isActive,
    required this.onTap,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
