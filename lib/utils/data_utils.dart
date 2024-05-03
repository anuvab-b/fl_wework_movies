class DataUtils{

  static String formatVotes(int? voteCount){
    String? res = "";
    if(voteCount!=null) {
      if (voteCount < 1000) {
        res = voteCount.toStringAsFixed(0);
      }
      else if(voteCount>=1000){
        res = "${(voteCount/1000).toStringAsFixed(1)} K";
      }
      return res;
    }
    return "";
  }
}