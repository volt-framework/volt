# Volt

![revolt-api](https://img.shields.io/npm/v/revolt-api?label=Revolt%20API)

Volt is a wrapper around Revolt API for creating bots for Dart language.
It's currently in active development so not all of the functionality has yet been implemented.

## Example usage

```dart
import 'package:volt/volt.dart';

void main() {
  final bot = Volt('TOKEN');

  bot.onMessageReceived.listen((event) {
    if (event.message.content == '!ping') {
      event.message.reply(MessageBuilder.content('Pong!'));
    }
  });
}
```

## Installation guide

Since the library is not yet available on [pub.dev](https://pub.dev/), the dependency needs to be added by yourself.

To install, edit your `pubspec.yaml`:

```yaml
dependencies:
    # ...your depedencies...
    volt:
        git: https://github.com/volt-framework/volt.git
```

Or just use the command line:

```bash
dart pub add volt --git-url=https://github.com/volt-framework/volt.git
```

## Contribution

-   Read [CONTRIBUTING.md](https://github.com/nyxx-discord/nyxx/blob/dev/CONTRIBUTING.md)
-   Join our server [here](https://app.revolt.chat/invite/h1eRgQfB)

## Credits

-   [Agilord](https://github.com/agilord/)'s for [ulid](https://github.com/agilord/ulid) dart implementation
-   This project is heavily inspired by [nyxx](https://github.com/nyxx-discord/nyxx) <3
