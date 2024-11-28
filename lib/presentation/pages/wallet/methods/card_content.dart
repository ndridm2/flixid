import '../../../extensions/int_extension.dart';
import '../../../misc/constants.dart';
import '../../../misc/methods.dart';
import '../../../providers/router/router_provider.dart';
import '../../../providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget cardContent(WidgetRef ref) => Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 50, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current balance',
                style: TextStyle(
                    fontSize: 12, color: Colors.white.withOpacity(0.5)),
              ),
              Text(
                (ref.watch(userDataProvider).valueOrNull?.balance ?? 0)
                    .toIDRCurrencyFormat(),
                style: const TextStyle(
                    color: primeOrange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpace(10),
              Text(ref.watch(userDataProvider).valueOrNull?.name ?? ''),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => ref.read(routerProvider).pushNamed('wallet-topup'),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.add, color: balanceColor),
                ),
              ),
              const Text(
                'Top Up',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
