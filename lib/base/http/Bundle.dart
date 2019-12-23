

class Bundle{
   Map<String,dynamic> map = {};

   Map<String,dynamic> getData(){
     return map;
}

   _setValue(var key,var value) => map[key] = value;

   _getValue(var key){
     if(!map.containsKey(key)){
       return null;
     }
     return map[key];
   }

   putInt(String key ,int value) => _setValue(key, value);
   putString(String key ,String value) => _setValue(key, value);
   putList<T>(String key ,List<T> value) => _setValue(key, value);
   putBool(String key ,bool value) => _setValue(key, value);
   putMap<K,V>(String key ,Map<K,V> value) => _setValue(key, value);


   int getInt(String key,int defalut){
     if(null ==  _getValue(key))
       return defalut;

     return _getValue(key) as int;
   }

   String getString(String key,{String defalut:""}){
     if(null ==  _getValue(key))
       return defalut;

     return _getValue(key) as String;
   }

   bool getBool(String key,{bool defalut:false}){
     if(null ==  _getValue(key))
       return defalut;

     return _getValue(key) as bool;
   }

   List<T> getList<T>(String key){
     if(null ==  _getValue(key))
       return null;

     return _getValue(key) as List;
   }

   Map getMap<T>(String key){
     if(null ==  _getValue(key))
       return null;

     return _getValue(key) as Map;
   }


}