package com.study.cmd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shift.framework.model.ModelCMD;
import com.study.dataset.MenuData;
import com.study.dataset.MenuDataSet;

public class RetrieveMenuListCmd extends ModelCMD {

	public void execute() throws Exception {
		MenuDataSet set = (MenuDataSet)this.getModelSet(MenuDataSet.class, MenuData.class);
		set.bind(this);
		
		List list = new ArrayList();
		
		HashMap row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "1000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "topmenu01");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "sub menu");
		row.put("LEVEL", "2");
		row.put("CODE", "1001");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "2000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "topmenu02");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "3000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "topmenu03");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		row = new HashMap();
		row.put("TEXT", "");
		row.put("LEVEL", "1");
		row.put("CODE", "4000");
		row.put("ENABLE", "1");
		row.put("IMAGE_ID", "blank");
		list.add(row);
		
		
		set.appendRows(list);
		set.flush();
	}
}
