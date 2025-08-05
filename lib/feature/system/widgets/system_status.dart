import 'package:emayer_cutter/core/component/base_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusContainer extends StatefulWidget {
  const StatusContainer({
    required this.isPowerOn,
    required this.topTitle,
    required this.infoText,
    required this.infoText1,
    required this.infoValue,
    required this.infoValue1,
    required this.sensor1Text,
    required this.sensor2Text,
    required this.sensor3Text,
    required this.sensor1Status,
    required this.sensor2Status,
    required this.sensor3Status,
    required this.motor1Text,
    required this.motor2Text,
    required this.motor3Text,
    required this.motor1Status,
    required this.motor2Status,
    required this.motor3Status,
    required this.speedIncrease,
    required this.speedDecrease,
    required this.torqueIncrease,
    required this.torqueDecrease,
    super.key,
  });
  final bool isPowerOn;
  final String topTitle;
  final String infoText;
  final String infoText1;
  final int? infoValue;
  final int? infoValue1;
  final String sensor1Text;
  final String sensor2Text;
  final String sensor3Text;
  final bool? sensor1Status;
  final bool? sensor2Status;
  final bool? sensor3Status;
  final String motor1Text;
  final String motor2Text;
  final String motor3Text;
  final bool? motor1Status;
  final bool? motor2Status;
  final bool? motor3Status;
  final VoidCallback speedIncrease;
  final VoidCallback speedDecrease;
  final VoidCallback torqueIncrease;
  final VoidCallback torqueDecrease;

  @override
  State<StatusContainer> createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BaseContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TopTitle(
            title: widget.topTitle,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.009,
              left: screenWidth * 0.017,
              right: screenWidth * 0.017,
              bottom: screenWidth * 0.01,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.sensor1Text,
                  status: widget.sensor1Status,
                ),
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.motor1Text,
                  status: widget.motor1Status,
                ),
              ],
            ),
          ),
          const Dvider(),
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.0068,
              left: screenWidth * 0.017,
              right: screenWidth * 0.017,
              bottom: screenWidth * 0.01,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.sensor2Text,
                  status: widget.sensor2Status,
                ),
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.motor2Text,
                  status: widget.motor2Status,
                ),
              ],
            ),
          ),
          const Dvider(),
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth * 0.0068,
              left: screenWidth * 0.017,
              right: screenWidth * 0.017,
              bottom: screenWidth * 0.01,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.sensor3Text,
                  status: widget.sensor3Status,
                ),
                SystemStatus(
                  isPowerOn: widget.isPowerOn,
                  title: widget.motor3Text,
                  status: widget.motor3Status,
                ),
              ],
            ),
          ),
          const Dvider(),
          Info(
            isPowerOn: widget.isPowerOn,
            title: widget.infoText,
            value: widget.infoValue ?? 0,
            increaseFunction: widget.speedIncrease,
            decreaseFunction: widget.speedDecrease,
          ),
          const Dvider(),
          Info(
            isPowerOn: widget.isPowerOn,
            title: widget.infoText1,
            value: widget.infoValue1 ?? 0,
            increaseFunction: widget.torqueIncrease,
            decreaseFunction: widget.torqueDecrease,
          )
        ],
      ),
    );
  }
}

class Dvider extends StatelessWidget {
  const Dvider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 23, right: 23),
      child: Divider(height: 1, color: Theme.of(context).colorScheme.secondary),
    );
  }
}

class Info extends StatefulWidget {
  const Info({
    required this.title,
    required this.value,
    required this.isPowerOn,
    required this.increaseFunction,
    required this.decreaseFunction,
    super.key,
  });
  final String title;
  final int value;
  final bool isPowerOn;
  final VoidCallback increaseFunction;
  final VoidCallback decreaseFunction;

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        right: screenWidth * 0.017,
        top: screenWidth * 0.005,
        bottom: screenWidth * 0.005,
      ),
      child: Row(
        children: [
          Expanded(
              child: Center(
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onError,
                          fontSize: MediaQuery.of(context).size.width * 0.011,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5)))),
          Expanded(
              child: Row(
            children: [
              IconButton(
                iconSize: MediaQuery.of(context).size.width * 0.022,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  backgroundColor: widget.isPowerOn
                      ? MaterialStateProperty.all(
                          const Color.fromRGBO(0, 187, 97, 1))
                      : MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: widget.isPowerOn ? widget.decreaseFunction : null,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: widget.isPowerOn
                      ? TextEditingController(text: widget.value.toString())
                      : TextEditingController(text: '0'),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: MediaQuery.of(context).size.width * 0.01,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5),
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                iconSize: MediaQuery.of(context).size.width * 0.022,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  backgroundColor: widget.isPowerOn
                      ? MaterialStateProperty.all(
                          const Color.fromRGBO(0, 187, 97, 1))
                      : MaterialStateProperty.all(Colors.grey),
                ),
                onPressed: widget.isPowerOn ? widget.increaseFunction : null,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class TopTitle extends StatelessWidget {
  const TopTitle({
    required this.title,
    super.key,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        top: screenWidth * 0.0125,
        left: screenWidth * 0.0225,
        right: screenWidth * 0.0255,
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.onError,
            maxRadius: MediaQuery.of(context).size.width * 0.0021,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: MediaQuery.of(context).size.width * 0.014,
              color: Theme.of(context).colorScheme.onError,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class SystemStatus extends StatefulWidget {
  const SystemStatus({
    required this.title,
    required this.status,
    required this.isPowerOn,
    super.key,
  });

  final String? title;
  final bool? status;
  final bool isPowerOn;

  @override
  State<SystemStatus> createState() => SystemStatusState();
}

class SystemStatusState extends State<SystemStatus> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 128,
        width: MediaQuery.of(context).size.width * 0.07,
        // height: 30,
        height: MediaQuery.of(context).size.height * 0.03,
        decoration: BoxDecoration(
          color: widget.isPowerOn
              ? widget.status!
                  ? const Color.fromRGBO(0, 187, 97, 1)
                  : const Color.fromRGBO(242, 61, 61, 1)
              : Colors.grey,
          borderRadius: BorderRadius.circular(
            // 10
            MediaQuery.of(context).size.width * 0.005,
          ),
        ),
        child: Center(
          child: Text(
            widget.title!,
            style: TextStyle(
              color: Colors.white,
              // fontSize: 14,
              fontSize: MediaQuery.of(context).size.width * 0.009,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ));
  }
}
