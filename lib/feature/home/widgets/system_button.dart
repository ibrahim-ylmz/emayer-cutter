import 'package:flutter/material.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';

class SystemButton extends StatefulWidget {
  const SystemButton({
    super.key,
    required this.value,
    required this.onToggle,
    this.title,
    this.activeColor = const Color.fromRGBO(246, 246, 246, 1),
    this.inactiveColor = const Color.fromRGBO(246, 246, 246, 1),
    this.activeTextColor = const Color.fromRGBO(147, 147, 147, 1),
    this.inactiveTextColor = const Color.fromRGBO(147, 147, 147, 1),
    this.toggleColor = Colors.white,
    this.activeToggleColor = const Color.fromRGBO(0, 187, 97, 1),
    this.inactiveToggleColor = const Color.fromRGBO(239, 51, 51, 1),
    this.width,
    this.height,
    this.toggleSize,
    this.borderRadius,
    this.padding = 5,
    this.activeText = 'ON',
    this.inactiveText = 'OFF',
    required this.activeIcon,
    required this.inactiveIcon,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
    this.textSize,
  });

  final bool value;
  final ValueChanged<bool> onToggle;
  final String? title;
  final String? activeText;
  final String? inactiveText;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double? width;
  final double? height;
  final double? toggleSize;
  final double? borderRadius;
  final double padding;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Duration duration;
  final bool disabled;
  final double? textSize;

  @override
  State<SystemButton> createState() => _FlutterSwitchState();
}

class _FlutterSwitchState extends State<SystemButton>
    with SingleTickerProviderStateMixin {
  late final Animation _toggleAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SystemButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value == widget.value) return;

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color toggleColor = Colors.white;

    if (widget.value) {
      toggleColor = widget.activeToggleColor ?? widget.toggleColor;
    } else {
      toggleColor = widget.inactiveToggleColor ?? widget.toggleColor;
    }

    double textSpace = (widget.width ?? 70.w) -
        (widget.toggleSize ?? 26.w) -
        4;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title ?? "",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18.sp,
              color: Theme.of(context).colorScheme.onError,
              fontWeight: FontWeight.w100,
              // color: widget.value
              //     ? const Color.fromRGBO(33, 184, 48, 1)
              //     : const Color.fromRGBO(239, 51, 51, 1),
              letterSpacing: 0.5,
            )),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Align(
              child: GestureDetector(
                onTap: () {
                  if (!widget.disabled) {
                    if (widget.value) {
                      _animationController.forward();
                    } else {
                      _animationController.reverse();
                    }
            
                    widget.onToggle(!widget.value);
                  }
                },
                child: Opacity(
                  opacity: widget.disabled ? 0.6 : 1,
                  child: Container(
                    width: widget.width ?? 88.w,
                    height: widget.height ?? 40.h,
                    padding: EdgeInsets.all(widget.padding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 20.r,
                      ),
                      // color: switchColor,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Stack(
                      children: <Widget>[
                        AnimatedOpacity(
                          opacity: widget.value ? 1.0 : 0.0,
                          duration: widget.duration,
                          child: Container(
                            width: textSpace,
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            alignment: Alignment.center,
                            child: _activeText,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedOpacity(
                            opacity: !widget.value ? 1.0 : 0.0,
                            duration: widget.duration,
                            child: Container(
                              width: textSpace,
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                              ),
                              alignment: Alignment.center,
                              child: _inactiveText,
                            ),
                          ),
                        ),
                        Align(
                          alignment: _toggleAnimation.value,
                          child: AnimatedContainer(
                              duration: widget.duration,
                              width: widget.toggleSize ?? 32.w,
                              height: widget.toggleSize ?? 32.w,
                              padding: EdgeInsets.all(3.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: toggleColor,
                              ),
                              child: Center(
                                child: widget.value
                                    ? widget.activeIcon
                                    : widget.inactiveIcon,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget get _activeText {
    return Text(
      widget.activeText ?? "ON",
      style: TextStyle(
        // color: const Color.fromRGBO(147, 147, 147, 1),
        color: Theme.of(context).colorScheme.tertiary,
        fontFamily: 'Roboto',
        fontSize: widget.textSize ?? 11.sp,
      ),
    );
  }

  Widget get _inactiveText {
    return Text(
      widget.inactiveText ?? "OFF",
      style: TextStyle(
        color: Theme.of(context).colorScheme.tertiary,
        fontFamily: 'Roboto',
        fontSize: widget.textSize ?? 11.sp,
      ),
    );
  }
}
