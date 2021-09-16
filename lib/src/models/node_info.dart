part of volt;

class NodeInfo {
  final String revolt;
  final NodeFeatures features;
  final Uri ws;
  final Uri app;
  final String vapid;

  NodeInfo._new(Map<String, dynamic> raw)
      : revolt = raw['revolt'] as String,
        features = NodeFeatures._new(raw['features'] as Map<String, dynamic>),
        ws = Uri.parse(raw['ws'] as String),
        app = Uri.parse(raw['app'] as String),
        vapid = raw['vapid'] as String;
}

class NodeFeatures {
  final Captcha captcha;
  final bool email;
  final bool inviteOnly;
  final Autumn autumn;
  final January january;
  final Voso voso;

  NodeFeatures._new(Map<String, dynamic> raw)
      : captcha = Captcha._new(raw['captcha'] as Map<String, dynamic>),
        email = raw['email'] as bool,
        inviteOnly = raw['invite_only'] as bool,
        autumn = Autumn._new(raw['autumn'] as Map<String, dynamic>),
        january = January._new(raw['january'] as Map<String, dynamic>),
        voso = Voso._new(raw['voso'] as Map<String, dynamic>);
}

class Captcha {
  final bool enabled;
  final String key;

  Captcha._new(Map<String, dynamic> raw)
      : enabled = raw['enabled'] as bool,
        key = raw['key'] as String;
}

/// File server micro-service info.
class Autumn {
  final bool enabled;
  final Uri url;

  Autumn._new(Map<String, dynamic> raw)
      : enabled = raw['enabled'] as bool,
        url = Uri.parse(raw['url'] as String);
}

/// Image proxy and embed generator info.
class January {
  final bool enabled;
  final Uri url;

  January._new(Map<String, dynamic> raw)
      : enabled = raw['enabled'] as bool,
        url = Uri.parse(raw['url'] as String);
}

/// Probably voice server ?
class Voso {
  final bool enabled;
  final Uri url;
  final Uri ws;

  Voso._new(Map<String, dynamic> raw)
      : enabled = raw['enabled'] as bool,
        url = Uri.parse(raw['url'] as String),
        ws = Uri.parse(raw['ws'] as String);
}
