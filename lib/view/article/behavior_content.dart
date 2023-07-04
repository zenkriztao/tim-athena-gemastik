import 'package:autism_perdiction_app/constants.dart';
import 'package:autism_perdiction_app/model/behavior_models.dart';
import 'package:autism_perdiction_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class BehaviorContentPage extends StatefulWidget {
  final BehaviorOverview behaviorOverview;

  const BehaviorContentPage(
    this.behaviorOverview, {
    super.key,
  });

  @override
  State<BehaviorContentPage> createState() => _BehaviorContentPageState();
}

class _BehaviorContentPageState extends State<BehaviorContentPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  BehaviorContent? behaviorContent;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    loadBehaviorContent();
  }

  void loadBehaviorContent() async {
    BehaviorContent data =
        await BehaviorContent.getDataFromFirestore(widget.behaviorOverview.id!);
    setState(() {
      behaviorContent = data;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlueColor,
        title: Text('Artikel',
            style: GoogleFonts.nunito(
              fontSize: 25,
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 300,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.behaviorOverview.imageURL,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(widget.behaviorOverview.title,
                            style: GoogleFonts.nunito(
                                fontSize: 30, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(widget.behaviorOverview.description,
                            style: GoogleFonts.nunito(
                                fontSize: 20, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            TabBar(
              labelColor: darkBlueColor,
              indicatorColor: darkBlueColor,
              unselectedLabelColor: Color.fromARGB(255, 184, 171, 171),
              tabs: [
                Tab(
                  child: Text(
                    "Deskripsi",
                    style: GoogleFonts.nunito(fontWeight: FontWeight.w500),
                  ),
                ),
                Tab(
                  child: Text(
                    "Bagaimana",
                    style: GoogleFonts.nunito(fontWeight: FontWeight.w500),
                  ),
                )
              ],
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: behaviorContent == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MarkdownViewer(behaviorContent!.overview)),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: behaviorContent == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : MarkdownViewer(behaviorContent!.howToAddress)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
