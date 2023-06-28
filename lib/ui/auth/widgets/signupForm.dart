import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:graduate_app/app/app_locator.dart';
import 'package:graduate_app/app/app_router.gr.dart';
import 'package:graduate_app/features/auth/cubits/signup_cubit.dart';
import 'package:graduate_app/helpers/helpers.dart';
import 'package:graduate_app/utils/utils.dart';
import 'package:image_cropper/image_cropper.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: const SignupFormView(),
    );
  }
}

class SignupFormView extends HookWidget {
  const SignupFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) => state.maybeMap(
        error: (state) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  exceptionHandler(state.exception),
                ),
              ),
            );
          return null;
        },
        orElse: () => null,
      ),
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final file = await locator.get<ImageHelper>().pick();

                  if (file != null) {
                    final croppedFile = await locator.get<ImageHelper>().crop(
                          file: file,
                          cropStyle: CropStyle.circle,
                        );
                    if (croppedFile != null) {
                      // ignore: use_build_context_synchronously
                      context
                          .read<SignupCubit>()
                          .updateFile(File(croppedFile.path));
                    }
                  }
                },
                child: BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return Center(
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 64,
                          foregroundImage: state.file != null
                              ? FileImage(state.file!)
                              : null,
                          child: const Icon(Icons.add_a_photo, size: 48),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
                keyboardType: TextInputType.name,
                onChanged: context.read<SignupCubit>().updateName,
                validator: (val) =>
                    val!.trim().isNotEmpty ? null : 'Invalid name',
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                onChanged: context.read<SignupCubit>().updateEmail,
                validator: (val) => val!.contains('@') ? null : 'Invalid email',
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
                obscureText: true,
                onChanged: context.read<SignupCubit>().updatePassword,
                validator: (val) => val!.length > 5
                    ? null
                    : 'Password must be at least 6 characters',
              ),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signUp();
                  }
                },
                child: const Text('Sign Up'),
              ),
              const Spacer(),
              const Divider(),
              TextButton(
                onPressed: () =>
                    AutoRouter.of(context).push(const LoginRoute()),
                child: const Text('Already have an account? Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
