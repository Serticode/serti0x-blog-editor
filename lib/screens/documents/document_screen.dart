import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentScreen extends ConsumerWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
