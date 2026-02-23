import 'package:flutter/material.dart';

import '../features/appointments/presentation/screens/appointment_screen.dart';
import '../features/health_logs/presentation/screens/health_logs_screen.dart';
import '../features/medicines/presentation/screens/medicines_screen.dart';
import 'theme.dart';

class HealthCompanionApp extends StatelessWidget {
  const HealthCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Reminder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _screens = [
    MedicinesScreen(),
    HealthLogsScreen(),
    AppointmentScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC78EF8), Color(0xFFD7EAFF), Color(0xFFEFF3F7)],
        ),
      ),
      child: Scaffold(
        extendBody: true,
        body: _screens[_index],
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: NavigationBar(
              selectedIndex: _index,
              backgroundColor: Colors.white.withValues(alpha: 0.82),
              indicatorColor: AppTheme.softViolet,
              onDestinationSelected: (value) => setState(() => _index = value),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_rounded),
                  label: 'Medicines',
                ),
                NavigationDestination(
                  icon: Icon(Icons.calendar_month_rounded),
                  label: 'Health Logs',
                ),
                NavigationDestination(
                  icon: Icon(Icons.event_note_rounded),
                  label: 'Visits',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
