// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/providers/theme_data_provider.dart';
// import '../../../../core/widgets/responsive_space.dart';

// class TaskProgressCard extends ConsumerWidget {
//   final DateTime startDate;
//   final int totalDays;
  
//   const TaskProgressCard({
//     super.key,
//     required this.startDate,
//     required this.totalDays,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final theme = ref.watch(themeDataProvider);
//     final now = DateTime.now();
//     final endDate = startDate.add(Duration(days: totalDays));
//     final isExpired = now.isAfter(endDate);
//     final remainingDays = isExpired 
//         ? 0 
//         : endDate.difference(now).inDays + 1;
    
//     final progress = isExpired ? 1.0 : 1 - (remainingDays / totalDays);


//     return _AnimatedProgressIndicator(
//       progress: progress,
//       isExpired: isExpired,
//       backgroundColor: theme.colorScheme.tertiary,
//       child: _ProgressText(
//         remainingDays: remainingDays,
//         isExpired: isExpired,
//         style: theme.textTheme.bodySmall,
//       ),
//     );
//   }
// }

// class _AnimatedProgressIndicator extends StatefulWidget {
//   final double progress;
//   final bool isExpired;
//   final Widget child;
//   final Color? backgroundColor;
  

//     const _AnimatedProgressIndicator({
//     required this.progress,
//     required this.child,
//     required this.isExpired,
//     this.backgroundColor,
    
//   });

//   @override
//   State<_AnimatedProgressIndicator> createState() => _AnimatedProgressIndicatorState();
// }

// class _AnimatedProgressIndicatorState extends State<_AnimatedProgressIndicator> 
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late Animation<double> _animation;
  

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();
    
//     _animation = Tween<double>(begin: 0, end: widget.progress).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//   }

//   @override
//   void didUpdateWidget(covariant _AnimatedProgressIndicator oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.progress != widget.progress) {
//       _controller.reset();
//       _animation = Tween<double>(begin: 0, end: widget.progress).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//       );
//       _controller.forward();
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // Progress indicator takes remaining space
//         Expanded(
//           child: AnimatedBuilder(
//             animation: _animation,
//             builder: (context, _) {
//               return LinearProgressIndicator(
//                 value: _animation.value,
//                 borderRadius: BorderRadius.circular(10),
//                 backgroundColor: widget.backgroundColor ?? Colors.grey[300],
//                 valueColor: AlwaysStoppedAnimation(
//                   widget.isExpired 
//                       ? Colors.red 
//                       : Theme.of(context).colorScheme.primary,
//                 ),
//                 minHeight: 8, // Adjust height as needed
//               );
//             },
//           ),
//         ),
        
//         // Space between progress and text
//         const ResponsiveSpace(width: 12),
        
//         // Text widget
//         widget.child,
//       ],
//     );
//   }
// }

// class _ProgressText extends StatelessWidget {
//   final int remainingDays;
//   final bool isExpired;
//   final TextStyle? style;

//   const _ProgressText({
//     required this.remainingDays,
//     required this.isExpired,
//     this.style,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(minWidth: 80), // Prevent text squeezing
//       child: Text(
//         isExpired ? 'انتهت المدة' : 'متبقي $remainingDays يوم',
//         style: style?.copyWith(
//           color: isExpired ? Colors.red : null,
//           fontWeight: FontWeight.bold,
//         ),
//         textAlign: TextAlign.end,
//       ),
//     );
//   }
// }

import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart' show themeDataProvider;

class TimerProgressCard extends ConsumerWidget {
  final DateTime startDate;
  final int totalDays;
  
  const TimerProgressCard({
    super.key,
    required this.startDate,
    required this.totalDays,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = ref.watch(responsiveProvider);
    final theme = ref.watch(themeDataProvider);
    final now = DateTime.now();
    final endDate = startDate.add(Duration(days: totalDays));
    final isExpired = now.isAfter(endDate);
    final remainingDays = isExpired 
        ? 0 
        : endDate.difference(now).inDays + 1;
    
    final progress = isExpired ? 1.0 : 1 - (remainingDays / totalDays);

    return Padding(
      padding: responsive.paddingAll(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(
              isExpired ?theme.colorScheme.error : theme.colorScheme.primary,
            ),
          ),
          ResponsiveSpace(height: 8),
          Text(
            isExpired 
                ? 'أنتهت المدة ${DateFormat.yMd().format(endDate)}'
                : '$remainingDays متبقى (${DateFormat.yMd().format(endDate)}) يوم',
            style: TextStyle(
              color: isExpired ? theme.colorScheme.error : null,
            ),
          ),
        ],
      ),
    );
  }
}