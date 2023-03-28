import 'package:flutter/material.dart';

class SearchInputFb1 extends StatelessWidget {
  final TextEditingController searchController;
  final String hintText;

  const SearchInputFb1(
      {required this.searchController, required this.hintText, Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.3)),
      ]),
      child: TextField(
        controller: searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {},
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.email),
          prefixIcon:
              const Icon(Icons.search, size: 20, color: Color(0xffFF5A60)),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
