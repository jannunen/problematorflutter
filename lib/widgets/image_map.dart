import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:problemator/widgets/imagemap/canvas_object.dart';

import 'imagemap/canvas_controller.dart';

class ImageMap extends StatefulWidget {
  final List<ImageMapShape> shapes;
  ImageMap(this.shapes);

  @override
  State<StatefulWidget> createState() => _ImageMap(this.shapes);
}

class _ImageMap extends State<ImageMap> {
  final List<ImageMapShape> shapes;
  final _controller = CanvasController();
  final Image image = Image(image: AssetImage('assets/images/floorplans/floorplan_1.png'));

  _ImageMap(this.shapes) {
    _controller.addObject(CanvasObject(
      dx: 20,
      dy: 20,
      width: 100,
      height: 100,
      child: image,
    ));
    _controller.addObject(CanvasObject(
      dx: 20,
      dy: 20,
      width: 100,
      height: 100,
      child: Container(color: Colors.blue),
    ));
    _controller.addObject(CanvasObject(
      dx: 150,
      dy: 50,
      width: 100,
      height: 100,
      child: Container(color: Colors.green),
    ));
  }

  @override
  void initState() {
    _controller.init();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CanvasController>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          }
          final instance = snapshot.data;
          print(instance.selectedObjectsIndices);
          return Column(
            children: [
              Row(
                children: [
                  FocusScope(
                    canRequestFocus: false,
                    child: IconButton(
                      tooltip: 'Zoom In',
                      icon: Icon(Icons.zoom_in),
                      onPressed: _controller.zoomIn,
                    ),
                  ),
                  FocusScope(
                    canRequestFocus: false,
                    child: IconButton(
                      tooltip: 'Zoom Out',
                      icon: Icon(Icons.zoom_out),
                      onPressed: _controller.zoomOut,
                    ),
                  ),
                  FocusScope(
                    canRequestFocus: false,
                    child: IconButton(
                      tooltip: 'Reset the Scale and Offset',
                      icon: Icon(Icons.restore),
                      onPressed: _controller.reset,
                    ),
                  ),
                ],
              ),
              Listener(
                behavior: HitTestBehavior.opaque,
                onPointerSignal: (details) {
                  if (details is PointerScrollEvent) {
                    GestureBinding.instance.pointerSignalResolver.register(details, (event) {
                      if (event is PointerScrollEvent) {
                        _controller.offset = _controller.offset - event.scrollDelta;
                      }
                    });
                  }
                },
                onPointerMove: (details) {
                  _controller.updateTouch(
                    details.pointer,
                    details.localPosition,
                    details.position,
                  );
                },
                onPointerDown: (details) {
                  _controller.addTouch(
                    details.pointer,
                    details.localPosition,
                    details.position,
                  );
                },
                onPointerUp: (details) {
                  _controller.removeTouch(details.pointer);
                },
                onPointerCancel: (details) {
                  _controller.removeTouch(details.pointer);
                },
                child: RawKeyboardListener(
                  autofocus: true,
                  focusNode: _controller.focusNode,
                  onKey: (key) => _controller.rawKeyEvent(context, key),
                  child: Stack(
                    children: [
                      image,
                      for (var i = 0; i < instance.objects.length; i++)
                        AnimatedPositioned.fromRect(
                          duration: const Duration(milliseconds: 50),
                          rect: instance.objects[i].rect.adjusted(
                            _controller.offset,
                            _controller.scale,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color:
                                  instance.isObjectSelected(i) ? Colors.grey : Colors.transparent,
                            )),
                            child: GestureDetector(
                              onTapDown: (_) => _controller.selectObject(i),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: SizedBox.fromSize(
                                  size: instance.objects[i].size,
                                  child: instance.objects[i].child,
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class ImageMapShapePainter extends CustomPainter {
  final BuildContext context;
  final ImageMapShape shape;
  final Size size;
  Path path;

  ImageMapShapePainter(this.context, this.shape, this.size) {
    double width = size.width;
    double height = size.height;
    // Convert imagemapcoordinates to points
    List<Point> points =
        this.shape.points.map((e) => Point(_getX(e.x, width), _getY(e.y, height))).toList();

    final thisPath = Path();
    points.asMap().forEach((index, Point p) {
      if (index == 0) {
        // If first item, start by moving pen to the point
        thisPath.moveTo(p.x, p.y);
      } else {
        // COntinue by drawing a line
        thisPath.lineTo(p.x, p.y);
      }
    });
    path = thisPath;
  }

  double _getX(double xPercentage, double width) {
    double div = (xPercentage / 100 * width);
    return div.roundToDouble();
  }

  double _getY(double yPercentage, double height) {
    double div = (yPercentage / 100 * height);
    return div.roundToDouble();
  }

  @override
  void paint(Canvas canvas, Size size) async {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red
      ..isAntiAlias = true;
    canvas.drawPath(path, paint);
    //PolygonUtil.drawRoundPolygon(points, canvas, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ImageMapShape {
  final String title;
  final String description;
  final List<ImageMapCoordinate> points;

  ImageMapShape({this.title, this.description, this.points});
}

class ImageMapCoordinate {
  final double x;
  final double y;

  ImageMapCoordinate(this.x, this.y);
}

class PolygonUtil {
  static List<Point> convertToPoints(Point center, double r, int num, {double startRadian = 0.0}) {
    var list = List<Point>();
    double perRadian = 2.0 * pi / num;
    for (int i = 0; i < num; i++) {
      double radian = i * perRadian + startRadian;
      var p = LineCircle.radianPoint(center, r, radian);
      list.add(p);
    }
    return list;
  }

  static Path drawRoundPolygon(List<Point> listPoints, Canvas canvas, Paint paint,
      {double distance = 4.0, double radius = 0.0}) {
    if (radius < 0.01) {
      radius = 6 * distance;
    }
    var path = Path();
    listPoints.add(listPoints[0]);
    listPoints.add(listPoints[1]);
    if (paint.style == PaintingStyle.stroke) {
      listPoints.add(listPoints[2]);
    }
    var p0 = LineInterCircle.intersectionPoint(listPoints[1], listPoints[0], distance);
    path.moveTo(p0.x, p0.y);
    for (int i = 0; i < listPoints.length - 2; i++) {
      var p1 = listPoints[i];
      var p2 = listPoints[i + 1];
      var p3 = listPoints[i + 2];
      var interP1 = LineInterCircle.intersectionPoint(p1, p2, distance);
      var interP2 = LineInterCircle.intersectionPoint(p3, p2, distance);
      path.lineTo(interP1.x, interP1.y);
      path.arcToPoint(
        Offset(interP2.x, interP2.y),
        radius: Radius.circular(radius),
      );
    }
    return path;
  }
}

class LineCircle {
  ///give the center ,radius of the circle,
  ///and have radian from x clockwise direction.
  ///you can get the point coordinate in the circle.
  static Point radianPoint(Point center, double r, double radian) {
    return Point(center.x + r * cos(radian), center.y + r * sin(radian));
  }
}

class Line {
  ///y = kx + c
  static double normalLine(x, {k = 0, c = 0}) {
    return k * x + c;
  }

  ///Calculate the param K in y = kx +c
  static double paramK(Point p1, Point p2) {
    if (p1.x == p2.x) return 0;
    return (p2.y - p1.y) / (p2.x - p1.x);
  }

  ///Calculate the param C in y = kx +c
  static double paramC(Point p1, Point p2) {
    return p1.y - paramK(p1, p2) * p1.x;
  }
}

/// start point p1, end point p2,p2 is center of the circle,r is its radius.
class LineInterCircle {
  /// start point p1, end point p2,p2 is center of the circle,r is its radius.
  /// param a: y = kx +c intersect with circle,which has the center with point2 and radius R .
  /// when derive to x2+ ax +b = 0 equation. the param a is here.
  static double paramA(Point p1, Point p2) {
    return (2 * Line.paramK(p1, p2) * Line.paramC(p1, p2) -
            2 * Line.paramK(p1, p2) * p2.y -
            2 * p2.x) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  /// start point p1, end point p2,p2 is center of the circle,r is its radius.
  /// param b: y = kx +c intersect with circle,which has the center with point2 and radius R .
  /// when derive to x2+ ax +b = 0 equation. the param b is here.
  static double paramB(Point p1, Point p2, double r) {
    return (p2.x * p2.x - r * r + (Line.paramC(p1, p2) - p2.y) * (Line.paramC(p1, p2) - p2.y)) /
        (Line.paramK(p1, p2) * Line.paramK(p1, p2) + 1);
  }

  ///the circle has the intersection or not
  static bool isIntersection(Point p1, Point p2, double r) {
    var delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    return delta >= 0.0;
  }

  ///the x coordinate whether or not is between two point we give.
  static bool _betweenPoint(x, Point p1, Point p2) {
    if (p1.x > p2.x) {
      return x > p2.x && x < p1.x;
    } else {
      return x > p1.x && x < p2.x;
    }
  }

  static Point _equalX(Point p1, Point p2, double r) {
    if (p1.y > p2.y) {
      return Point(p2.x, p2.y + r);
    } else if (p1.y < p2.y) {
      return Point(p2.x, p2.y - r);
    } else {
      return p2;
    }
  }

  static Point _equalY(Point p1, Point p2, double r) {
    if (p1.x > p2.x) {
      return Point(p2.x + r, p2.y);
    } else if (p1.x < p2.x) {
      return Point(p2.x - r, p2.y);
    } else {
      return p2;
    }
  }

  ///intersection point
  static Point intersectionPoint(Point p1, Point p2, double r) {
    if (p1.x > p2.x - 1 && p1.x < p2.x + 1) return _equalX(p1, p2, r);
    if (p1.y > p2.y - 1 && p1.y < p2.y + 1) return _equalY(p1, p2, r);
    var delta = sqrt(paramA(p1, p2) * paramA(p1, p2) - 4 * paramB(p1, p2, r));
    if (delta < 0.0) {
      //when no intersection, i will return the center of the circ  le.
      return p2;
    }
    var a_2 = -paramA(p1, p2) / 2.0;
    var x1 = a_2 + delta / 2;
    if (_betweenPoint(x1, p1, p2)) {
      var y1 = Line.paramK(p1, p2) * x1 + Line.paramC(p1, p2);
      return Point(x1, y1);
    }
    var x2 = a_2 - delta / 2;
    var y2 = Line.paramK(p1, p2) * x2 + Line.paramC(p1, p2);
    return Point(x2, y2);
  }
}

extension RectUtils on Rect {
  Rect adjusted(Offset offset, double scale) {
    final left = (this.left + offset.dx) * scale;
    final top = (this.top + offset.dy) * scale;
    final width = this.width * scale;
    final height = this.height * scale;
    return Rect.fromLTWH(left, top, width, height);
  }
}
