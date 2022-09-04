import 'dart:math';
import 'dart:ui' as ui;

import 'package:clean_architecture/stock_app/domain/model/intraday_info.dart';
import 'package:flutter/material.dart';

class StockChart extends StatelessWidget {
  final List<IntradayInfo> infos;
  final Color graphColor;
  final Color textColor;

  const StockChart({
    Key? key,
    this.infos = const [],
    required this.graphColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: CustomPaint(
        painter: ChartPainter(infos, graphColor, textColor),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final List<IntradayInfo> infos;
  final Color graphColor;
  final Color textColor;

  late int upperValue = infos.map((e) => e.close).fold<double>(0.0, max).ceil();
  late int lowerValue = infos.map((e) => e.close).reduce(min).toInt();
  final spacing = 50.0;

  late Paint strokePaint;

  ChartPainter(this.infos, this.graphColor, this.textColor) {
    strokePaint = Paint()
      ..color = graphColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 세로
    final priceStep = (upperValue - lowerValue) / 5.0;
    for (var i = 0; i < 5; i++) {
      // 텍스트 내용 설정
      final textSpan = TextSpan(
        text: '${(lowerValue + priceStep * i).round()}',
        style: TextStyle(fontSize: 12, color: textColor),
      );

      // 텍스트 위치 설정
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );

      // 위치 잡아주기
      textPainter.layout();
      // 위치에 그리기(canvas의 offset 좌표에)
      textPainter.paint(
        canvas,
        Offset(10, size.height - spacing - i * (size.height / 5.0)),
      );
    }

    // 가로
    final spacePerHour = (size.width - 50) / infos.length;
    for (var i = 0; i < infos.length; i += 12) {
      final hour = infos[i].date.hour;

      final textSpan = TextSpan(
        text: '$hour',
        style: TextStyle(fontSize: 12, color: textColor),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.start,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(i * spacePerHour + spacing, size.height),
      );
    }

    var lastX = 0.0;
    final strokePath = Path();
    for (var i = 0; i < infos.length; i++) {
      final info = infos[i];
      var nextIndex = i + 1;
      if (nextIndex == infos.length) nextIndex = infos.length - 1;

      final nextInfo = infos[nextIndex];

      final leftRatio = (info.close - lowerValue) / (upperValue - lowerValue);
      final rightRatio = (nextInfo.close - lowerValue) / (upperValue - lowerValue);

      final x1 = spacing + i * spacePerHour;
      final y1 = size.height - (leftRatio * size.height).toDouble();

      final x2 = spacing + nextIndex * spacePerHour;
      final y2 = size.height - (rightRatio * size.height).toDouble();

      if (i == 0) {
        strokePath.moveTo(x1, y1);
      }

      lastX = (x1 + x2) / 2.0;
      strokePath.quadraticBezierTo(x1, y1, lastX, (y1 + y2) / 2.0);
    }
    final fillPath = Path.from(strokePath)
      ..lineTo(lastX, size.height - spacing)
      ..lineTo(spacing, size.height - spacing)
      ..close();

    final fillPaint = Paint()
      ..color = graphColor
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(0, size.height - spacing),
        [
          graphColor.withOpacity(0.5),
          Colors.transparent,
        ],
      );

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(strokePath, strokePaint);
  }

  // 언제 다시 렌더링 할 것인가?
  @override
  bool shouldRepaint(ChartPainter oldDelegate) {
    return oldDelegate.infos != infos;
  }
}
