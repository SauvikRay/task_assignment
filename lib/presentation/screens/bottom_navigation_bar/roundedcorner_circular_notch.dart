
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class RoundedCircularNotchedRectangle extends NotchedShape {
  /// Creates a [CircularNotchedRectangle].
  ///
  /// The same object can be used to create multiple shapes.
  const RoundedCircularNotchedRectangle({required this.cornerRadius}) : assert(cornerRadius > 10);
  final double cornerRadius;
 
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }
    final double notchRadius = guest.width / 2.0;
    // log('Guest Width:${guest.width}');
    // log('Notch Radius:$notchRadius');

    const double s1 = 15.0;
    const double s2 = 1.0;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA);
    final double p2yB = math.sqrt(r * r - p2xB * p2xB);

    final List<Offset?> p = List<Offset?>.filled(6, null);

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right - cornerRadius, host.top)
      ..arcToPoint(
        Offset(host.right - cornerRadius, (2 * cornerRadius)),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(host.right, cornerRadius)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..lineTo(host.left, host.bottom - (2 * cornerRadius))
      ..arcToPoint(
        Offset(host.bottom - (2 * cornerRadius), host.left),
        radius: Radius.circular(cornerRadius),
        clockwise: true,
      )
      ..lineTo(cornerRadius, host.left)
      ..close();
  }
}