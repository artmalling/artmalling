
package com.study.dataset;

import com.shift.framework.model.ModelSet;

/**
 * GauceDataSet [MENUDATA] 를 proxy한 인터페이스
 */
public interface MenuDataSet extends ModelSet{

    /**
	 * GauceDataSet의 이름을 보관하는 변수
	 */
	public static final String SET_NAME = "MENUDATA";
		
	/**
	 * GauceDataRow의 [TEXT]컬럼의 이름을 보관하는 변수
	 */
	public static final String TEXT = "TEXT";
		
	/**
	 * GauceDataRow의 [LEVEL]컬럼의 이름을 보관하는 변수
	 */
	public static final String LEVEL = "LEVEL";
		
	/**
	 * GauceDataRow의 [CODE]컬럼의 이름을 보관하는 변수
	 */
	public static final String CODE = "CODE";
		
	/**
	 * GauceDataRow의 [ENABLE]컬럼의 이름을 보관하는 변수
	 */
	public static final String ENABLE = "ENABLE";
		
	/**
	 * GauceDataRow의 [IMAGE_ID]컬럼의 이름을 보관하는 변수
	 */
	public static final String IMAGE_ID = "IMAGE_ID";
	
	
	/**
	 * GauceDataRow의 컬럼 리스트를 보관하는 변수
	 */
	public static final String[] PROPERTY_LIST = {

		TEXT,

		LEVEL,

		CODE,

		ENABLE,

		IMAGE_ID,

	};	

    /**
	 * GauceDataRow의 컬럼타입 리스트를 보관하는 변수
	 */
	public static final int[] TYPE_LIST = {

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

		STRING_TYPE,

	};	

    /**
	 * GauceDataRow의 컬럼크기 리스트를 보관하는 변수
	 */
	public static final double[] SIZE_LIST = {

		255,

		2,

		10,

		1,

		10,

	};	
		
	/**
	 * GauceDataRow의 컬럼 키타입 리스트를 보관하는 변수
	 */
	public static final int[] KEY_TYPE_LIST = {
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
		
		NORMAL_TYPE,
	
	};
	
	/**
	 * GauceDataRow proxy인터페이스의 Proxy객체를 생성한다.
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public MenuData newMenuData();

	/**
	 * GauceDataSet에서 GauceDataRow들을 Proxy객체배열로 변환하여 반환한다. 
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public MenuData[] getMenuDatas();
	
	/**
	 * GauceDataSet에서 인덱스에 해당하는 GauceDataRow를 Proxy객체로 변환하여 반환한다.
	 * @param index GauceDataRow 인덱스
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public MenuData getMenuData(int index);
	
	/**
	 * GauceDataSet에 GauceDataRow의 Proxy객체를 추가한다.
	 * @param arg GauceDataRow의 Proxy객체
	 */
	public void appendMenuData(MenuData arg);
}

