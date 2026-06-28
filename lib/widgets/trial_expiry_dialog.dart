import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TrialExpiryDialog extends StatefulWidget {
  @override
  _TrialExpiryDialogState createState() => _TrialExpiryDialogState();
}

class _TrialExpiryDialogState extends State<TrialExpiryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back button from closing dialog
        return false;
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildDialogContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogContent() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Warning Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.timer_off_outlined,
              size: 40,
              color: Colors.orange[700],
            ),
          ),

          SizedBox(height: 20),

          // Title
          Text(
            '60-Day Trial Expired',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          // Message
          Text(
            'Your 60-day trial period has ended. Upgrade to premium to continue enjoying all features and unlock advanced analytics.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 24),

          // Features that will be unlocked
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildFeatureRow('Unlimited Properties', Icons.home_work_outlined),
                _buildFeatureRow('Advanced Analytics', Icons.analytics_outlined),
                _buildFeatureRow('Cash Flow Projections', Icons.trending_up),
                _buildFeatureRow('Export Reports', Icons.file_download_outlined),
                _buildFeatureRow('Priority Support', Icons.support_agent),
              ],
            ),
          ),

          SizedBox(height: 24),

          // Trial ended indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.orange[700],
                ),
                SizedBox(width: 8),
                Text(
                  'Trial Period: ENDED (60 Days)',
                  style: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Don't close dialog - just contact support
                    _contactSupport();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Contact Support',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Don't close dialog - just navigate to subscription
                    _navigateToSubscription();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Upgrade Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.orange[700],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Icon(
            Icons.check_circle,
            size: 16,
            color: Colors.orange[700],
          ),
        ],
      ),
    );
  }

  void _contactSupport() {
    // Implement contact support logic without closing dialog
    Get.snackbar(
      'Contact Support',
      'Please contact our support team for subscription assistance.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange[100],
      colorText: Colors.orange[900],
      duration: Duration(seconds: 3),
    );
  }

  void _navigateToSubscription() {
    // Implement navigation to subscription page without closing dialog
    // You can navigate to your subscription screen here
    // Example: Get.toNamed('/subscription');

    Get.snackbar(
      'Upgrade to Premium',
      'Please visit our subscription page to upgrade your account.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange[100],
      colorText: Colors.orange[900],
      duration: Duration(seconds: 3),
    );

    // Optional: Navigate to subscription page
    // Get.toNamed('/subscription');
  }
}