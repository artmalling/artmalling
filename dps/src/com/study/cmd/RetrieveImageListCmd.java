package com.study.cmd;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shift.framework.conf.BeaverConfigManager;
import com.shift.framework.model.ModelCMD;
import com.study.dataset.Image2Data;
import com.study.dataset.Image2DataSet;

public class RetrieveImageListCmd extends ModelCMD {

	public void execute() throws Exception {
		Image2DataSet set = (Image2DataSet)this.getModelSet(Image2DataSet.class, Image2Data.class);
		set.bind(this);
		
		//IMAGE LIST
		String[] imgList = new String[] {
				"menu_01.gif",
				"menu_02.gif",
				"menu_03.gif",
				"menu_04.gif",
				"menu_05.gif",
				"menu_06.gif",
				"menu_07.gif",
				"menu_08.gif",
				"blank.gif"
			};
		
		
		// IMAGE ID LIST
		String[] imgIdList = new String[] {
				"topmenu01",
				"topmenu02",
				"topmenu03",
				"topmenu04",
				"topmenu05",
				"topmenu06",
				"topmenu07",
				"topmenu08",
				"blank"
			};
		
		String imagePath = BeaverConfigManager.getUserProperty("IMAGE_PATH");
		
		List list = new ArrayList();
		for (int i=0; i<imgList.length;i++) {
			HashMap row = new HashMap();
			row.put("IMAGE_ID", imgIdList[i]);
			File f = new File(imagePath + imgList[i] );
			FileInputStream fis = new FileInputStream(f);
			row.put("IMAGE", fis);
			row.put("IMAGE_SIZE", Long.toString(f.length()));
			list.add(row);
		}
		
		set.appendRows(list);
		set.flush();
	}
}
