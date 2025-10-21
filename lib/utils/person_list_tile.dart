import 'package:flutter/material.dart';
import 'package:people_project/home/model/user_model.dart';

// ignore: non_constant_identifier_names
Widget PersonListTile(
    {required User person,
    required BuildContext context,
    required VoidCallback onTap}) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    leading: CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(person.picture.thumbnail),
      backgroundColor: Colors.grey[200],
    ),
    title: Text(
      '${person.name.first} ${person.name.last}',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    subtitle: Row(
      children: [
        const Icon(Icons.email, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            person.email,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    tileColor: Colors.white,
    onTap: onTap,
  );
}
