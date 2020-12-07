import 'package:ari/utils/theme_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

setPolygon(List<LatLng> points) {
print(points);
  List<Polygon> _lines = <Polygon>[
    new Polygon(
        polygonId: new PolygonId("111"),
        points: points,
        fillColor: ThemeColor().greenLightColor.withOpacity(0.6),
        strokeColor: ThemeColor().greenLightColor.withOpacity(0.2),
        zIndex: 2),
  ];
  Set<Polygon> plo = new Set();
  plo.addAll(_lines);
  return plo;
}
