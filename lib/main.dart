import 'package:flutter/material.dart';
import 'package:pendataanwarga/providers/berita_panel_provider.dart';
import 'package:pendataanwarga/views/views/login_views.dart';
import 'package:pendataanwarga/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

main(List<String> args) {
  runApp(MultiProvider(
    builder: (context, widget) {
      return const MaterialApp(home: LoginView());
    },
    providers: [
      ChangeNotifierProvider(create: (c) => DashboardProvider()),
      ChangeNotifierProvider(create: (c) => BeritaPanelProvider())
    ],
  ));
}
