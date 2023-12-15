
// close all windows
run("Close All");
// clear ROI manager
nROIs = roiManager("count");
if (nROIs>0) {
roiManager("SelectAll");
roiManager("Delete");
}
//open files
run("Bio-Formats Importer");

run("Properties...");

//user input
newRoiset = getBoolean("Make New ROIs (Yes) or open previous ROI file (No)");

if(newRoiset==1){
	////Make new ROI File
	waitForUser("Mark square Rois and press t to add to ROI Manager then click OK");
	Directory = File.directory;
	Name = File.nameWithoutExtension;
	Final = getBoolean("Save ROIs as" + Directory + Name +".zip");
	if(Final == 1){
		roiManager("Save", Directory + Name +".zip");
		print("File Saved");
	}else{
		print("File not saved");
	}
// Run plot axis profile

	nROIs = roiManager("count");
	print(nROIs);


	for ( n = 0; n<nROIs; n++){ 
		result = drawSquares(n);
		addToTable(result,n);	
	}

	Directory = File.directory;
	Name = File.nameWithoutExtension;
	selectWindow("Results");
	saveAs("txt", Directory + Name + "Bleaching_Results.txt");
	print("File Saved");

}


function drawSquares(n){
roiManager("select", n);
Roi.getContainedPoints(xpoints, ypoints);
Roi.getBounds(x, y, width, height);
run("Specify...", "width=5 height=5 x="+(x+(width/2))+" y="+(y+(height/2))+" centered");
IJ.log(x + " " + y + " " + width + " " + height + " " + xpoints[0] + " " + ypoints[0]);
result_1= getZProfile();
run("Specify...", "width=9 height=9 x="+(x+(width/2))+" y="+(y+(height/2))+" centered");
result_2= getZProfile();
result = newArray(result_1.length);
for (i = 0; i < result_1.length; i++) {
	result[i]=result_1[i] - (((result_2[i]*81)-(result_1[i]*25))/56);
	}
return result;
}

function addToTable(result,column){
	frames = result.length;
	n=column;
	for (j=0; j<frames; j++) {
    		setResult(n, j , result[j]);
          	}
          	updateResults();
}

function getZProfile(){
	//zstack= getimage dimensions
	getDimensions(width, height, channels, slices, frames);
	result = measureStack(frames);
	return result;
	
}

function measureStack(slices) {
	result=0;
    for (i=1; i<=slices; i++) {
    		setSlice(i);
          	getRawStatistics(nPixels, mean, min, max, std);
          	result = Array.concat(result,mean);
          	}
	result = Array.slice(result,1,slices+1);
    return result;
}