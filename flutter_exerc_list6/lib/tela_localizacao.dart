import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

class TelaLocalizacao extends StatefulWidget {
  const TelaLocalizacao({Key? key}) : super(key: key);

  @override
  _TelaLocalizacaoState createState() => _TelaLocalizacaoState();
}

class _TelaLocalizacaoState extends State<TelaLocalizacao> {
  LocationData? local;
  StreamSubscription? inscricao;

  @override
  void initState() {
    super.initState();
    inscricao = Location.instance.onLocationChanged.listen((event) {
      setState(() {
        local = event;
      });
    });
  }

  void a() async {
    LocationData localizacao = await Location.instance.getLocation();
    print(localizacao.latitude);
    Location.instance.changeSettings(interval: 60000, accuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: local != null ? Text(''' 
        lat = ${local!.latitude!.toStringAsFixed(2)}
        long = ${local!.longitude}
        alt = ${local!.altitude}
        prec = ${local!.accuracy}
        ''') : Text('Sem localização'),
      ),
    );
  }

  @override
  void dispose() {
    inscricao!.cancel();
    super.dispose();
  }
}