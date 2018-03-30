
package com.study.dataset;

import com.shift.framework.model.ModelSet;

/**
 * GauceDataSet [Emp] �� proxy�� �������̽�
 */
public interface EmpSet extends ModelSet{

    /**
	 * GauceDataSet�� �̸�; �����ϴ� ����
	 */
	public static final String SET_NAME = "Emp";
		
	/**
	 * GauceDataRow�� [EMP_NO]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String EMP_NO = "EMP_NO";
		
	/**
	 * GauceDataRow�� [EMP_NM]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String EMP_NM = "EMP_NM";
		
	/**
	 * GauceDataRow�� [BIRTH_DATE]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String BIRTH_DATE = "BIRTH_DATE";
		
	/**
	 * GauceDataRow�� [GRADE_CD]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String GRADE_CD = "GRADE_CD";
		
	/**
	 * GauceDataRow�� [DEPT_CD]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String DEPT_CD = "DEPT_CD";
		
	/**
	 * GauceDataRow�� [LEVEL_CD]�÷��� �̸�; �����ϴ� ����
	 */
	public static final String LEVEL_CD = "LEVEL_CD";
	
	
	/**
	 * GauceDataRow�� �÷� ����Ʈ�� �����ϴ� ����
	 */
	public static final String[] PROPERTY_LIST = {

		EMP_NO,

		EMP_NM,

		BIRTH_DATE,

		GRADE_CD,

		DEPT_CD,

		LEVEL_CD,

	};	

    /**
	 * GauceDataRow�� �÷�Ÿ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final int[] TYPE_LIST = {

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

	};	

    /**
	 * GauceDataRow�� �÷�ũ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final double[] SIZE_LIST = {

		8,

		20,

		8,

		10,

		13.2,

		10,

	};	
		
	/**
	 * GauceDataRow�� �÷� ŰŸ�� ����Ʈ�� �����ϴ� ����
	 */
	public static final int[] KEY_TYPE_LIST = {
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
	
	};
	
	/**
	 * GauceDataRow proxy�������̽��� Proxy��ü�� ���Ѵ�.
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public Emp newEmp();

	/**
	 * GauceDataSet���� GauceDataRow��; Proxy��ü�迭�� ��ȯ�Ͽ� ��ȯ�Ѵ�. 
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public Emp[] getEmps();
	
	/**
	 * GauceDataSet���� �ε����� �ش��ϴ� GauceDataRow�� Proxy��ü�� ��ȯ�Ͽ� ��ȯ�Ѵ�.
	 * @param index GauceDataRow �ε���
	 * @return GauceDataRow proxy�������̽� ��ü
	 */
	public Emp getEmp(int index);
	
	/**
	 * GauceDataSet�� GauceDataRow�� Proxy��ü�� �߰��Ѵ�.
	 * @param arg GauceDataRow�� Proxy��ü
	 */
	public void appendEmp(Emp arg);
}

