import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.lightBackgroundGray),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[50]!, blurRadius: 10, spreadRadius: 3)
            ],
            borderRadius: BorderRadius.circular(18),
            color: Colors.transparent),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: CupertinoColors.systemGrey3,
                      child: Icon(
                        CupertinoIcons.person,
                        color: CupertinoColors.lightBackgroundGray,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
                child: Container(
              color: CupertinoColors.lightBackgroundGray,
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Icon(
                CupertinoIcons.photo,
                size: 100,
                color: Colors.grey,
              )),
            )),
          ],
        ),
      ),
    );
  }
}