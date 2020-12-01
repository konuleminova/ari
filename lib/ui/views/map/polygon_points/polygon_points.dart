import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

setPolygon(List<LatLng> points) {
print(points);
  List<Polygon> _lines = <Polygon>[
    new Polygon(
        polygonId: new PolygonId("111"),
        points: points,
        fillColor: const Color(0xFFE2AD98),
        strokeColor: const Color(0xFFE2AD98),
        zIndex: 2),
  ];
  Set<Polygon> plo = new Set();
  plo.addAll(_lines);
  return plo;
}
