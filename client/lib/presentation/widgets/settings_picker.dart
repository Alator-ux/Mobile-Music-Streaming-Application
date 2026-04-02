import 'package:flutter/material.dart';

class PickerItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  PickerItem({required this.value, required this.label, this.icon});
}

class SettingsPicker<T> extends StatelessWidget {
  final T initialValue;
  final List<PickerItem<T>> items;
  final String buttonLabel;
  final ValueChanged<T> onSelected;

  const SettingsPicker({
    super.key,
    required this.initialValue,
    required this.items,
    required this.buttonLabel,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      initialValue: initialValue,
      onSelected: onSelected,
      child: Row(
        mainAxisAlignment: .center,
        mainAxisSize: .min,
        children: [Text(buttonLabel), const Icon(Icons.keyboard_arrow_down)],
      ),
      itemBuilder: (context) => items
          .map(
            (item) => PopupMenuItem<T>(
              value: item.value,
              child: Row(
                children: [
                  if (item.icon != null) ...[
                    Icon(item.icon, size: 20),
                    const SizedBox(width: 12),
                  ],
                  Text(item.label),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
