import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../core/provider/account_provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<AccountProvider>().currentUser;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg1.png'),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            'images/profile_image_sample.png',
            width: 50,
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.playerName,
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.textTheme.headline6.color,
                  ),
                ),
                Text(
                  user.islandName,
                  style: TextStyle(
                    fontSize: 15,
                    color: theme.textTheme.bodyText2.color,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
