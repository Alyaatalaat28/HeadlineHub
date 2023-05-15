import 'package:flutter/material.dart';

import 'adaptive_progress_indicator.dart';
import 'constants.dart';
class DesktopScreen extends StatelessWidget {
  const DesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                height: double.infinity,
                color: Colors.teal,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("login now to communicate with friends",
                  style: TextStyle(
                 color: Colors.grey,
                 fontSize: 20.0,
                        ),),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                       labelText: 'email address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                   const SizedBox(
                    height: 5.0,
                  ),
                 TextFormField(
                    decoration: const InputDecoration(
                       labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                  ),
               const SizedBox(
                height: 20.0,
               ),
                Row(
                  children: [
                    Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.login), label:const Text('login'))),
                    SizedBox(
                      width: 5.0,
                    ),
                    Expanded(child: OutlinedButton.icon(onPressed: (){}, icon: const Icon(Icons.app_registration), label:const Text('register'))),
                  ],
                ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AdaptiveProgressIndicator(
                  getOs()
                ),
                ],
                          ),
              )),
          ],
          
        ),
    );
  }
}