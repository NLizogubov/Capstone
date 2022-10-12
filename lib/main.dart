import 'package:flutter/material.dart';
import 'package:capstone/domain/Context.dart';
import 'package:capstone/domain/Web/Requests/Top250Request.dart';
import 'package:capstone/data/Top250Movie.dart';

void main() {
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange
      ),
      home: const RootTabBar(),
    );
  }
}

class RootTabBar extends StatefulWidget {
  const RootTabBar({Key? key}) : super(key: key);

  @override
  State<RootTabBar> createState() => _RootTabBarControllerState();
}

class _RootTabBarControllerState extends State<RootTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Image.asset('assets/images/account.png')),
              Tab(icon: Image.asset('assets/images/account.png')),
            ],
          ),
          title: const Text('Home'),
        ),
        body: const TabBarView(
          children: [
            Top250Movies(),
            Top250Movies()
          ],
        ),
      ),
    );
  }
}

class Top250Movies extends StatefulWidget {
  const Top250Movies({Key? key}) : super(key: key);

  @override
  State<Top250Movies> createState() => _Top250MoviesState();
}

class _Top250MoviesState extends State<Top250Movies> {

  // MARK: - Properties

  final dependencies = Context();

  List<Top250Movie> movies = [];

  // MARK: - Lifecycle
  
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text('Loading...'),
      );
    } else {
      return ListView.builder(
          itemBuilder: (context, index) {
            final movie = movies[index];

            return makeListItem(movie);
          },
      );
    }
  }

  Widget makeListItem(Top250Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text("Title: "),
            Text(movie.title),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Text("Year: "),
            Text(movie.year),
          ]),
          const SizedBox(height: 4),
          Row(children: [
            const Text("Rating: "),
            Text(movie.imDbRating),
          ]),
        ],
      ),
    );
  }
  
  // MARK: - Methods

  void fetchData() async {
    final request = Top250Request();
    final response = await dependencies.webService.perform(request);
    final items = response['items'];

    List<Top250Movie> movies = [];
    for (var item in items) {
      final model = Top250Movie.fromJson(item);

      movies.add(model);
    }

    setState(() {
      this.movies = movies;
    });
  }
  
}



