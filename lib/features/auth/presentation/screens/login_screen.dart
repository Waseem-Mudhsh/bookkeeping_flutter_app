// lib/features/auth/presentation/screens/login_screen.dart

import 'package:bookkeeping_flutter_app/core/base_layout/base_layout_screen.dart';
import 'package:bookkeeping_flutter_app/core/base_layout/build_non_tabbar_layout.dart';
import 'package:bookkeeping_flutter_app/core/utils/extensions.dart';
import 'package:bookkeeping_flutter_app/core/utils/route_names.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_auto_size_text.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_huge_icon.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_icon_button.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_padding.dart';
import 'package:bookkeeping_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:bookkeeping_flutter_app/core/widgets/responsive_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../../../core/widgets/custom_button.dart';
import '../providers/login_provider.dart';

// استخدام ConsumerWidget للوصول إلى الـ Providers
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});


  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
 
  
  
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

   final formKeyLogin = GlobalKey<FormState>();
    // Controllers لحقول الإدخال
    late TextEditingController phoneController;
    late TextEditingController passwordController;
    // Providers
    
    



  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

   Future<void> performLogin( ) async {
      // التحقق من صحة المدخلات في الـ Form
      if (formKeyLogin.currentState?.validate() ?? false) {
        // تفعيل حالة التحميل
        ref.read(loadingStateProvider.notifier).state = true;

        // استدعاء حالة الاستخدام عبر الـ provider
        final loginSuccess = await ref.read(loginUseCaseProvider).execute(
              phoneController.text,
              passwordController.text,
            );

        // إيقاف حالة التحميل
        ref.read(loadingStateProvider.notifier).state = false;

        // عرض رسالة بناءً على نتيجة العملية
        if (mounted) {
          if (loginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content: CustomAutoSizeText(

                  text:  'تم تسجيل الدخول بنجاح',
                  colorText:ref.theme.colorScheme.onPrimary,
                  style: ref.theme.textTheme.bodySmall,
                  fontSize: 10,
                  ),
                backgroundColor:ref.theme.colorScheme.primary,
              ),
            );
            // الانتقال إلى الشاشة الرئيسية عند النجاح
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RouteNames.home.screen),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                content:CustomAutoSizeText(

                  text:  'فشل تسجيل الدخول. تحقق من رقم الهاتف وكلمة المرور.',
                  colorText:ref.theme.colorScheme.onPrimary,
                  style: ref.theme.textTheme.bodySmall,
                  fontSize: 10,
                  ),
                backgroundColor:ref.theme.colorScheme.primary,
              ),
            );
          }
        }
      }
    }

 

  @override
  Widget build(BuildContext context) {
    // مفتاح للوصول إلى حالة الـ Form
   // متغيرات الحالة من Riverpod
    final isPasswordVisible = ref.watch(passwordVisibilityProvider);
    final isLoading = ref.watch(loadingStateProvider);
    final responsive = ref.responsive;
    final theme = ref.theme;
    
   

    // دالة لتنفيذ عملية تسجيل الدخول
    

    return BaseLayoutScreen(
      // 1. الجزء العلوي من الشاشة (Header)
     
      backgroundColor: theme.colorScheme.surface, // لون خلفية للشاشة يتناسب مع الهيدر
      // 2. محتوى الشاشة
      body: BuildNonTabbarLayout(
        padding: 0,
        physics: responsive.orientation == Orientation.portrait ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
        slivers: [
          // 1. الجزء العلوي من الشاشة (Header)
          SliverToBoxAdapter(
            child: Stack(
              
            children: [
              Container(
               
                color: ref.theme.colorScheme.surface,
                constraints: BoxConstraints(
                  minHeight: responsive.deviceSize.height,
                  maxHeight: responsive.deviceSize.height*1.5,
                ),

              ),
              
              _buildLogo(ref),
              Positioned(
                top: responsive.h(150),
                left: 0,
                right: 0,
                
                child: CustomPadding(
                 horizontal: 64 ,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLoginForm(ref, isPasswordVisible, isLoading, performLogin),
                      const ResponsiveSpace(height: 16),
                      _buildBottomSection(),
                    ],
                  ),
                ), ),
                
               

            ] ),),
         
        ]
        )
    );
  }

  Widget _buildLogo( WidgetRef ref) {
    
    final theme = ref.theme;
    return Container(
      width: double.infinity,
      height: ref.responsive.h(200),
      color: theme.colorScheme.primary,
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ResponsiveSpace(height: 32),
          // الشعار (Logo)
          CustomAutoSizeText(
          text:   '{ }',
          colorText: theme.colorScheme.onPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
           
      
            style: theme.textTheme.headlineMedium,
          ),
          CustomAutoSizeText(
          text:   'تطبيق تابع',
          colorText: theme.colorScheme.onPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          
      
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
}

  Widget _buildLoginForm(WidgetRef ref ,  bool isPasswordVisible, bool isLoading, Future<void> Function() performLogin) {
    final theme = ref.theme;
    final responsive = ref.responsive;
    return Padding(
      padding: responsive.paddingSym(h: 16),
      child: Card(
        // استخدام Material Design 3 Card
        elevation: 6.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: responsive.paddingSym(h: 24, v: 32),
          child: Form(
            key: formKeyLogin,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // عنوان الفورم
                CustomAutoSizeText(
                 text:  'تسجيل دخول',
                  style: theme.textTheme.headlineMedium,
                  fontWeight: FontWeight.bold,
                  colorText: theme.colorScheme.primary,
                ),
                const ResponsiveSpace(height: 32),
          
                // حقل رقم الهاتف
                CustomTextField(
                  controller: phoneController,
                  label: 'رقم الهاتف',
                  prefixIcon: CustomHugeIcon(icon: HugeIcons.strokeRoundedSmartPhone01,
                  color: theme.colorScheme.onSurface,),
                  hint: 'ادخل رقم الهاتف',
                  keyboardType: TextInputType.number,
                  // تقييد الإدخال ليكون أرقام فقط وبطول 9
                  
                  
                  // تحديد المدخلات لتكون أرقام فقط وبطول 9
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  // قواعد التحقق
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال رقم الهاتف';
                    }
                    if (value.length != 9) {
                      return 'يجب أن يتكون الرقم من 9 أرقام';
                    }
                    return null;
                  },
                ),
                const ResponsiveSpace(height: 16),
          
                // حقل كلمة المرور
                CustomTextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible, // إخفاء النص أو إظهاره
                  label: 'كلمة المرور',
                  hint: 'ادخل كلمة المرور',
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon:CustomHugeIcon(icon: HugeIcons.strokeRoundedCircleLock01,
                  color: theme.colorScheme.onSurface,),
                  suffixIcon: IconButton(
                      icon: CustomHugeIcon(
                       icon: isPasswordVisible ? HugeIcons.strokeRoundedViewOffSlash : HugeIcons.strokeRoundedView,
                      ),
                      onPressed: () {
                        ref.read(passwordVisibilityProvider.notifier).state = !isPasswordVisible;
                      },
                    ),
          
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور';
                    }
                    return null;
                  },
                ),
                const ResponsiveSpace(height: 8),
          
                // رابط "نسيت كلمة المرور"
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RouteNames.forgotPasswordScreen.screen;
                          }));
                    },
                    child:CustomAutoSizeText(text: 'هل نسيت كلمة المرور؟',
                      style: theme.textTheme.bodySmall,
                      colorText: theme.colorScheme.primary,
                      fontSize: 10,
                    ),
                  ),
                ),
                const ResponsiveSpace(height: 24),
          
                // زر تسجيل الدخول
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CustomButton(
                        backgroundColor: theme.colorScheme.primary,
                        textColor: theme.colorScheme.onPrimary,
                        text: 'تسجيل الدخول',
                        isLoading: isLoading,
      
                        // عرض مؤشر تحميل دائري إذا كانت isLoading true
                        onPressed: isLoading ? null : performLogin,
                        
                      ),
                    ),
                    const ResponsiveSpace(width: 16),
                    Expanded(
                      child: CustomIconButton
                      (onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RouteNames.home.screen),
                        );
                      },
                        hugeIcon: HugeIcon(icon: HugeIcons.strokeRoundedFingerPrintScan,
                        size: 32,
                          color: theme.colorScheme.primary),
      
                       )
                    ),
                  ],
                ),
               
          
                // رابط إنشاء حساب جديد
               
              ],
            ),
          ),
        ),
      ),
    );

      
  }
  Widget _buildBottomSection() {
    final theme = ref.theme;
    return  Center(
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                       CustomAutoSizeText(text: 'ليس لديك حساب؟ ',
                      style: theme.textTheme.bodySmall,
                      fontSize: 10,
                      colorText: theme.colorScheme.onSurface,
                      ),
                      const ResponsiveSpace(width: 4),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return RouteNames.signUpScreen.screen;
                          }));
                        },
                        child: CustomAutoSizeText(text:'انشاء حساب جديد',
                          style: theme.textTheme.bodySmall,
                          colorText: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
    );
    
  }
 
}