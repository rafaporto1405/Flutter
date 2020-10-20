import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalendarViewDate extends StatefulWidget {
  CalendarViewDate(
      this.text, {
        this.selected = false,
        this.notSameMonth = false,
        this.style = const TextStyle(),
        Key key,
        this.hasEvent = false,
      }) : super(key: key);
  final String text;
  final bool selected;
  final bool notSameMonth;
  final TextStyle style;
  final bool hasEvent;

  @override
  _CalendarViewDateState createState() => _CalendarViewDateState();
}

class _CalendarViewDateState extends State<CalendarViewDate> {
  @override
  Widget build(BuildContext context) {
    return _buildDate();
  }

  Widget _buildDate() {

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.notSameMonth
            ? Colors.black.withOpacity(0.10)
            : Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 32,
            height: 32,
            child: Text(
              widget.text,
              style: widget.style
                  .copyWith(color: Colors.black),
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: widget.selected ? Colors.blue : null,
                borderRadius: BorderRadius.circular(8)
              // shape: BoxShape.circle,
            ),
          ),
          Positioned(
            bottom: 2,
            child: Container(
              width: 8,
              height: 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: widget.hasEvent
                      ? widget.selected ? Colors.white70 : Colors.blue
                      : null,
                  borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }
}
