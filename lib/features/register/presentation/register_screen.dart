import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/app_color.dart';
import 'package:movies_app/core/resources/app_icon.dart';
import 'package:movies_app/core/resources/app_image.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isEnglish = true;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final ValueNotifier<Locale> appLocale = ValueNotifier<Locale>(
    const Locale('en'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.black,
      appBar: AppBar(
        backgroundColor: MColors.black,
        centerTitle: true,
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 16,
            color: MColors.yellow,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Image.asset(MIcons.barrow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(MImages.avatar1),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(MImages.avatar2),
                ),
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(MImages.avatar3),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "Avatar",
              style: const TextStyle(color: MColors.white, fontSize: 16),
            ),
            TextField(
              style: const TextStyle(color: MColors.white),
              cursorColor: MColors.yellow,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    MIcons.name,
                    width: 24,
                    height: 24,
                    color: MColors.white,
                  ),
                ),
                hintText: "Name",
                hintStyle: const TextStyle(color: MColors.white),
                filled: true,
                fillColor: MColors.dgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 24),

            TextField(
              style: const TextStyle(color: MColors.white),
              cursorColor: MColors.yellow,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    MIcons.mail,
                    width: 24,
                    height: 24,
                    color: MColors.white,
                  ),
                ),
                hintText: "Email",
                hintStyle: const TextStyle(color: MColors.white),
                filled: true,
                fillColor: MColors.dgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 24),

            TextField(
              obscureText: isPasswordHidden,
              style: const TextStyle(color: MColors.white),
              cursorColor: MColors.yellow,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    MIcons.lock,
                    width: 24,
                    height: 24,
                    color: MColors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    color: MColors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  },
                ),
                hintText: "Password",
                hintStyle: const TextStyle(color: MColors.white),
                filled: true,
                fillColor: MColors.dgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 24),

            TextField(
              obscureText: isConfirmPasswordHidden,
              style: const TextStyle(color: MColors.white),
              cursorColor: MColors.yellow,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    MIcons.lock,
                    width: 24,
                    height: 24,
                    color: MColors.white,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isConfirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: MColors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordHidden = !isConfirmPasswordHidden;
                    });
                  },
                ),
                hintText: "Confirm Password",
                hintStyle: const TextStyle(color: MColors.white),
                filled: true,
                fillColor: MColors.dgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 24),

            TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: MColors.white),
              cursorColor: MColors.yellow,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    MIcons.call,
                    width: 24,
                    height: 24,
                    color: MColors.white,
                  ),
                ),
                hintText: "Phone Number",
                hintStyle: const TextStyle(color: MColors.white),
                filled: true,
                fillColor: MColors.dgrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: MColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    color: MColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: MColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: MColors.yellow,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 18),

            GestureDetector(
              onTap: () {
                setState(() {
                  isEnglish = !isEnglish;
                });
                appLocale.value = isEnglish
                    ? const Locale('en')
                    : const Locale('ar');
              },
              child: Container(
                width: 100,
                height: 40,
                decoration: BoxDecoration(
                  color: MColors.dgrey,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: MColors.yellow, width: 1.5),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(MIcons.en, width: 20, height: 20),
                        Image.asset(MIcons.arabic, width: 20, height: 20),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: isEnglish ? 4 : 54,
                      child: Container(
                        width: 38,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MColors.black.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
