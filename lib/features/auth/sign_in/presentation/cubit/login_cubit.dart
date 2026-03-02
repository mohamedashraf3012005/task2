import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final supabase = Supabase.instance.client;
  final googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.isEmpty) {
      emit(LoginError('الإيميل وكلمة المرور مطلوبين'));
      return;
    }

    try {
      emit(LoginLoading());

      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.session != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginError('فشل تسجيل الدخول – لا يوجد جلسة'));
      }
    } on AuthException catch (e) {
      emit(LoginError(e.message));
    } catch (e) {
      emit(LoginError('حدث خطأ غير متوقع: $e'));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(LoginLoading());

      final googleSignIn = GoogleSignIn(
        serverClientId:
            '909306851836-fd0qeporlfnd13q9edq4ukj97sqvdscd.apps.googleusercontent.com',
        scopes: ['email'],
      );

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(LoginError('تم إلغاء اختيار الحساب'));
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        emit(LoginError('فشل في الحصول على ID Token'));
        return;
      }

      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );

      if (response.session != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginError('فشل إنشاء الجلسة بعد تسجيل الدخول'));
      }
    } on AuthException catch (e) {
      emit(LoginError('خطأ من Supabase: ${e.message}'));
    } catch (e) {
      emit(LoginError('خطأ غير متوقع أثناء تسجيل الدخول بجوجل: $e'));
    }
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      await googleSignIn.signOut();
      emit(LoginInitial());
    } catch (e) {
      emit(LoginError('فشل تسجيل الخروج: $e'));
    }
  }
}
