import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:todo_stuffasia/shared/themedata.dart'
    show Margin, StyleSheet;

class CustomDrawer extends StatelessWidget {
  final Margin margin = StyleSheet().margin(10);

  Widget _listTile(
      BuildContext context, String text, IconData icon, Function onPressed) {
    return ListTile(
      leading: Padding(
        padding: margin.leftMargin,
        child: Icon(
          icon,
          color: Theme.of(context).primaryIconTheme.color,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        onPressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 1,
            ),
            Material(
              child: Container(
                width: double.infinity,
                margin: margin.leftMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _listTile(
                            context,
                            "Calendar",
                            Icons.calendar_today,
                            () {
                              // TODO:implement notifications
                            },
                          ),
                          _listTile(
                            context,
                            "Notifications",
                            Icons.notifications_none,
                            () {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              elevation: 1,
            ),
            SizedBox(
              height: 1,
            ),
            Material(
              child: Container(
                width: double.infinity,
                margin: margin.topLeftMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: margin.bottomtMargin,
                      child: Text(
                        "Enrolled",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    _listTile(
                      context,
                      "To-do",
                      Icons.fact_check_outlined,
                      () {},
                    ),
                    ListTile(
                      leading: Container(
                        margin: EdgeInsets.fromLTRB(
                          2,
                          margin.marginUnit,
                          0,
                          margin.marginUnit,
                        ),
                        child: CircleAvatar(
                          child: Text("M"),
                        ),
                      ),
                      title: Text(
                        "MIT 523: Advanced Web Tech...",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text("MIT 3rd Batch"),
                      contentPadding: EdgeInsets.zero,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              elevation: 1,
            ),
            SizedBox(
              height: 1,
            ),
            Material(
              child: Container(
                width: double.infinity,
                margin: margin.leftMargin,
                child: Column(
                  children: [
                    _listTile(
                      context,
                      "Archived classes",
                      Icons.archive_outlined,
                      () {},
                    ),
                    _listTile(
                      context,
                      "Classroom folder",
                      Icons.folder_open,
                      () {},
                    ),
                    _listTile(
                      context,
                      "Settings",
                      Icons.settings_outlined,
                      () {},
                    ),
                    _listTile(
                      context,
                      "Help",
                      Icons.help_outline_outlined,
                      () {},
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;
  MyListTile({
    @required this.text,
    @required this.icon,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(icon),
        color: Theme.of(context).primaryIconTheme.color,
        onPressed: () => onPressed,
      ),
      title: Text(text),
      contentPadding: EdgeInsets.zero,
    );
  }
}
