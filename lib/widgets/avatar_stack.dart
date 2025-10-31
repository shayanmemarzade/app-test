import 'package:flutter/material.dart';

class AvatarStack extends StatelessWidget {
  const AvatarStack({super.key, required this.avatarUrls});

  final List<String> avatarUrls;

  @override
  Widget build(BuildContext context) {
    final overlap = 16.0;
    return SizedBox(
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < avatarUrls.length; i++)
            Positioned(
              left: i * overlap,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(avatarUrls[i]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
