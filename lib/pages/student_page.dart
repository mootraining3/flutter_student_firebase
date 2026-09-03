import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  // ดึงข้อมูลจาก Firebase ลงมา
  final CollectionReference _studentCollection = FirebaseFirestore.instance
      .collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('รายชื่อนักศึกษา')),
      body: StreamBuilder(
        stream: _studentCollection.snapshots(),
        builder: (context, snapshot) {
          // CHECK ERROR ในการเชื่อมต่อ
          if (snapshot.hasError) {
            return Center(
              child: Text('เกิดข้อผิดพลาดในการเชื่อมต่อ: ${snapshot.error}'),
            );
          }
          // ระหว่างที่รอ read แสดง loading icon
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // เช็คว่ามีข้อมูลใน firestore หรือไม่
          final List<DocumentSnapshot> docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'ขณะนี้ยังไม่มีข้อมูลในฐานข้อมูล',
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            );
          }
          // แสดงข้อมูล
          return const Center(
            child: Text(
              'OK',
              style: TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
          );
        },
      ),
    );
  }
}
