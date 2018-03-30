
package com.study.dataset;

import com.shift.framework.model.ModelSet;

/**
 * GauceDataSet [dept] 를 proxy한 인터페이스
 */
public interface DeptSet extends ModelSet{

    /**
	 * GauceDataSet의 이름을 보관하는 변수
	 */
	public static final String SET_NAME = "dept";
		
	/**
	 * GauceDataRow의 [DEPT_CD]컬럼의 이름을 보관하는 변수
	 */
	public static final String DEPT_CD = "DEPT_CD";
		
	/**
	 * GauceDataRow의 [DEPT_NM]컬럼의 이름을 보관하는 변수
	 */
	public static final String DEPT_NM = "DEPT_NM";
		
	/**
	 * GauceDataRow의 [DEPT_LOC]컬럼의 이름을 보관하는 변수
	 */
	public static final String DEPT_LOC = "DEPT_LOC";
	
	
	/**
	 * GauceDataRow의 컬럼 리스트를 보관하는 변수
	 */
	public static final String[] PROPERTY_LIST = {

		DEPT_CD,

		DEPT_NM,

		DEPT_LOC,

	};	

    /**
	 * GauceDataRow의 컬럼타입 리스트를 보관하는 변수
	 */
	public static final int[] TYPE_LIST = {

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

	};	

    /**
	 * GauceDataRow의 컬럼크기 리스트를 보관하는 변수
	 */
	public static final double[] SIZE_LIST = {

		10,

		40,

		40,

	};	
		
	/**
	 * GauceDataRow의 컬럼 키타입 리스트를 보관하는 변수
	 */
	public static final int[] KEY_TYPE_LIST = {
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
	
	};
	
	/**
	 * GauceDataRow proxy인터페이스의 Proxy객체를 생성한다.
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public Dept newDept();

	/**
	 * GauceDataSet에서 GauceDataRow들을 Proxy객체배열로 변환하여 반환한다. 
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public Dept[] getDepts();
	
	/**
	 * GauceDataSet에서 인덱스에 해당하는 GauceDataRow를 Proxy객체로 변환하여 반환한다.
	 * @param index GauceDataRow 인덱스
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public Dept getDept(int index);
	
	/**
	 * GauceDataSet에 GauceDataRow의 Proxy객체를 추가한다.
	 * @param arg GauceDataRow의 Proxy객체
	 */
	public void appendDept(Dept arg);
}

