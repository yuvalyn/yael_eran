import 'package:flutter/material.dart';

class AnimatedFloatingActionButton extends StatefulWidget {
  final bool showAnimation;
  final VoidCallback onAddPress;

  const AnimatedFloatingActionButton({
    super.key,
    required this.showAnimation,
    required this.onAddPress,
  });

  @override
  State<AnimatedFloatingActionButton> createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: -20, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.showAnimation) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(AnimatedFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showAnimation != oldWidget.showAnimation) {
      if (widget.showAnimation) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: FloatingActionButton(
            onPressed: widget.onAddPress,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
