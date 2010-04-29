UltraEdit.outputWindow.visible;
var text = UltraEdit.activeDocument.path;
var term = "\\";
var gitDestination="";
var stringArray = new Array();
var stringArray = text.split(term);

//get length of array
arrayLength = stringArray.length;

var filename=stringArray[arrayLength-2]+'\\'+stringArray[arrayLength-1];
UltraEdit.messageBox(filename,"This Program");

var proj = UltraEdit.getString("Which Project 2--dc2 3=dc3 4=cardiokinetix Integrated",1);
UltraEdit.messageBox(proj,"This Project");

if (proj == "2"){
var gitDestination="C:\\projects\\projects\\sasnci\\dc2\\"+filename;
}

if (proj=='3'){
var gitDestination="C:\\projects\\projects\\sasnci\\dc3\\"+filename;
}
if (proj=='4'){
var gitDestination="C:\\projects\\projects\\sasnci\\CKINT\\"+filename;

}
if (gitDestination!= ""){
UltraEdit.messageBox(gitDestination,"GIT Saving  This Program");
UltraEdit.saveAs(gitDestination);
}else{
UltraEdit.messageBox("No Version or project chosen");

}



