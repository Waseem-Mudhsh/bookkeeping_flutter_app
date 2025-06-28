import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/responsive_notifier.dart';
import '../../../../core/providers/theme_data_provider.dart';
import '../../../../core/widgets/custom_show_box_balince.dart';
import '../../../../core/widgets/responsive_space.dart';
import '../../domain/entities/currency.dart';
import '../providers/currency_provider.dart';

class CustomShowBalince extends ConsumerStatefulWidget {
  const CustomShowBalince({super.key});

  @override
  ConsumerState<CustomShowBalince> createState() => _CustomShowBalinceState();
}

class _CustomShowBalinceState extends ConsumerState<CustomShowBalince> {
  late List<Currency> currencies = [];
  late Currency currencySelected;
  bool _obscureText = false;
  final TextEditingController _balanceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    currencies = ref.read(currencyListProvider);
    currencySelected = currencies[0];
    _balanceController.text= currencySelected.balanceDue?.toStringAsFixed(2) ?? '0.00';
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ref.watch(responsiveProvider);
    return Material(
      elevation: 4,
      child: Container(
        padding: responsive.paddingSym(h: 16, v: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 0.5, color: Colors.grey.shade300),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: responsive.h(170),
            // maxHeight: responsive.h(150),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              _buildCurrencyHeader(),
              //  const ResponsiveSpace(height: 2),

              const ResponsiveSpace(height: 2),
              Divider(height: 1, thickness: 0.5, color: Colors.grey.shade300),
              const ResponsiveSpace(height: 2),
              _buildBalinceDue(),
              const ResponsiveSpace(height: 2),
               Divider(height: 1, thickness: 0.5, color: Colors.grey.shade300),
              const ResponsiveSpace(height: 2),
               _buildButtonsBalince(),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildCurrencyHeader() {
    final responsive = ref.watch(responsiveProvider);
  final theme = ref.watch(themeDataProvider);
    return  IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: responsive.paddingSym(h: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),

                        color: theme.colorScheme.primary,
                      ),

                      child: InkWell(
                        onTap: () => showDropdownSheet(context, ref),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomAutoSizeText(
                              style: theme.textTheme.bodySmall,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              text: currencySelected.name,

                              colorText: theme.colorScheme.onPrimary,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const ResponsiveSpace(width: 16),
                    Expanded(
                      child: CustomTextField(
                        textAlign: TextAlign.center,
                        obscureText: _obscureText,
                       
                        controller: _balanceController,

                        readOnly: true,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 14,
                          color: theme.colorScheme.primary,
                        ),
                       
                          label: 'رصيدك الحالي',
                          labelStyle: theme.textTheme.bodySmall,
                          suffixIcon: CustomIconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                              
                            },
                             icon: Icon(
                             _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: theme.colorScheme.primary,
                          ),
                          ),
                         
                          fillColor: theme.colorScheme.surface,
                        
                      ),
                    ),
                  ],
                ),
              );
  }

  Widget _buildBalinceDue() {
    return ResponsiveSpace(
      height: 45,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CustomDropdown(),
            Expanded(
              child: CustomShowBoxBalince(
                valueBalince: '0',
                iscreditor: true,
                isleft: false,
              ),
            ),
            VerticalDivider(),
            // ResponsiveSpace(width: responsive.w(8)),
            Expanded(
              child: CustomShowBoxBalince(
                valueBalince: '100,000,000,000,000',
                iscreditor: false,
                isleft: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildButtonsBalince() {
    final theme = ref.watch(themeDataProvider);
    ref.watch(responsiveProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: Icon(Icons.add_circle_outline,semanticLabel: 'إضافة',),
          onPressed: () {
            // Handle add balance action
          },
          iconColor: theme.colorScheme.onPrimaryFixed,
          backgroundColor: theme.colorScheme.primaryFixed,
        ),
        CustomIconButton(
          icon: Icon(Icons.picture_as_pdf_outlined,semanticLabel: 'pdf',),
          onPressed: () {
            // Handle remove balance action
          },
           iconColor: theme.colorScheme.onPrimaryFixed,
          backgroundColor: theme.colorScheme.primaryFixed,
        ),
        CustomIconButton(
          icon: Icon(Icons.share_outlined,semanticLabel: 'مشاركة',),
          onPressed: () {
            // Handle remove balance action
          },
          iconColor: theme.colorScheme.onPrimaryFixed,
          backgroundColor: theme.colorScheme.primaryFixed,
        ),
        CustomIconButton(
          icon: Icon(Icons.note_add_outlined,semanticLabel: 'إضافة ملاحظة',),
          onPressed: () {
            // Handle remove balance action
          },
          iconColor: theme.colorScheme.onPrimaryFixed,
          backgroundColor: theme.colorScheme.primaryFixed,
        ),
        CustomIconButton(
          icon: Icon(Icons.refresh_outlined,semanticLabel: 'تحديث',),
          onPressed: () {
            // Handle refresh action
          },
           iconColor: theme.colorScheme.onPrimaryFixed,
          backgroundColor: theme.colorScheme.primaryFixed,
        ),
      ],
    );
  }

  void showDropdownSheet(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    showModalBottomSheet(
      backgroundColor: theme.colorScheme.surface,
      useSafeArea: true,
      context: context,
      builder: (_) {
        return ListView(
          children:
              currencies.map((item) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      currencySelected = item;
                      _balanceController.text = item.balanceDue?.toStringAsFixed(2) ?? '0.00';
                    });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          item.flagUrl != null
                              ? Image.asset(
                                item.flagUrl!,
                                fit: BoxFit.none,
                              ).image
                              : null,

                      backgroundColor: Colors.grey.shade200,
                    ),
                    title: CustomAutoSizeText(
                      text: item.name,
                      style: theme.textTheme.bodyMedium,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                    subtitle: CustomAutoSizeText(
                      text: item.code,
                      style: theme.textTheme.bodyMedium,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      colorText: theme.colorScheme.primary,
                    ),
                    trailing: CustomAutoSizeText(
                      text: item.balanceDue!.toStringAsFixed(2),
                      style: theme.textTheme.bodyMedium,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      colorText: theme.colorScheme.primary,
                    ),
                  ), // custom full widget
                );
              }).toList(),
        );
      },
    );
  }
}
