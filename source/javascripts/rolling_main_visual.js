$(function(){
  var index = Math.floor(Math.random()*6);
  var url = 'images/pc/mv' + index + '.jpg';
  console.log(url)
  document.querySelector(".hero").style.cssText = "background-image: url("+ url +")";
})
