import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:people_project/database/view/database_view.dart';
import 'package:people_project/details/view/details_view.dart';
import 'package:people_project/home/view_model/home_view_model.dart';
import 'package:people_project/utils/person_list_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ViewModel viewModel = ViewModel();
  late final Ticker _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) async {
    if (elapsed.inSeconds - _elapsed.inSeconds >= 5) {
      _elapsed = elapsed;
      viewModel.getPerson();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return ListView.builder(
              itemCount: viewModel.people.length,
              itemBuilder: (context, index) {
                final person = viewModel.people[index];
                return PersonListTile(
                  person: person,
                  context: context,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsView(user: person),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.storage_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DatabaseView(),
              ),
            );
          }),
    );
  }
}
