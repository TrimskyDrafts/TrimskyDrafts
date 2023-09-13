part of '../tasks_page.dart';

class AddAction extends StatelessWidget {
  const AddAction({super.key, required VoidCallback onTap}) : _onTap = onTap;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: _onTap,
      padding: const EdgeInsets.only(left: 4.0),
      iconSize: 26,
      splashRadius: 16,
    );
  }
}