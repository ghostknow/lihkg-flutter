import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/widget/common/common_widget.dart';
import 'package:lihkg_flutter/page/user_profile.dart';

typedef VoidCallback OnPageChange(int page);

class UserModalBottomSheet extends StatelessWidget {
  final User user;
  final Item thread;
  final ThreadItem reply;

  UserModalBottomSheet(
      {@required this.user, @required this.thread, @required this.reply});

  Widget _buildInfoRow() => Builder(builder: (BuildContext context) {
        final theme = Theme.of(context);
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserNickname(
                      user: user,
                      nickname: thread.userNickname,
                      fontSize: theme.textTheme.subhead.fontSize),
                  Text('#${user.userId}',
                      style: theme.textTheme.subtitle
                          .copyWith(color: theme.disabledColor))
                ],
              )
            ]));
      });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ModalBottomSheet(
        child: SafeArea(
            bottom: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildInfoRow(),
                Expanded(
                    child: ListView(
                  itemExtent: 50,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                        leading:
                            Icon(Icons.search, color: theme.iconTheme.color),
                        title: Text('起底', style: theme.textTheme.subhead),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  UserProfilePage(user: user)));
                        }),
                    // ListTile(
                    //     leading: Icon(Icons.import_contacts,
                    //         color: theme.iconTheme.color),
                    //     title: Text('追故模式', style: theme.textTheme.subhead)),
                    // ListTile(
                    //     leading:
                    //         Icon(Icons.reply, color: theme.iconTheme.color),
                    //     title: Text('引用回覆', style: theme.textTheme.subhead)),
                    ListTile(
                        leading:
                            Icon(Icons.share, color: theme.iconTheme.color),
                        title: Text('分享${reply.msgNum == "1" ? '主題' : '回覆'}'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Share.share(reply.msgNum == "1"
                              ? '${thread.title}\nhttps://lih.kg/${thread.threadId}\n- 分享自 LIHKG 討論區'
                              : '${thread.title}\nhttps://lihkg.com/thread/${thread.threadId}/page/${reply.page}?post=${reply.msgNum}\n#${reply.msgNum} 回覆 - 分享自 LIHKG 討論區');
                        }),
                    // ListTile(
                    //     leading:
                    //         Icon(Icons.report, color: theme.iconTheme.color),
                    //     title: Text('檢舉回覆', style: theme.textTheme.subhead)),
                  ],
                ))
              ],
            )));
  }
}
