import 'package:flutter/material.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 100, color: Colors.indigo),
          SizedBox(height: 12),
          Text(
            'Michael Danies Manurung',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('NIM: 42325015'),
        ],
      ),
    );
  }
}