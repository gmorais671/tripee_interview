import 'package:flutter/material.dart';

class RoutePoints extends StatelessWidget {
  final String originTitle;
  final String originSubtitle;
  final String destinationTitle;
  final String destinationSubtitle;
  final Color? accentColor;

  /// controla o comprimento total da área da linha pontilhada (altura usada dentro do connectorSpacing)
  final double lineHeight;

  /// altura do traço (dash) e espaço entre dashes
  final double lineDashHeight;
  final double lineGap;

  /// espessura do traço
  final double lineStrokeWidth;

  /// largura da coluna de ícones (pin + linha)
  final double iconColumnWidth;

  /// escala global aplicável aos ícones/pins (use <1.0 para versão compacta)
  final double iconScale;

  /// padding do conteúdo; permite ao caller reduzir o espaçamento horizontal
  final EdgeInsetsGeometry contentPadding;

  /// cor do texto (title/subtitle). Se null, usa preto.
  final Color? textColor;

  /// controla se a linha pontilhada deve ser mostrada (true) ou só o espaçamento entre ícones (false).
  final bool showConnector;

  /// espaçamento total vertical entre os ícones (inclui a área onde a linha pontilhada seria desenhada).
  final double connectorSpacing;

  /// controla se os subtitles devem ser exibidos (true) ou não (false).
  final bool showSubtitle;

  const RoutePoints({
    super.key,
    required this.originTitle,
    required this.originSubtitle,
    required this.destinationTitle,
    required this.destinationSubtitle,
    this.accentColor,
    this.lineHeight = 12,
    this.lineDashHeight = 1,
    this.lineGap = 4,
    this.lineStrokeWidth = 2,
    this.iconColumnWidth = 40,
    this.iconScale = 1.0,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    this.textColor,
    this.showConnector = true,
    this.connectorSpacing = 24, // default: 6 + lineHeight + 6 (compatibilidade visual)
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? Theme.of(context).colorScheme.primary;
    final double scale = (iconScale.clamp(0.6, 1.4) as num).toDouble();

    Widget originIconStacked({
      required Color color,
      double pinSize = 36,
      double pinIconSize = 30,
      double innerPinSize = 24,
      double personCircleSize = 25,
      double personIconSize = 20,
      double personOffsetY = 0.0,
      double personOffsetX = 0.0,
    }) {
      return SizedBox(
        width: pinSize,
        height: pinSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.location_on, color: color, size: pinIconSize),
            Positioned(
              top: (pinSize - personCircleSize) / 2 + personOffsetY,
              child: Icon(Icons.location_on, color: Colors.white, size: innerPinSize),
            ),
            Positioned(
              top: (pinSize - personIconSize) / 2 + personOffsetY,
              child: Icon(Icons.person, color: color, size: personIconSize),
            ),
          ],
        ),
      );
    }

    Widget destinationIcon({
      required Color color,
      double pinSize = 36,
      double pinIconSize = 30,
      double innerPinSize = 24,
      double personCircleSize = 30,
      double personIconSize = 16,
      double personOffsetY = 0.0,
      double personOffsetX = 0.0,
    }) {
      final double dotSize = (personIconSize).clamp(6.0, 20.0);
      return SizedBox(
        width: pinSize,
        height: pinSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: color, size: pinIconSize),
                SizedBox(height: 4 * scale),
                Container(
                  width: (pinIconSize * 0.66).clamp(12.0, 28.0),
                  height: (3 * scale).clamp(2.0, 6.0),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
            Positioned(
              top: (pinSize - personCircleSize + 6) / 2 + personOffsetY,
              child: Container(width: dotSize, height: dotSize, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
            ),
            Positioned(
              top: (pinSize - personCircleSize) / 2 + personOffsetY,
              child: Icon(Icons.location_on, color: Colors.white, size: (innerPinSize - 2).clamp(8.0, 28.0)),
            ),
          ],
        ),
      );
    }

    Widget routeTextTile({required String title, required String subtitle}) {
      final Color titleColor = textColor ?? Colors.black;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: showSubtitle ? 6 : 4),
            child: Text(title, style: TextStyle(color: titleColor, fontWeight: showSubtitle ? FontWeight.w600 : FontWeight.w400)),
          ),
          if (showSubtitle && subtitle.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey[600])),
          ],
        ],
      );
    }

    return Padding(
      padding: showSubtitle ? contentPadding : const EdgeInsetsGeometry.symmetric(horizontal: 2),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: iconColumnWidth * scale,
              child: Column(
                children: [
                  originIconStacked(
                    color: color,
                    pinSize: 36 * scale,
                    pinIconSize: 30 * scale,
                    innerPinSize: 27 * scale,
                    personCircleSize: 25.5 * scale,
                    personIconSize: 14 * scale,
                    personOffsetY: -1 * scale,
                  ),

                  // Espaçamento / conector entre ícones.
                  SizedBox(
                    height: connectorSpacing * scale,
                    child: showConnector
                        ? Center(
                            child: SizedBox(
                              height: lineHeight * scale,
                              child: _DashedLine(
                                color: Colors.grey.shade400,
                                dashHeight: lineDashHeight * scale,
                                gap: lineGap * scale,
                                strokeWidth: lineStrokeWidth * scale,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  destinationIcon(
                    color: color,
                    pinSize: 36 * scale,
                    pinIconSize: 28 * scale,
                    innerPinSize: 26 * scale,
                    personCircleSize: 30.5 * scale,
                    personIconSize: 11 * scale,
                    personOffsetY: 0 * scale,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  routeTextTile(title: originTitle, subtitle: originSubtitle),
                  SizedBox(height: 16 * scale),
                  routeTextTile(title: destinationTitle, subtitle: destinationSubtitle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  final double dashHeight;
  final double gap;
  final Color color;
  final double strokeWidth;

  const _DashedLine({
    Key? key,
    this.dashHeight = 6,
    this.gap = 6,
    this.color = Colors.grey,
    this.strokeWidth = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: strokeWidth,
      child: CustomPaint(
        size: const Size(2, double.infinity),
        painter: _DashedLinePainter(color: color, dashHeight: dashHeight, gap: gap, strokeWidth: strokeWidth),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;
  final double gap;
  final double strokeWidth;

  _DashedLinePainter({
    required this.color,
    required this.dashHeight,
    required this.gap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeCap = StrokeCap.round..strokeWidth = strokeWidth;
    double y = 0;
    final centerX = size.width / 2;
    while (y < size.height) {
      final endY = (y + dashHeight).clamp(0.0, size.height);
      canvas.drawLine(Offset(centerX, y), Offset(centerX, endY), paint);
      y += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.dashHeight != dashHeight || oldDelegate.gap != gap || oldDelegate.strokeWidth != strokeWidth;
  }
}