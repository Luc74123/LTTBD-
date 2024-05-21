Map<String, int> countWords(String sentence){
  Map<String, int> outputMap = {};

  List<String> words = sentence.toLowerCase().split(RegExp("[' ' ? . , ; : ! \n \t]+"));

  for(String word in words){
    outputMap[word] = (outputMap[word] ?? 0) + 1;
  }
  outputMap.remove(' ');
  return outputMap;
}

void main(){
  var res = countWords("Tết, tết tết tết hết rồi!");
  res.forEach((key, value) {
    print("$key: $value");
  });
}