import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BidirectionalVoteSwitch extends StatefulWidget {
  final String? leadingFlag; // "green", "red", or null
  final int? greenCount;
  final int? redCount;
  final Function(String vote) onVote; // Callback when user votes
  final double width;
  final double height;
  final bool? hasVoted;
  final String? votedColor;

  const BidirectionalVoteSwitch({
    super.key,
    this.leadingFlag,
    this.greenCount,
    this.redCount,
    required this.onVote,
    this.width = 70,
    this.height = 40,
    this.hasVoted,
    this.votedColor,
  });

  @override
  State<BidirectionalVoteSwitch> createState() =>
      _BidirectionalVoteSwitchState();
}

class _BidirectionalVoteSwitchState extends State<BidirectionalVoteSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _dragPosition = 0.0; // -1 to 1, 0 is center
  bool _isDragging = false;
  String? _tempVote;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Set initial position based on current vote
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialPosition();
    });
  }

  void _setInitialPosition() {
    // If user has voted, position flag according to their vote
    if (widget.hasVoted == true) {
      if (widget.votedColor == 'green') {
        _dragPosition = 1.0;
      } else if (widget.votedColor == 'red') {
        _dragPosition = -1.0;
      } else {
        _dragPosition = 0.0;
      }
    } else {
      // User hasn't voted, keep flag in center
      _dragPosition = 0.0;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(BidirectionalVoteSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.votedColor != widget.votedColor ||
        oldWidget.hasVoted != widget.hasVoted) {
      _setInitialPosition();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      final delta = details.delta.dx / (widget.width / 2);
      _dragPosition = (_dragPosition + delta).clamp(-1.0, 1.0);

      // Determine temp vote based on position
      if (_dragPosition > 0.3) {
        _tempVote = 'green';
      } else if (_dragPosition < -0.3) {
        _tempVote = 'red';
      } else {
        _tempVote = null;
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });

    // Determine final vote based on position
    if (_dragPosition > 0.4) {
      // Vote green
      widget.onVote('green');
      _animateToPosition(1.0);
    } else if (_dragPosition < -0.4) {
      // Vote red
      widget.onVote('red');
      _animateToPosition(-1.0);
    } else {
      // Return to center or current vote position
      if (widget.hasVoted == true) {
        if (widget.votedColor == 'green') {
          _animateToPosition(1.0);
        } else if (widget.votedColor == 'red') {
          _animateToPosition(-1.0);
        } else {
          _animateToPosition(0.0);
        }
      } else {
        _animateToPosition(0.0);
      }
    }
    _tempVote = null;
  }

  void _animateToPosition(double target) {
    final start = _dragPosition;
    _controller.reset();
    _animation = Tween<double>(
      begin: start,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _animation.addListener(() {
      setState(() {
        _dragPosition = _animation.value;
      });
    });

    _controller.forward();
  }

  Color _getBackgroundColor() {
    if (_isDragging && _tempVote != null) {
      return _tempVote == 'green'
          ? Colors.green.withValues(alpha: 0.3)
          : Colors.red.withValues(alpha: 0.3);
    }

    if (widget.leadingFlag == 'green') {
      return Colors.green.withValues(alpha: 0.2);
    } else if (widget.leadingFlag == 'red') {
      return Colors.red.withValues(alpha: 0.2);
    }

    return Colors.black.withValues(alpha: 0.3);
  }

  Color _getFlagColor() {
    if (_isDragging && _tempVote != null) {
      return _tempVote == 'green' ? Colors.green : Colors.red;
    }

    if (widget.leadingFlag == 'green') {
      return Colors.green;
    } else if (widget.leadingFlag == 'red') {
      return Colors.red;
    }

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track
          Container(
            width: widget.width,
            height: 20,
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(widget.height / 2),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                // Red side indicator
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      '${widget.redCount ?? 0}',
                      style: GoogleFonts.poppins(
                        color: Colors.red.withValues(alpha: 0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Green side indicator
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${widget.greenCount ?? 0}',
                      style: GoogleFonts.poppins(
                        color: Colors.green.withValues(alpha: 0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Draggable flag
          Positioned(
            left:
                ((widget.width - 32) / 2) +
                (_dragPosition * (widget.width - 32) / 2),
            top: (widget.height - 32) / 2,
            child: GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: _getFlagColor(), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.flag, size: 16, color: _getFlagColor()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
