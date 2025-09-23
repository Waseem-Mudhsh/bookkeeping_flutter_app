import 'package:flutter/material.dart';

class MesterCard extends StatelessWidget {
final  String id;
   final Color color;
  final String balance;
  const MesterCard({
    super.key,
    required this.balance,
    required this.color,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Stack(
        children: [
          // for rectangular box in card
          
          cardBackground(size: 160, pBottom: -50),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    masterCardLogo(),
                    Text(
                      id,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Mastercard",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          balance,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Container(
                     
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 24,
                        
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Positioned cardBackground({
    double size = 40,
    double? pTop,
    double? pBottom,
    double? pLeft,
    double? pRight,
  }) =>
      Positioned(
        left: pLeft,
        top: pTop,
        bottom: pBottom,
        right: pRight,
        child: Transform.rotate(
          angle: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(size / 6),
            ),
            height: size,
            width: size,
          ),
        ),
      );

  SizedBox masterCardLogo() {
    return SizedBox(
      width: 100,
      child: Stack(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          Positioned(
            left: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticsData extends StatelessWidget {
  const StatisticsData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Statistics",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.tune,
                  size: 32,
                  color: Colors.black,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.orange,
            ),
            child: Row(
              
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.black26,
                  ),
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFFE9AA4E),
                    ),
                    child: const Center(
                      child: Text(
                        "55%",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text(
                      "Average Spand",
                      style: TextStyle(
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      "{${10010}}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Icon(
                          Icons.file_open,
                          color: Colors.white,
                          size: 18,
                        ),
                          SizedBox(
                          width: 10,
                        ),
                         Text(
                          "Report",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

