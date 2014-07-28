/**
 * 
 */

function PreviewImage(imgFile) 
{ 
 var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/;      
 if(!pattern.test(imgFile.value)) 
 { 
  alert("只支援jpg/jpeg/png/gif/bmp之格式檔案");  
  imgFile.focus(); 
 } 
 else 
 { 
  var path; 
  if(document.all)//IE 
  { 
   imgFile.select(); 
   path = document.selection.createRange().text; 
   document.getElementById("imgPreview").innerHTML=""; 
   document.getElementById("imgPreview").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")";//雿輻?皛日???? 
  } 
  else//FF 
  { 
   path = URL.createObjectURL(imgFile.files[0]);
   document.getElementById("imgPreview").innerHTML = "<img src='"+path+"' height='260' width='260'/>"; 
  } 
 } 
} 