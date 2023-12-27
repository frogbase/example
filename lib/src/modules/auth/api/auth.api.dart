import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../frogbase/utils/helpers.dart';
import '../../../shared/show_toast/awsome.snackbar/awesome.snackbar.dart';
import '../../../shared/show_toast/awsome.snackbar/show.awesome.snackbar.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/logger/logger_helper.dart';
import '../provider/auth.provider.dart';

Future<void> fgbsSignup(BuildContext context, AuthProvider notifier) async {
  EasyLoading.show(status: 'Creating account...');
  try {
    //
    await fb.signup(data: {
      'username': notifier.usernameCntrlr.text,
      'email': notifier.emailCntrlr.text,
      'password': notifier.pwdCntrlr.text,
      'name': notifier.nameCntrlr.text,
    });
    //
    notifier.clear();
    if (!context.mounted) return;
    showAwesomeSnackbar(
        context, 'Success!', 'User created successfully.', MessageType.success);
    context.beamUpdate();
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('User Creation: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', e.toString(), MessageType.failure);
    return;
  }
}

Future<void> fgbsSignin(BuildContext context, AuthProvider notifier) async {
  EasyLoading.show(status: 'Matching Credentials...');
  try {
    //
    await fb.signin(notifier.emailCntrlr.text, notifier.pwdCntrlr.text);
    //
    notifier.clear();
    if (!context.mounted) return;
    context.beamUpdate();
    EasyLoading.dismiss();
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('User signin: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', e.toString(), MessageType.failure);
    return;
  }
}

Future<void> fgbsResetPassword(BuildContext context, String email) async {
  EasyLoading.show(status: 'Sending email...');
  try {
    //
    return;
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return;
  } catch (e) {
    log.e('Reset Password: $e');
    if (!context.mounted) return;
    showAwesomeSnackbar(context, 'Failed!', e.toString(), MessageType.failure);
    return;
  }
}
