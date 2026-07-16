import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../constant/app_colors.dart'; // તમારા પ્રોજેક્ટના કલર્સ ભાઈ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../constant/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/event_controller.dart';
import '../constant/app_colors.dart';
import '../widgets/widgets.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart'; // તમારો એક્સપાન્ડેડ એપબાર ભાઈ
import '../widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/app_colors.dart';
import '../controllers/event_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_footer.dart';

class EventScreen extends GetView<EventController> {
  static const pageId = "/EventScreen";
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 900;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      drawer: !isWeb ? const CustomMobileDrawer() : null,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.textMaroon));
        }

        if (controller.eventsList.isEmpty) {
          return const Center(
            child: Text("હાલમાં કોઈ પ્રવૃત્તિઓ ઉપલબ્ધ નથી ભાઈ.", style: TextStyle(color: AppColors.textMaroon)),
          );
        }

        return SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? screenWidth * 0.04 : 16.0,
                vertical: 30.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "વિતેલી પ્રવૃત્તિઓની યાદી",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.textMaroon),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 60,
                    height: 4,
                    decoration: BoxDecoration(color: AppColors.textOrange, borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(height: 35),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.eventsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWeb ? 3 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      mainAxisExtent: isWeb ? 430 : 410,
                    ),
                    itemBuilder: (context, index) {
                      final event = controller.eventsList[index];
                      return _buildEventCard(context, event, isWeb);
                    },
                  ),
                  const SizedBox(height: 40),
                  const CustomFooter(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildEventCard(BuildContext context, Map<String, dynamic> event, bool isWeb) {
    final RxBool isHovered = false.obs;

    return MouseRegion(
      onEnter: (_) => isHovered.value = true,
      onExit: (_) => isHovered.value = false,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openSlidingGalleryDialog(context, event['title'] ?? 'પ્રવૃત્તિ આલ્બમ', event['images'] ?? []),
        child: Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..translate(0.0, isHovered.value ? -6.0 : 0.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered.value ? AppColors.textOrange.withOpacity(0.4) : Colors.black.withOpacity(0.04),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered.value ? Colors.black.withOpacity(0.08) : Colors.black.withOpacity(0.02),
                blurRadius: isHovered.value ? 15 : 8,
                offset: isHovered.value ? const Offset(0, 8) : const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                  child: event['image_url'] != null && event['image_url'].toString().startsWith('http')
                      ? Image.network(
                    event['image_url'],
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Image.asset('assets/images/om_logo.png', fit: BoxFit.contain),
                  )
                      : Image.asset(
                    event['image_url'] ?? 'assets/images/om_logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Image.asset('assets/images/om_logo.png', fit: BoxFit.contain),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textMaroon),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, size: 16, color: AppColors.textOrange),
                        const SizedBox(width: 6),
                        Text(event['date'] ?? '', style: const TextStyle(fontSize: 13, color: AppColors.textMaroon, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 16, color: AppColors.textOrange),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event['venue'] ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, color: AppColors.textMaroon, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(height: 1),
                    const SizedBox(height: 12),
                    Text(
                      event['description'] ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 13.5, color: AppColors.textMaroon.withOpacity(0.8), height: 1.5, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  // 🖼️ ⚡ NO-CROP 100% FULL IMAGE SLIDING GALLERY
  void _openSlidingGalleryDialog(BuildContext context, String title, List<dynamic> images) {
    if (images.isEmpty) {
      Get.snackbar("માહિતી", "આ પ્રવૃત્તિ માટે કોઈ ફોટા ઉપલબ્ધ નથી ભાઈ.", backgroundColor: AppColors.textMaroon, colorText: Colors.white);
      return;
    }

    final PageController pageController = PageController();
    final RxInt currentIndex = 0.obs;
    final size = MediaQuery.of(context).size;

    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF121212),
        child: Container(
          width: size.width * 0.96,
          height: size.height * 0.94,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() => Text(
                      "$title - ફોટો ગેલેરી (${currentIndex.value + 1}/${images.length})",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    )),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 28, color: Colors.white70),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const Divider(height: 20, color: Colors.white24),

              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: pageController,
                      itemCount: images.length,
                      onPageChanged: (index) => currentIndex.value = index,
                      itemBuilder: (context, idx) {
                        final imageUrl = images[idx].toString();
                        return Center(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: imageUrl.startsWith('http')
                                  ? Image.network(
                                imageUrl,
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                errorBuilder: (c, e, s) => const Center(
                                  child: Icon(Icons.broken_image, size: 50, color: Colors.white38),
                                ),
                              )
                                  : Image.asset(
                                imageUrl,
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                                errorBuilder: (c, e, s) => const Center(
                                  child: Icon(Icons.broken_image, size: 50, color: Colors.white38),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    Positioned(
                      left: 10,
                      child: Obx(() => currentIndex.value > 0
                          ? CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                          onPressed: () {
                            pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          },
                        ),
                      )
                          : const SizedBox.shrink()),
                    ),

                    Positioned(
                      right: 10,
                      child: Obx(() => currentIndex.value < images.length - 1
                          ? CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 22),
                          onPressed: () {
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          },
                        ),
                      )
                          : const SizedBox.shrink()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 65,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, idx) {
                    return Obx(() {
                      final isSelected = currentIndex.value == idx;
                      final thumbUrl = images[idx].toString();
                      return GestureDetector(
                        onTap: () {
                          pageController.animateToPage(idx, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: isSelected ? AppColors.textOrange : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Opacity(
                              opacity: isSelected ? 1.0 : 0.4,
                              child: thumbUrl.startsWith('http')
                                  ? Image.network(
                                  thumbUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c,e,s) => Container(color: Colors.grey)
                              )
                                  : Image.asset(
                                  thumbUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c,e,s) => Container(color: Colors.grey)
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}