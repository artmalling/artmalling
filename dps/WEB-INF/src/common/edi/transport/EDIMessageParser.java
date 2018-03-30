/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.edi.transport;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;


/**
 * EDI 송수신 메세지 변환 처리 1. 요청문서를 전문포맷 맞춰 byte 로 변환 2. 응답문서 byte를 전문포맷 맞춰 Map 으로 변환
 * 
 * @created  on 1.0, 2010/05/18
 * @created  by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * 
 */
public class EDIMessageParser {

	/**
	 * <pre>
	 * 구분코드에 해당하는 전문포맷에  byte로 변환후 리턴한다.
	 * </pre>
	 * 
	 * @param docData 요청데이타셋
	 * @param buff 변환후 저장되는 버퍼
	 * @param gubunCd
	 *            구분코드
	 * @return 요청 메세지 byte
	 * @throws Exception
	 */
	public static byte[] getRquestMessage(Document docData, byte[] buff, String node, String resource) throws Exception {
		Document docFormat = (new SAXReader()).read(resource);
		return getRquestMessage(docData, buff, node, docFormat);
	}

	/**
	 * <pre>구분코드에 해당하는 전문포맷에  byte로 변환후 리턴한다.
	 * </pre>
	 * @param docData 요청데이타셋
	 * @param buff 
	 * @param node 전문에 해당하는 노드
	 * @param docFormat 전문포맷
	 * @return
	 * @throws Exception
	 */
	public static byte[] getRquestMessage(Document docData, byte[] buff, String node, Document docFormat) throws Exception {
		Element element = (Element) docFormat.selectSingleNode(EDIConstants.TMPL_BASE_NODE + node);
		Iterator<Element> iterator = element.elementIterator();
		int startIndex = 0;
		System.out.println("=======================================================================");
		System.out.println(">>> node:" + EDIConstants.TMPL_BASE_NODE + node);
		while (iterator.hasNext()) {
			Element dataElement = (Element) iterator.next();
			String name = dataElement.getName();
			if (EDIConstants.TMPL_MSGE_NODE.equals(name)) {
				String type = dataElement.attributeValue("type");
				if (EDIConstants.TMPL_MSGE_TYPE_BASIC.equals(type)) {
					Iterator<Element> messageIterator = dataElement.elementIterator();
					Map<String, String> messageMap = new HashMap<String, String>();
					while (messageIterator.hasNext()) {
						Element item = (Element) messageIterator.next();
						String elementName = item.getName();
						messageMap.put(elementName, item.getStringValue());
					}
					if (messageMap.size() > 0) {
						String id = (String) messageMap.get("id");
						String length = (String) messageMap.get("length");
						String align = (String) messageMap.get("align");
						String pad = (String) messageMap.get("pad");
						int size = length.length() > 0 ? Integer.parseInt(length) : 0;
						byte[] dataByte = new byte[size];
						String indata = docData.valueOf("/REQ_XML/" + id);
						//System.out.println("####:" + id + "/" + length + "/"+ indata);
						if (indata != null) {
							if (align.equals("R")  && indata.length() > 0) {
								indata = nLpad(indata, size, pad);
								System.out.println("indata:" + indata);
							} else if (align.equals("L")) {
								indata = sRpad(indata, size, pad);
								System.out.println("indata:" + indata);
							}
							System.arraycopy(indata.getBytes(), 0, dataByte, 0, indata.getBytes().length);
						}
						System.arraycopy(dataByte, 0, buff, startIndex, size);
						//System.out.println("####request:" + id + "|" + length + "|[" + new String(buff, startIndex, size) + "]");
						startIndex += size;
						//System.out.println("startIndex:" + startIndex);
					}
				}
			}
		}
		System.out.println(">>> endIndex:" + startIndex);
		System.out.println(">>> data:[" + new String(buff) + "]");
		System.out.println("=======================================================================");
		return buff;
	}

	/**
	 * <pre>
	 * 응답받은 전문을 분석하여 메세지 맵으로 변환하여 리턴한다.
	 * </pre>
	 * 
	 * @param buff
	 *            응답받은 전문
	 * @param gubunCd
	 *            구분코드
	 * @return 응답 메세지 Map
	 * @throws Exception
	 */
	public static Map<String, String> getRecvCommMsgMap(byte[] buff, String resource) throws Exception {
		return parseResponseMessageMap(buff, null, resource);
	}

	/**
	 * <pre>
	 * 응답받은 전문을 분석하여 메세지 맵으로 변환하여 리턴한다.
	 * </pre>
	 * 
	 * @param buff
	 *            응답받은 전문
	 * @param node
	 *            구분코드
	 * @return 응답 메세지 Map
	 * @throws Exception
	 */
	public static Map<String, String> parseResponseMessageMap(byte[] buff, String node, String resource)
	        throws Exception {
		Document document = (new SAXReader()).read(resource);
		return parseResponseMessageMap(buff, node, document);
	}

	/**
	 * <pre>
	 * 응답받은 전문을 분석하여 메세지 맵으로 변환하여 리턴한다.
	 * </pre>
	 * 
	 * @param buff
	 *            응답받은 전문
	 * @param gubunCd
	 *            구분코드
	 * @return 응답 메세지 Map
	 * @throws Exception
	 */
	public static Map<String, String> parseResponseMessageMap(byte[] buff, String node, Document docFormat)
	        throws Exception {
		return parseResponseMessageMap(buff, node, docFormat, 0, null);
	}

	public static Map<String, String> parseResponseMessageMap(byte[] buff, String node, Document docFormat,
	        int startIndex) throws Exception {
		return parseResponseMessageMap(buff, node, docFormat, startIndex, null);
	}

	public static Map<String, String> parseResponseMessageMap(byte[] buff, String node, Document docFormat,
	        Map<String, String> messageMap) throws Exception {
		return parseResponseMessageMap(buff, node, docFormat, 0, messageMap);
	}

	public static Map<String, String> parseResponseMessageMap(byte[] buff, String node, Document docFormat,
	        int startIndex, Map<String, String> messageMap) throws Exception {
		System.out.println("=======================================================================");
		System.out.println(">>> length,node,format,index: "+ buff.length +","+ node +","+ (docFormat == null ? "null": "not null!")+","+ startIndex);
		if (messageMap == null) {
			messageMap = new HashMap<String, String>();
		}		
		System.out.println(">>> node:" + EDIConstants.TMPL_BASE_NODE + node);
		Element element = (Element) docFormat.selectSingleNode(EDIConstants.TMPL_BASE_NODE + node);
		Iterator<Element> iterator = null;
		try {
			iterator = element.elementIterator();
		}
		catch (Exception e) {
			System.out.println("### 해당 노드를 찾을수 없습니다.:"+ EDIConstants.TMPL_BASE_NODE + node);
			e.printStackTrace();
			throw e;			
		}

		while (iterator.hasNext()) {
			Element dataElement = (Element) iterator.next();
			String name = dataElement.getName();
			if (EDIConstants.TMPL_MSGE_NODE.equals(name)) {
				String type = dataElement.attributeValue("type");
//				System.out.println("type:"+ type);
				if (EDIConstants.TMPL_MSGE_TYPE_BASIC.equals(type)) {
					Iterator<Element> messageIterator = dataElement.elementIterator();
					Map<String, String> elementMap = new HashMap<String, String>();
					while (messageIterator.hasNext()) {
						Element item = (Element) messageIterator.next();
						String elementName = item.getName();
						elementMap.put(elementName, item.getStringValue());
					}
					if (elementMap.size() > 0) {
						String id = (String) elementMap.get("id");
						String length = (String) elementMap.get("length");
						int size = length.length() > 0 ? Integer.parseInt(length) : 0;
						messageMap.put(id, new String(buff, startIndex, size));
						//System.out.println("response:" + id + "|" + length + "|[" + new String(buff, startIndex, size) +"]");
						startIndex += size;
					}
				}
			}
		}
		System.out.println(">>> endIndex:" + startIndex);
		System.out.println("=======================================================================");
		return messageMap;
	}


	/**
	 * 
	 * @param str
	 * @param size
	 * @param pad
	 * @return
	 * @throws Exception
	 */
	public static String sRpad(String str, int size, String pad) throws Exception {
		if (null == str)
			str = "";
		int len = str.length();
		int tmp = size - len;

		for (int i = 0; i < tmp; i++) {
			str = str + pad;
		}
		return str.substring(0, size);
	}

	/**
	 * nLpad
	 * 
	 * @param String
	 *            , int
	 * @return String
	 * 
	 * @throws Exception
	 */
	public static String nLpad(String num, int size, String pad) throws Exception {
		if (null == num)
			num = "";
		int len = size - num.length();
		for (int i = 0; i < len; i++) {
			num = pad + num;
		}
		return num.substring(num.length() - size, num.length());
	}
}
