import 'package:emayer_cutter/feature/system/system_notifier.dart';
import 'package:emayer_cutter/feature/system/system_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin SystemScreenMixin on State<SystemScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SystemNotifier>(context, listen: false).getSystemStatus();
    Provider.of<SystemNotifier>(context, listen: false).statusValue();
  }
}
