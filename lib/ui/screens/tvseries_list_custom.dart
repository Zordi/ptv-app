import 'package:flutter/material.dart';
import '../widgets/tvseries_item_custom.dart';
import '/common/route_paths.dart';
import '/models/episode.dart';
import '/ui/screens/video_detail_screen.dart';
import '/ui/widgets/tvseries_item.dart';

class TvSeriesListCustom extends StatefulWidget {
  final DatumType? type;
  final loading;
  final data;
  TvSeriesListCustom({this.type, this.loading, this.data});
  @override
  _TvSeriesListState createState() => _TvSeriesListState();
}

class _TvSeriesListState extends State<TvSeriesListCustom> {
  @override
  Widget build(BuildContext context) {
    return widget.loading == true
        ? Container(
      height: 75, // Change the height to 75
      margin: EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 15.0),
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(37.5), // Set borderRadius to half of the height
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37.5), // Set borderRadius to half of the height
                child: Image.asset(
                  "assets/placeholder_box.jpg",
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    )
        : Container(
      height: 75, // Change the height to 75
      margin: EdgeInsets.only(top: 15.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.only(left: 15.0),
        scrollDirection: Axis.horizontal,
        itemCount: widget.data.length == 0 ? 4 : widget.data.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.data.length == 0
              ? Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(37.5), // Set borderRadius to half of the height
              child: ClipRRect(
                borderRadius: BorderRadius.circular(37.5), // Set borderRadius to half of the height
                child: Image.asset(
                  "assets/placeholder_box.jpg",
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
              : InkWell(
            borderRadius: BorderRadius.circular(37.5), // Set borderRadius to half of the height
            child: Container(
              margin: EdgeInsets.only(right: 15.0),
              child: TVSeriesItemCustom(widget.data[index], context),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.videoDetail,
                arguments: VideoDetailScreen(
                  widget.data[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
