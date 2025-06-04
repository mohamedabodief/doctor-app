import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardOfDoctor extends StatefulWidget {
  final String name;
  final String specialization;
  final String location;
  final String imagePath;
  final String docId;
  final String contact;
  final num rating;
  final num experience;
  final num reviews;
  final num clinicFees;

  const CardOfDoctor({
    super.key,
    required this.name,
    required this.specialization,
    required this.location,
    required this.imagePath,
    required this.docId,
    required this.contact,
    required this.rating,
    required this.experience,
    required this.reviews,
    required this.clinicFees,
  });

  @override
  State<CardOfDoctor> createState() => _CardOfDoctorState();
}

class _CardOfDoctorState extends State<CardOfDoctor> {
  void onDeleteDoc(String docId) {
    final CollectionReference doctors = FirebaseFirestore.instance.collection(
      'doctors',
    );
    doctors.doc(docId).delete();
  }

  void onEditDoc(
    String docId,
    String name,
    String specialization,
    String location,
    String contact,
    String imagePath,
    num rating,
    num experience,
    num reviews,
    num clinicFees,
  ) {
    final CollectionReference doctors = FirebaseFirestore.instance.collection(
      'doctors',
    );

    // Controllers with initial values
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController specializationController = TextEditingController(
      text: specialization,
    );
    TextEditingController locationController = TextEditingController(
      text: location,
    );
    TextEditingController contactController = TextEditingController(
      text: contact,
    );
    TextEditingController imagePathController = TextEditingController(
      text: imagePath,
    );
    TextEditingController ratingController = TextEditingController(
      text: rating.toString(),
    );
    TextEditingController experienceController = TextEditingController(
      text: experience.toString(),
    );
    TextEditingController reviewsController = TextEditingController(
      text: reviews.toString(),
    );
    TextEditingController clinicFeesController = TextEditingController(
      text: clinicFees.toString(),
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Doctor'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextField(
                    controller: specializationController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: 'Specialization',
                    ),
                  ),
                  TextField(
                    controller: locationController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                  TextField(
                    controller: contactController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Contact'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: imagePathController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Image Path'),
                  ),
                  TextField(
                    controller: ratingController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Rating'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: experienceController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Experience'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: reviewsController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Reviews'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: clinicFeesController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(labelText: 'Clinic Fees'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await doctors.doc(docId).update({
                              'name': nameController.text,
                              'specialization': specializationController.text,
                              'location': locationController.text,
                              'contact': contactController.text,
                              'imagePath': imagePathController.text,
                              'rating': double.parse(ratingController.text),
                              'experience': int.parse(
                                experienceController.text,
                              ),
                              'reviews': int.parse(reviewsController.text),
                              'clinicfees': int.parse(
                                clinicFeesController.text,
                              ),
                            });
                            debugPrint('Edited successfully $docId');
                            Navigator.of(context).pop();
                          } catch (e) {
                            debugPrint('Error: ${e.toString()}');
                          }
                        },
                        child: const Text('Edit'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void onVote(String docId) async {
    final CollectionReference doctors = FirebaseFirestore.instance.collection(
      'doctors',
    );
    var user = FirebaseAuth.instance.currentUser;
    var currentData = await doctors.doc(docId).get();

    List frontendList = currentData['frontend'];
    List backendList = currentData['backend'];

    if (user == null) {
      return showAboutDialog(
        context: context,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Login first'),
          ),
        ],
      );
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              content: Text(
                'Vote has been casted',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (frontendList.contains(user.uid)) {
                      frontendList.remove(user.uid);
                    } else {
                      frontendList.add(user.uid);
                    }
                    await doctors.doc(docId).update({'frontend': frontendList});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'frontend votes: ${frontendList.length}\nbackend votes: ${backendList.length}',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Frontend'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (backendList.contains(user.uid)) {
                      backendList.remove(user.uid);
                    } else {
                      backendList.add(user.uid);
                    }
                    await doctors.doc(docId).update({'backend': backendList});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'frontend votes: ${frontendList.length}\nbackend votes: ${backendList.length}',
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Backend'),
                ),
              ],
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 145,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Leading image
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                widget.imagePath,
                height: 80,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            /// Info texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.specialization,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          widget.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Edit & Delete icons
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed:
                      () => onEditDoc(
                        widget.docId,
                        widget.name,
                        widget.specialization,
                        widget.location,
                        widget.contact,
                        widget.imagePath,
                        widget.rating,
                        widget.experience,
                        widget.reviews,
                        widget.clinicFees,
                      ),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDeleteDoc(widget.docId),
                  tooltip: 'Delete',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.how_to_vote_outlined,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () => onVote(widget.docId),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
