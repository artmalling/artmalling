package com.study.cmd;

import com.shift.framework.model.ModelCMD;
import com.study.bean.SampleBean;
import com.study.dataset.UploadData;
import com.study.dataset.UploadDataSet;

public class FileUploadCmd extends ModelCMD {

	public void execute() throws Exception {
		UploadDataSet set = (UploadDataSet)this.getModelSet(UploadDataSet.class, UploadData.class);
		set.bind(this, "UPLOAD");
		
		SampleBean bean = new SampleBean();
		bean.fileUpload(set.getList());
	}
}
