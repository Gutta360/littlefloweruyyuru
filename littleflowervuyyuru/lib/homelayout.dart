import 'package:flutter/material.dart';

class HomeLayoutWidget extends StatefulWidget {
  const HomeLayoutWidget({super.key});

  @override
  _HomeLayoutWidgetState createState() => _HomeLayoutWidgetState();
}

class _HomeLayoutWidgetState extends State<HomeLayoutWidget> {
  String expandedTab = 'Home';
  String selectedSubTab = 'Dashboard';

  final Map<String, List<String>> subTabs = {
    'Home': ['Dashboard'], // 🏠 NEW HOME TAB
    'Student': ['Student', 'Student Details'],
    'Staff': ['Staff', 'Staff Details'],
    'Payments': ['Income', 'Outgoing'],
    'Inventory': ['Item', 'Item Details'],
  };

  Widget getTabContent() {
    return Center(
      child: Text(
        'Showing content for: $selectedSubTab',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side Navigation Column
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            color: Colors.blueGrey.shade50,
            child: ListView(
              children: subTabs.keys.map((tab) {
                bool isExpanded = expandedTab == tab;
                return ExpansionTile(
                  initiallyExpanded: isExpanded,
                  title: Text(
                    tab,
                    style: TextStyle(
                      fontWeight:
                          isExpanded ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onExpansionChanged: (expanded) {
                    setState(() {
                      expandedTab = tab;
                      selectedSubTab = subTabs[tab]!.first;
                    });
                  },
                  children: subTabs[tab]!
                      .map(
                        (subTab) => ListTile(
                          title: Text(subTab),
                          selected: selectedSubTab == subTab,
                          onTap: () {
                            setState(() {
                              selectedSubTab = subTab;
                              expandedTab = tab;
                            });
                          },
                        ),
                      )
                      .toList(),
                );
              }).toList(),
            ),
          ),
          // Main Content Area
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            color: Colors.white,
            child: getTabContent(),
          ),
        ],
      ),
    );
  }
}