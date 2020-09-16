function openfiles(path, filename, addit){
	open(path + filename + ".ARW.B.tiff");
	rename("Blue" + addit);
	open(path + filename + ".ARW.G.tiff");
	rename("Green" + addit);
	open(path + filename + ".ARW.G2.tiff");
	rename("Green2" + addit);
	open(path + filename + ".ARW.R.tiff");
	rename("Red" + addit);
}

function processer(channels){
	for (m = 0; m < channels.length; m++){
		selectWindow(channels[m]);
		run("Add...", "value=1000");
		imageCalculator("Subtract create", channels[m], channels[m] + "_bg");
		saveAs("tiff", save_path + filenames[j] + channels[m]);
		close();
		selectWindow(channels[m]);
		close();
	}
}


Dialog.create("Choose params");
Dialog.addDirectory("Path to files:", " ");
Dialog.addNumber("Number of various conditions:", 0);
Dialog.show();

open_path = Dialog.getString();
save_path = open_path + "processed\\";
File.makeDirectory(save_path);
cond = Dialog.getNumber();
channels = newArray("Blue", "Green", "Green2", "Red");

Dialog.create("Choose black pics");
for (i = 1; i < cond + 1; i++){
	Dialog.addString("Write last four numbers of file for condition" + toString(i) + ":", " ");
}
Dialog.show();
blacks = newArray();
for (i = 1; i < cond + 1; i++){
	bufarray = newArray("DSC0" + Dialog.getString());
	blacks = Array.concat(blacks, bufarray);
}

for (i = 0; i < cond; i++){
	run("Close All");
	openfiles(open_path, blacks[i], "_bg");
	filelist = File.openAsString(open_path + "filelist" + toString(i + 1) + ".txt");
	filenames = split(filelist, "\n");
	for(j = 0; j < filenames.length; j++){
		openfiles(open_path, filenames[j], "");
		processer(channels);
	}
	run("Close All");
}
