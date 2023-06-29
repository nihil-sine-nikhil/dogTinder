import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task/src/app/constants/ui_constants.dart';

import '../../../data/card/provider/card_provider.dart';
import '../../../data/dog/bloc/dog_bloc.dart';
import '../../../data/user/bloc/user_bloc.dart';
import '../../widgets/dancing_dots.dart';
import '../widgets/dog_card.dart';
import '../widgets/rounded_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DogBloc, DogState>(
      builder: (context, state) {
        final cardProvider = Provider.of<CardProvider>(context, listen: false);
        cardProvider.loadCounts();
        return Scaffold(
            body: (state is DogImageLoaded)
                ? SafeArea(
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      DogCard(
                        urlImage: state.dog!.pic!,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kRed,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofDislikes.toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kBlue,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofLikes.toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RoundedIconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: kBlack,
                                  ),
                                ),
                                Consumer<CardProvider>(
                                  builder: (context, provider, _) {
                                    return poppinsText(
                                      txt: provider.numberofSuperlikes
                                          .toString(),
                                      fontSize: 20,
                                      color: kWhite,
                                      weight: FontWeight.w700,
                                    );
                                  },
                                )
                              ],
                            ),
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserProfileLoaded) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      poppinsText(
                                          txt: "Hi!",
                                          fontSize: 20,
                                          color: kWhite,
                                          weight: FontWeight.w500),
                                      poppinsText(
                                          txt: state.userProfile.name,
                                          fontSize: 20,
                                          maxLines: 2,
                                          color: kWhite,
                                          weight: FontWeight.w700),
                                    ],
                                  );
                                }
                                return JumpingDots();
                              },
                            )
                          ],
                        ),
                      )
                    ]),
                  )
                : Center(
                    child: JumpingDots(),
                  ));
      },
    );
  }
}
