import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'profile_view.dart';

class _NavigateDrawerItem extends StatelessWidget {
  final String title;
  final String routeName;

  _NavigateDrawerItem(this.title, this.routeName);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      leading: Icon(Icons.face),
      title: Text(title),
    );
  }
}

class _AcnhDrawer extends StatelessWidget {
  _AcnhDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final T = S.of(context);
    return Drawer(
      child: ListView(children: <Widget>[
        ProfileView(),
        _NavigateDrawerItem(T.pageTurnip, '/'),
        _NavigateDrawerItem(T.pageFriends, '/friend'),
        _NavigateDrawerItem(T.pageProfile, '/profile'),
      ]),
    );
  }
}

class AcnhPage extends StatefulWidget {
  final String title;
  final bool showDrawer;
  final Widget child;
  final Widget floatingActionButton;
  final List<Widget> actions;

  AcnhPage(
      {Key key,
      this.title,
      this.child,
      this.floatingActionButton,
      this.showDrawer = true,
      this.actions})
      : super(key: key);

  @override
  _AcnhPageState createState() => _AcnhPageState();
}

class _AcnhPageState extends State<AcnhPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        actions: widget.actions,
        title: widget.title != null ? Text(widget.title) : null,
        centerTitle: true,
      ),
      drawer: widget.showDrawer ? _AcnhDrawer() : null,
      body: widget.child,
      floatingActionButton: widget.floatingActionButton,
    );
  }
}
