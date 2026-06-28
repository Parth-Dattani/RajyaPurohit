import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constant/const.dart';

// --- 1. THE LEAVE DIALOG (Subtler Red Glow) ---
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeaveSessionDialog extends StatelessWidget {
  final VoidCallback onDisconnect;
  final VoidCallback onShareAlert;
  final VoidCallback onRecruit;

  const LeaveSessionDialog({
    super.key,
    required this.onDisconnect,
    required this.onShareAlert,
    required this.onRecruit,
  });

  @override
  Widget build(BuildContext context) {
    const glowColor = Colors.redAccent;

    return Dialog(
      backgroundColor: Colors.transparent,
      // ✅ 1. Remove insetPadding so our constraints work perfectly
      insetPadding: const EdgeInsets.all(20),
      child: Center( // ✅ 2. Center widget ensures it doesn't stretch vertically
        child: ConstrainedBox(
          // ✅ 3. MAX WIDTH: Ensures it looks like a phone dialog even on Web
          constraints: const BoxConstraints(maxWidth: 450),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF0F1115),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: glowColor.withOpacity(0.3), width: 1),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withOpacity(0.1),
                  blurRadius: 15,
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keep it compact vertically
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: glowColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.warning_amber_rounded, color: glowColor.withOpacity(0.8), size: 32),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Wait. The coherence is dropping.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Text(
                  "Your energy just helped stabilize the field. As you disconnect, the signal weakens.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Don't break the chain.",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  "Recruit someone to take your spot before you leave.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                ),
                const SizedBox(height: 25),

                // Share Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                          "Share Alert",
                          Icons.share,
                          Colors.blueAccent,
                          onShareAlert
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                          "Recruit Allies",
                          Icons.group_add,
                          const Color(0xFF5C6BC0),
                          onRecruit
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // DISCONNECT BUTTON (Red Tint)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onDisconnect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.withOpacity(0.1),
                      foregroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.red.withOpacity(0.3)),
                      ),
                    ),
                    child: const Text(
                      "Disconnect completely",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // CANCEL BUTTON (White Tint)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.white.withOpacity(0.2)),
                      ),
                    ),
                    child: const Text(
                      "Cancel (Return to Session)",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    );
  }
}

// --- 2. THE POWER DIALOG (Subtler Orange Glow) ---
class ContributionDialog extends StatefulWidget {
  final Function(int) onContribute;

  const ContributionDialog({super.key, required this.onContribute});

  @override
  State<ContributionDialog> createState() => _ContributionDialogState();
}

class _ContributionDialogState extends State<ContributionDialog> {
  int selectedAmount = 10;

  @override
  Widget build(BuildContext context) {
    const glowColor = Color(0xFFFFA726);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1115),
          borderRadius: BorderRadius.circular(20),
          // ✅ LOW BORDER: Thinner and more transparent (0.3 opacity)
          border: Border.all(color: glowColor.withOpacity(0.3), width: 1),
          // ✅ LOW SHADOW: Tighter blur (15) and lower opacity (0.1)
          boxShadow: [
            BoxShadow(
              color: glowColor.withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: glowColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.dns, color: glowColor.withOpacity(0.9), size: 30),
            ),
            const SizedBox(height: 20),

            const Text(
              "Keep the Signal Live",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Text(
              "Hosting a coherent field for thousands of users requires massive server resources. Help us maintain the connection.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAmountOption(5, glowColor),
                _buildAmountOption(10, glowColor),
                _buildAmountOption(20, glowColor),
              ],
            ),
            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => widget.onContribute(selectedAmount),
                style: ElevatedButton.styleFrom(
                  backgroundColor: glowColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 2, // Reduced elevation
                  shadowColor: glowColor.withOpacity(0.3), // Reduced shadow
                ),
                child: const Text(
                  "CONTRIBUTE ENERGY",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.0),
                ),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              "Secure transaction via Stripe/PayPal",
              style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () => Get.back(),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountOption(int amount, Color activeColor) {
    final isSelected = selectedAmount == amount;
    return GestureDetector(
      onTap: () => setState(() => selectedAmount = amount),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.15) : Colors.transparent, // Lower opacity bg
          border: Border.all(
            color: isSelected ? activeColor.withOpacity(0.8) : Colors.white.withOpacity(0.1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "\$$amount",
          style: TextStyle(
            color: isSelected ? activeColor : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
