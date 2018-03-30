package common.util;

import java.io.*;
import java.util.*;
import java.net.*;

import kr.fujitsu.ffw.base.BaseProperty;


public class EtZipcode implements Serializable
{
	private String returnaddr[] = null;
	
	/* 테스트 시작 */
	public static void main(String[] args)
	{
		EtZipcode zip = new EtZipcode();

		try
		{	
			
			zip.putAddress("경기도 안양시 동안구 호계동","한마음임광아파트 101-105");
						
			System.out.println("getAddr_Gbn  : [" + zip.getAddr_Gbn() + "]");					/*	새주소, 구주소 구분	*/
			System.out.println("getRevise_Zipcode1  : [" + zip.getRevise_Zipcode1() + "]");		/*	정제 후 우편번호1	*/
			System.out.println("getRevise_Zipcode2  : [" + zip.getRevise_Zipcode2() + "]");		/*	정제 후 우편번호2	*/
			System.out.println("getWide_Nm : [" + zip.getWide_Nm() + "]");						/*	시도	*/
			System.out.println("getCity_Nm  : [" + zip.getCity_Nm() + "]");						/*	시군	*/
			System.out.println("getSection_Nm  : [" + zip.getSection_Nm() + "]");				/*	구	*/
			System.out.println("getVillage_Nm  : [" + zip.getVillage_Nm() + "]");				/*	읍면	*/
			System.out.println("getAddress_Nm  : [" + zip.getAddress_Nm() + "]");				/*	동리	*/
			System.out.println("getBunji_Gbn  : [" + zip.getBunji_Gbn() + "]");					/*	번지 구분	*/
			System.out.println("getHead_Bunji  : [" + zip.getHead_Bunji() + "]");				/*	번지	*/
			System.out.println("getGaji_Bunji  : [" + zip.getGaji_Bunji() + "]");				/*	가지번지	*/
			System.out.println("getBuild_Nm  : [" + zip.getBuild_Nm() + "]");					/*	건물명	*/
			System.out.println("getBuild_Dong  : [" + zip.getBuild_Dong() + "]");				/*	건물 동	*/
			System.out.println("getBuild_Ho  : [" + zip.getBuild_Ho() + "]");					/*	건물 호	*/
			System.out.println("getBuild_Floor  : [" + zip.getBuild_Floor() + "]");				/*	건물 층	*/
			System.out.println("getRevise_Addr1  : [" + zip.getRevise_Addr1() + "]");			/*	정제 후 주소1	*/	
			System.out.println("getRevise_Addr2  : [" + zip.getRevise_Addr2() + "]");			/*	정제 후 주소2	*/
			System.out.println("getDisc_Cd  : [" + zip.getDisc_Cd() + "]");						/*	결과코드	*/
			System.out.println("getRevise_StAddr1  : [" + zip.getRevise_StAddr1() + "]");		/*	정제 후 새주소1	*/
			System.out.println("getRevise_StAddr2  : [" + zip.getRevise_StAddr2() + "]");		/*	정제 후 새주소1	*/
			System.out.println("getMr_Cd  : [" + zip.getMr_Cd() + "]");							/*	새주소결과코드	*/
			System.out.println("getCln_Yn  : [" + zip.getCln_Yn() + "]");						/*	주소클린징여부	*/	
			System.out.println("getDeliv_Yn  : [" + zip.getDeliv_Yn() + "]");					/*	우편물발송가능여부	*/
		}
		catch (Exception e)
		{
			System.out.println(e);
			System.exit(1);
		}
	}
	
	public EtZipcode()
	{
	}
	
	
	public String putAddress(String js1, String js2) throws Exception
	{
		String addr  = null;
	    String ret   = "";
		addr = js1 + "|" + js2 + "|";
		
		try
		{
			SearchPost sp;
			sp = new SearchPost();
			sp.searchAddress(addr); 
			returnaddr = sp.getAddress();
			ret = "Y";
		} 
		catch(Exception ex)
		{
			ex.printStackTrace();
			ret = "N";
			//throw new Exception(ex);
		}	
		return ret;
	}
	
	
	public String getAddr_Gbn()
	{
		return returnaddr[0];
	}
	
	public String getRevise_Zipcode1()
	{
		return returnaddr[1];
	}
	
	public String getRevise_Zipcode2()
	{
		return returnaddr[2];
	}

	public String getWide_Nm()
	{
		return returnaddr[3];
	}

	public String getCity_Nm()
	{
		return returnaddr[4];
	}

	public String getSection_Nm()
	{
		return returnaddr[5];
	}

	public String getVillage_Nm()
	{
		return returnaddr[6];
	}

	public String getAddress_Nm()
	{
		return returnaddr[7];
	}

	public String getBunji_Gbn()
	{
		return returnaddr[8];
	}

	public String getHead_Bunji()
	{
		return returnaddr[9];
	}

	public String getGaji_Bunji()
	{
		return returnaddr[10];
	}

	public String getBuild_Nm()
	{
		return returnaddr[11];
	}

	public String getBuild_Dong()
	{
		return returnaddr[12];
	}

	public String getBuild_Ho()
	{
		return returnaddr[13];
	}
	public String getBuild_Floor()
	{
		return returnaddr[14];
	}
		
	public String getRevise_Addr1()
	{
		return returnaddr[15];
	}
	public String getRevise_Addr2()
	{
		return returnaddr[16];
	}
	
	public String getDisc_Cd()
	{
		return returnaddr[17];
	}
	public String getRevise_StAddr1()
	{
		return returnaddr[18];
	}
	public String getRevise_StAddr2()
	{
		return returnaddr[19];
	}
	
	public String getMr_Cd()
	{
		return returnaddr[20];
	}
	public String getCln_Yn()
	{
		return returnaddr[21];
	}
	public String getDeliv_Yn()
	{
		return returnaddr[22];
	}
}

class SearchPost
{
	// 변수 선언
	private Socket s = null;
	private String oldAddress = null;
	private String gstrRecv = null;
	private String Address[] = null;
	
	String strEnd = "ET:EOF";

	String sendAddress = null; 
	DataInputStream sin; 
	PrintWriter out;
	
	int size_addr = 30;

	// 생성자 - 소켓과 스트림 초기화
	public SearchPost() throws Exception
	{
        boolean isWindow = (System.getProperty("os.name").toUpperCase().startsWith("WINDOWS")) ? true : false;
        //System.out.println("isWindow======================>"+isWindow);
	    String serverIp = (isWindow) ? BaseProperty.get("postSocketServerIp").toString() : BaseProperty.get("remotePostSocketServerIp").toString();
	    int serverPort  = Integer.parseInt(BaseProperty.get("postServerPort")) ; 
        //System.out.println("serverIp======================>"+serverIp);
	    s = new Socket( serverIp, serverPort ); 
	    s.setSoTimeout (8000);
		sin = new DataInputStream(s.getInputStream());
		out = new PrintWriter(s.getOutputStream(), true); 
		Address = new String[size_addr];
	} 

	// 주소조회
	public void searchAddress(String oldAddress) throws Exception
	{
		try
		{
			this.oldAddress = oldAddress;
			sendAddress = "ET:" + oldAddress;
			//Thread.sleep(1000000);
			writeDataExternal(out);
			readDataExternal(sin);
			tokenAddress();
		} 
		catch(Exception ex)
		{
			System.out.println("소켓에 데이타를 쓰는 중 에러발생");
			//throw new Exception("소켓에 데이타를 쓰는 중 에러발생");
		}
		// 스트림 닫기
		finally
		{
			sin.close();
			out.close();
			s.close();
		}
	}
	
	public void writeDataExternal(java.io.PrintWriter stream) throws IOException
	{
		stream.println(sendAddress);
		stream.println(strEnd);
	}

	public void readDataExternal(java.io.DataInputStream stream) throws IOException
	{
		//System.out.println("소켓에 데이타를 쓰는 중 에러발생3333333333333");
		int len = 2048;
		byte[] strBytes=new byte[len];
		stream.read(strBytes, 0, len);
		gstrRecv = new String(strBytes);
		//System.out.println("소켓에 데이타를 쓰는 중 에러발생4444444444444");
	}

	// 	결과 주소를 tokenization
	public void tokenAddress() throws IOException
	{
		int start=0;
		int count=0;

		/* ET:우편번호|우편번호 시퀀스|광역명|..........| */
		String temp = gstrRecv.substring(gstrRecv.indexOf("ET:")+3);

		for(int k = 0; k < temp.length() && count < size_addr; k++)
		{
			if(temp.charAt(k) == '|')
			{
				Address[count] = temp.substring(start,k);
				count++;
				start = k+1;
			}
		}
	}

	// 결과 값 리턴
	public String[] getAddress()  throws IOException
	{
		return Address;
	}
}
