class ImageMapCoordinate {
  final double x;
  final double y;

  ImageMapCoordinate(this.x, this.y);

  static ImageMapCoordinate fromJson(json) {
    if (json != null) {
      return ImageMapCoordinate(
        (json['x'].toDouble()),
        (json['y'].toDouble()),
      );
    }
    return ImageMapCoordinate(0, 0);
  }
}
