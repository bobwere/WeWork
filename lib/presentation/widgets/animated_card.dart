import 'package:flutter/material.dart';
import 'package:we_work/common/utils.dart';
import 'package:we_work/infrastructure/model/worker_details.dart';

class AnimatedCard extends StatefulWidget {
  AnimatedCard(
      {Key? key,
      required this.controller,
      required this.index,
      required this.workerDetail,
      required this.image,
      required this.hexCode})
      : super(key: key);

  final ScrollController controller;
  final Image image;
  final int index;
  final WorkerDetails workerDetail;
  final String hexCode;

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  late var offset;
  late var itemSize;
  late var itemPositionIndex;
  late var difference;
  late var percent;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        itemSize = 150.0;
        itemPositionIndex = (widget.index + 1) * itemSize * 0.7;
        offset = widget.controller.hasClients ? widget.controller.offset : 0;
        difference = widget.controller.offset - itemPositionIndex;
        percent = 1 - (difference / itemSize * 0.7);
        double opacity = percent;
        double scale = percent;
        if (opacity > 1.0) opacity = 1.0;
        if (opacity < 0.5) opacity = 0.0;
        if (scale > 1.0) scale = 1.0;

        return Align(
          heightFactor: 0.7,
          child: Opacity(
            opacity: opacity,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..scale(scale, scale),
              child: Container(
                height: itemSize,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, -2),
                        color: Colors.grey.withOpacity(0.3),
                      )
                    ]),
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  elevation: 5,
                  color: colorFromHex(widget.hexCode),
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.workerDetail.name ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Flexible(
                                  child: Text(
                                    widget.workerDetail.occupation ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 100, height: 100, child: widget.image)
                        ],
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
