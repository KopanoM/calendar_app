class DooMe{
  String _Description;
  String _Title;
  String _Pic;
  String _Option;
  String _Tasks;
  bool _Complete;
  bool _Active;
  int _CalendarDate;
  String _Day;
  int _SMonth;
  int _SDaY;
  int _SYear;
  String _UID;


  int get SMonth => _SMonth;

  set SMonth(int value) {
    _SMonth = value;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['Title'] = this.Title;
    map['Description'] = this.Description;
    map['Pic'] = this.Pic;
    map['Option'] = this.Option;
    map['Tasks'] = this.Tasks;
    map['Complete'] = this.Complete;
    map['Active'] = this.Active;
    map['CalendarDate'] = this.CalendarDate;
    map['Day'] = this.Day;
    map['SMonth'] = this.SMonth;
    map['SDaY'] = this.SDaY;
    map['SYear'] = this.SYear;
    map['UID'] = this.UID;
    return map;
  }



  DooMe(this._Title,this._Description,this._Active,this._Complete,this._Tasks,this._Option,this._CalendarDate,this._Pic,this._Day,this._SYear,this._SMonth,this._SDaY,this._UID);

  int get CalendarDate => _CalendarDate;

  String get Day => _Day;

  set Day(String value) {
    _Day = value;
  }

  String get UID => _UID;

  set UID(String value) {
    _UID = value;
  }

  set CalendarDate(int value) {
    _CalendarDate = value;
  }

  bool get Active => _Active;

  set Active(bool value) {
    _Active = value;
  }

  bool get Complete => _Complete;

  set Complete(bool value) {
    _Complete = value;
  }

  String get Tasks => _Tasks;

  set Tasks(String value) {
    _Tasks = value;
  }

  String get Option => _Option;

  set Option(String value) {
    _Option = value;
  }

  String get Pic => _Pic;

  set Pic(String value) {
    _Pic = value;
  }

  String get Title => _Title;

  set Title(String value) {
    _Title = value;
  }

  String get Description => _Description;

  set Description(String value) {
    _Description = value;
  }

  int get SDaY => _SDaY;

  set SDaY(int value) {
    _SDaY = value;
  }

  int get SYear => _SYear;

  set SYear(int value) {
    _SYear = value;
  }
}