package com.study.cmd;

import com.shift.framework.model.ModelCMD;
import com.study.bean.SampleBean;
import com.study.dataset.Emp;
import com.study.dataset.EmpSet;

public class SaveEmpListCmd extends ModelCMD {

	public void execute() throws Exception {
		EmpSet set = (EmpSet)this.getModelSet(EmpSet.class, Emp.class);
		set.bind(this, "EMP");
		SampleBean bean = new SampleBean();
		bean.saveEmpList(set.getList());
	}
}
