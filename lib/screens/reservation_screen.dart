import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp3/models/destination.dart';

class ReservationScreen extends StatefulWidget{
  final Destination destination;
  final int voyageurs;
  const ReservationScreen({
    super.key,
    required this.destination,
    required this.voyageurs,
  });
  @override
  State<ReservationScreen> createState()=> _ReservationScreenState();

}
class _ReservationScreenState extends State<ReservationScreen>{
  final _formKey= GlobalKey<FormState>();
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  @override
  void dispose(){
    
      _nomCtrl.dispose();
      _telCtrl.dispose();
      _emailCtrl.dispose();
    
    super.dispose();
  }
  InputDecoration _deco(String label,IconData icone,{String? aide}){
    return InputDecoration(
      labelText: label,
      helperText: aide,
      prefixIcon: Icon(icone),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
  String? _validerNom(String? v){
    if (v==null || v.trim().isEmpty) return 'Indiquez votre nom';
    if (v.trim().length<3) return 'Au moins 3 caractéres';
    return null;
  }
  String? _validerEmail(String? v){
    if (v==null||v.trim().isEmpty) return 'Indiquez votre email';
    if (!RegExp(r'[\w.+-]+@[\w-]+\.[\w.]+$').hasMatch(v.trim())) return 'email invalide';
  }
  String? _validerTel(String? v){
    if (v==null || v.trim().isEmpty) return 'Indiquez votre tel';
    if (v.length!=8) return 'chiffres attendus';
  }
  void _valider(){
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Formulaire valide')));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:const Text('Réserver')),
      body : Form(
        key:_formKey,
        child:SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Destination : ${widget.destination.nom}'),
                  Text('Durée : ${widget.destination.duree}'),
                  Text('Voyageurs : ${widget.voyageurs}')
                ],
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nomCtrl,
                decoration: _deco('Nom complet', Icons.person_outline),
                textCapitalization: TextCapitalization.words,
                textInputAction:TextInputAction.next,
                validator:_validerNom,
                ),
              const SizedBox(height:16),
              TextFormField(
                controller: _emailCtrl,
                decoration: _deco('email', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction:TextInputAction.next,
                validator:_validerEmail,
                ), 
                const SizedBox(height: 16),
                TextFormField(
                controller: _telCtrl,
                decoration: _deco('telephone', Icons.phone_android_outlined,aide: '8 chiffres, sans indicatif'),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly,LengthLimitingTextInputFormatter(8)],
                textInputAction:TextInputAction.next,
                validator:_validerTel,
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(16)
        ,child: FilledButton.icon(onPressed: _valider, label: Text('Confirmer')),
      ),
    );
  }
}