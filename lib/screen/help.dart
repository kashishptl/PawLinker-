import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final List<_HelpItem> _helpItems = [
    _HelpItem(
      question: '📦 How do I track my orders or delivery?',
      answer:
          'You can track your orders in real-time from the Orders screen. Notifications are sent when your pet food, toys, or accessories are shipped. If there are issues, contact support below.',
    ),
    _HelpItem(
      question: '🐶 How does pet adoption work?',
      answer:
          'Browse pets under the Adopt tab. Tap a pet to view age, breed, and health info. Follow on-screen steps or contact us for paperwork support.',
    ),
    _HelpItem(
      question: '🛒 How can I buy food, toys, and accessories?',
      answer:
          'Go to the Shop tab to explore items. Use filters for pet type, price, etc. Add items to cart and checkout with ease.',
    ),
    _HelpItem(
      question: '❤️ Where can I find pet care tips?',
      answer:
          'We post weekly pet parenting tips on the homepage. Recommendations are tailored based on what pet you’ve adopted or purchased.',
    ),
    _HelpItem(
      question: '🤝 How do I contact support?',
      answer: '📧 Email: support@pawlinker.help\n📞 Phone: +91 98765 43210\nAvailable: Mon–Sat, 9 AM – 7 PM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _helpItems.length,
        itemBuilder: (context, index) {
          return _ExpandableHelpTile(item: _helpItems[index]);
        },
      ),
    );
  }
}

class _HelpItem {
  final String question;
  final String answer;
  bool isExpanded;

  _HelpItem({required this.question, required this.answer, this.isExpanded = false});
}

class _ExpandableHelpTile extends StatefulWidget {
  final _HelpItem item;

  const _ExpandableHelpTile({super.key, required this.item});

  @override
  State<_ExpandableHelpTile> createState() => _ExpandableHelpTileState();
}

class _ExpandableHelpTileState extends State<_ExpandableHelpTile> {
  bool _isExpanded = false;
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.item.isExpanded;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      widget.item.isExpanded = _isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: _toggleExpanded,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(widget.item.question, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                ],
              ),
              AnimatedContainer(
                duration: _duration,
                curve: Curves.easeInOut,
                height: _isExpanded ? null : 0,
                padding: _isExpanded ? const EdgeInsets.only(top: 10) : EdgeInsets.zero,
                child: _isExpanded ? Text(widget.item.answer, style: const TextStyle(fontSize: 15)) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
