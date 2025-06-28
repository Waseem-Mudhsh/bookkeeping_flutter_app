// import 'package:bookkeeping_flutter_app/core/providers/responsive_notifier.dart';
// import 'package:bookkeeping_flutter_app/core/providers/theme_data_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomDropdown  extends ConsumerStatefulWidget{
//    const CustomDropdown({super.key});

//   @override
//   ConsumerState<CustomDropdown> createState() => _CustomDropdownState();
   

// }
// class _CustomDropdownState extends ConsumerState<CustomDropdown> {
//    String dropdownValue = 'USD';
//   @override

//   Widget build(BuildContext context) {
//     final responsive = ref.watch(responsiveProvider);
//     final theme = ref.watch(themeDataProvider);
   
//     return Container(
//       // width: responsive.deviceSize.width,
//       constraints: BoxConstraints(
//         minHeight: responsive.h(50),
//         maxHeight: responsive.h(100),
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: theme.colorScheme.primary,
//           width: responsive.w(0.5),

//         ),
//         color: theme.colorScheme.surfaceBright,
        
//         borderRadius: const BorderRadius.all(Radius.circular(6)),),
//       child: DropdownButton<String>(
//         dropdownColor: theme.colorScheme.surfaceBright,
//         isExpanded: true,
//         hint: Text(
//           'Select Currency',
//           style: theme.textTheme.bodyMedium!.copyWith(
//             color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
//           ),
//         ),
        
//         // alignment: AlignmentDirectional.center,
//         padding: responsive.paddingSym(h: 16, ),
//         value: dropdownValue,
//         icon: const Icon(Icons.arrow_drop_down),
//         elevation: 0,
//         style:  theme.textTheme.bodyMedium!.copyWith(
//           fontWeight: FontWeight.bold),
//         underline: Container(),
        
        
        
//         onChanged: (String? value) {
//           // This is called when the user selects an item.
//           setState(() {
//             dropdownValue = value!;
//           });
//         },
//         items: <String>['USD', 'EUR', 'GBP', 'CAD']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value,
//             style: theme.textTheme.bodyMedium!.copyWith(
//               color: theme.colorScheme.primary
//             ),),
//           );
//         }).toList(), 
         
//         ),
//     );}
  
// }

