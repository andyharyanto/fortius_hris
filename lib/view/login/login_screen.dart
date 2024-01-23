import 'package:flutter/material.dart';
import 'package:fortius_hris/common/colors.dart';
import 'package:fortius_hris/common/styles.dart';
import 'package:fortius_hris/view/login/login_view_model.dart';
import 'package:fortius_hris/widget/fortius_error_widget.dart';
import 'package:fortius_hris/widget/fortius_long_button.dart';
import 'package:fortius_hris/widget/fortius_text_field.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../common/constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  late LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<LoginViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(builder: (_, model, child) {
      return Scaffold(
          backgroundColor: darkBluePrimary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Center(
                    child: Image.asset(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        fortiusLogoWhite),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText().textBold("Sign In").fontSize(24),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomText().textBold("Email"),
                        const SizedBox(
                          height: 4,
                        ),
                        FortiusTextField(
                            hints: "Email",
                            type: TFType.email,
                            textEditingController: controllerEmail),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomText().textBold("Password"),
                        const SizedBox(
                          height: 4,
                        ),
                        FortiusTextField(
                            hints: "Password",
                            type: TFType.password,
                            textEditingController: controllerPassword),
                        viewModel.getMessageError != ""
                            ? Container(
                                margin: const EdgeInsets.only(top: 12),
                                child: FortiusErrorWidget(
                                    errorText: viewModel.getMessageError),
                              )
                            : Container(),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FortiusLongButton(
                              buttonText: "Sign In",
                              onButtonPress: () async {
                                viewModel.postLogin(
                                    controllerEmail.text.toString(),
                                    controllerPassword.text.toString());
                              },
                              disabled: false,
                              isLoading: viewModel.getIsLoading),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ));
    });
  }
}
