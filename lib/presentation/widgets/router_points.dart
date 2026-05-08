import 'package:flutter/material.dart';

class RoutePoints extends StatelessWidget {
  final String originTitle;
  final String originSubtitle;
  final String destinationTitle;
  final String destinationSubtitle;
  final Color? accentColor;

  /// controla o comprimento total da linha pontilhada (altura entre ícones)
  final double lineHeight;

  /// altura do traço (dash) e espaço entre dashes
  final double lineDashHeight;
  final double lineGap;

  /// espessura do traço
  final double lineStrokeWidth;

  final double iconColumnWidth;

  const RoutePoints({
    Key? key,
    required this.originTitle,
    required this.originSubtitle,
    required this.destinationTitle,
    required this.destinationSubtitle,
    this.accentColor,
    this.lineHeight = 12, // default: 72px de linha entre ícones
    this.lineDashHeight = 1,
    this.lineGap = 4,
    this.lineStrokeWidth = 2,
    this.iconColumnWidth = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? Theme.of(context).colorScheme.primary;

    Widget originIconStacked({
      required Color color,
      double pinSize = 36,            // tamanho total do container
      double pinIconSize = 30,        // size do Icons.location_on (a "sombra" maior)
      double innerPinSize = 24,       // size do Icons.location_on em branco (empilha sobre a sombra)
      double personCircleSize = 25,   // círculo branco por trás da pessoa (contraste)
      double personIconSize = 20,     // size do ícone de pessoa
      double personOffsetY = 0.0,     // deslocamento vertical da pessoa (positivo desce, negativo sobe)
      double personOffsetX = 0.0,     // deslocamento horizontal se precisar
    }) {
      return SizedBox(
        width: pinSize,
        height: pinSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // camada de sombra / pin grande (atras)
            Icon(Icons.location_on, color: color, size: pinIconSize),

            // camada branca menor (dá contraste ao ícone da pessoa)
            Positioned(
              //left: (pinSize - personCircleSize) / 2 + personOffsetX,
              top: (pinSize - personCircleSize) / 2 + personOffsetY,
              child: Icon(Icons.location_on, color: Colors.white, size: innerPinSize),
            ),

            // ícone da pessoa, posicionado exatamente sobre o círculo
            Positioned(
              //left: (pinSize - personIconSize) / 2 + personOffsetX,
              top: (pinSize - personIconSize) / 2 + personOffsetY,
              child: Icon(Icons.person, color: color, size: 14),
            ),
          ],
        ),
      );
    }

    Widget destinationIcon({
      required Color color,
      double pinSize = 36,            // tamanho total do container
      double pinIconSize = 30,        // size do Icons.location_on (a "sombra" maior)
      double innerPinSize = 24,       // size do Icons.location_on em branco (empilha sobre a sombra)
      double personCircleSize = 30,   // círculo branco por trás da pessoa (contraste)
      double personIconSize = 16,     // size do ícone de pessoa
      double personOffsetY = 0.0,     // deslocamento vertical da pessoa (positivo desce, negativo sobe)
      double personOffsetX = 0.0,     // deslocamento horizontal se precisar
    }) {
      return SizedBox(
        width: pinSize,
        height: pinSize,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // camada de sombra / pin grande (atras)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: color, size: 28),
                const SizedBox(height: 4),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),

            Positioned(
              //left: (pinSize - personCircleSize) / 2 + personOffsetX,
              top: (pinSize - personCircleSize + 6) / 2 + personOffsetY,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
            ),

            // camada branca menor (dá contraste ao ícone da pessoa)
            Positioned(
              //left: (pinSize - personCircleSize) / 2 + personOffsetX,
              top: (pinSize - personCircleSize) / 2 + personOffsetY,
              child: Icon(Icons.location_on, color: Colors.white, size: (innerPinSize - 2)),
            ),
          ],
        ),
      );
    }

    Widget routeTextTile({required String title, required String subtitle}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // coluna de ícones + linha pontilhada (com altura controlada)
            SizedBox(
              width: iconColumnWidth,
              child: Column(
                children: [
                  originIconStacked(color: color),
                  const SizedBox(height: 6),
                  // Linha pontilhada com altura fixa (lineHeight)
                  SizedBox(
                    height: lineHeight,
                    child: Center(
                      child: _DashedLine(
                        color: Colors.grey.shade400,
                        dashHeight: lineDashHeight,
                        gap: lineGap,
                        strokeWidth: lineStrokeWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  destinationIcon(color: color),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // textos (origem + destino)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  routeTextTile(title: originTitle, subtitle: originSubtitle),
                  const SizedBox(height: 16),
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
    // Usamos CustomPaint com size infinito na vertical; o parent (SizedBox) controla a altura.
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}