import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/friend.dart';

class FriendProfileScreen extends StatelessWidget {
  const FriendProfileScreen({super.key, this.friend});

  final Friend? friend;

  @override
  Widget build(BuildContext context) {
    final selectedFriend = friend ?? friends.firstWhere(
      (friend) => friend.id == 'friend_jessica',
      orElse: () => friends.first,
    );
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${selectedFriend.name.split(' ').first}'s Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(selectedFriend.avatarUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    selectedFriend.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    selectedFriend.username,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    avatar: const Icon(Icons.cake_outlined, size: 18),
                    label: Text(
                      'Birthday in ${selectedFriend.nextBirthday.difference(DateTime.now()).inDays} days',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "${selectedFriend.name.split(' ').first}'s Wishlist",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: selectedFriend.wishlist.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = selectedFriend.wishlist[index];
                  return SizedBox(
                    width: 220,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                              ),
                              child: Image.network(
                                item.imageUrl ??
                                    'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=900&q=80',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.subtitle,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(44),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                  child: Text(item.priceRange),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Gifts We've Given',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            ...selectedFriend.pastGifts.map(
              (gift) => Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange[100],
                    child: const Icon(Icons.card_giftcard, color: Color(0xFFFF8A65)),
                  ),
                  title: Text(gift.title),
                  subtitle: Text(gift.occasion),
                  trailing: Text(gift.year.toString()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
