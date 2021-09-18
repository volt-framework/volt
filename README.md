# Volt

![revolt-api](https://img.shields.io/npm/v/revolt-api?label=Revolt%20API)

Volt is a wrapper over the Revolt API for easily writing bots using the Dart language.
It is currently in active development so not all of the functionality has yet been implemented.

---

## Example usage

```dart
import 'package:volt/volt.dart';

void main() {
  final bot = Volt('TOKEN');

  bot.onMessageReceived.listen((event) {
    if (event.message.content == '!ping') {
      await event.message.channel.sendMessage(MessageBuilder.content('Pong!'));
    }
  });
}

```

## Contribution

-   Read [CONTRIBUTING.md](https://github.com/nyxx-discord/nyxx/blob/dev/CONTRIBUTING.md)
-   Join our server [here](https://app.revolt.chat/invite/h1eRgQfB)

## Credits

-   [Agilord](https://github.com/agilord/)'s for [ulid](https://github.com/agilord/ulid) dart implementation
-   This project is heavily inspired by [nyxx](https://github.com/nyxx-discord/nyxx) <3
