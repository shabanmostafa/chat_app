import 'package:flutter/material.dart';

class IdenyifySection extends StatelessWidget {
  const IdenyifySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75),
          child: Image.asset(
            'assets/images/scholar.png',
            height: 100,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'shaban Meeting',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
