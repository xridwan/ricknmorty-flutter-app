import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const routeName = '/setting_page';

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const Center(
        child: Text('Update Version'),
      ),
    );
  }
}
