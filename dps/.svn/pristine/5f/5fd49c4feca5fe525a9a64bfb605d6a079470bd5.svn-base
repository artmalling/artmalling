/*
 * Copyright (c) 2010 한국후지쯔. All rights reserved.
 *
 * This software is the confidential and proprietary information of 한국후지쯔.
 * You shall not disclose such Confidential Information and shall use it
 * only in accordance with the terms of the license agreement you entered into
 * with 한국후지쯔
 */
package common.edi.transport;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.util.Map;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.io.SAXReader;

/**
 * <pre>KSNET 전문 송수신 처리 추상클래스
 * 
 * <pre>
 * 1. 소켓 연결 및 입출력
 * 
 * @created  on 1.0, 2010/05/18
 * @created  by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on 
 * @modified by 
 * 
 */
public abstract class AbstractEDIService {
	private OutputStream output = null;
	private InputStream input 	= null;
	private Document trFormXml 	= null; // 전문포맷 문서
	private Properties prop		= null;

	public AbstractEDIService() {
		try {
			//prop = this.getProperties();
			System.out.println("prop.size():"+ prop.size());
		}
		catch(Exception e) {
			
		}
	}
	/**
	 * <pre>
	 * ksnet 호스트에 socket 연결한다.
	 * </pre>
	 * 
	 * @return socket
	 * @throws Exception
	 */
	public Socket connection() throws Exception {
//		String HOST = (String) prop.get("KSNET_HOST_IP");
//		int PORT = Integer.parseInt((String) prop.get("KSNET_PORT"));
		String HOST = "210.181.29.21";
//		String HOST = "127.0.0.1";
		int PORT = 20189;
		System.out.println("#######################################################################");
		System.out.println("HOST:" + HOST + "/" + PORT);
		Socket socket = new Socket(HOST, PORT);
		System.out.println("server to connection ok");
		System.out.println("#######################################################################");

		// socket 의 출력 스트림을 얻는다.
		output 	= socket.getOutputStream();
		input 	= socket.getInputStream();

		return socket;
	}

	/**
	 * <pre>
	 * 송신전문을 전송하여 수신전문을 응답받는다
	 * </pre>
	 * 
	 * @param request
	 *            송신전문
	 * 
	 * @return 수신전문
	 */
	public byte[] transport(byte[] request) {		
		byte[] recMsg = null;
		
		try {			
			/* 소켓서버로 메세지 송신 */
			this.sendMessage(request);
			
			/* */
			recMsg = this.recvMessage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return recMsg;			
	}
	
	/**
	 * <pre>전문 수신</pre>
	 * 
	 * @return 수신전문(byte)
	 */
	public byte[] recvMessage() throws Exception {
		byte[] message = null;

		try {			
			/**/
			System.out.println("#######################################################################");
			ByteArrayOutputStream sendByteArrayOutputStream = new ByteArrayOutputStream();
			/**/
			int headbyteSize = 4;
			byte[] headbyte = new byte[headbyteSize];
			int readLen = input.read(headbyte);
			if (readLen < headbyteSize) {
				throw new Exception("Invalid byte!");
			}
			System.out.println(">>> headbyte:[" + new String(headbyte) + "]");
			/**/
			//int totoalsize = Integer.parseInt(new String(headbyte).trim()) - headbyteSize;			
			int totoalsize = Integer.parseInt(new String(headbyte).trim());
			byte[] buffer = new byte[totoalsize];
			int byteRead;
			int offset = 0;
			int i = 0;
			while ((byteRead = input.read(buffer)) != -1) {
				sendByteArrayOutputStream.write(buffer, (i * totoalsize), byteRead);
				offset += byteRead;
				 System.out.println(">>> offset:[" + offset + "/" + totoalsize + "]");
				if (offset >= totoalsize) {
					break;
				}
			}			
			sendByteArrayOutputStream.close();
			byte[] resBuff = sendByteArrayOutputStream.toByteArray();
			/**/
			message = new byte[headbyte.length + resBuff.length];
			System.arraycopy(headbyte, 0, message, 0, headbyte.length);
			System.arraycopy(resBuff, 0, message, headbyte.length, resBuff.length);			
			System.out.println("#### receive message : [" + new String(message) + "]");
			System.out.println("#######################################################################");
		} catch (Exception e) {
			System.out.println(e);
			throw e;
		}

		return message;
	}


	/**
	 * <pre>소켓서버로 메세지 송신</pre>
	 * 
	 * @param message 송신메세지(byte)	 * 
	 * @throws Exception
	 */
	public void sendMessage(byte[] message) throws Exception {
		System.out.println("#######################################################################");
		try {
			System.out.println(">>> send message:[" + new String(message) + "]");
			
			/* 소켓으로 전문을 전송한다. */
			output.write(message);
			output.flush();
		} catch (Exception e) {
			throw e;
		}
		
		System.out.println("#######################################################################");
	}

	/**
	 * <pre>
	 * 오류메세지 전송
	 * </pre>
	 * 
	 * @param errCd
	 */
	public void sendErrMsg(String errCd) {
		// this.transport(msgHandler.getRquestMessage(EDIConstants.TR_CD_R09,
		// 0));
	}

	/**
	 * <pre>
	 * 송신전문 유효성 검사
	 * </pre>
	 * 
	 * @param sTrcd
	 *            전문구분코드
	 * @param sendTermId
	 *            송신시 기관
	 * @param recvTermId
	 *            수신시 기관
	 * @param sendRecCnt
	 *            송신시 레코드건수
	 * @param recvRecCnt
	 *            수신시 레코드건수
	 * @return 유효성여부
	 */
	public boolean isValidFTService(String sTrcd, String rTrcd, String sendTermId, String recvTermId, int sendRecCnt, int recvRecCnt) {
		if (sTrcd == null) {
			System.out.println("전문형식오류:" + EDIConstants.TR_PROTOCOL_ERR);
			return false;
		}

		if (sTrcd.equals(EDIConstants.TR_CD_T09)) {
			System.out.println("KSNET으로 부터 수신된 에러메시지 : ");
			return false;
		}

		if (!sTrcd.equals(EDIConstants.TR_CD_T01) && !sTrcd.equals(EDIConstants.TR_CD_T02)
		        && !sTrcd.equals(EDIConstants.TR_CD_T03) && !sTrcd.equals(EDIConstants.TR_CD_T12)
		        && !sTrcd.equals(EDIConstants.TR_CD_T13)) {
			this.sendErrMsg(EDIConstants.TR_PROTOCOL_ERR);
			System.out.println("전문형식오류:" + EDIConstants.TR_PROTOCOL_ERR);
			return false;
		}

		/**/
		if (rTrcd != null && !sTrcd.equals(rTrcd)) {
			return false;
		}
		
		if (sendRecCnt != recvRecCnt) {
			if (sTrcd.equals(EDIConstants.TR_CD_T03)) {
				this.sendErrMsg(EDIConstants.TR_TOTAL_REC_DIFF_ERR);
				System.out.println("전송건수 상이:" + EDIConstants.TR_TOTAL_REC_DIFF_ERR);
			} else {
				this.sendErrMsg(EDIConstants.TR_DATA_DIFF_ERR);
				System.out.println("전송건수 상이:" + EDIConstants.TR_DATA_DIFF_ERR);
			}

			System.out.println("송신건수 " + sendRecCnt + "와 수신건수 " + sendRecCnt + " 상이!");
			return false;
		}

//		if (!sendTermId.equals(recvTermId)) {
//			this.sendErrMsg(EDIConstants.TR_ETC_ERR);
//			System.out.println("송신단말 " + sendTermId + "와 수신단말 " + recvTermId + " 상이!");
//			return false;
//		}

		return true;
	}

	/**
	 * <pre>
	 * 수신전문 유효성 검사
	 * </pre>
	 * 
	 * @param sTrcd
	 *            전문구분코드
	 * @param sendTermId
	 *            송신시 기관
	 * @param recvTermId
	 *            수신시 기관
	 * @param sendRecCnt
	 *            송신시 레코드건수
	 * @param recvRecCnt
	 *            수신시 레코드건수
	 * @return
	 */
	public boolean isValidFRServiceMsg(String sTrcd, String rTrcd, String sendTermId, String recvTermId, int sendRecCnt, int recvRecCnt) {
		/**/
		if (sTrcd == null) {
			System.out.println("전문형식오류:" + EDIConstants.TR_PROTOCOL_ERR);
			return false;
		}

		/**/
		if (sTrcd.equals(EDIConstants.TR_CD_R09)) {
			System.out.println("KSNET으로 부터 수신된 에러메시지 : ");
			return false;
		}

		/**/
		if (!sTrcd.equals(EDIConstants.TR_CD_R01) && !sTrcd.equals(EDIConstants.TR_CD_R02)
		        && !sTrcd.equals(EDIConstants.TR_CD_R03) && !sTrcd.equals(EDIConstants.TR_CD_R12)
		        && !sTrcd.equals(EDIConstants.TR_CD_R13)) {
			this.sendErrMsg(EDIConstants.TR_PROTOCOL_ERR);
			System.out.println("전문형식오류:" + EDIConstants.TR_PROTOCOL_ERR);
			return false;
		}

		/**/
		if (rTrcd != null && !sTrcd.equals(rTrcd)) {
			return false;
		}
		
		/**/
		if (sendRecCnt != recvRecCnt) {
			if (recvRecCnt > sendRecCnt) {
				//
			} else {
				this.sendErrMsg(EDIConstants.TR_DATA_DIFF_ERR);
				System.out.println("송신건수 " + sendRecCnt + "와 수신건수 " + sendRecCnt + " 상이!");
				return false;
			}
		}

		/**/
		// if (!sendTermId.equals(recvTermId)) {
		// this.sendErrMsg(EDIConstants.TR_ETC_ERR);
		// System.out.println("송신단말 " + sendTermId + "와 수신단말 " + recvTermId +
		// " 상이!");
		// return false;
		// }

		return true;
	}

	/**
	 * <pre>
	 * 구분코드별 노드 리턴
	 * </pre>
	 * 
	 * 상수클래스 이용가능
	 * 
	 * @param gubunCd
	 *            구분코드
	 * @return 노드
	 */
	public String getMessageNod(String gubunCd) {
		String node = null;
		if (gubunCd == null) {
			node = "/head";
		} else if (EDIConstants.TR_CD_T01.equals(gubunCd.toUpperCase())) {
			node = "/request/ft01";
		} else if (EDIConstants.TR_CD_T02.equals(gubunCd.toUpperCase())) {
			node = "/request/ft02";
		} else if (EDIConstants.TR_CD_T03.equals(gubunCd.toUpperCase())) {
			node = "/head";
		} else if (EDIConstants.TR_CD_T09.equals(gubunCd.toUpperCase())) {
			node = "/error";
		} else if (EDIConstants.TR_CD_R12.equals(gubunCd.toUpperCase())) {
			node = "/request/fr12";
		} else if (EDIConstants.TR_CD_R13.equals(gubunCd.toUpperCase())) {
			node = "/head";
		} else {
			node = "/head";
		}
		return node;
	}

	/**
	 * <pre>
	 * 구분코드에 해당하는 전문포맷에 맞춰  공통부(헤더) byte로 변환후 리턴한다.
	 * </pre>
	 * 
	 * @param gubunCd
	 *            구분코드
	 * @param totRecCnt
	 *            전체레코드갯수
	 * @param recCnt
	 *            기전송된 레코드수
	 * @param txLen
	 *            전문 Length
	 * @param recLen
	 *            레코드 길이
	 * @return 요청 메세지 byte
	 * @throws Exception
	 */
	public Document getReqMsg2Xml(String gubunCd, int totRecCnt, int txLen, int recLen) throws Exception {
		System.out.println("#######################################################################");
		System.out.println("#### totRecCnt:		[" + totRecCnt + "]");
		System.out.println("#### txLen:   		[" + txLen + "]");
		System.out.println("#######################################################################");
		/* 공통부 */
		StringBuffer bufXml = new StringBuffer();
		bufXml.append("<?xml version='1.0' encoding='euc-kr'?>\n");
		bufXml.append("<REQ_XML>\n");
		bufXml.append("<LENGTH>").append(txLen-EDIConstants.TX_HEAD_LENGTH).append("</LENGTH>\n");
		bufXml.append("<TERM_ID>").append(EDIConstants.Ft.TX_TERM_ID).append("</TERM_ID>\n");
		bufXml.append("<REC_NO>").append(totRecCnt).append("</REC_NO>\n");
		bufXml.append("<REC_LEN>").append(recLen).append("</REC_LEN>\n");
		bufXml.append("<GUBUN_CD>").append(gubunCd.toUpperCase()).append("</GUBUN_CD>\n");
		bufXml.append("</REQ_XML>\n");
		/**/
		System.out.println("#######################################################################");
		System.out.println("COMMON_XML:[" + bufXml.toString() + "]");
		System.out.println("#######################################################################");

		/* xml문자열을 xml문서로 변환 */
		Document dRequest = DocumentHelper.parseText(bufXml.toString());
		/* */
		return dRequest;
	}

	/**
	 * <pre>
	 * 전문공통(헤더) 포맷으로  byte 변환
	 * </pre>
	 * 
	 * @param gubunCd
	 *            구분코드
	 * @param totRecCnt
	 *            전체레코드길이
	 * @param txLen
	 *            전송길이
	 * @param recLen
	 *            레코드길이
	 * @param resource
	 * @return
	 * @throws Exception
	 */
	public byte[] getRquestCommonMessage(String gubunCd, int totRecCnt, int txLen, int recLen, String resource)
	        throws Exception {
		System.out.println("#######################################################################");
		System.out.println("#### totRecCnt:		[" + totRecCnt + "]");
		System.out.println("#### txLen:   		[" + txLen + "]");
		System.out.println("#######################################################################");
		/* 공통부 */
		StringBuffer bufXml = new StringBuffer();
		bufXml.append("<?xml version='1.0' encoding='euc-kr'?>\n");
		bufXml.append("<REQ_XML>\n");
		bufXml.append("<LENGTH>").append(txLen).append("</LENGTH>\n");
		bufXml.append("<TERM_ID>").append(EDIConstants.Ft.TX_TERM_ID).append("</TERM_ID>\n");
		bufXml.append("<REC_NO>").append(totRecCnt).append("</REC_NO>\n");
		bufXml.append("<REC_LEN>").append(recLen).append("</REC_LEN>\n");
		bufXml.append("<GUBUN_CD>").append(gubunCd.toUpperCase()).append("</GUBUN_CD>\n");
		bufXml.append("</REQ_XML>\n");
		/**/
		System.out.println("#######################################################################");
		System.out.println("COMMON_XML:[" + bufXml.toString() + "]");
		System.out.println("#######################################################################");

		/* xml문자열을 xml문서로 변환 */
		Document dRequest = DocumentHelper.parseText(bufXml.toString());
		/* */
		byte[] buff = new byte[EDIConstants.TX_COMM_LENGTH];
		System.out.println("#### EDIMessageHandler.getRquestMessage: ");
		return EDIMessageParser.getRquestMessage(dRequest, buff, "/head", resource);
	}

	/**
	 * <pre>
	 * 파라메터 node 포맷으로 byte 수신메시지를 Map 으로 변환
	 * </pre>
	 * 
	 * @param buff
	 * @param node
	 * @return
	 * @throws Exception
	 */
	public Map<String, String> getRecvMsgMap(byte[] buff, String node) throws Exception {
		return EDIMessageParser.parseResponseMessageMap(buff, node, trFormXml);
	}
	public Map<String, String> getRecvMsgMap(byte[] buff, String node, int startIndex) throws Exception {
		return EDIMessageParser.parseResponseMessageMap(buff, node, trFormXml, startIndex);
	}


	/**
	 * <pre>
	 * 요청메세지 byte 변환
	 * </pre>
	 * 
	 * @param doc
	 *            요청메세지 document
	 * @param buff
	 *            변환 byte buffer
	 * @param node
	 *            전문포맷 node 명
	 * @return 요청메세지 byte
	 * @throws Exception
	 */
	public byte[] getRquestMessage(Document doc, byte[] buff, String node) throws Exception {
		return EDIMessageParser.getRquestMessage(doc, buff, node, trFormXml);
	}

	/**
	 * <pre>
	 * 파라메터에 해당하는 공통부 요청메세지 변환
	 * </pre>
	 * 
	 * @param gubunCd
	 *            구분코드
	 * @param totRecCnt
	 *            전체레코드길이
	 * @param txLen
	 *            전문전송길이
	 * @param recLen
	 *            레코드길이
	 * @return 공통부요청메시지 byte
	 * @throws Exception
	 */
	public byte[] getReqCommMsg(String gubunCd, int totRecCnt, int txLen, int recLen) throws Exception {
		byte[] buff = new byte[EDIConstants.TX_COMM_LENGTH];

		return EDIMessageParser.getRquestMessage(this.getReqMsg2Xml(gubunCd, totRecCnt, txLen, recLen), buff, "/head", trFormXml);
	}

	/**
	 * 공통부 + 데이터부
	 * 
	 * @param bfComm
	 * @param bfData
	 * @return
	 */
	public byte[] getRequestMessage(byte[] bfComm, byte[] bfData) {
		byte[] buff = new byte[bfComm.length + bfData.length];
		System.arraycopy(bfComm, 0, buff, 0, bfComm.length);
		System.arraycopy(bfData, 0, buff, bfComm.length, bfData.length);
		
		return buff;
	}
	
	/**
	 * <pre>
	 * 소켓 close, in/out stream close
	 * </pre>
	 */
	public void close() {

	}

	/**
	 * <pre>
	 * 전문포맷문서 리턴
	 * </pre>
	 * 
	 * @return
	 */
	public Document getTranFormDoc() {
		return this.trFormXml;
	}

	/**
	 * <pre>
	 * 전문포맷문서(document) 설정
	 * </pre>
	 * 
	 * @param resource
	 *            리소스명
	 * @throws Exception
	 */
	public void setTranFormDoc(String resource) throws Exception {
		System.out.println("resource:"+ getRepository() + resource);
		this.trFormXml = (new SAXReader()).read(getRepository() + resource);
	}

	/**
	 * <pre>
	 * config 파일에서 repository 정보를 읽어 리턴
	 * </pre>
	 * 
	 * @return 전문포맷문서 저장소 리턴
	 */
	public String getRepository() {
//		String path = (String) prop.get("KSNET_REPOSITORY_PATH");
//		String path = "C:/java/webapps/dps/WEB-INF/classes/common/edi/xml";//
		String path = "/data_in/dcsapps/bin/common/edi/xml";//
		System.out.println("###PATH:"+ path);
		return path;
	}

	
	public Properties getProperties() throws Exception {
//		String path = (String) BaseProperty.get("edi.properties");
//		String path = "C:/java/webapps/dps/WEB-INF/classes/common/edi/edi.properties";//
		String path = "/data_in/dcsapps/bin/common/edi/edi.properties";//
		System.out.println("###path:"+ path);
		try {
			InputStream is = (InputStream) new FileInputStream(new File(path));
			Properties props = new Properties();
			props.load(is);
			return props;
		} catch (Exception e) {
			throw e;
		}
	}
}
