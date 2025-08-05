import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:flutter/material.dart';

class SystemInfo extends StatefulWidget {
  const SystemInfo(
      {required this.title,
      required this.valueText,
      required this.valueText1,
      required this.valueText2,
      required this.valueText3,
      required this.value,
      required this.value1,
      required this.value2,
      required this.value3,
      super.key});

  final String title;
  final String valueText;
  final String valueText1;
  final String valueText2;
  final String valueText3;
  final String value;
  final String value1;
  final String value2;
  final String value3;

  @override
  State<SystemInfo> createState() => _SystemInfoState();
}

class _SystemInfoState extends State<SystemInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205.w,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 11.h,
              left: 22.w,
              bottom: 6.h,
            ),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4.w,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.sp,
                      color: Theme.of(context).colorScheme.onError,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InfoItem(valueText: widget.valueText, value: widget.value),
          InfoItem(valueText: widget.valueText1, value: widget.value1),
          InfoItem(valueText: widget.valueText2, value: widget.value2),
          InfoItem(
              valueText: widget.valueText3, value: widget.value3, isLast: true)
        ],
      ),
    );
  }
}

class InfoItem extends StatefulWidget {
  const InfoItem(
      {required this.valueText,
      required this.value,
      this.isLast = false,
      super.key});

  final String valueText;
  final String value;
  final bool isLast;

  @override
  State<InfoItem> createState() => _InfoItemState();
}

class _InfoItemState extends State<InfoItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
            bottom: 15.h,
            top: 15.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Text(widget.valueText,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                        fontSize: 8.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5)),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Text(widget.value,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onError,
                        fontSize: 8.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.5)),
              ),
            ],
          ),
        ),
        widget.isLast
            ? Container()
            : Padding(
                padding: EdgeInsets.only(
                  left: 13.w,
                  right: 13.w,
                ),
                child: Divider(
                    height: 1, color: Theme.of(context).colorScheme.secondary),
              ),
      ],
    );
  }
}
