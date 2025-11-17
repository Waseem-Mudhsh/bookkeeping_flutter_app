
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/responsive_values.dart';
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
      'route': RouteNames.advancedSliverAppBar,
    },
    {
      'name': 'القياسات',
      'icon': HugeIcons.strokeRoundedTapeMeasure,
      'route': RouteNames.financeServiceScreen,
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
        crossAxisSpacing: responsive.w(16.0), // Reduced spacing for density
        mainAxisSpacing: responsive.w(16.0),
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
  final ResponsiveValues responsive;
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
  late AnimationController _animationController;
  late Animation<double> _curvedAnimation;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    // Use a more dynamic curve like easeOutBack for a "pop" effect
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack, // This creates a satisfying bounce
    );

    // Staggered animation: delay based on the card's index
    Future.delayed(Duration(milliseconds: widget.index * 70), () {
      if (mounted) {
        _animationController.forward();
      }
    });
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
    // Use AnimatedBuilder for more complex, synchronized animations (fade, slide, scale)
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (context, child) {
        // Define tweens for opacity, slide, and scale based on the single curved animation
        final opacity = Tween<double>(begin: 0.0, end: 1.0).evaluate(_curvedAnimation).clamp(0.0, 1.0);
        final slideOffset = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).evaluate(_curvedAnimation);
        final scale = Tween<double>(begin: 0.8, end: 1.0).evaluate(_curvedAnimation);

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: slideOffset,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
        );
      },
      // The child is the part of the tree that doesn't need to rebuild on animation ticks
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
                  padding: widget.responsive.paddingAll(16.0),
                  decoration: BoxDecoration(
                    // Use a slightly darker background for a premium feel
                    color: widget.theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12.0),

                    // Subtle, modern shadow for depth
                    boxShadow: [
                      BoxShadow(
                        color: widget.theme.colorScheme.primary.withValues(alpha: 0.05)!,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 5.0),
                      ),
                      // Inner shadow/border for 'depth' (Neumorphic effect)
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5)!,
                        blurRadius: 1.0,
                        spreadRadius: -1.0,
                        offset: const Offset(1.0, 1.0),
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
                        size: 24.0, // Larger icon for impact
                        color: widget.theme.colorScheme.primary,
                      ),
                     
                      
                      // Modern Typography: Bold and primary colored
                      CustomAutoSizeText(
                        text: widget.name,
                        style: widget.theme.textTheme.bodyMedium!,
                        fontSize: 12.0, // Slightly larger font
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
    );
  }
}