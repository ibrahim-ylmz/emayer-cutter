class SystemValue {
  Message? message;
  bool? status;

  SystemValue({
    this.message,
    this.status,
  });

  SystemValue copyWith({
    Message? message,
    bool? status,
  }) {
    return SystemValue(
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

  factory SystemValue.fromJson(Map<String, dynamic> json) {
    return SystemValue(
      message: json['message'] == null
          ? null
          : Message.fromJson(json['message'] as Map<String, dynamic>),
      status: json['status'] as bool?,
    );
  }

  @override
  String toString() => "SystemValue(message: $message,status: $status)";

  @override
  int get hashCode => Object.hash(message, status);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystemValue &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          status == other.status;
}

class Message {
  int? speed;
  int? torque;

  Message({
    this.speed,
    this.torque,
  });

  Message copyWith({
    int? speed,
    int? torque,
  }) {
    return Message(
      speed: speed ?? this.speed,
      torque: torque ?? this.torque,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'torque': torque,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      speed: json['speed'] as int?,
      torque: json['torque'] as int?,
    );
  }

  @override
  String toString() => "Message(speed: $speed,torque: $torque)";

  @override
  int get hashCode => Object.hash(speed, torque);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          speed == other.speed &&
          torque == other.torque;
}
