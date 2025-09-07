import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constant.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/images/profile_img.png'),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: textFieldColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Vikas Kushwaha',
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'vikas@gmail.com',
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                        Text(
                          '7588970296',
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(onPressed: () {}, child: const Text('Edit'))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileListTile(title: 'Address', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Wishlist', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Payment', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Help', pageRedirection: () {}),
              const SizedBox(height: 10),
              ProfileListTile(title: 'Support', pageRedirection: () {}),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final VoidCallback pageRedirection;
  const ProfileListTile({super.key, required this.title, required this.pageRedirection});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Iconsax.arrow_right_3),
        onTap: pageRedirection,
      ),
    );
  }
}
