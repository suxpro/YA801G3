function PreviewImage(imgFile) 
{ 
 var pattern = /(\.*.jpg$)|(\.*.png$)|(\.*.jpeg$)|(\.*.gif$)|(\.*.bmp$)/;      
 if(!pattern.test(imgFile.value)) 
 { 
  alert("�u�䴩jpg/jpeg/png/gif/bmp���榡�ɮ�");  
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
   document.getElementById("imgPreview").style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")";//使�?滤�???? 
  } 
  else//FF 
  { 
   path = URL.createObjectURL(imgFile.files[0]);
   document.getElementById("imgPreview").innerHTML = "<img src='"+path+"' height='260' width='260'/>"; 
  } 
 } 
} 