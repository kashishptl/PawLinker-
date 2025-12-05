import 'package:flutter/material.dart';
import 'package:pawlinker/model/user.dart';
import 'login.dart'; // Ensure to import the Login screen

User tempUser = User("1", "Megh Tarwadi", "jmegh@gmail.com", "MeghMegh", "lib/resources/user.png");

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current theme colors
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    String stars = "";
    for (int i = 0; i < tempUser.password.length; i++) {
      stars += "*";
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: colorScheme.primary.withAlpha(32), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Profile Image
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: colorScheme.primary, width: 3),
                            image: DecorationImage(image: AssetImage(tempUser.image), fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello ${tempUser.name.split(' ')[0]}',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.primary),
                              ),

                              Text(
                                'Welcome to Pawlinker!',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorScheme.primary),
                              ),
                              const SizedBox(height: 8),
                              // Email and password section
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${tempUser.email}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: colorScheme.primary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Password: ${stars}', // Password should be hidden
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(color: colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Description about App inside a container with styling
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: colorScheme.primary.withAlpha(32), borderRadius: BorderRadius.circular(16)),
                child: Text(
                  'Pawlinker is your one-stop solution for everything pet-related. '
                  'You can adopt pets, shop for their accessories, toys, food, and even get helpful care tips.\n\n'
                  'Here’s what you can do with Pawlinker:\n'
                  '- Adopt pets from various categories.\n'
                  '- Buy food, toys, grooming kits, and more for your pets.\n'
                  '- Access expert pet care tips and recommendations.\n\n'
                  'We’re here to make your pet-parenting journey easy and fun!',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Floating action button for Log Out
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate directly to Login screen when Log out is clicked
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        },
        child: const Icon(Icons.logout),
        backgroundColor: Theme.of(context).colorScheme.primary, // Log Out button color
        tooltip: 'Log Out',
      ),
    );
  }
}
