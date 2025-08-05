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
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: MediaQuery.of(context).size.width * 0.19,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.015,
        ),
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
              top: screenWidth * 0.010,
              left: screenWidth * 0.02,
              bottom: screenWidth * 0.006,
            ),
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.004,
                  height: screenWidth * 0.004,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.004,
                  ),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      // fontSize: 24,
                      fontSize: MediaQuery.of(context).size.width * 0.015,
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
            // left: 55,
            left: MediaQuery.of(context).size.width * 0.028,
            // right: 55,
            right: MediaQuery.of(context).size.width * 0.028,
            // bottom: 10,
            bottom: MediaQuery.of(context).size.height * 0.008,
            // top: 10,
            top: MediaQuery.of(context).size.height * 0.008,
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
                        // fontSize: 15,
                        fontSize: MediaQuery.of(context).size.width * 0.008,
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
                        // fontSize: 15,
                        fontSize: MediaQuery.of(context).size.width * 0.0078,
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
                  // left: 23,
                  left: MediaQuery.of(context).size.width * 0.012,
                  // right: 23,
                  right: MediaQuery.of(context).size.width * 0.012,
                ),
                child: Divider(
                    height: 1, color: Theme.of(context).colorScheme.secondary),
              ),
      ],
    );
  }
}
