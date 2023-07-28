import 'package:flutter/material.dart';
import '/common/apipath.dart';

class TVSeriesItemCustom extends StatelessWidget {
  final tvSeriesItem;
  final BuildContext context;

  TVSeriesItemCustom(this.tvSeriesItem, this.context);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100.0),
      child: Container(
        width: 75,
        height: 75,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            image: APIData.tvImageUriTv + "${tvSeriesItem.thumbnail}",
            placeholder: "assets/placeholder_box.jpg",
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/placeholder_box.jpg",
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
  }
}
