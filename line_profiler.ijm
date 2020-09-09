Dialog.create("Choose params");
Dialog.addChoice("Channel:", newArray("red", "green"));
Dialog.addDirectory("Saving path:", " ");
Dialog.addString("Index number of experiment:", "Hui");
Dialog.addNumber("Number of rois", 0);
Dialog.show();

save_path = Dialog.getString();
name = Dialog.getString();
channel = Dialog.getChoice();
rois = Dialog.getNumber();
title = getTitle();

roiManager("Save", save_path + "Roiset_" + name + ".zip");


for(i = 0; i < rois; i++){
	roiManager("Select", 0);
	run("Plot Profile");
	Plot.showValues(); 
	saveAs("Results", save_path + channel + "_" + name + "_" + i + "_profile.csv");
	close();
	roiManager("Delete");
}

roiManager("Deselect");
roiManager("Multi Measure");
saveAs("Results", save_path + channel + "_" + name + ".csv");

roiManager("delete");
roiManager("Open", save_path + "Roiset_" + name + ".zip");

selectWindow(title);
close();