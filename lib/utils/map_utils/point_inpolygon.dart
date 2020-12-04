import 'package:google_maps_flutter/google_maps_flutter.dart';

bool isPointInPolygon(LatLng tap, List<LatLng> vertices) {
  int intersectCount = 0;
  for (int j = 0; j < vertices.length - 1; j++) {
    if (rayCastIntersect(tap, vertices[j], vertices[j+1])) {
      intersectCount++;
    }
  }

  return ((intersectCount % 2) == 1); // odd = inside, even = outside;
}

bool rayCastIntersect(LatLng tap, LatLng vertA, LatLng vertB) {

  double aY = vertA.latitude;
  double bY = vertB.latitude;
  double aX = vertA.longitude;
  double bX = vertB.longitude;
  double pY = tap.latitude;
  double pX = tap.longitude;

  if ((aY > pY && bY > pY) || (aY < pY && bY < pY)
      || (aX < pX && bX < pX)) {
    return false; // a and b can't both be above or below pt.y, and a or
    // b must be east of pt.x
  }

  double m = (aY - bY) / (aX - bX); // Rise over run
  double bee = (-aX) * m + aY; // y = mx + b
  double x = (pY - bee) / m; // algebra is neat!

  return x > pX;
}