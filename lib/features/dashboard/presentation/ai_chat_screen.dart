
import 'package:flutter/material.dart';

const Color aiBlue = Color(0xFF1769FF);
const Color aiDark = Color(0xFF10204A);
const Color aiBackground = Color(0xFFF3F6FC);

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _category = 'All';
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text':
          'Hi there! 👋 I’m your InsureAI assistant.\n\n'
          'I can help you explore insurance options, understand coverage, '
          'compare premiums, and plan your monthly payments.\n\n'
          'What would you like help with today?',
    },
  ];

  final List<String> _categories = [
    'All',
    'Health',
    'Vehicle',
    'Life',
    'EMI',
  ];

  final List<Map<String, dynamic>> _suggestions = [
    {
      'icon': Icons.favorite_rounded,
      'title': 'Health insurance',
      'subtitle': 'Find suitable health coverage',
      'prompt': 'Help me understand health insurance options',
    },
    {
      'icon': Icons.directions_car_rounded,
      'title': 'Vehicle insurance',
      'subtitle': 'Explore car and bike coverage',
      'prompt': 'What should I compare in vehicle insurance?',
    },
    {
      'icon': Icons.account_balance_wallet_rounded,
      'title': 'Manage my budget',
      'subtitle': 'Understand premiums and EMI',
      'prompt': 'Help me plan my insurance budget',
    },
    {
      'icon': Icons.compare_arrows_rounded,
      'title': 'Compare insurance',
      'subtitle': 'Learn how to compare plans',
      'prompt': 'How can I compare two insurance plans?',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? suggestedText]) {
    final text = (suggestedText ?? _controller.text).trim();

    if (text.isEmpty || _isTyping) return;

    setState(() {
      _messages.add({'isUser': true, 'text': text});
      _controller.clear();
      _isTyping = true;
    });

    _scrollToBottom();

    // Demo response only. Replace this with your AI API call.
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;

      setState(() {
        _messages.add({
          'isUser': false,
          'text': _getDemoReply(text),
        });
        _isTyping = false;
      });

      _scrollToBottom();
    });
  }

  String _getDemoReply(String question) {
    final q = question.toLowerCase();

    if (q.contains('health') || q.contains('hospital')) {
      return 'Let’s explore health insurance! 💙\n\n'
          'When comparing plans, look at:\n\n'
          '• Hospitalisation coverage\n'
          '• Network hospitals and cashless treatment\n'
          '• Waiting periods and exclusions\n'
          '• Sum insured and room limits\n'
          '• Premium and claim settlement conditions\n\n'
          'To narrow down your options, consider your age, budget, '
          'and whether you need individual or family coverage.';
    }

    if (q.contains('vehicle') || q.contains('car') || q.contains('bike')) {
      return 'Let’s look at vehicle insurance! 🚗\n\n'
          'Compare these important factors:\n\n'
          '• Third-party versus comprehensive cover\n'
          '• Insured Declared Value (IDV)\n'
          '• Deductibles and add-on covers\n'
          '• Garage network and claim process\n'
          '• Premium and policy exclusions\n\n'
          'Your vehicle type, age, and usage can help determine '
          'which coverage to explore.';
    }

    if (q.contains('budget') || q.contains('emi') || q.contains('premium')) {
      return 'Let’s make your insurance budget easier to manage! 📊\n\n'
          '1. List your monthly income and essential expenses.\n'
          '2. Add up existing EMIs and insurance premiums.\n'
          '3. Compare annual and monthly payment options.\n'
          '4. Keep an emergency fund for unexpected expenses.\n\n'
          'Share your approximate monthly budget if you’d like '
          'help organising your expenses.';
    }

    if (q.contains('compare')) {
      return 'A useful insurance comparison should include:\n\n'
          '• Coverage and sum insured\n'
          '• Premium and deductibles\n'
          '• Waiting periods and exclusions\n'
          '• Claim procedures and service support\n'
          '• Renewal conditions and add-ons\n\n'
          'The cheapest plan is not always the best fit. '
          'Check the policy wording before choosing.';
    }

    return 'I can help you explore insurance and financial planning. 💙\n\n'
        'For a useful starting point, tell me:\n'
        '• Which type of insurance interests you?\n'
        '• What is your approximate budget?\n'
        '• Who or what do you want to protect?\n\n'
        'I’ll help you identify the key factors to compare. '
        'This demo uses sample responses, not a live AI service.';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: aiBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: aiDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [aiBlue, Color(0xFF65A3FF)],
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(width: 11),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'InsureAI Assistant',
                    style: TextStyle(
                      color: aiDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3),
                  Row(
                    children: [
                      CircleAvatar(radius: 3, backgroundColor: Colors.green),
                      SizedBox(width: 5),
                      Text(
                        'Insurance guide',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'New chat',
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'isUser': false,
                  'text':
                      'New conversation started! 👋\n\n'
                      'What insurance question can I help you explore?',
                });
                _isTyping = false;
              });
            },
            icon: const Icon(Icons.add_comment_outlined, color: aiDark),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _categorySelector(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return _typingIndicator();
                  }

                  final message = _messages[index];
                  return _messageBubble(
                    text: message['text'] as String,
                    isUser: message['isUser'] as bool,
                  );
                },
              ),
            ),
            if (_messages.length == 1 && !_isTyping) _suggestionCards(),
            _inputBar(),
          ],
        ),
      ),
    );
  }

  Widget _categorySelector() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 13),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((category) {
            final selected = _category == category;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(category),
                selected: selected,
                showCheckmark: false,
                selectedColor: aiBlue,
                backgroundColor: const Color(0xFFF0F4FA),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : aiDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                side: BorderSide.none,
                onSelected: (_) {
                  setState(() => _category = category);
                  if (category != 'All') {
                    _controller.text = 'Help me explore $category insurance';
                    _controller.selection = TextSelection.collapsed(
                      offset: _controller.text.length,
                    );
                  }
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _messageBubble({
    required String text,
    required bool isUser,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [aiBlue, Color(0xFF65A3FF)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 19,
              ),
            ),
            const SizedBox(width: 9),
          ],
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 560),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isUser ? aiBlue : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(19),
                  topRight: const Radius.circular(19),
                  bottomLeft: Radius.circular(isUser ? 19 : 5),
                  bottomRight: Radius.circular(isUser ? 5 : 19),
                ),
                boxShadow: [
                  BoxShadow(
                    color: aiDark.withOpacity(0.035),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: SelectableText(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : aiDark,
                  fontSize: 13,
                  height: 1.65,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typingIndicator() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 15, left: 43),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 10),
                Text(
                  'Thinking...',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _suggestionCards() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TRY ASKING',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _suggestions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = _suggestions[index];
                final color = [
                  aiBlue,
                  const Color(0xFFE84F67),
                  const Color(0xFF159C75),
                  const Color(0xFF845BEA),
                ][index];

                return SizedBox(
                  width: 205,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(17),
                      onTap: () => _sendMessage(item['prompt'] as String),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              color: color,
                              size: 22,
                            ),
                            const Spacer(),
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                color: aiDark,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item['subtitle'] as String,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: aiDark.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: 'Ask about insurance...',
                hintStyle: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: aiBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [aiBlue, Color(0xFF65A3FF)],
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: IconButton(
              tooltip: 'Send message',
              onPressed: _isTyping ? null : () => _sendMessage(),
              icon: const Icon(Icons.arrow_upward_rounded),
              color: Colors.white,
              iconSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
