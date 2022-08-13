import 'package:flutter/material.dart';
import 'package:samba_browser/samba_browser.dart';

void main() {
  runApp(const SambaApp());
}

class SambaApp extends StatefulWidget {
  const SambaApp({Key? key}) : super(key: key);

  @override
  State<SambaApp> createState() => _SambaAppState();
}

class _SambaAppState extends State<SambaApp> {

  String shareUrl = '';
  String domain = '';
  String username = '';
  String password = '';

  Future<List>? shareFuture;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SAMBA Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) => shareUrl = text,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'SAMBA share URL',
                    ),
                  ),

                  TextFormField(
                    onChanged: (text) => domain = text,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Domain',
                    ),
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          onChanged: (text) => username = text,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                        child: TextFormField(
                          onChanged: (text) => password = text,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ],
                  ),

                  TextButton(
                    onPressed: () => setState(() {
                      shareFuture = SambaBrowser.getShareList(shareUrl, domain, username, password);
                    }),
                    child: const Text("List available shares")
                  ),

                  const SizedBox(height: 30.0),

                  if (shareFuture != null) FutureBuilder(future: shareFuture, builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Column(
                      children: [
                        const Text('An error has occurred.'),
                        Text(snapshot.error.toString())
                      ]);
                    }

                    if (!snapshot.hasData) return const CircularProgressIndicator();

                    List<String> shares = (snapshot.data as List).cast<String>();
                    return Column(children: shares.map((e) => Text(e)).toList());
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
