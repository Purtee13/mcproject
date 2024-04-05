import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool? isMe;
  final String? image;
  final String? type;
  final String? friendName;
  final String? myName;
  final Timestamp? date;

  const SingleMessage(
      {super.key,
      this.message,
      this.isMe,
      this.image,
      this.type,
      this.friendName,
      this.myName,
      this.date});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime d = DateTime.parse(date!.toDate().toString());
    String cdate = "${d.hour}" + ":" + "${d.minute}";
    return type == "text"
        ? Container(
            constraints: BoxConstraints(
              maxWidth: size.width / 2,
            ),
            alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Container(
                decoration: BoxDecoration(
                  color: isMe! ? Colors.pink : Colors.black,
                  borderRadius: isMe!
                      ? BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                ),
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxWidth: size.width / 2,
                ),
                alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          isMe! ? myName! : friendName!,
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        )),
                    Divider(),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          message!,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                    Divider(),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "$cdate",
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        )),
                  ],
                )),
          )
        : type == 'img'
            ? Container(
                height: size.height / 2.5,
                width: size.width,
                // constraints: BoxConstraints(
                //   maxWidth: size.width / 2,
                // ),
                alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Container(
                    height: size.height / 2.5,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: isMe! ? Colors.pink : Colors.black,
                      borderRadius: isMe!
                          ? BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                    ),
                    // padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: size.width / 2,
                    ),
                    alignment:
                        isMe! ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isMe! ? myName! : friendName!,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white70),
                            )),
                        Divider(),
                        CachedNetworkImage(
                          imageUrl: message!,
                          fit: BoxFit.cover,
                          height: size.height / 3.62,
                          width: size.width,
                          placeholder: (context, url) => BuildShimmer(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Divider(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "$cdate",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white70),
                            )),
                      ],
                    )),
              )
            : Container(
                constraints: BoxConstraints(
                  maxWidth: size.width / 2,
                ),
                alignment: isMe! ? Alignment.centerRight : Alignment.centerLeft,
                padding: EdgeInsets.all(10),
                child: Container(
                    decoration: BoxDecoration(
                      color: isMe! ? Colors.pink : Colors.black,
                      borderRadius: isMe!
                          ? BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            )
                          : BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                    ),
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(
                      maxWidth: size.width / 2,
                    ),
                    alignment:
                        isMe! ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isMe! ? myName! : friendName!,
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white70),
                            )),
                        Divider(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                await launchUrl(Uri.parse("$message"));
                              },
                              child: Text(
                                message!,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            )),
                        Divider(),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "$cdate",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.white70),
                            )),
                      ],
                    )),
              );
  }
}

const double defaultPadding = 16.0;

class BuildShimmer extends StatelessWidget {
  const BuildShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Shimmer.fromColors(
          child: ShimmerWidget(),
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: double.infinity,
          height: 200,
        ),
      ),
    );
  }
}

// class ShimmerWidget extends StatelessWidget {
//   const ShimmerWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Skeleton(height: 120, width: 120),
//         const SizedBox(width: defaultPadding),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Skeleton(width: 80),
//               const SizedBox(height: defaultPadding / 2),
//               const Skeleton(),
//               const SizedBox(height: defaultPadding / 2),
//               const Skeleton(),
//               const SizedBox(height: defaultPadding / 2),
//               Row(
//                 children: const [
//                   Expanded(
//                     child: Skeleton(),
//                   ),
//                   SizedBox(width: defaultPadding),
//                   Expanded(
//                     child: Skeleton(),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
//
// class Skeleton extends StatelessWidget {
//   final double? height;
//   final double? width;
//   const Skeleton({super.key, this.width, this.height});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       width: width,
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(16),
//       ),
//     );
//   }
// }
