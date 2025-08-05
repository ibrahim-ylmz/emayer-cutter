class SystemStatus {
  Message? message;
  bool? status;

  SystemStatus({
    this.message,
    this.status,
  });

  SystemStatus copyWith({
    Message? message,
    bool? status,
  }) {
    return SystemStatus(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
    };
  }

  factory SystemStatus.fromJson(Map<String, dynamic> json) {
    return SystemStatus(
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );
  }

  @override
  String toString() => "SystemStatus(message: $message,status: $status)";

  @override
  int get hashCode => Object.hash(message, status);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemStatus &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          status == other.status;
}

class Message {
  bool? lights;
  Motors? motors;
  bool? power;
  Sensors? sensors;
  bool? vacuum;

  Message({
    this.lights,
    this.motors,
    this.power,
    this.sensors,
    this.vacuum,
  });

  Message copyWith({
    bool? lights,
    Motors? motors,
    bool? power,
    Sensors? sensors,
    bool? vacuum,
  }) {
    return Message(
      lights: lights ?? this.lights,
      motors: motors ?? this.motors,
      power: power ?? this.power,
      sensors: sensors ?? this.sensors,
      vacuum: vacuum ?? this.vacuum,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lights': lights,
      'motors': motors,
      'power': power,
      'sensors': sensors,
      'vacuum': vacuum,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      lights: json['lights'] as bool?,
      motors: json['motors'] == null
          ? null
          : Motors.fromJson(json['motors'] as Map<String, dynamic>),
      power: json['power'] as bool?,
      sensors: json['sensors'] == null
          ? null
          : Sensors.fromJson(json['sensors'] as Map<String, dynamic>),
      vacuum: json['vacuum'] as bool?,
    );
  }

  @override
  String toString() =>
      "Message(lights: $lights,motors: $motors,power: $power,sensors: $sensors,vacuum: $vacuum)";

  @override
  int get hashCode => Object.hash(lights, motors, power, sensors, vacuum);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          lights == other.lights &&
          motors == other.motors &&
          power == other.power &&
          sensors == other.sensors &&
          vacuum == other.vacuum;
}

class Motors {
  bool? motor1;
  bool? motor2;
  bool? motor3;

  Motors({
    this.motor1,
    this.motor2,
    this.motor3,
  });

  Motors copyWith({
    bool? motor1,
    bool? motor2,
    bool? motor3,
  }) {
    return Motors(
      motor1: motor1 ?? this.motor1,
      motor2: motor2 ?? this.motor2,
      motor3: motor3 ?? this.motor3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'motor_1': motor1,
      'motor_2': motor2,
      'motor_3': motor3,
    };
  }

  factory Motors.fromJson(Map<String, dynamic> json) {
    return Motors(
      motor1: json['motor_1'] as bool?,
      motor2: json['motor_2'] as bool?,
      motor3: json['motor_3'] as bool?,
    );
  }

  @override
  String toString() =>
      "Motors(motor1: $motor1,motor2: $motor2,motor3: $motor3)";

  @override
  int get hashCode => Object.hash(motor1, motor2, motor3);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Motors &&
          runtimeType == other.runtimeType &&
          motor1 == other.motor1 &&
          motor2 == other.motor2 &&
          motor3 == other.motor3;
}

class Sensors {
  bool? sensor1;
  bool? sensor2;
  bool? sensor3;

  Sensors({
    this.sensor1,
    this.sensor2,
    this.sensor3,
  });

  Sensors copyWith({
    bool? sensor1,
    bool? sensor2,
    bool? sensor3,
  }) {
    return Sensors(
      sensor1: sensor1 ?? this.sensor1,
      sensor2: sensor2 ?? this.sensor2,
      sensor3: sensor3 ?? this.sensor3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sensor_1': sensor1,
      'sensor_2': sensor2,
      'sensor_3': sensor3,
    };
  }

  factory Sensors.fromJson(Map<String, dynamic> json) {
    return Sensors(
      sensor1: json['sensor_1'] as bool?,
      sensor2: json['sensor_2'] as bool?,
      sensor3: json['sensor_3'] as bool?,
    );
  }

  @override
  String toString() =>
      "Sensors(sensor1: $sensor1,sensor2: $sensor2,sensor3: $sensor3)";

  @override
  int get hashCode => Object.hash(sensor1, sensor2, sensor3);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sensors &&
          runtimeType == other.runtimeType &&
          sensor1 == other.sensor1 &&
          sensor2 == other.sensor2 &&
          sensor3 == other.sensor3;
}
