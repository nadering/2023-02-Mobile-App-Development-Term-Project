import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  // ToDo: 카테고리 인덱스, 오브젝트(물건/재질 등) 인덱스 required 설정
  final int categoryId;
  final int objectId;

  const InformationPage({super.key, this.categoryId = 0, this.objectId = 0});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  // ToDo: 이름, 카테고리, 설명은 추후 데이터베이스를 통해 얻어옵니다.
  final String _name = "Test Name";
  final String _category = "Test Category";
  final String _description = "Test Description";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
        child: ListView(
          children: [
            // ToDo: Add image
            const AspectRatio(
              aspectRatio: 1.618 / 1,
              child: SizedBox(
                // This sets SizedBox's width to parent's width.
                width: double.infinity,
                child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.green)),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              _name,
              style: const TextStyle(
                fontSize: 28.3,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              _category,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                _description,
                style: const TextStyle(
                  fontSize: 21.28,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
