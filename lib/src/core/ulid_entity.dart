part of volt;

class UlidEntity {
  final Ulid id;

  const UlidEntity(this.id);

  @override
  int get hashCode => id.hashCode;

  DateTime get createdAt => id.toTimestamp();

  @override
  bool operator ==(dynamic other) {
    if (other is UlidEntity) return id == other.id;
    if (other is Ulid) return id == other;
    if (other is String) return id.toString() == other;

    return false;
  }
}
