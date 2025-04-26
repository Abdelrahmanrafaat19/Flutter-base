extension TextEllipsize on String{
  String ellipsize(int count){
    if(this.length <= count){
      return this;
    }else{
      return "${this.substring(0,count)}...";
    }
  }
}