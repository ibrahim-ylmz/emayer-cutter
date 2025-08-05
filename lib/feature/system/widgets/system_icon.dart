import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SystemIcon extends StatelessWidget {
  const SystemIcon({
    required this.isActive,
    required this.svgIconPath,
    required this.onTap,
    super.key,
  });

  final bool isActive;
  final String svgIconPath;
  final ValueChanged<bool> onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!isActive),
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 45.w,
          height: 45.w,
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? const Color.fromRGBO(0, 187, 97, 1)
                : const Color.fromRGBO(233, 233, 233, 1),
          ),
          child: Center(
            child: SvgPicture.asset(
              svgIconPath,
              // ignore: deprecated_member_use
              color: isActive
                  ? Colors.white
                  : const Color.fromRGBO(119, 119, 119, 1),
              height: 30.s,
              width: 30.s,
            ),
          )),
    );
  }
}
