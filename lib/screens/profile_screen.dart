import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_scratch/constants.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late TabController tbController;
  late Map<String?, dynamic> userData;
  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  bool _progressController = true;

  @override
  void initState() {
    tbController = TabController(length: 3, vsync: this);
    getUserData();
    super.initState();
  }

  void getUserData() async {
    try {
      final userDoc = await db
          .collection("users")
          .where("uuid", isEqualTo: currentUser?.uid)
          .get();

      userData = userDoc.docs[0].data();
      setState(() {
        _progressController = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: kWhite,
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              backgroundColor: kWhite,
              title: Text(
                "My Kitchen",
                style: textTheme.displayLarge?.copyWith(color: kDark),
              ),
              centerTitle: false,
              actions: [
                SizedBox(
                  width: 96,
                  child: TextButton.icon(
                    icon: SvgPicture.asset(
                      "assets/images/icons/Settings.svg",
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      context.go("/settings");
                    },
                    label: Text(
                      "Settings",
                      style: textTheme.bodySmall?.copyWith(color: kDark),
                    ),
                  ),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 30.0, bottom: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: kGreen,
                          radius: 41,
                          child: Text(
                            "${userData["fullName"]?.substring(0, 1)}",
                            style:
                                textTheme.displayLarge?.copyWith(color: kWhite),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text("${userData["fullName"]}",
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                            Text("Bio", style: textTheme.bodySmall),
                            const SizedBox(height: 11),
                            Row(
                              children: [
                                Text("584 followers",
                                    style: textTheme.bodySmall),
                                const SizedBox(width: 10),
                                SvgPicture.asset("assets/images/icons/dot.svg"),
                                const SizedBox(width: 10),
                                Text("584 likes", style: textTheme.bodySmall)
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () => context.go("/editprofile"),
                        icon: SvgPicture.asset("assets/images/icons/Edit.svg"))
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(),
              ),
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: MySliverPersistentHeaderDelegate(
                    Container(
                      color: kWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: TabBar(
                          physics: const BouncingScrollPhysics(),
                          controller: tbController,
                          labelColor: kDark,
                          unselectedLabelColor: kInactiveText,
                          indicatorWeight: 4,
                          indicatorColor: kGreen,
                          tabs: const [
                            TabColunm(metric: "20", label: "Recipes"),
                            TabColunm(metric: "20", label: "Saved"),
                            TabColunm(metric: "20", label: "Following"),
                          ],
                        ),
                      ),
                    ),
                    90,
                    maxExtent: 90)),
            const SliverToBoxAdapter(
              child: Divider(height: 1),
            )
          ];
        },
        body: PageView(
          children: [
            Scaffold(
              body: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            const Scaffold(),
            const Scaffold(),
          ],
        ),
      ),
    );
  }
}

class TabColunm extends StatelessWidget {
  const TabColunm({required this.metric, required this.label, super.key});
  final String metric;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(metric,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        const SizedBox(height: 5),
      ],
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(this._tabBar, this.minExtent,
      {required this.maxExtent});

  final Container _tabBar;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
