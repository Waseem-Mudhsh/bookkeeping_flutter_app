// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/base_layout/base_layout_screen.dart';
// import '../../../../core/base_layout/build_non_tabbar_layout.dart';


// class Beneficiary {
//   final int id;
//   final String name;
//   final String relation;
//   Beneficiary(this.id, this.name, this.relation);
// }

// class BeneficiariesScreen extends ConsumerStatefulWidget {
//   const BeneficiariesScreen({super.key});
//   @override
//   ConsumerState<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
// }

// class _BeneficiariesScreenState extends ConsumerState<BeneficiariesScreen> {
//   final GlobalKey<AnimatedListState> _listKey = GlobalKey();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _relationController = TextEditingController();
//   final List<Beneficiary> _beneficiaries = [];
//   int _maxId = 0;

//   void _addBeneficiary() {
//     final name = _nameController.text.trim();
//     final relation = _relationController.text.trim();
//     if (name.isEmpty || relation.isEmpty) return;
//     final beneficiary = Beneficiary(_maxId++, name, relation);
//     setState(() {
//       _beneficiaries.add(beneficiary);
//       _listKey.currentState?.insertItem(_beneficiaries.length - 1, duration: const Duration(milliseconds: 400));
//       _nameController.clear();
//       _relationController.clear();
//     });
//   }

//   void _removeBeneficiary(int index) {
//     final removed = _beneficiaries.removeAt(index);
//     _listKey.currentState?.removeItem(
//       index,
//       (context, animation) => FadeTransition(
//         opacity: animation,
//         child: _buildBeneficiaryTile(removed, index),
//       ),
//       duration: const Duration(milliseconds: 400),
//     );
//     setState(() {});
//   }

//   void _editBeneficiary(int index) async {
//     final beneficiary = _beneficiaries[index];
//     _nameController.text = beneficiary.name;
//     _relationController.text = beneficiary.relation;
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('تعديل مستفيد'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: const InputDecoration(labelText: 'اسم المستفيد'),
//             ),
//             TextField(
//               controller: _relationController,
//               decoration: const InputDecoration(labelText: 'نوع العلاقة'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text('إلغاء'),
//           ),
//           ElevatedButton(
//             onPressed: () => Navigator.pop(context, true),
//             child: const Text('حفظ'),
//           ),
//         ],
//       ),
//     );
//     if (result == true) {
//       setState(() {
//         _beneficiaries[index] = Beneficiary(
//           beneficiary.id,
//           _nameController.text.trim(),
//           _relationController.text.trim(),
//         );
//         _nameController.clear();
//         _relationController.clear();
//       });
//     }
//   }

//   Widget _buildBeneficiaryTile(Beneficiary beneficiary, int index) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
//       child: ListTile(
//         leading: const CircleAvatar(child: Icon(Icons.person)),
//         title: Text(beneficiary.name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text('العلاقة: ${beneficiary.relation}'),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             IconButton(
//               icon: const Icon(Icons.edit, color: Colors.blueAccent),
//               onPressed: () => _editBeneficiary(index),
//               tooltip: 'تعديل',
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete, color: Colors.redAccent),
//               onPressed: () => _removeBeneficiary(index),
//               tooltip: 'حذف',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _relationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseLayoutScreen(
//       body: BuildNonTabbarLayout(
//         titleWidget: const Text('المستفيدون', style: TextStyle(fontWeight: FontWeight.bold)),
//         slivers: [
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'اسم المستفيد',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Expanded(
//                     child: TextField(
//                       controller: _relationController,
//                       decoration: const InputDecoration(
//                         labelText: 'نوع العلاقة',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   ElevatedButton.icon(
//                     onPressed: _addBeneficiary,
//                     icon: const Icon(Icons.add),
//                     label: const Text('إضافة'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: AnimatedList(
//               key: _listKey,
//               shrinkWrap: true,
//               initialItemCount: _beneficiaries.length,
//               itemBuilder: (context, index, animation) {
//                 final beneficiary = _beneficiaries[index];
//                 return FadeTransition(
//                   opacity: animation,
//                   child: _buildBeneficiaryTile(beneficiary, index),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_alert_dialog_enhanced.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/base_layout/base_layout_screen.dart';
import '../../../../core/base_layout/build_non_tabbar_layout.dart';


// Assuming you have your custom core files imported here

// Define the Beneficiary model (unchanged)
class Beneficiary {
  final int id;
  final String name;
  final String relation;
  Beneficiary(this.id, this.name, this.relation);
}

class BeneficiariesScreen extends ConsumerStatefulWidget {
  const BeneficiariesScreen({super.key});
  @override
  ConsumerState<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends ConsumerState<BeneficiariesScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final List<Beneficiary> _beneficiaries = [];
  int _maxId = 0;

  void _addBeneficiary() {
    final name = _nameController.text.trim();
    final relation = _relationController.text.trim();
    if (name.isEmpty || relation.isEmpty) return;
    final beneficiary = Beneficiary(_maxId++, name, relation);
    setState(() {
      _beneficiaries.add(beneficiary);
      _listKey.currentState?.insertItem(_beneficiaries.length - 1, duration: const Duration(milliseconds: 400));
      _nameController.clear();
      _relationController.clear();
    });
  }

  void _removeBeneficiary(int index) async {
    // التحقق من أن الفهرس لا يزال صالحًا
    if (index < 0 || index >= _beneficiaries.length) {
        return;
    }
    
    final removed = _beneficiaries[index];
    final result = await showCustomAlert<bool>(
        context: context, 
        ref: ref,
        title: 'حذف مستفيد',
        message: 'هل أنت متأكد أنك تريد حذف المستفيد ${removed.name}؟',
        confirmText: 'نعم',
        cancelText: 'لا',
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
    );
    
    if (result == true) {
        // التحقق مرة أخرى من صحة الفهرس قبل الحذف
        if (index < _beneficiaries.length && _beneficiaries[index].id == removed.id) {
            _listKey.currentState?.removeItem(
                index,
                (context, animation) => FadeTransition(
                    opacity: animation,
                    child: _buildBeneficiaryTile(removed, index),
                ),
                duration: const Duration(milliseconds: 400),
            );
            setState(() {
                _beneficiaries.removeAt(index);
            });
        }
    }
}

  // --- ENHANCED EDIT DIALOG ---
  void _editBeneficiary(int index) async {
     final theme = ref.theme;
    final Beneficiary beneficiary = _beneficiaries[index];
    // Use fresh controllers for the dialog to avoid clearing main ones if cancelled
    final tempNameController = TextEditingController(text: beneficiary.name);
    final tempRelationController = TextEditingController(text: beneficiary.relation);

    final result = await showCustomDialog<bool>(
      barrierDismissible: false,
      context: context,
      titleWidget: CustomAutoSizeText(
        text: 'تعديل مستفيد',
      style: theme.textTheme.bodyMedium,
      fontSize: 12,
      colorText: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            CustomTextField(controller: tempNameController,
                   label: 'اسم المستفيد',
                   hint: 'اسم المستفيد (مثال: احمد، محمد)',
                   suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02,),
                   validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'الرجاء إدخال اسم المستفيد';
                    }
                    return null;
                   },
                   ),
                  const ResponsiveSpace(height: 12,),
                  // 2. Relation Input
                 CustomTextField(controller: tempRelationController,
                  label: 'نوع القرابة',
                  hint: 'ادخل نوع القرابة',
                 suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUserGroup03,),
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'الرجاء إدخال نوع القرابة';
                    }
                    return null;
                  },
                 ),
         
        
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
        ),
        CustomButton(
          onPressed: (){
            Navigator.pop(context, true);

          },
         backgroundColor: theme.colorScheme.secondary,
         text: 'حفظ',
          width: 100, height: 30,
        ),
      ],
    );

    if (result == true) {
      setState(() {
        _beneficiaries[index] = Beneficiary(
          beneficiary.id,
          tempNameController.text.trim(),
          tempRelationController.text.trim(),
        );
      });
    }

    // Dispose temporary controllers
    tempNameController.dispose();
    tempRelationController.dispose();
  }
  // -----------------------------

  // --- ENHANCED TILE WIDGET ---
  Widget _buildBeneficiaryTile(Beneficiary beneficiary, int index, {bool isRemoved = false}) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Card(
    
      elevation: isRemoved ? 0 : 4, // Reduce elevation during removal
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // Subtle border for definition
        side: BorderSide(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), width: 0.5),
      ),
      child: ListTile(
        contentPadding: responsive.paddingSym(h: 16, v: 4),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: CustomHugeIcon(icon:HugeIcons.strokeRoundedUser02, ),
        ),
        title: CustomAutoSizeText(
        text:   beneficiary.name,
          style: theme.textTheme.bodyMedium,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          colorText: theme.colorScheme.onSurface,
        ),
        subtitle: CustomAutoSizeText(
          text: 'العلاقة: ${beneficiary.relation}',
          fontSize: 10,
          style: theme.textTheme.bodySmall,
          fontWeight: FontWeight.w500,
          colorText: theme.colorScheme.onSurfaceVariant,),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button (Blue)
            IconButton(
              icon: CustomHugeIcon(icon:HugeIcons.strokeRoundedEdit02,
              color: theme.colorScheme.secondary,
              size: 20,
              ),
              onPressed: () => _editBeneficiary(index),
              tooltip: 'تعديل',
            ),
            // Delete Button (Red)
            IconButton(
              icon: CustomHugeIcon(icon: HugeIcons.strokeRoundedDelete02,
              color: theme.colorScheme.error,
              size: 20,),
              onPressed: () => _removeBeneficiary(index),
              tooltip: 'حذف',
            ),
          ],
        ),
      ),
    );
  }
  // -----------------------------


  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
     final theme = ref.theme;

    return BaseLayoutScreen(
      body: BuildNonTabbarLayout(
        titleWidget:  CustomAutoSizeText(
          text: 'إدارة المستفيدين',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  colorText: theme.colorScheme.onSurface,
                  style: theme.textTheme.bodyMedium,
                ),
        slivers: [
          SliverToBoxAdapter(child: const ResponsiveSpace(height: 16)),
          SliverToBoxAdapter(
            child: _buildAddBeneficiarySection(),
          ),
          SliverToBoxAdapter(child: const ResponsiveSpace(height: 24)),
           SliverToBoxAdapter(child: _buildListHeader()),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 8)),
          SliverToBoxAdapter(
            child: AnimatedList(
              shrinkWrap: true,
             
              key: _listKey,
              initialItemCount: _beneficiaries.length,
              itemBuilder: (context, index, animation) {
                final beneficiary = _beneficiaries[index];
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(animation),
                  child: _buildBeneficiaryTile(beneficiary, index),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: ResponsiveSpace(height: 30)), // Bottom spacing
        ],
      ),
    );
  }
  // List Header Widget
  Widget _buildListHeader() {
      final theme = ref.theme;
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomAutoSizeText(text:  'قائمة المستفيدين (${_beneficiaries.length})', 
                         style: theme.textTheme.bodyMedium,
                         fontSize: 12,),
                    if (_beneficiaries.isNotEmpty)
                      TextButton(
                        onPressed: () { /* Sort logic */ },
                        child: const Text('فرز'),
                      ),
                  ],
                );
  }
  Widget _buildAddBeneficiarySection() {
     final theme = ref.theme;
     final responsive = ref.responsive;
    return Container(
      padding: responsive.paddingAll(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
            // 1. Name Input
                  CustomTextField(controller: _nameController,
                   label: 'اسم المستفيد',
                   hint: 'اسم المستفيد (مثال: احمد، محمد)',
                   suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02,)
                   ),
                  const ResponsiveSpace(height: 12,),
                  // 2. Relation Input
                 CustomTextField(controller: _relationController, label: 'نوع القرابة', hint: 'ادخل نوع القرابة',
                 suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUserGroup03,)
                 ),
                  const ResponsiveSpace(height: 16,),
                  CustomButton(
                    text:  'إضافة مستفيد',
                    onPressed: _addBeneficiary,
                    backgroundColor: theme.colorScheme.secondary,
                    ),
                  
                  
                 
        ],
      ),


    );
  }
}