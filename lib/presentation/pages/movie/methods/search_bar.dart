import '../../../misc/constants.dart';
import 'package:flutter/material.dart';

Widget searchBar(BuildContext context) => Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 24 - 24 - 90,
          height: 50,
          margin: const EdgeInsets.only(left: 24, right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 48, 52, 69),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            style: TextStyle(color: Colors.grey.shade400),
            decoration: const InputDecoration(
              hintText: 'Search movie',
              border: InputBorder.none,
              icon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [primeOrange, primeRed]),
              borderRadius: BorderRadius.circular(10)),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            child: const Center(
              child: Icon(
                Icons.search,
                color: ghostWhite,
              ),
            ),
          ),
        ),
      ],
    );
