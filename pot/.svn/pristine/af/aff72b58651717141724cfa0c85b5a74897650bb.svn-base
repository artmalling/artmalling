
package com.study.dataset;

import com.shift.framework.model.ModelSet;

/**
 * GauceDataSet [IMAGE] 를 proxy한 인터페이스
 */
public interface ImageSet extends ModelSet{

    /**
	 * GauceDataSet의 이름을 보관하는 변수
	 */
	public static final String SET_NAME = "IMAGE";
		
	/**
	 * GauceDataRow의 [IMG_ID]컬럼의 이름을 보관하는 변수
	 */
	public static final String IMG_ID = "IMG_ID";
		
	/**
	 * GauceDataRow의 [IMG]컬럼의 이름을 보관하는 변수
	 */
	public static final String IMG = "IMG";
		
	/**
	 * GauceDataRow의 [IMG_SIZE]컬럼의 이름을 보관하는 변수
	 */
	public static final String IMG_SIZE = "IMG_SIZE";
	
	
	/**
	 * GauceDataRow의 컬럼 리스트를 보관하는 변수
	 */
	public static final String[] PROPERTY_LIST = {

		IMG_ID,

		IMG,

		IMG_SIZE,

	};	

    /**
	 * GauceDataRow의 컬럼타입 리스트를 보관하는 변수
	 */
	public static final int[] TYPE_LIST = {

		STRING_TYPE,

		BLOB_TYPE,

		INT_TYPE,

	};	

    /**
	 * GauceDataRow의 컬럼크기 리스트를 보관하는 변수
	 */
	public static final double[] SIZE_LIST = {

		255,

		255,

		6,

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
	public Image newImage();

	/**
	 * GauceDataSet에서 GauceDataRow들을 Proxy객체배열로 변환하여 반환한다. 
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public Image[] getImages();
	
	/**
	 * GauceDataSet에서 인덱스에 해당하는 GauceDataRow를 Proxy객체로 변환하여 반환한다.
	 * @param index GauceDataRow 인덱스
	 * @return GauceDataRow proxy인터페이스 객체
	 */
	public Image getImage(int index);
	
	/**
	 * GauceDataSet에 GauceDataRow의 Proxy객체를 추가한다.
	 * @param arg GauceDataRow의 Proxy객체
	 */
	public void appendImage(Image arg);
}

