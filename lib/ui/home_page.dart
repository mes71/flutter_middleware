import 'package:flutter/material.dart';
import 'package:flutter_middleware/data/local/fake_data.dart';
import 'package:flutter_middleware/data/middlerware/middleware.dart';
import 'package:flutter_middleware/data/middlerware/role_check_middleware.dart';
import 'package:flutter_middleware/data/middlerware/throttling_middleware.dart';
import 'package:flutter_middleware/data/middlerware/user_exists_middleware.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FakeData? _fakeData;

  @override
  void initState() {
    initFakeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Middleware in flutter'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email)),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock)),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(180, 43)),
              onPressed: () {
                _fakeData?.logIn(
                    _emailController.text, _passwordController.text);
              },
              child: const Text('Login'))
        ],
      ),
    );
  }

  void initFakeData() {
    _fakeData = FakeData();
    _fakeData?.register('admin@gmail.com', '1234');
    _fakeData?.register('writer@gmail.com', '1234');
    _fakeData?.register('user@gmail.com', '1234');

    Middleware middleware = Middleware.link(ThrottlingMiddleware(3),
        [UserExistsMiddleware(_fakeData!), RoleCheckMiddleware()]);

    _fakeData?.setMiddleware = middleware;
  }
}
