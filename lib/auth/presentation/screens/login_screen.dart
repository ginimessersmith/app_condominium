import 'package:condominium/auth/presentation/providers/auth_provider.dart';
import 'package:condominium/auth/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:condominium/config/router/app_router.dart';
import 'package:condominium/shared/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                // Icon Banner
                const Icon(
                  Icons.add_to_home_screen,
                  color: Colors.white,
                  size: 100,
                ),
                const SizedBox(height: 80),
                Container(
                  height:
                      size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100)),
                  ),
                  child: _LoginForm(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerStatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  bool isProgressIndicator = false;

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = ref.watch(loginFormProvider);
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    //? escuchar los cambios
    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      // print(next.errorMessage);
      showSnackbar(context, next.errorMessage);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            'Bienvenido',
            style: (textStyles.titleLarge),
          ),
          const SizedBox(height: 90),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(loginFormProvider.notifier).onEmailChange(value),
            errorMessage:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) =>
                ref.read(loginFormProvider.notifier).onPasswordChange(value),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: colors.primary,
              onPressed: loginForm.isPosting
                  ? null
                  : () async {
                      setState(() {
                        isProgressIndicator = true;
                      });
                      await ref
                          .read(loginFormProvider.notifier)
                          .onFormSubmith();
                      setState(() {
                        isProgressIndicator = false;
                      });
                    },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (isProgressIndicator) const LinearProgressIndicator(),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
