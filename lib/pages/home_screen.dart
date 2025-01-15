import 'package:flutter/material.dart';
import 'package:myapp/components/playing_card.dart';

class HomeScreen extends StatelessWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
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
                  color: Colors.greenAccent,
                  blurRadius: 32,
                ),
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
