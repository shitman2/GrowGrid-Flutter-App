import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool toggleLight = false;
  bool toggleWater = false;
  bool isLightVisible = false;
  bool isWaterVisible = false;
  bool isCustomRepeat = false;
  bool isCustomWaterRepeat = false;

  final TextEditingController boxNameController = TextEditingController();

  final List<String> durations = [
    '1 Hour', '2 Hours', '3 Hours', '4 Hours', '5 Hours',
    '6 Hours', '7 Hours', '8 Hours', '9 Hours', '10 Hours',
    '11 Hours', '12 Hours', '13 Hours', '14 Hours', '15 Hours',
    '16 Hours', '17 Hours', '18 Hours', '19 Hours', '20 Hours',
    '21 Hours', '22 Hours', '23 Hours', '24 Hours',
  ];

  final List<String> repeatOptions = [
    'Every day', 'Every 2 days', 'Every 3 days', 'Every week', 'Every 2 weeks', 'Every month', 'Custom'
  ];

  String? selectedDuration;
  String? selectedRepeat;
  String? customRepeatValue;

  String? selectedWaterDuration;
  String? selectedWaterRepeat;
  String? customWaterRepeatValue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'GrowGrid',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),

            // TextField for Box Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: boxNameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Box Name",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Container with Icons
            Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 130,
                      width: 400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 125,
                      width: 395,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Row(
                    children: [
                      if (isLightVisible) 
                        IconButton(
                        icon: toggleLight
                            ? const Icon(Icons.lightbulb, size: 30)
                            : const Icon(Icons.lightbulb_outline, size: 30),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            toggleLight = !toggleLight;
                            isLightVisible = !isLightVisible;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: toggleWater
                            ? const Icon(Icons.water_drop, size: 30)
                            : const Icon(Icons.water_drop_outlined, size: 30),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            toggleWater = !toggleWater;
                            isWaterVisible = !isWaterVisible;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
              
            ),

            const SizedBox(height: 10),

            // Light Controls
            if (isLightVisible) ...[
              buildDropdown(
                hint: "Light Duration",
                value: selectedDuration,
                items: durations,
                onChanged: (newValue) {
                  setState(() {
                    selectedDuration = newValue;
                  });
                },
                icon: Icons.access_time,
              ),
              buildDropdown(
                hint: "Light Repeat",
                value: selectedRepeat,
                items: repeatOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedRepeat = newValue;
                    isCustomRepeat = newValue == "Custom";
                  });
                },
                icon: Icons.repeat,
              ),
              if (isCustomRepeat)
                buildCustomRepeatField(
                  hint: "Enter custom repeat time",
                  onChanged: (value) {
                    setState(() {
                      customRepeatValue = value;
                    });
                  },
                ),
            ],

            // Water Controls
            if (isWaterVisible) ...[
              buildDropdown(
                hint: "Water Duration",
                value: selectedWaterDuration,
                items: durations,
                onChanged: (newValue) {
                  setState(() {
                    selectedWaterDuration = newValue;
                  });
                },
                icon: Icons.access_time,
              ),
              buildDropdown(
                hint: "Water Repeat",
                value: selectedWaterRepeat,
                items: repeatOptions,
                onChanged: (newValue) {
                  setState(() {
                    selectedWaterRepeat = newValue;
                    isCustomWaterRepeat = newValue == "Custom";
                  });
                },
                icon: Icons.repeat,
              ),
              if (isCustomWaterRepeat)
                buildCustomRepeatField(
                  hint: "Enter custom water repeat time",
                  onChanged: (value) {
                    setState(() {
                      customWaterRepeatValue = value;
                    });
                  },
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(
              hint,
              style: const TextStyle(color: Colors.white),
            ),
            items: items.map(buildMenuItem).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.grey[900],
            style: const TextStyle(color: Colors.white),
            icon: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildCustomRepeatField({
    required String hint,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
