import 'package:flutter/material.dart';
import 'package:myapp/components/playing_card.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSuitSection(
                  'Hearts ${CardSuit.hearts.symbol}', CardSuit.hearts),
              const SizedBox(height: 40),
              _buildSuitSection(
                  'Diamonds ${CardSuit.diamonds.symbol}', CardSuit.diamonds),
              const SizedBox(height: 40),
              _buildSuitSection(
                  'Clubs ${CardSuit.clubs.symbol}', CardSuit.clubs),
              const SizedBox(height: 40),
              _buildSuitSection(
                  'Spades ${CardSuit.spades.symbol}', CardSuit.spades),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuitSection(String title, CardSuit suit) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                    offset: Offset(2, 2), color: Colors.black38, blurRadius: 8),
              ],
            ),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 15,
              itemBuilder: (context, index) {
                return index < 13
                    ? PlayingCard(
                        suit: suit,
                        value: index + 1,
                      )
                    : PlayingCard(
                        suit: suit,
                        value: 1,
                        isFaceUp: false,
                      );
              }),
        ],
      );
}
