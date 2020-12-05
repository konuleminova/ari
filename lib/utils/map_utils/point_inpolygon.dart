import 'package:google_maps_flutter/google_maps_flutter.dart';

bool isPointInPolygon (LatLng point, List<LatLng> vs) {
  // ray-casting algorithm based on
  // https://wrf.ecse.rpi.edu/Research/Short_Notes/pnpoly.html/pnpoly.html

  var x = point.latitude, y = point.longitude;

  var inside = false;
  for (var i = 0, j = vs.length - 1; i < vs.length; j = i++) {
    var xi = vs[i].latitude, yi = vs[i].longitude;
    var xj = vs[j].latitude, yj = vs[j].longitude;

    var intersect = ((yi > y) != (yj > y))
        && (x < (xj - xi) * (y - yi) / (yj - yi) + xi);
    if (intersect) inside = !inside;
  }
  return inside;
}
