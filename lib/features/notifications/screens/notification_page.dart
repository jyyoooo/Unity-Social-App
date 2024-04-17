import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:unitysocial/core/constants/unity_appbar.dart';
import 'package:unitysocial/features/notifications/data/notification_model.dart';
import 'package:unitysocial/features/notifications/data/notification_repo.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: UnityAppBar(
            title: 'Notifications',
            enableCloseAction: true,
            smallTitle: true,
          )),
      body: StreamBuilder(
        stream: NotificationRepository().fetchNotification(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Something went wrong',
                    style: TextStyle(color: Colors.grey)));
          } else if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(
                    child: Text('No new notifications',
                        style: TextStyle(color: Colors.grey)))
                : _showNotificationsList(snapshot);
          }
          return const Text('error');
        },
      ),
    );
  }

  ListView _showNotificationsList(
      AsyncSnapshot<List<UnityNotification>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(snapshot.data![index].title),
        subtitle: Text(snapshot.data![index].description),
      ),
      separatorBuilder: (context, index) =>
          const Divider(height: .2, thickness: .2, color: Colors.grey),
    );
  }
}
