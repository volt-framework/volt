import 'package:volt/volt.dart';

Future<void> main() async {
  final bot = Volt('token');

  // log messages
  bot.onMessageReceived.listen((event) {
    print('Content: ${event.message.content}');
  });

  // ping-pong stuff
  bot.onMessageReceived
      .where((event) => event.message.content == '!ping')
      .listen((event) async {
    await event.message.reply(
      MessageBuilder.content('pong!'),
    );
  });

  // get channel mention
  bot.onMessageReceived
      .where((event) => event.message.content == '!channel')
      .listen((event) async {
    final channel = await bot.fetchChannel<ServerTextChannel>(
      event.message.channel.id,
    );

    await event.message.reply(MessageBuilder.content(
      'the channel is ${channel.name} (${channel.mention})',
    ));
  });

  // get user info
  bot.onMessageReceived
      .where((event) => event.message.content == '!user')
      .listen((event) async {
    final user = await bot.fetchUser(event.message.author.id);

    await event.message.reply(
      MessageBuilder.content('you are @${user.username} (${user.mention})'),
    );
  });
}
