package com.study.cmd;

import com.shift.framework.model.ModelCMD;
import com.study.bean.SampleBean;
import com.study.dataset.Dept;
import com.study.dataset.DeptSet;
import com.study.dataset.Emp;
import com.study.dataset.EmpSet;

public class RetrieveMultiListCmd extends ModelCMD {

	public void execute() throws Exception {
		//to-be
		EmpSet set = (EmpSet)this.getModelSet(EmpSet.class, Emp.class);
		set.bind(this, "EMP");
		
		DeptSet set2 = (DeptSet)this.getModelSet(DeptSet.class, Dept.class);
		set2.bind(this, "DEPT");
		
		SampleBean bean = new SampleBean();
		bean.selectMultiList(set, set2, this.getParameter(true));
//		
		set.flush();
		set2.flush();
	}
}
