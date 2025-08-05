import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  const BaseContainer({required this.child, super.key});

  final Widget child;

  @override
  State<BaseContainer> createState() => BaseContainerState();
}

class BaseContainerState extends State<BaseContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
