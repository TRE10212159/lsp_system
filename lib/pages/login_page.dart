import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lsp_system/core/constants/dictionary.dart';
import 'package:lsp_system/core/constants/routes.dart';
import 'package:lsp_system/core/providers/auth_provider.dart';
import 'package:lsp_system/shared/widgets/icons.dart';

/// ログインページ
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ログイン処理
  Future<void> _handleLogin() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate() || !mounted) return;
    setState(() => _isLoading = true);
    try {
      final success = await ref
          .read(authStateProvider.notifier)
          .login(_usernameController.text, _passwordController.text);
      if (!mounted) return;
      if (success) return context.go(Routes.home.value);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ログインに失敗しました'), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.primary);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.business, size: 80),
                Text(Dictionary.appName.t(), style: textStyle, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                _buildTextInput(_usernameController, Dictionary.userName.t(), Icons.person),
                const SizedBox(height: 16),
                _buildTextInput(_passwordController, Dictionary.password.t(), Icons.lock),
                const SizedBox(height: 24),
                Container(
                  height: 42,
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
                  child: FilledButton(
                    onPressed: _handleLogin,
                    style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: _isLoading ? const LoadingIcon(color: Colors.white) : Text(Dictionary.login.t()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(TextEditingController controller, String labelText, IconData prefixIcon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText, border: OutlineInputBorder(), prefixIcon: Icon(prefixIcon)),
      validator: (value) {
        if (value == null || value.isEmpty) return Dictionary.inputPrompt.t({'text': labelText});
        return null;
      },
    );
  }
}
