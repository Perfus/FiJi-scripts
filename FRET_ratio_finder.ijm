	Dialog.create("Choose position");
	Dialog.addString("Pos", "pos1");
	Dialog.show();
	pos = Dialog.getString();
	function bg_subtract(input){
		selectWindow(input);
		roiManager("select", 0);
		run("Measure");
		roiManager("select", 1);
		bg = getResult("Mean", nResults - 1);
		run("Subtract...", "value=" + bg);
		run("Add...", "value=1");
	}
	listw = newArray("zel_do_" + pos, "red_do_" + pos, "zel_po_" + pos, "red_po_" + pos);
	
	for(i = 0; i < 4; i++){
		bg_subtract(listw[i]);
	}
	
	imageCalculator("Divide create 32-bit", "zel_do_" + pos,"red_do_" + pos);
	imageCalculator("Divide create 32-bit", "zel_po_" + pos,"red_po_" + pos);
	selectWindow("Result of zel_do_" + pos);
	run("Add Slice");
	selectWindow("Result of zel_po_" + pos);
	run("Copy");
	selectWindow("Result of zel_do_" + pos);
	run("Paste");
	run("Fire");
	setMinAndMax("0.01", "5.00");
	selectWindow("Result of zel_po_" + pos);
	close();
	roiManager("Deselect");
	roiManager("Delete");
	for(i = 0; i < 4; i++){
		selectWindow(listw[i]);
		close();
	}
