import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF343434),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 160, 0, 0),
        child: Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ScoreCard(
                  subject: 'Flutter',
                  initialScore: 5,
                  gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade200])
                ),
                const SizedBox(height: 24),
                ScoreCard(
                  subject: 'Dart',
                  initialScore: 3,
                  gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade200])
                ),
                const SizedBox(height: 24),
                ScoreCard(
                  subject: 'React',
                  initialScore: 10,
                  gradient: LinearGradient(colors: [Colors.blue.shade600, Colors.blue.shade200])
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
);

class ScoreCard extends StatefulWidget {
  final String subject;
  final int initialScore;
  final Gradient gradient;

  const ScoreCard({
    super.key,
    required this.subject,
    required this.initialScore,
    required this.gradient,
  });

  @override
  State<ScoreCard> createState() => _ScoreCardState();
}

class _ScoreCardState extends State<ScoreCard> {
  static const _minScore = 1;
  static const _maxScore = 10;

  late int _score = widget.initialScore.clamp(_minScore, _maxScore);

  void _changeScore(int amount) {
    setState(() {
      _score = (_score + amount).clamp(_minScore, _maxScore);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'My score in ${widget.subject}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: 'Decrease ${widget.subject} score',
                  onPressed: _score > _minScore ? () => _changeScore(-1) : null,
                  icon: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text('$_score / $_maxScore'),
                ),
                IconButton(
                  tooltip: 'Increase ${widget.subject} score',
                  onPressed: _score < _maxScore ? () => _changeScore(1) : null,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _ScoreBar(fraction: _score / _maxScore, gradient: widget.gradient),
          ],
        ),
      ),
    );
  }
}

class _ScoreBar extends StatelessWidget {
  const _ScoreBar({required this.fraction, required this.gradient});

  final double fraction;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return SizedBox(
      height: 44,
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: borderRadius,
            ),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: fraction,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
