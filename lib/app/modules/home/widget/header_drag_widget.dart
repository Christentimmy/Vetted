

import 'package:flutter/material.dart';

class DraggableCreatePostWidget extends StatefulWidget {
  final VoidCallback onNavigate;
  final double width;

  const DraggableCreatePostWidget({
    super.key,
    required this.onNavigate,
    this.width = 200,
  });

  @override
  State<DraggableCreatePostWidget> createState() => _DraggableCreatePostWidgetState();
}

class _DraggableCreatePostWidgetState extends State<DraggableCreatePostWidget>
    with TickerProviderStateMixin {
  
  late AnimationController _slideController;
  late AnimationController _bounceController;
  late AnimationController _glowController;
  
  late Animation<double> _slideAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _glowAnimation;
  
  double _dragDistance = 0;
  bool _isDragging = false;
  bool _isCompleted = false;
  
  static const double _threshold = 100.0; // Distance needed to trigger action
  
  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _slideAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));
    
    _bounceAnimation = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.elasticOut,
    ));
    
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
  }
  
  @override
  void dispose() {
    _slideController.dispose();
    _bounceController.dispose();
    _glowController.dispose();
    super.dispose();
  }
  
  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _isCompleted = false;
    });
    _bounceController.forward().then((_) => _bounceController.reverse());
  }
  
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragDistance = (details.localPosition.dx - 24).clamp(0.0, _threshold);
    });
    
    // Update slide animation based on drag progress
    _slideController.value = _dragDistance / _threshold;
  }
  
  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
    
    if (_dragDistance >= _threshold) {
      // Complete the action
      _completeAction();
    } else {
      // Snap back
      _slideController.reverse();
      setState(() {
        _dragDistance = 0;
      });
    }
  }
  
  void _completeAction() {
    setState(() {
      _isCompleted = true;
    });
    
    // Animate to completion
    _slideController.forward().then((_) {
      // Trigger navigation after animation
      Future.delayed(const Duration(milliseconds: 200), () {
        widget.onNavigate();
        _resetWidget();
      });
    });
  }
  
  void _resetWidget() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _dragDistance = 0;
          _isCompleted = false;
        });
        _slideController.reset();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_slideAnimation, _bounceAnimation, _glowAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _bounceAnimation.value,
          child: Container(
            height: 48,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(_glowAnimation.value * 0.3),
                  blurRadius: 8,
                  spreadRadius: _isDragging ? 2 : 0,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                
                // Progress indicator
                if (_dragDistance > 0)
                  Container(
                    width: _dragDistance + 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red.shade600,
                          Colors.red.shade800,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                
                // Content
                GestureDetector(
                  onPanStart: _onPanStart,
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Draggable icon
                        Transform.translate(
                          offset: Offset(_dragDistance, 0),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: _isCompleted ? Colors.green : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isCompleted ? Icons.check : Icons.edit_square,
                              color: _isCompleted ? Colors.white : Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                        
                        // Arrow indicators
                        Expanded(
                          child: _buildArrowTrail(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildArrowTrail() {
    final progress = _dragDistance / _threshold;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(4, (index) {
        final opacity = _calculateArrowOpacity(index, progress);
        final scale = _calculateArrowScale(index, progress);
        
        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Transform.scale(
            scale: scale,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(opacity),
              size: 14,
            ),
          ),
        );
      }),
    );
  }
  
  double _calculateArrowOpacity(int index, double progress) {
    final baseOpacity = [0.4, 0.6, 0.8, 1.0][index];
    final animatedOpacity = (progress * 2 - index * 0.2).clamp(0.0, 1.0);
    return baseOpacity * (0.3 + 0.7 * animatedOpacity);
  }
  
  double _calculateArrowScale(int index, double progress) {
    final wave = (progress * 4 - index).clamp(0.0, 1.0);
    return 0.8 + 0.4 * wave;
  }
}
