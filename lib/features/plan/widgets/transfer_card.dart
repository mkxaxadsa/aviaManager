import 'package:flutter/cupertino.dart';

import '../../../core/config/app_colors.dart';

class TransferCard extends StatefulWidget {
  const TransferCard({
    super.key,
    required this.expanded,
    required this.transfer,
  });

  final bool expanded;
  final String transfer;

  @override
  State<TransferCard> createState() => _TransferCardState();
}

class _TransferCardState extends State<TransferCard> {
  bool expanded = false;
  String transfer = '...';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: expanded ? 180 : 126,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.grey8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer',
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          const Text(
            'Do you need a transfer?',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _TransferButton(
            title: expanded ? 'Yes' : transfer,
            onPressed: () {
              if (expanded) {
                setState(() {
                  transfer = 'Yes';
                  expanded = false;
                });
              } else {
                setState(() {
                  expanded = true;
                });
              }
            },
          ),
          if (expanded) ...[
            const SizedBox(height: 8),
            _TransferButton(
              title: 'No',
              onPressed: () {
                setState(() {
                  transfer = 'No';
                  expanded = false;
                });
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _TransferButton extends StatelessWidget {
  const _TransferButton({
    required this.title,
    this.expanded = false,
    required this.onPressed,
  });

  final String title;
  final bool expanded;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.grey8,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.grey40,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
