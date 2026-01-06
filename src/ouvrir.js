openDic = function (id){
  copyTextToClipboard(id);
  var text = document.getElementById(id).innerHTML ;
  // let result = text.replace(/ /g, "+");
  var chaine="https://en.wiktionary.org/wiki/"+text
  window.open(chaine);
}