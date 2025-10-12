
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';

// --- (Placeholder for the client's custom model definitions) ---
// Assuming these types are defined in the project:
// dynamic get responsive;
// dynamic get theme;
// dynamic get screen;
// ----------------------------------------------------------------

class CustomListServices extends ConsumerWidget {
  const CustomListServices({super.key});

  List<Map<String, dynamic>> get services => [
    {
      'name': 'الحسابات',
      'icon': HugeIcons.strokeRoundedWallet01,
      'route': RouteNames.finance,
    },
    {
      'name': 'الادخار',
      'icon': HugeIcons.strokeRoundedPiggyBank,
      'route': RouteNames.finance,
    },
    {
      'name': 'إدارة العقار',
      'icon': HugeIcons.strokeRoundedBuilding01,
      'route': RouteNames.finance,
    },
    {
      'name': 'القياسات',
      'icon': HugeIcons.strokeRoundedTapeMeasure,
      'route': RouteNames.finance,
    },
    {
      'name': 'الديون الشخصية',
      'icon': HugeIcons.strokeRoundedSaveMoneyDollar,
      'route': RouteNames.debtsOfClientScreen,
    },
    // Adding one more for a cleaner 3x2 grid layout
    {
      'name': 'إعدادات النظام',
      'icon': HugeIcons.strokeRoundedSettings01,
      'route': RouteNames.settings,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    
    // Using a fixed height or a proportional height is usually better than relying on ResponsiveSpace(height: 300)
    // for a GridView with NeverScrollableScrollPhysics.
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: responsive.w(16), // Reduced spacing for density
        mainAxisSpacing: responsive.w(16),
        childAspectRatio: 0.9,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _AnimatedServiceCard(
          name: services[index]['name'],
          icon: services[index]['icon'],
          onTap: () {
            // Simplified Navigation
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => services[index]['route'].screen,
              ),
            );
          },
          theme: theme,
          responsive: responsive,
          index: index, // Pass the index for staggered animation
        ),
        childCount: services.length,
      ),
    );
  }
}

// --------------------------------------------------------------------
// ENHANCED ANIMATED SERVICE CARD
// --------------------------------------------------------------------

class _AnimatedServiceCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  final ThemeData theme;
  final dynamic responsive;
  final int index;

  const _AnimatedServiceCard({
    required this.name,
    required this.icon,
    required this.onTap,
    required this.theme,
    required this.responsive,
    required this.index,
  });

  @override
  State<_AnimatedServiceCard> createState() => _AnimatedServiceCardState();
}

class _AnimatedServiceCardState extends State<_AnimatedServiceCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeInAnimation;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Staggered animation: delay based on the card's index
    Future.delayed(Duration(milliseconds: widget.index * 70), () {
      if (mounted) {
        _animationController.forward();
      }
    });

    // Use a premium, fluid curve for initial appearance (e.g., Decelerate)
    _fadeInAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.decelerate, // More professional and smooth fade/slide in
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Simplified and consolidated tap interaction
  void _onTapDown(_) => setState(() => _scale = 0.90);
  void _onTapUp(_) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    // 1. Initial Staggered Appearance Animation
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5), // Starts slightly below
          end: Offset.zero,
        ).animate(_fadeInAnimation),
        // 2. Tap Scale/Interaction Animation
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: _scale),
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: GestureDetector(
                onTap: widget.onTap,
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                onTapCancel: _onTapCancel,
                // 3. Modern Design (Neumorphic/Elevated Glass look)
                child: Container(
                  padding: widget.responsive.paddingAll(16),
                  decoration: BoxDecoration(
                    // Use a slightly darker background for a premium feel
                    color: widget.theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),

                    // Subtle, modern shadow for depth
                    boxShadow: [
                      BoxShadow(
                        color: widget.theme.colorScheme.primary.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                      // Inner shadow/border for 'depth' (Neumorphic effect)
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5),
                        blurRadius: 1,
                        spreadRadius: -1,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Icon with slight scale animation on tap
                      CustomHugeIcon(
                        icon: widget.icon,
                        size: 24, // Larger icon for impact
                        color: widget.theme.colorScheme.primary,
                      ),
                     
                      
                      // Modern Typography: Bold and primary colored
                      CustomAutoSizeText(
                        text: widget.name,
                        style: widget.theme.textTheme.bodyMedium,
                        fontSize: 12, // Slightly larger font
                        fontWeight: FontWeight.w700,
                        colorText: widget.theme.colorScheme.onSurface, // Using onSurface for better readability
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}