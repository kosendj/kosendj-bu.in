$(function(){
  var index = Math.floor(Math.random()*6);
  var directory = "pc"
  if(window.navigator.userAgent.toLowerCase().match(/(iphone|android)/i)) {
    directory = "sp"
  }
  var url = 'images/' + directory + '/mv' + index + '.jpg';
  console.log(url)
  document.querySelector(".hero").style.cssText = "background-image: url("+ url +")";
})
