part of volt;

class Attachment {
  final String id;
  final FileTag tag;
  final int size;
  final String fileName;
  final String contentsType;
  final Metadata metadata;

  Attachment._new(RawApiMap raw)
      : id = raw['_id'] as String,
        tag = FileTag.from('tag'),
        size = raw['size'] as int,
        fileName = raw['filename'] as String,
        contentsType = raw['content_type'] as String,
        metadata = Metadata._define(raw['metadata']);
}

class FileTag extends Enum<String> {
  static const attachments = FileTag._create('atttachments');
  static const avatars = FileTag._create('avatars');
  static const backgrounds = FileTag._create('backgrounds');
  static const banners = FileTag._create('banners');
  static const icons = FileTag._create('icons');

  FileTag.from(String value) : super(value);
  const FileTag._create(String value) : super(value);
}
