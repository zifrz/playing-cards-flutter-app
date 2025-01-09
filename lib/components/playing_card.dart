import 'package:flutter/material.dart';

// Move constants outside the class for better memory usage
const double _cardScale = 20.0;
const double _cardWidth = 5.0 * _cardScale;
const double _cardHeight = 7.0 * _cardScale;
const EdgeInsets _cardPadding = EdgeInsets.all(12.0);
const double _symbolFontSize = 40.0;
const double _labelFontSize = 28.0;

// Use enum for better type safety
enum CardSuit {
  hearts('♥'),
  diamonds('♦'),
  clubs('♣'),
  spades('♠');

  final String symbol;
  const CardSuit(this.symbol);

  Color get color =>
      (this == hearts || this == diamonds) ? Colors.red : Colors.black;
}

class PlayingCard extends StatelessWidget {
  final CardSuit suit;
  final int value;
  final bool isFaceUp;

  // Add const constructor for better performance
  const PlayingCard({
    super.key,
    required this.suit,
    required this.value,
    this.isFaceUp = true,
  }) : assert(value >= 1 && value <= 13, 'Card value must be between 1 and 13');

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: SizedBox(
        width: _cardWidth,
        height: _cardHeight,
        child: isFaceUp ? _buildFrontCard() : _buildBackCard(),
      ),
    );
  }

  Widget _buildBackCard() {
    return Padding(
      padding: _cardPadding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.brown, // Background color for the back of the card
        ),
        child: ClipRect(
          child: CustomPaint(
            painter: _CardBackPainter(), // Custom painter for design
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Padding(
      padding: _cardPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: _buildCardLabel(),
          ),
          Center(
            child: Text(
              suit.symbol,
              style: TextStyle(
                fontSize: _symbolFontSize,
                color: suit.color,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Transform.rotate(
              angle: 3.14159, // PI
              child: _buildCardLabel(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardLabel() {
    return Text(
      _getDisplayValue(),
      style: TextStyle(
        fontSize: _labelFontSize,
        fontWeight: FontWeight.bold,
        height: 0,
        color: suit.color,
      ),
    );
  }

  String _getDisplayValue() {
    switch (value) {
      case 1:
        return 'A';
      case 11:
        return 'J';
      case 12:
        return 'Q';
      case 13:
        return 'K';
      default:
        return value.toString();
    }
  }
}

class _CardBackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double stripeSpacing = 30;
    final width = size.width;
    final height = size.height;

    // Draw diagonal stripes from top-left to bottom-right
    for (double x = -height; x < width; x += stripeSpacing) {
      final double startX = x.clamp(0, width);
      final double startY = (x < 0) ? -x : 0;

      final double endX = (x + height).clamp(0, width);
      final double endY =
          (x + height > width) ? height - (x + height - width) : height;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }

    // Draw diagonal stripes from top-right to bottom-left
    for (double x = width + height; x > 0; x -= stripeSpacing) {
      final double startX = (x > width) ? width : x;
      final double startY = (x > width) ? x - width : 0;

      final double endX = (x - height > 0) ? x - height : 0;
      final double endY = (x - height > 0) ? height : x;

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
