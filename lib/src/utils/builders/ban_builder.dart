part of volt;

class BanBuilder extends Builder<RawApiMap> {
  /// Ban reason.
  String? reason;

  @override
  RawApiMap build() {
    return {
      if (reason != null) 'reason': reason,
    };
  }
}
