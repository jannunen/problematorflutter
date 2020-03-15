import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';


   
class QrScanner extends StatefulWidget { 
  @override 
  ScannerState createState() => ScannerState();
 
  }
 
  class ScannerState extends State<QrScanner> {
    String result = "Terve!";
    Future _scanQR() async{ 
    try{ 
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
         });
    }on PlatformException catch(exception) {
      if(exception.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
        result = "Camera permission was denied";
         });
      }else{
        setState(() {
        result = "Unknown Error $exception";
        });
    }
  } on FormatException{
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
  } catch (exception) { 
    setState(() {
        result = "Unknown Error $exception";
        });
    }
  }  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text("QR-Scanner"),
      ),
      body: Center(
        child: Text("Welcome to QR-Scanner", style: TextStyle(
          fontSize: 30.0, fontWeight: FontWeight.bold),
          )),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          label: Text("Scan"),
          onPressed: _scanQR,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    }  
  }
