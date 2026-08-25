import 'package:flutter/material.dart';
import 'doctor_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'All';
  double minimumRating = 0;

  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. John Smith',
      'specialization': 'General Physician',
      'rating': 4.8,
      'experience': '10 years',
      'location': 'City Hospital',
      'fee': '₹500',
    },
    {
      'name': 'Dr. Sarah Williams',
      'specialization': 'Cardiologist',
      'rating': 4.9,
      'experience': '12 years',
      'location': 'Health Care Clinic',
      'fee': '₹800',
    },
    {
      'name': 'Dr. Michael Brown',
      'specialization': 'Dermatologist',
      'rating': 4.7,
      'experience': '8 years',
      'location': 'Skin Care Center',
      'fee': '₹600',
    },
    {
      'name': 'Dr. Emily Davis',
      'specialization': 'Pediatrics',
      'rating': 4.6,
      'experience': '7 years',
      'location': 'Children Hospital',
      'fee': '₹400',
    },
  ];

  List<Map<String, dynamic>> get filteredDoctors {
    final searchText = searchController.text.toLowerCase();

    return doctors.where((doctor) {
      final matchesSearch =
          doctor['name'].toString().toLowerCase().contains(searchText) ||
          doctor['specialization'].toString().toLowerCase().contains(searchText);

      final matchesCategory = selectedCategory == 'All' ||
          doctor['specialization'] == selectedCategory;

      final matchesRating = doctor['rating'] >= minimumRating;

      return matchesSearch && matchesCategory && matchesRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Doctors'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Search by doctor or specialization',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    setState(() {});
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'All',
                        child: Text('All'),
                      ),
                      DropdownMenuItem(
                        value: 'General Physician',
                        child: Text('General'),
                      ),
                      DropdownMenuItem(
                        value: 'Cardiologist',
                        child: Text('Cardiology'),
                      ),
                      DropdownMenuItem(
                        value: 'Dermatologist',
                        child: Text('Dermatology'),
                      ),
                      DropdownMenuItem(
                        value: 'Pediatrics',
                        child: Text('Pediatrics'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                IconButton(
                  onPressed: showRatingFilter,
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filter by rating',
                ),
              ],
            ),

            const SizedBox(height: 15),

            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(
                      child: Text(
                        'No doctors found.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(
                              doctor['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${doctor['specialization']}\n'
                              '⭐ ${doctor['rating']} • ${doctor['experience']}',
                            ),
                            isThreeLine: true,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DoctorDetailsScreen(
                                    doctor: doctor,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showRatingFilter() {
    double tempRating = minimumRating;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Filter by Rating'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${tempRating.toStringAsFixed(1)} stars & above',
                  ),
                  Slider(
                    value: tempRating,
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: tempRating.toStringAsFixed(1),
                    onChanged: (value) {
                      setDialogState(() {
                        tempRating = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      minimumRating = tempRating;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}