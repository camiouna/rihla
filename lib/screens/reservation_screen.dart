import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp3/models/destination.dart';
import 'package:tp3/models/reservation.dart';

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
  AutovalidateMode _autoValidation = AutovalidateMode.disabled;
  final _formKey= GlobalKey<FormState>();
  final _nomCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  DateTime? _date;
  String _formule = 'Essentiel';
  bool _conditions = false;
  int get _prixParPersonne => _formule =='Confort' ? (widget.destination.prix*1.3).round():widget.destination.prix;
  int get _total =>_prixParPersonne * widget.voyageurs;
  
  Future<void> _choisirDate() async {
    final demain = DateTime.now().add(const Duration(days:1));
    final choisie = await showDatePicker(context: context,
      initialDate: _date ?? demain,
      firstDate: demain,
      lastDate: DateTime.now().add(const Duration(days:365)),
      helpText: 'Date de depart',
    );
    if (choisie ==null) return;
    setState(() {
      _date=choisie;
      _dateCtrl.text='${choisie.day.toString().padLeft(2, '0')}/${choisie.month.toString().padLeft(2, '0')}/${choisie.year}';
    });

  }

  @override
  void dispose(){
      _dateCtrl.dispose();
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
    
    if (!_formKey.currentState!.validate()){
      setState(()=>_autoValidation=AutovalidateMode.onUserInteraction);
      return;
    }
    final reservation = Reservation(
      destination: widget.destination,nom: _nomCtrl.text,email: _emailCtrl.text,telephone: _telCtrl.text,voyageurs: widget.voyageurs,formule: _formule,dateDepart: _date!);
      Navigator.pop(context,reservation);
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title:const Text('Réserver')),
      body :
      Form(
        key:_formKey,
        autovalidateMode: _autoValidation,
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
                const SizedBox(height:16),
                TextFormField(
                  controller: _dateCtrl,
                  readOnly: true,
                  onTap:_choisirDate,
                  decoration: _deco('Date de depart', Icons.calendar_month_outlined),
                  validator: (_)=>_date==null?'Choisissez une date':null,
                ),
                SegmentedButton<String>(
                segments: const[
                ButtonSegment(value: 'Essentiel',label:Text('Essentiel'),icon:Icon(Icons.backpack_outlined)),
      ButtonSegment(value: 'Confort',label:Text('Confort +30%'),icon:Icon(Icons.hotel_outlined)),
    ],
    selected:{_formule},
    onSelectionChanged:(choix){
      setState(() {
        _formule=choix.first;
      });
    }
  ),
  CheckboxListTile(value: _conditions, onChanged:(v)=> setState(()=>_conditions=v??false),
    controlAffinity: ListTileControlAffinity.leading,
    contentPadding: EdgeInsets.zero,
    title: const Text("J'accepte les conditions d'annulation"),
    subtitle: const Text("Annulation gratuite jusqu'a 48h avant"),
  ),
            ],
          ),
          
        ),
        
      ),
      bottomNavigationBar: Padding(padding: const EdgeInsets.all(16)
        ,child:Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
           children:[
            Text('${_prixParPersonne*widget.voyageurs} DT'),
            FilledButton.icon(onPressed: _conditions ? _valider : null, label: Text('Confirmer')),
           ]
           )
      ),
      
    );
  }
}