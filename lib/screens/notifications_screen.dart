import 'package:flutter/material.dart';

import '../data/sample_data.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings_outlined),
          )
        ],
        bottom: TabBar(
          controller: _controller,
          labelColor: const Color(0xFFFF8A65),
          unselectedLabelColor: Colors.grey[500],
          indicatorColor: const Color(0xFFFF8A65),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Gifts'),
            Tab(text: 'Social'),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 56,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              scrollDirection: Axis.horizontal,
              itemCount: NotificationType.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final type = NotificationType.values[index];
                final isSelected = _selectedFilter == index;
                return ChoiceChip(
                  label: Text(type.name[0].toUpperCase() + type.name.substring(1)),
                  selected: isSelected,
                  onSelected: (_) => setState(() => _selectedFilter = index),
                );
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: [
                _NotificationList(
                  items: notifications,
                ),
                _NotificationList(
                  items: notifications
                      .where((item) => item.type == NotificationType.gifts)
                      .toList(),
                ),
                _NotificationList(
                  items: notifications
                      .where((item) => item.type == NotificationType.social)
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList({required this.items});

  final List<NotificationItem> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (items.isEmpty) {
      return Center(
        child: Text(
          'No notifications here yet',
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey[500]),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: const NetworkImage(
                'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&w=200&q=80',
              ),
            ),
            title: Text(item.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  item.body,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  item.timeLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            trailing: item.actionLabel != null
                ? TextButton(
                    onPressed: () {},
                    child: Text(item.actionLabel!),
                  )
                : null,
          ),
        );
      },
    );
  }
}
