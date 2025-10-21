import 'package:flutter/material.dart';
import 'package:people_project/details/view/details_view.dart';
import 'package:people_project/utils/person_list_tile_scroll.dart';

import '../view_model/database_view_model.dart';

class DatabaseView extends StatefulWidget {
  const DatabaseView({super.key});

  @override
  State<DatabaseView> createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<DatabaseView> {
  final DataBaseViewModel viewModel = DataBaseViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init().then((_) {
      viewModel.getPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Database')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            final people = viewModel.people ?? [];

            if (people.isEmpty) {
              return const Center(child: Text('Nenhum usuário salvo'));
            }

            return SizedBox(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: people.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final person = people[index];

                  return PersonHorizontalTileScroll(
                    person: person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsView(user: person),
                        ),
                      );
                    },
                    onDelete: () {
                      viewModel.removePerson(person.login.uuid, context);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
