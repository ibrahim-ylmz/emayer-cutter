// import 'dart:async';

// import 'package:emayer_application/future/dashboard/dashboard_notifier.dart';
// import 'package:emayer_application/future/home/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// mixin HomeScreenMixin on State<HomeScreen> {
//   Timer? _connectionCheckTimer;
//   late DashBoardNotifier _dashboardNotifier;

//   @override
//   void initState() {
//     super.initState();

//     // Dashboard notifier'ını al
//     _dashboardNotifier = Provider.of<DashBoardNotifier>(context, listen: false);

//     // Socket bağlantısını başlat
//     _initializeSocket();

//     // Bağlantıyı periyodik olarak kontrol et
//     _startConnectionWatcher();
//   }

//   void _initializeSocket() {
//     // Socket bağlantısını başlat
//     _dashboardNotifier.initializeSocket();
//   }

//   void _startConnectionWatcher() {
//     // Her 10 saniyede bir bağlantıyı kontrol et
//     _connectionCheckTimer = Timer.periodic(const Duration(seconds: 10), (_) {
//       _checkSocketConnection();
//     });
//   }

//   void _checkSocketConnection() {
//     // Bağlantı yoksa yeniden bağlanmayı dene
//     if (!_dashboardNotifier.isSocketConnected) {
//       _dashboardNotifier.reconnectSocket();
//     }
//   }

//   @override
//   void dispose() {
//     // Timer'ı durdur
//     _connectionCheckTimer?.cancel();
//     super.dispose();
//   }
// }
