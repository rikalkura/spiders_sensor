import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rock Paper Scissors',
      home: RPSGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RPSGame extends StatefulWidget {
  const RPSGame({super.key});

  @override
  State<RPSGame> createState() => _RPSGameState();
}

class _RPSGameState extends State<RPSGame> {
  final List<String> options = ['Rock', 'Paper', 'Scissors'];
  String _playerChoice = '';
  String _computerChoice = '';
  String _result = '';
  int _playerScore = 0;
  int _computerScore = 0;
  bool _gameOver = false;
  String _winner = '';

  void _play(String playerChoice) {
    if (_gameOver) return;

    final random = Random();
    final computerChoice = options[random.nextInt(3)];

    String result;
    if (playerChoice == computerChoice) {
      result = 'Draw';
    } else if (
    (playerChoice == 'Rock' && computerChoice == 'Scissors') ||
        (playerChoice == 'Paper' && computerChoice == 'Rock') ||
        (playerChoice == 'Scissors' && computerChoice == 'Paper')
    ) {
      result = 'You Win!';
      _playerScore++;
    } else {
      result = 'You Lose!';
      _computerScore++;
    }

    if (_playerScore == 5 || _computerScore == 5) {
      _gameOver = true;
      _winner = _playerScore == 5 ? 'Player' : 'Computer';
    }

    setState(() {
      _playerChoice = playerChoice;
      _computerChoice = computerChoice;
      _result = result;
    });
  }

  void _resetGame() {
    setState(() {
      _playerScore = 0;
      _computerScore = 0;
      _playerChoice = '';
      _computerChoice = '';
      _result = '';
      _gameOver = false;
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$_winner Wins!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetGame,
                child: const Text('Play Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Rock Paper Scissors')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose your move:', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options.map((option) {
                return ElevatedButton(
                  onPressed: () => _play(option),
                  child: Text(option),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Text(
              'You chose: $_playerChoice',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Computer chose: $_computerChoice',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Player Score', style: TextStyle(fontSize: 16)),
                    Text(
                      '$_playerScore',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text
                      ('Computer Score', style: TextStyle(fontSize: 16)),
                    Text(
                      '$_computerScore',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
