import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provide LoginCubit.
    return const LoginFormView();
  }
}

class LoginFormView extends HookWidget {
  const LoginFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    // TODO: Add LoginCubit BlocListener.
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (val) {
                // TODO: Update email in state.
              },
              validator: (val) => val!.contains('@') ? null : 'Invalid email',
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              onChanged: (val) {
                // TODO: Update password in state.
              },
              validator: (val) => val!.length > 5 ? null : 'Invalid password',
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // TODO: Log in with email and password.
                }
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}
