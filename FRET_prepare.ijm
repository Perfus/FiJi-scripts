	Dialog.create("Choose position");
	Dialog.addString("Pos", "pos1");
	Dialog.show();
	pos = Dialog.getString();
	title = getTitle();
	selectWindow(title);
	run("Split Channels");
	selectWindow("C1-" + title);
	getDimensions(h, w, dummy, dymmy, nFr);
	run("Enhance Contrast", "saturated=0.35");
	run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=400 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
	selectWindow("Aligned " + nFr + " of " + nFr);
	rename("zel");
	selectWindow("C1-" + title);
	close();
	
	selectWindow("zel");
	run("Duplicate...", " ");
	rename("zel_do_" + pos);
	selectWindow("zel");
	run("Duplicate...", "title=zel_po_" + pos + " duplicate range=" + nFr);

	selectWindow("C2-" + title);
	run("Enhance Contrast", "saturated=0.35");
	run("Linear Stack Alignment with SIFT", "initial_gaussian_blur=1.60 steps_per_scale_octave=3 minimum_image_size=64 maximum_image_size=1024 feature_descriptor_size=4 feature_descriptor_orientation_bins=8 closest/next_closest_ratio=0.92 maximal_alignment_error=400 inlier_ratio=0.05 expected_transformation=Rigid interpolate");
	selectWindow("Aligned " + nFr + " of " + nFr);
	rename("red");
	selectWindow("C2-" + title);
	close();
	
	
	selectWindow("red");
	run("Duplicate...", " ");
	rename("red_do_" + pos);
	selectWindow("red");
	run("Duplicate...", "title=red_po_" + pos + " duplicate range=" + nFr);
	
	
	selectWindow("zel_do_" + pos);
	run("Duplicate...", " ");
	rename("control");
	run("Add Slice");
	selectWindow("zel_po_" + pos);
	run("Copy");
	selectWindow("control");
	run("Paste");
	run("Add Slice");
	selectWindow("red_do_" + pos);
	run("Copy");
	selectWindow("control");
	run("Paste");
	run("Add Slice");
	selectWindow("red_po_" + pos);
	run("Copy");
	selectWindow("control");
	run("Paste");