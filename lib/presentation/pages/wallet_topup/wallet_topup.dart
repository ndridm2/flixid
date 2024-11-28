import 'package:flixid/presentation/misc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../extensions/int_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_provider.dart';
import '../../providers/user_data/user_data_provider.dart';
import '../../widgets/back_navigation_bar.dart';
import '../../widgets/fade_animation.dart';
import 'method/membership_banner.dart';

class WalletTopup extends ConsumerWidget {
  const WalletTopup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<int> topUpValues = [
      50000,
      100000,
      150000,
      200000,
      300000,
      500000,
      1000000,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
        child: Column(
          children: [
            BackNavigationBar(
              title: 'Top Up',
              onTap: () => ref.read(routerProvider).pop(),
            ),
            // Wrap the ListView.builder with Expanded to allow it to fill available space
            Expanded(
              child: ListView.builder(
                itemCount: topUpValues.length,
                itemBuilder: (context, index) {
                  int value = topUpValues[index];
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            // cardPattern(),
                            membershipBanner(),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 50, 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // verticalSpace(2),
                                      // Container(
                                      //   padding: EdgeInsets.symmetric(
                                      //       horizontal: 8, vertical: 4),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.green,
                                      //     borderRadius:
                                      //         BorderRadius.circular(4),
                                      //   ),
                                      //   child: Text(
                                      //     'Terhemat',
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 12,
                                      //     ),
                                      //   ),
                                      // ),
                                      verticalSpace(20),
                                      Text(
                                        'Top Up',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                      ),
                                      Text(
                                        value.toIDRCurrencyFormat(),
                                        style: const TextStyle(
                                            color: primeOrange,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ref
                                              .read(userDataProvider.notifier)
                                              .topUp(value);
                                          showSuccessSnackbar(context);
                                        },
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade800,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: const Icon(Icons.add,
                                              color: saffron),
                                        ),
                                      ),
                                      const Text(
                                        'Top Up',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccessSnackbar(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 -
            100, // Posisi vertikal di tengah
        left: MediaQuery.of(context).size.width / 2 -
            185, // Posisi horizontal di tengah
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset("assets/ticker.json",
                    width: 350, height: 250), // Ukuran animasi
                FadeAnimation(
                  delay: 1,
                  child: Text(
                    "Top up Berhasil!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                verticalSpace(20),
              ],
            ),
          ),
        ),
      ),
    );

    // Menambahkan overlay entry ke layar
    overlay.insert(overlayEntry);

    // Menghapus overlay setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
      // ignore: use_build_context_synchronously
      GoRouter.of(context).pop();
    });
  }
}
