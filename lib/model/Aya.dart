class Aya
{
   String _id;
   String _txt;

   String get txt => _txt;
   String get id => _id;

   set id(String value) {
     _id = value;
   }
   set txt(String value) {
     _txt = value;
   }


  factory Aya.fromJson(Map<String, dynamic> json) {
    return new Aya(json["index"],json["text"]);
  }

   Aya(this._id, this._txt);

   @override
  String toString() {
    return "{ id : $id , text : $txt  }";
  }


}