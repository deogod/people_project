import 'package:flutter/material.dart';
import 'package:people_project/database/view/database_view.dart';
import 'package:people_project/details/view_model/details_view_model.dart';
import 'package:people_project/home/model/user_model.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  final User user;

  const DetailsView({super.key, required this.user});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final DetailsViewModel viewModel = DetailsViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return ChangeNotifierProvider<DetailsViewModel>(
        create: (_) => DetailsViewModel(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Detalhes'),
            centerTitle: true,
          ),
          body: Consumer<DetailsViewModel>(
            builder: (context, viewModel, _) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.picture.large),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        '${user.name.title} ${user.name.first} ${user.name.last}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card de Contato
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(user.email),
                        subtitle: Text('Username: ${user.login.username}'),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(user.phone),
                        subtitle: Text('Cell: ${user.cell}'),
                      ),
                    ),

                    // Card de Endereço
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.home),
                        title: Text(
                            '${user.location.street.number} ${user.location.street.name}, ${user.location.city}'),
                        subtitle: Text(
                            '${user.location.state}, ${user.location.country}, ${user.location.postcode}'),
                      ),
                    ),

                    // Card de Coordenadas e Timezone
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.map),
                        title: Text(
                            'Lat: ${user.location.coordinates.latitude}, Long: ${user.location.coordinates.longitude}'),
                        subtitle: Text(
                            'Timezone: ${user.location.timezone.description} (${user.location.timezone.offset})'),
                      ),
                    ),

                    // Card de Datas
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.cake),
                        title: Text('Nascimento: ${user.dob.date}'),
                        subtitle: Text('Idade: ${user.dob.age}'),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.date_range),
                        title: Text('Registrado: ${user.registered.date}'),
                        subtitle: Text('Há ${user.registered.age} anos'),
                      ),
                    ),

                    // Card de ID
                    Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.perm_identity),
                        title: Text('NINO: ${user.id.value}'),
                        subtitle: Text('Nationality: ${user.nat}'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: Column(
            mainAxisSize:
                MainAxisSize.min, // mantém o tamanho ajustado aos FABs
            crossAxisAlignment: CrossAxisAlignment.end, // alinha à direita
            children: [
              FloatingActionButton(
                heroTag: 'btn1',
                onPressed: () {
                  viewModel.savePerson(user, context);
                },
                tooltip: 'Salvar',
                child: const Icon(Icons.save),
              ),
              const SizedBox(height: 12),
              FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {
                  viewModel.removePerson(user.login.uuid, context);
                },
                tooltip: 'Remover',
                backgroundColor: Colors.red,
                child: const Icon(Icons.remove),
              ),
              const SizedBox(height: 12),
              FloatingActionButton(
                heroTag: 'btn3',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DatabaseView(),
                    ),
                  );
                },
                tooltip: 'Lista de persistidos',
                child: const Icon(Icons.storage),
              ),
            ],
          ),
        ));
  }
}
