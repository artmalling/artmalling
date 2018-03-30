package com.study.cmd;

import com.shift.framework.model.ModelCMD;
import com.study.bean.SampleBean;
import com.study.dataset.Emp;
import com.study.dataset.EmpSet;

import com.study.dataset.EmpSet;

public class RetrieveEmpListCmd extends ModelCMD {

	public void execute() throws Exception {
		//to-be
		EmpSet set = (EmpSet)this.getModelSet(EmpSet.class, Emp.class);
		set.bind(this);
		
		
		SampleBean bean = new SampleBean();
		bean.selectEmpList(set, this.getParameter(true));
//		
		set.flush();
	}
}
