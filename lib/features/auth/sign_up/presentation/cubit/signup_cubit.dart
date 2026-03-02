import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  final supabase = Supabase.instance.client;

  Future<void> signup({
    required String email,
    required String password,
    String? name,
  }) async {
    // ──────────────── Validation ────────────────
    if (email.trim().isEmpty) {
      emit(SignupError("الإيميل مطلوب"));
      return;
    }

    if (!isValidEmail(email.trim())) {
      emit(SignupError("الإيميل غير صحيح (مثال: name@example.com)"));
      return;
    }

    if (password.isEmpty) {
      emit(SignupError("كلمة المرور مطلوبة"));
      return;
    }

    if (password.length < 8) {
      emit(SignupError("كلمة المرور لازم تكون 8 حروف أو أكتر"));
      return;
    }
    try {
      emit(SignupLoading());

      await supabase.auth.signUp(
        email: email.trim(),
        password: password.trim(),
      );

      emit(SignupSuccess());
    } on AuthException catch (e) {
      emit(SignupError(e.message));
    } catch (e) {
      emit(SignupError("حصل خطأ غير متوقع: $e"));
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
