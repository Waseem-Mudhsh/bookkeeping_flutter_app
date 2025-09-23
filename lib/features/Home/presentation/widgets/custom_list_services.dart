import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/utils/route_names.dart';
import '../../../../core/widgets/responsive_space.dart';

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
      'route': RouteNames.accounts,
    },
    {
      'name': 'القياسات',
      'icon': HugeIcons.strokeRoundedTapeMeasure,
      'route': RouteNames.accounts,
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.responsive;
    final theme = ref.theme;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: responsive.w(20),
        mainAxisSpacing: responsive.w(20),
        childAspectRatio: 1.0,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return _AnimatedServiceCard(
          name: services[index]['name'],
          icon: services[index]['icon'],
          onTap: () {
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
        );
      },
    );
  }
}



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

class _AnimatedServiceCardState extends State<_AnimatedServiceCard> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  double _scale = 1.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Staggered animation: delay based on the card's index
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _animationController.forward();
      }
    });

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - _animation.value)),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: _scale),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: GestureDetector(
                    onTap: widget.onTap,
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTapCancel: () => setState(() => _scale = 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: widget.theme.colorScheme.primary.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: widget.theme.colorScheme.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.elasticOut,
                              builder: (context, anim, child) => Transform.scale(
                                scale: anim,
                                child: child,
                              ),
                              child: CustomHugeIcon(
                                icon: widget.icon,
                                size: widget.responsive.w(38),
                                color: widget.theme.colorScheme.primary,
                              ),
                            ),
                            ResponsiveSpace(height: 18),
                            CustomAutoSizeText(
                              text: widget.name,
                              style: widget.theme.textTheme.bodyLarge,
                              fontWeight: FontWeight.bold,
                              colorText: widget.theme.colorScheme.primary,
                              letterSpacing: 0.5,
                              maxLines: 2,
                              textAlign: TextAlign.center,
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
        );
      },
    );
  }
}