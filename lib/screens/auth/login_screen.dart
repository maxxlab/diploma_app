import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tourist_app/screens/auth/widgets/auth_divider.dart';
import 'package:tourist_app/screens/auth/widgets/auth_form_container.dart';
import 'package:tourist_app/screens/auth/widgets/auth_gradient_background.dart';
import 'package:tourist_app/screens/auth/widgets/auth_header.dart';
import 'package:tourist_app/screens/auth/widgets/google_sign_in_button.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_text_field.dart';
import '../../core/extensions/string_extension.dart';
import '../../generated/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() == true) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleGoogleSignIn() {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthGradientBackground(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              context.go('/home');
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom - 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      AuthHeaderWidget(
                        title: 'Welcome Back',
                        subtitle: 'Sign in to continue your journey',
                      ),
                      const SizedBox(height: 10),
                      AuthFormContainer(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AppTextField(
                                controller: _emailController,
                                label: S.of(context).email,
                                keyboardType: TextInputType.emailAddress,
                                enabled: !isLoading,
                                validator: (value) {
                                  if (value == null || value.isEmpty || !value.isEmail) {
                                    return S.of(context).errorInvalidEmail;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              AppTextField(
                                controller: _passwordController,
                                label: S.of(context).password,
                                obscureText: true,
                                enabled: !isLoading,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).errorEmptyPassword;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              AppButton(
                                onPressed: isLoading ? null : _handleLogin,
                                label: S.of(context).login,
                                isLoading: isLoading,
                              ),
                              const AuthDividerWidget(),
                              GoogleSignInButton(
                                onPressed: isLoading ? null : _handleGoogleSignIn,
                                isLoading: isLoading,
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: TextButton(
                                  onPressed: isLoading ? null : () => context.go('/signup'),
                                  child: Text(
                                    S.of(context).noAccount,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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