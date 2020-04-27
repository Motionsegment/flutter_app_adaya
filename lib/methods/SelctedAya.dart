import 'package:flutterappadaya/model/Aya.dart';
import 'package:flutterappadaya/model/Sura.dart';

Aya margeAya(List<Aya> a)
{
  String txt;
  String id;
  id = a[0].id + " - " + a.last.id;
  for (var x in a) {
    if(txt== null)
       txt = x.txt;
      else
       txt += " * "+ x.txt;
  }

  return new Aya(id, txt);
}

List<Aya> selectedAya(Sura s)
{
  List<Aya> a ;
  String txt ;
  String id ;
  switch(s.id){
    case "2" :
      {
        a = [s.aya[126],s.aya[127],s.aya[200],s.aya[249],s.aya[284],s.aya[285]];
        return a;
      }
    case "3" :
      {
        a = [s.aya[7],s.aya[8],s.aya[15],s.aya[26],s.aya[37],s.aya[52],s.aya[146],s.aya[172],s.aya[190],s.aya[191],s.aya[192],s.aya[193]];
        return a;
      }

    case "4" :
      {
        a = [s.aya[74]];
        return a;
      }
    case "5" :
      {
        a = [s.aya[82]];
        return a;
      }

    case "7" :
      {
        a = [s.aya[22],s.aya[46],s.aya[88],s.aya[125],s.aya[148],s.aya[151],s.aya[154]];
        return a;
      }
    case "9" :
      {
        a = [s.aya[128]];
        return a;
      }
    case "10" :
      {

        a = [margeAya([s.aya[84],s.aya[85]])];

        return a;
      }

    case "11" :
      {
        a = [s.aya[40],s.aya[46]];
        return a;
      }

    case "12" :
      {
        a = [s.aya[100]];
        return a;
      }

    case "14" :
      {
        a = [s.aya[34],s.aya[37],s.aya[38],s.aya[39],s.aya[40]];
        return a;
      }

    case "17" :
      {
        a = [s.aya[79]];
        return a;
      }


    case "18" :
      {
        a = [s.aya[9]];
        return a;
      }
    case "19" :
      {
        a = [s.aya[3]];
        return a;
      }

    case "20" :
      {

        a = [margeAya([s.aya[24],s.aya[25],s.aya[26],s.aya[27]]),s.aya[113]];
        return a;
      }
    case "21" :
      {
        a = [s.aya[82],s.aya[86],s.aya[88],s.aya[11]];
        return a;
      }
    case "23" :
      {

        a = [s.aya[28],margeAya([s.aya[96],s.aya[97]]),s.aya[108],s.aya[117]];
        return a;
      }

    case "25" :
      {
      
        a = [margeAya([s.aya[64],s.aya[65]]),s.aya[73]];
        return a;
      }
    case "26" :
      {
        txt = "${s.aya[82].txt} * ${s.aya[83].txt} * ${s.aya[84].txt}";
        id = s.aya[82].id + " - " + s.aya[83].id + " - " + s.aya[84].id;

        a = [margeAya([s.aya[82],s.aya[83],s.aya[84]]),margeAya([s.aya[86],s.aya[87],s.aya[88]]),s.aya[168]];
        return a;
      }
    case "27" :
      {
        a = [s.aya[18]];
        return a;
      }
    case "28" :
      {
        a = [s.aya[15],s.aya[20],s.aya[21],s.aya[23]];
        return a;
      }

    case "29" :
      {
        a = [s.aya[29]];
        return a;
      }

    case "30" :
      {
        a = [margeAya([s.aya[16],s.aya[17],s.aya[18]])];
        return a;
      }

    case "37" :
      {
        a = [s.aya[99]];
        return a;
      }

    case "38" :
      {
        a = [s.aya[40]];
        return a;
      }

    case "40" :
      {
        a = [s.aya[6],margeAya([s.aya[7],s.aya[8]])];
        return a;
      }
    case "43" :
      {
        a = [s.aya[12]];
        return a;
      }
    case "44" :
      {
        a = [s.aya[11]];
        return a;
      }
    case "46" :
      {
        a = [s.aya[14]];
        return a;
      }
    case "54" :
      {
        a = [s.aya[9]];
        return a;
      }
    case "59" :
      {
        a = [s.aya[9]];
        return a;
      }

    case "60" :
      {
        a = [s.aya[3],s.aya[4]];
        return a;
      }
    case "66" :
      {
        a = [s.aya[7],s.aya[10]];
        return a;
      }
    case "71" :
      {
        a = [margeAya([s.aya[25],s.aya[26]]),s.aya[27]];
        return a;
      }
    default:
        return [];
  }


}