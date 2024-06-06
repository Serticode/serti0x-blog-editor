import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runApp(
    const ProviderScope(
      child: Serti0xBlogEditor(),
    ),
  );
}

class Serti0xBlogEditor extends StatelessWidget {
  const Serti0xBlogEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Serti0x Blog Editor",
          ),
        ),
      ),
    );
  }
}
