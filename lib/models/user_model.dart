import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 0)
class User with _$User {
  const factory User({
    @HiveField(0) required String id,
    @HiveField(1) String? email,
    @HiveField(2) @Default(false) @JsonKey(defaultValue: false) bool isGuest,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) DateTime? lastSyncAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // Add a factory method for creating a new guest user
  factory User.createGuest() {
    return User(
      id: const Uuid().v4(),
      email: null,
      isGuest: true,
      createdAt: DateTime.now(),
      lastSyncAt: null,
    );
  }

  // Add a factory method for creating a registered user
  factory User.createRegistered({
    required String email,
  }) {
    return User(
      id: const Uuid().v4(),
      email: email,
      isGuest: false,
      createdAt: DateTime.now(),
      lastSyncAt: null,
    );
  }
}

// Hive adapter for User model
@HiveType(typeId: 0)
class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(
      id: reader.read(),
      email: reader.read(),
      isGuest: reader.read(),
      createdAt: reader.read(),
      lastSyncAt: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.id);
    writer.write(obj.email);
    writer.write(obj.isGuest);
    writer.write(obj.createdAt);
    writer.write(obj.lastSyncAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is UserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
