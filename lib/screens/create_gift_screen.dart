import 'package:flutter/material.dart';

import '../data/sample_data.dart';
import '../models/friend.dart';

class CreateGiftScreen extends StatefulWidget {
  const CreateGiftScreen({super.key});

  @override
  State<CreateGiftScreen> createState() => _CreateGiftScreenState();
}

class _CreateGiftScreenState extends State<CreateGiftScreen> {
  int _currentStep = 0;
  Friend? _selectedFriend;
  String? _occasion;
  double _goal = 150;

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep += 1);
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Step ${_currentStep + 1} of 4'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).maybePop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              createGiftWizard[_currentStep].title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              createGiftWizard[_currentStep].description,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(child: _buildStepContent()),
            const SizedBox(height: 24),
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _previousStep,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep > 0) const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentStep == 3 ? _finish : _nextStep,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(_currentStep == 3 ? 'Create Gift Event' : 'Next'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _FriendSelection(
          friends: friends,
          selectedFriend: _selectedFriend,
          onSelect: (friend) => setState(() => _selectedFriend = friend),
        );
      case 1:
        return _OccasionSelection(
          selectedOccasion: _occasion,
          onChanged: (value) => setState(() => _occasion = value),
        );
      case 2:
        return _GoalSetting(
          goal: _goal,
          onChanged: (value) => setState(() => _goal = value),
        );
      default:
        return _Summary(
          friend: _selectedFriend,
          occasion: _occasion,
          goal: _goal,
        );
    }
  }

  void _finish() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Gift Event Ready!'),
        content: const Text(
          'We've prepared your surprise. Share it with friends to start raising funds!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Share Now'),
          ),
        ],
      ),
    );
  }
}

class _FriendSelection extends StatelessWidget {
  const _FriendSelection({
    required this.friends,
    required this.selectedFriend,
    required this.onSelect,
  });

  final List<Friend> friends;
  final Friend? selectedFriend;
  final ValueChanged<Friend> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search for a friend',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: friends.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final friend = friends[index];
              final isSelected = selectedFriend?.id == friend.id;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(
                    color: isSelected ? const Color(0xFFFF8A65) : Colors.grey[300]!,
                  ),
                ),
                leading: CircleAvatar(backgroundImage: NetworkImage(friend.avatarUrl)),
                title: Text(friend.name),
                trailing: TextButton(
                  onPressed: () => onSelect(friend),
                  child: Text(isSelected ? 'Selected' : 'Select'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _OccasionSelection extends StatelessWidget {
  const _OccasionSelection({required this.selectedOccasion, required this.onChanged});

  final String? selectedOccasion;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final occasions = [
      'Birthday',
      'Graduation',
      'Baby Shower',
      'Farewell',
      'Just Because',
    ];

    return ListView(
      children: [
        for (final occasion in occasions)
          Card(
            child: RadioListTile<String>(
              value: occasion,
              groupValue: selectedOccasion,
              onChanged: (value) {
                if (value != null) onChanged(value);
              },
              title: Text(occasion),
            ),
          ),
      ],
    );
  }
}

class _GoalSetting extends StatelessWidget {
  const _GoalSetting({required this.goal, required this.onChanged});

  final double goal;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set your funding goal',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 16),
        Text(
          goal.toStringAsFixed(0),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        Slider(
          value: goal,
          min: 50,
          max: 500,
          divisions: 9,
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
        Text(
          'Tip: Keep goals reachable to encourage quick wins! You can always stretch after.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({this.friend, this.occasion, required this.goal});

  final Friend? friend;
  final String? occasion;
  final double goal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: friend != null
                    ? NetworkImage(friend!.avatarUrl)
                    : null,
                child: friend == null ? const Icon(Icons.person) : null,
              ),
              title: Text(friend?.name ?? 'No friend selected yet'),
              subtitle: Text(occasion ?? 'Pick an occasion to personalize your surprise'),
            ),
            const Divider(height: 32),
            Row(
              children: [
                const Icon(Icons.savings_outlined, color: Color(0xFFFF8A65)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Target goal: ${goal.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Once created, you can invite contributors and track progress right from the dashboard.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
