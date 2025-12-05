import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pawlinker/screen/login.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'Pawlinker',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
        home: Login(),
      ),
    ),
  );
}
