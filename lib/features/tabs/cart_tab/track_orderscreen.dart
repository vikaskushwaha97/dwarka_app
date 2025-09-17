import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;
  final String estimatedDelivery;

  const TrackOrderScreen({
    Key? key,
    required this.orderId,
    required this.estimatedDelivery,
  }) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<DeliveryStep> _deliverySteps = [
    DeliveryStep(
      title: 'Order Confirmed',
      description: 'Your eyewear order is confirmed',
      icon: Iconsax.eye,
      time: '10:30 AM',
    ),
    DeliveryStep(
      title: 'Lens Crafting',
      description: 'Precision lens cutting in progress',
      icon: Iconsax.d_cube_scan,
      time: '11:15 AM',
    ),
    DeliveryStep(
      title: 'Frame Adjustments',
      description: 'Custom fitting your frames',
      icon: Iconsax.setting_4,
      time: '1:30 PM',
    ),
    DeliveryStep(
      title: 'Quality Check',
      description: 'Final inspection & cleaning',
      icon: Iconsax.tick_circle,
      time: '2:15 PM',
    ),
    DeliveryStep(
      title: 'Out for Delivery',
      description: 'Your glasses are on the way!',
      icon: Iconsax.truck,
      time: '2:45 PM',
    ),
    DeliveryStep(
      title: 'Delivered',
      description: 'Ready for pickup/delivery',
      icon: Iconsax.glass,
      time: 'Estimated 3:30 PM',
    ),
  ];

  int _currentStep = 4; // Currently at "Out for Delivery"

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutQuint,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Track Your Glasses',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.colorScheme.onBackground,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Spectacle Order Card
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSpectacleOrderCard(theme, primaryColor),
              ),
            ),

            const SizedBox(height: 32),

            // Crafting Process Timeline
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildTimelineHeader(theme),
              ),
            ),

            const SizedBox(height: 16),

            // Animated Crafting Timeline
            _buildCraftingTimeline(primaryColor),

            const SizedBox(height: 32),

            // Delivery Progress Visualization
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildDeliveryVisualization(theme, primaryColor),
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons for Spectacle Shop
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildSpectacleActions(theme, primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpectacleOrderCard(ThemeData theme, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withOpacity(0.1),
            primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Iconsax.eye,
                  color: primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order #${widget.orderId}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ready by: ${widget.estimatedDelivery}',
                      style: TextStyle(
                        color: theme.hintColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _deliverySteps[_currentStep].title,
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSpectacleInfoItem(Iconsax.clock, '2 days', 'Crafting Time'),
              _buildSpectacleInfoItem(Iconsax.eye, 'Blue Light', 'Lens Type'),
              _buildSpectacleInfoItem(Iconsax.colorfilter, 'Black', 'Frame Color'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpectacleInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineHeader(ThemeData theme) {
    return Text(
      'Crafting Journey',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: theme.colorScheme.onBackground,
      ),
    );
  }

  Widget _buildCraftingTimeline(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          _deliverySteps.length,
              (index) => _buildCraftingStep(
            _deliverySteps[index],
            index,
            index <= _currentStep,
            primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCraftingStep(
      DeliveryStep step,
      int index,
      bool isCompleted,
      Color primaryColor,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator with spectacle-themed icons
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted ? primaryColor : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                step.icon,
                size: 16,
                color: isCompleted ? Colors.white : Colors.grey[600],
              ),
            ),
            if (index < _deliverySteps.length - 1)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? primaryColor : Colors.grey[200],
              ),
          ],
        ),
        const SizedBox(width: 16),
        // Step content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? primaryColor : Colors.grey[800],
                      fontSize: 15,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    step.time,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                step.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
              if (index < _deliverySteps.length - 1) const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryVisualization(ThemeData theme, Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Journey',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor.withOpacity(0.03),
                primaryColor.withOpacity(0.01),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: primaryColor.withOpacity(0.1)),
          ),
          child: Stack(
            children: [
              // Road path with curves
              Positioned(
                left: 20,
                right: 20,
                top: 60,
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width - 40, 30),
                  painter: RoadPainter(progress: _progressAnimation.value),
                ),
              ),

              // Animated moving glasses with bounce effect
              Positioned(
                left: 20 + (MediaQuery.of(context).size.width - 80) *
                    (_currentStep / (_deliverySteps.length - 1)),
                top: 45 + 5 * sin(_controller.value * 2 * pi), // Bouncing effect
                child: Transform.rotate(
                  angle: sin(_controller.value * 4 * pi) * 0.1, // Slight rocking
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.6),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Iconsax.glass,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Start point - Shop
              const Positioned(
                left: 10,
                top: 40,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 16,
                      child: Icon(
                        Iconsax.shop,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Shop',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              // End point - Home
              Positioned(
                right: 10,
                top: 40,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 16,
                      child: const Icon(
                        Iconsax.home,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'You',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Progress percentage
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    final progressPercent =
                    ((_currentStep / (_deliverySteps.length - 1)) * 100)
                        .toInt();
                    return Text(
                      '$progressPercent% Complete',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    );
                  },
                ),
              ),

              // Distance markers
              ..._buildDistanceMarkers(primaryColor),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDistanceMarkers(Color primaryColor) {
    final markers = <Widget>[];
    final totalWidth = MediaQuery.of(context).size.width - 40;
    const markerCount = 5;

    for (var i = 0; i < markerCount; i++) {
      final position = 20 + (totalWidth * i / (markerCount - 1));
      final isPassed = position <=
          20 + (totalWidth * (_currentStep / (_deliverySteps.length - 1)));

      markers.add(
        Positioned(
          left: position - 2,
          top: 58,
          child: Container(
            width: 4,
            height: 14,
            decoration: BoxDecoration(
              color: isPassed ? primaryColor : Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      );

      // Distance labels
      if (i < markerCount - 1) {
        markers.add(
          Positioned(
            left: position + 10,
            top: 75,
            child: Text(
              '${(i + 1) * 2}km',
              style: TextStyle(
                fontSize: 9,
                color: isPassed ? primaryColor : Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    }

    return markers;
  }

  Widget _buildSpectacleActions(ThemeData theme, Color primaryColor) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Call for support
          },
          icon: const Icon(Iconsax.call, size: 20),
          label: const Text('Call for Fitting Advice'),
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {
            // View order details
          },
          icon: const Icon(Iconsax.eye, size: 20),
          label: const Text('View Prescription Details'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: primaryColor),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (_currentStep) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.purple;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

class RoadPainter extends CustomPainter {
  final double progress;

  RoadPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Create a curved road path
    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.8,
      size.width * 0.5,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width * 0.7,
      size.height * 0.2,
      size.width,
      size.height / 2,
    );

    // Draw the full road
    canvas.drawPath(path, paint);

    // Draw the progress
    final metrics = path.computeMetrics();
    final metric = metrics.first;
    final extractedPath = metric.extractPath(0.0, metric.length * progress);

    canvas.drawPath(extractedPath, progressPaint);

    // Add road dashes
    final dashPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final dashPath = Path();
    for (double i = 0; i < metric.length; i += 15) {
      final tangent = metric.getTangentForOffset(i);
      if (tangent != null) {
        dashPath.moveTo(
          tangent.position.dx,
          tangent.position.dy - 1,
        );
        dashPath.lineTo(
          tangent.position.dx,
          tangent.position.dy + 1,
        );
      }
    }
    canvas.drawPath(dashPath, dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DeliveryStep {
  final String title;
  final String description;
  final IconData icon;
  final String time;

  DeliveryStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.time,
  });
}