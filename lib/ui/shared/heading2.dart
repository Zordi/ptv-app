import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:nexthour/ui/shared/recommended_grid_view.dart';
import 'package:nexthour/ui/shared/top_grid_view.dart';
import '../../models/datum.dart';
import '/common/route_paths.dart';
// ignore: import_of_legacy_library_into_null_safe
import '/common/shimmer-effect.dart';
import '/ui/widgets/grid_movie_tv.dart';

class Heading3 extends StatefulWidget {
  final String heading;
  final String? type;
  final loading;
  final List<Datum>? videoList;
  Heading3(this.heading, this.loading, {this.type, this.videoList});

  @override
  _Heading3State createState() => _Heading3State();
}

class _Heading3State extends State<Heading3> {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return widget.loading == true
        ? Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade400,
        highlightColor2: Colors.grey.shade500,
        highlightColor: Colors.grey.shade500,
        child: Text(
          translate("Loading_"),
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    )
        : Padding(
      padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.heading,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}