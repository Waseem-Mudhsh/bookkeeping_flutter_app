import 'package:bookkeeping_flutter_app/core/app_scaffold/adaptive_scaffold.dart';
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
  ConsumerState<BeneficiariesScreen> createState() =>
      _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends ConsumerState<BeneficiariesScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _relationFocusNode = FocusNode();
  final List<Beneficiary> _beneficiaries = [];
  int _maxId = 0;
  // Add a new collection to track all controllers
  final List<TextEditingController> _tempControllers = [];

  @override
  void dispose() {
    _nameController.dispose();
    _relationController.dispose();
    _nameFocusNode.dispose();
    _relationFocusNode.dispose();
    // Clean up all temporary controllers
    for (final controller in _tempControllers) {
      controller.dispose();
    }
    _tempControllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.theme;

    return GestureDetector(
      onTap: () {
        // Unfocus all fields when tapping outside
        _nameFocusNode.unfocus();
        _relationFocusNode.unfocus();
      },
      child: AdaptiveScaffold(
        body: BuildNonTabbarLayout(
          titleWidget: CustomAutoSizeText(
            text: 'إدارة المستفيدين',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            colorText: theme.colorScheme.onSurface,
            style: theme.textTheme.bodyMedium,
          ),
          slivers: [
            SliverToBoxAdapter(child: const ResponsiveSpace(height: 16)),
            SliverToBoxAdapter(child: _buildAddBeneficiarySection()),
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
            const SliverToBoxAdapter(
              child: ResponsiveSpace(height: 30),
            ), // Bottom spacing
          ],
        ),
      ),
    );
  }

  // List Header Widget
  Widget _buildListHeader() {
    final theme = ref.theme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomAutoSizeText(
          text: 'قائمة المستفيدين (${_beneficiaries.length})',
          style: theme.textTheme.bodyMedium,
          fontSize: 12,
        ),
        if (_beneficiaries.isNotEmpty)
          TextButton(
            onPressed: () {
              /* Sort logic */
            },
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
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Name Input
          CustomTextField(
            controller: _nameController,
            label: 'اسم المستفيد',
            hint: 'اسم المستفيد (مثال: احمد، محمد)',
            suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02),
            focusNode: _nameFocusNode,
            onFieldSubmitted: (_) {
              // Move focus to relation field on submit
              _relationFocusNode.requestFocus();
            },
          ),
          const ResponsiveSpace(height: 12),
          // 2. Relation Input
          CustomTextField(
            controller: _relationController,
            label: 'نوع القرابة',
            hint: 'ادخل نوع القرابة',
            suffixIcon: CustomHugeIcon(
              icon: HugeIcons.strokeRoundedUserGroup03,
            ),
            focusNode: _relationFocusNode,
            onFieldSubmitted: (_) {
              _relationFocusNode.unfocus();
            },
          ),
          const ResponsiveSpace(height: 16),
          CustomButton(
            text: 'إضافة مستفيد',
            onPressed: _addBeneficiary,
            backgroundColor: theme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  void _addBeneficiary() {
    final name = _nameController.text.trim();
    final relation = _relationController.text.trim();
    if (name.isEmpty || relation.isEmpty) return;
    final beneficiary = Beneficiary(_maxId++, name, relation);
    setState(() {
      _beneficiaries.add(beneficiary);
      _listKey.currentState?.insertItem(
        _beneficiaries.length - 1,
        duration: const Duration(milliseconds: 400),
      );
      _nameController.clear();
      _relationController.clear();
    });
    // Hide keyboard and unfocus fields
    _nameFocusNode.unfocus();
    _relationFocusNode.unfocus();
  }

  void _removeBeneficiary(int index) async {
    // التحقق من أن الفهرس لا يزال صالحًا
    if (index < 0 || index >= _beneficiaries.length) {
      return;
    }

    final removed = _beneficiaries[index];
    final result = await showCustomDialog<bool>(
      context: context,
      title: 'حذف مستفيد',
      hugeIconTitle: HugeIcons.strokeRoundedDelete02,
      content: CustomAutoSizeText(
        text: 'هل أنت متأكد من حذف المستفيد ${removed.name}؟',
        fontSize: 12,
        style: ref.theme.textTheme.bodyMedium,
        fontWeight: FontWeight.bold,
        colorText: ref.theme.colorScheme.onSurface,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
        ),
        CustomButton(
          onPressed: () => Navigator.pop(context, true),
          backgroundColor: ref.theme.colorScheme.error,
          text: 'حذف',
          width: 100,
          height: 30,
        ),
      ],
    );

    if (result == true) {
      // التحقق مرة أخرى من صحة الفهرس قبل الحذف
      if (index < _beneficiaries.length &&
          _beneficiaries[index].id == removed.id) {
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
    final tempRelationController = TextEditingController(
      text: beneficiary.relation,
    );
    final tempNameFocusNode = FocusNode();
    final tempRelationFocusNode = FocusNode();
    // Add temporary controllers to the tracking list
    _tempControllers.addAll([tempNameController, tempRelationController]);

    final result = await showCustomDialog<bool>(
      barrierDismissible: false,
      context: context,
      title: 'تعديل مستفيد',
      hugeIconTitle: HugeIcons.strokeRoundedEdit02,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextField(
            controller: tempNameController,
            focusNode: tempNameFocusNode,
            onFieldSubmitted: (_) {
              // Move focus to relation field on submit
              _relationFocusNode.requestFocus();
            },
            label: 'اسم المستفيد',
            hint: 'اسم المستفيد (مثال: احمد، محمد)',
            suffixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02),
            validator: (p0) {
              if (p0 == null || p0.isEmpty) {
                return 'الرجاء إدخال اسم المستفيد';
              }
              return null;
            },
          ),
          const ResponsiveSpace(height: 12),
          // 2. Relation Input
          CustomTextField(
            controller: tempRelationController,
            focusNode: tempRelationFocusNode,
            onFieldSubmitted: (value) {
              // Hide keyboard when submitting the last field
              tempRelationFocusNode.unfocus();
            },
            label: 'نوع القرابة',
            hint: 'ادخل نوع القرابة',
            suffixIcon: CustomHugeIcon(
              icon: HugeIcons.strokeRoundedUserGroup03,
            ),
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
          onPressed: () {
            Navigator.pop(context, true);
          },
          backgroundColor: theme.colorScheme.secondary,
          text: 'حفظ',
          width: 100,
          height: 30,
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
  }
  // -----------------------------

  // --- ENHANCED TILE WIDGET ---
  Widget _buildBeneficiaryTile(
    Beneficiary beneficiary,
    int index, {
    bool isRemoved = false,
  }) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Card(
      elevation: isRemoved ? 0 : 4, // Reduce elevation during removal
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // Subtle border for definition
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 0.5,
        ),
      ),
      child: ListTile(
        contentPadding: responsive.paddingSym(h: 16, v: 4),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: CustomHugeIcon(icon: HugeIcons.strokeRoundedUser02),
        ),
        title: CustomAutoSizeText(
          text: beneficiary.name,
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
          colorText: theme.colorScheme.onSurfaceVariant,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit Button (Blue)
            IconButton(
              icon: CustomHugeIcon(
                icon: HugeIcons.strokeRoundedEdit02,
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              onPressed: () => _editBeneficiary(index),
              tooltip: 'تعديل',
            ),
            // Delete Button (Red)
            IconButton(
              icon: CustomHugeIcon(
                icon: HugeIcons.strokeRoundedDelete02,
                color: theme.colorScheme.error,
                size: 20,
              ),
              onPressed: () => _removeBeneficiary(index),
              tooltip: 'حذف',
            ),
          ],
        ),
      ),
    );
  }

  // -----------------------------
}
