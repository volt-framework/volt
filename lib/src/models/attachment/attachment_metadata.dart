part of volt;

class Metadata {
  FileMetadataType type;

  Metadata._new(RawApiMap raw)
      : type = FileMetadataType.from(raw['type'] as String);

  factory Metadata._define(RawApiMap raw) {
    switch (raw['type'] as String) {
      case 'File':
        return FileMetadata._new(raw);
      case 'Text':
        return TextMetadata._new(raw);
      case 'Audio':
        return AudioMetadata._new(raw);
      case 'Image':
        return ImageMetadata._new(raw);
      case 'Video':
        return VideoMetadata._new(raw);
      default:
        return UndefinedMetadata._new(raw);
    }
  }
}

class FileMetadata extends Metadata {
  FileMetadata._new(RawApiMap raw) : super._new(raw);
}

class TextMetadata extends Metadata {
  TextMetadata._new(RawApiMap raw) : super._new(raw);
}

class AudioMetadata extends Metadata {
  AudioMetadata._new(RawApiMap raw) : super._new(raw);
}

class ImageMetadata extends Metadata {
  final int width;
  final int height;

  ImageMetadata._new(RawApiMap raw)
      : width = raw['width'] as int,
        height = raw['height'] as int,
        super._new(raw);
}

class VideoMetadata extends Metadata {
  final int width;
  final int height;

  VideoMetadata._new(RawApiMap raw)
      : width = raw['width'] as int,
        height = raw['height'] as int,
        super._new(raw);
}

class UndefinedMetadata extends Metadata {
  UndefinedMetadata._new(RawApiMap raw) : super._new(raw);
}

class FileMetadataType extends Enum<String> {
  static const file = FileMetadataType._create('File');
  static const text = FileMetadataType._create('Text');
  static const audio = FileMetadataType._create('Audio');
  static const image = FileMetadataType._create('Image');
  static const video = FileMetadataType._create('Video');
  static const undefined = FileMetadataType._create('Undefined');

  const FileMetadataType._create(String value) : super(value);
  FileMetadataType.from(String value) : super(value);
}
