package ksnet.util.sign;

import java.io.File;

/**
 * 전자서명 모듈을 호출하여 이미지 생성한다.
 * 
 * @created on 1.0, 2010/07/18
 * @created by 조형욱(FUJITSU KOREA LTD.)
 * 
 * @modified on
 * @modified by
 * 
 */
public class SignbmpJni {
	public native int KSNET_SIGNBMP_EXTRACT(String recvBuf, int recvLen, String resBMP);

	static {
		String filePath = "/jeus/lib/system";
		File f = new File(filePath);
		if (f.exists()) {
			System.out.println("라이브러리 로드합니다.");
//			System.load("/data_in/dcsapps/so/libsignbmpjni.sl");			
			System.loadLibrary("libsignbmpjni");
			System.out.println("libsignbmpjni 라이브러리 로드되었습니다!");
//			System.load("/data_in/dcsapps/so/libks2bmp.sl");
			System.loadLibrary("libks2bmp");
			System.out.println("libks2bmp 라이브러리 로드되었습니다!");
		} else {
			System.out.println("경로를 찾을수 없습니다.");
		}

	}

}
