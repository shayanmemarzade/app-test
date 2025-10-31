import 'package:flutter/material.dart';

import '../models/friend.dart';
import '../models/gift.dart';

final friends = [
  Friend(
    id: 'friend_alex',
    name: 'Alex Doe',
    username: '@alexd',
    avatarUrl:
        'https://images.unsplash.com/photo-1614284826691-7095b1448d1d?auto=format&fit=crop&w=200&q=80',
    nextBirthday: DateTime.now().add(const Duration(days: 12)),
    wishlist: const [
      WishlistItem(
        title: 'DJI Mini 4 Pro Drone',
        subtitle: 'Perfect for capturing hiking adventures',
        priceRange: '€500 goal',
        imageUrl:
            'https://images.unsplash.com/photo-1504208434309-cb69f4fe52b0?auto=format&fit=crop&w=900&q=80',
      ),
      WishlistItem(
        title: 'AcousticPro Headphones',
        subtitle: 'Immersive noise-cancelling sound',
        priceRange: '\$249.99',
        imageUrl:
            'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?auto=format&fit=crop&w=900&q=80',
      ),
    ],
    pastGifts: const [
      PastGift(title: 'AirPods Pro', occasion: '25th Birthday', year: 2023),
      PastGift(
        title: 'Barista Express Coffee Machine',
        occasion: 'Housewarming',
        year: 2022,
      ),
      PastGift(title: 'Premium Yoga Mat', occasion: 'Christmas', year: 2021),
    ],
  ),
  Friend(
    id: 'friend_jessica',
    name: 'Jessica Miller',
    username: '@jessica',
    avatarUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
    nextBirthday: DateTime.now().add(const Duration(days: 5)),
    wishlist: const [
      WishlistItem(
        title: 'AcousticPro Headphones',
        subtitle: '\$75 of \$249.99 raised',
        priceRange: 'Contribute',
        imageUrl:
            'https://images.unsplash.com/photo-1517423440428-a5a00ad493e8?auto=format&fit=crop&w=900&q=80',
      ),
      WishlistItem(
        title: 'The Starlight Painting',
        subtitle: 'Bring some magic to her studio',
        priceRange: '\$320 goal',
        imageUrl:
            'https://images.unsplash.com/photo-1511765224389-37f0e77cf0eb?auto=format&fit=crop&w=900&q=80',
      ),
    ],
    pastGifts: const [
      PastGift(title: 'Wacom Tablet', occasion: 'Birthday', year: 2022),
      PastGift(title: 'Paris Trip Fund', occasion: 'Anniversary', year: 2021),
    ],
  ),
];

final sampleGift = Gift(
  id: 'gift_dji_drone',
  title: 'DJI Mini 4 Pro Drone',
  imageUrl:
      'https://images.unsplash.com/photo-1523961131990-5ea7c61b2107?auto=format&fit=crop&w=1200&q=80',
  goalAmount: 500,
  raisedAmount: 325,
  occasion: "Alex's Birthday",
  organizer: 'David Smith',
  contributors: const [
    Contributor(
      name: 'Sarah',
      avatarUrl:
          'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=80',
    ),
    Contributor(
      name: 'Emily',
      avatarUrl:
          'https://images.unsplash.com/photo-1504593811423-6dd665756598?auto=format&fit=crop&w=200&q=80',
    ),
    Contributor(
      name: 'Jordan',
      avatarUrl:
          'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?auto=format&fit=crop&w=200&q=80',
    ),
    Contributor(
      name: 'Miguel',
      avatarUrl:
          'https://images.unsplash.com/photo-1544723795-432537f7b8c4?auto=format&fit=crop&w=200&q=80',
    ),
  ],
  description:
      "Alex has been talking about getting a drone for ages to capture his hiking adventures. The DJI Mini 4 Pro is super lightweight, easy to fly, and shoots incredible 4K video. Let's all chip in to get him the best gear for his next trip!",
);

class NotificationItem {
  const NotificationItem({
    required this.title,
    required this.body,
    required this.timeLabel,
    this.type = NotificationType.general,
    this.actionLabel,
  });

  final String title;
  final String body;
  final String timeLabel;
  final NotificationType type;
  final String? actionLabel;
}

enum NotificationType { all, gifts, social, general }

final notifications = [
  const NotificationItem(
    title: 'New Contribution',
    body: "Alex contributed to Sarah's Birthday Gift.",
    timeLabel: '2m ago',
    type: NotificationType.gifts,
    actionLabel: 'View Gift',
  ),
  const NotificationItem(
    title: 'Friend Request',
    body: 'Ben wants to be your friend.',
    timeLabel: '5m ago',
    type: NotificationType.social,
    actionLabel: 'Accept',
  ),
  const NotificationItem(
    title: 'Goal Reached!',
    body: "Maya's Graduation Gift has been fully funded.",
    timeLabel: '1d ago',
    type: NotificationType.gifts,
    actionLabel: 'Purchase Gift',
  ),
  const NotificationItem(
    title: 'Upcoming Birthday',
    body: "It's Leo's birthday tomorrow!",
    timeLabel: '1d ago',
    type: NotificationType.all,
    actionLabel: 'Start a gift',
  ),
];

final upcomingBirthdays = [
  (
    friend: friends.first,
    goal: 150.0,
    raised: 75.0,
  ),
  (
    friend: friends[1],
    goal: 200.0,
    raised: 120.0,
  ),
];

final whatsNew = [
  'Alex Chen just added a new item to his wishlist.',
  "Maya Singh contributed to Olivia's birthday gift.",
  'Your gift for James Smith was successfully sent!',
];

final createGiftSteps = [
  const _CreateGiftStep(
    title: 'Who is the gift for?',
    description: 'Select a friend to surprise.',
  ),
  const _CreateGiftStep(
    title: 'What are you celebrating?',
    description: 'Birthday, graduation, baby shower, and more.',
  ),
  const _CreateGiftStep(
    title: 'Set the funding goal',
    description: 'Decide how much you want to raise together.',
  ),
  const _CreateGiftStep(
    title: 'Share with friends',
    description: 'Invite contributors and make it happen.',
  ),
];

class _CreateGiftStep {
  const _CreateGiftStep({required this.title, required this.description});

  final String title;
  final String description;
}

List<_CreateGiftStep> get createGiftWizard => createGiftSteps;
