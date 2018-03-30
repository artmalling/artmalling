<%
/*******************************************************************************
 * 시스템명 : 한국후지쯔 통합정보시스템
 * 작 성 일 : 2010.02.23
 * 작 성 자 : 정진영
 * 수 정 자 :
 * 파 일 명 : imageLoad.jsp
 * 버    전 : 1.0
 * 개    요 : imgs 폴더에서 이미지를 로딩하여 가우스 IMG_DATA_SET 으로 반환한다.
 * 이    력 : 
 *****************************************************************************/
%>
<%@ page import="java.io.*,java.util.*,java.text.*,com.gauce.*,com.gauce.io.*,com.gauce.log.*,com.gauce.common.*, kr.fujitsu.ffw.base.BaseProperty" %><%

    com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(request, response);
    GauceService service = loader.newService();

    String strApath = BaseProperty.get("absolutepath");
    
    File pDir = null;
    File f = null;
    FileInputStream fis = null;
    
    try {
        response.setContentType("application/octet-stream;charset=ISO-8859-1");
        GauceResponse res = service.getGauceResponse();
        GauceDataSet ds = new GauceDataSet();
        res.enableFirstRow(ds);
        ds.addDataColumn(new GauceDataColumn("img",GauceDataColumn.TB_BLOB));		
        ds.addDataColumn(new GauceDataColumn("img_id",GauceDataColumn.TB_STRING));
		ds.addDataColumn(new GauceDataColumn("img_size",GauceDataColumn.TB_INT));
		
   		String imgDir = strApath + "/pot/imgs/gauce/";
   		//System.out.println("imgDir=="+ imgDir );
		pDir = new File(imgDir);
        String[] dFiles = pDir.list();
        for( int i=0; i< dFiles.length; i++) 
        {
        	String[] fileNms = dFiles[i].split("\\.");
        	if(fileNms.length == 2 ){
        		if(fileNms[1].equals("gif")){
                    f = new File( imgDir + dFiles[i] );
                    fis = new FileInputStream(f);
                    GauceDataRow row = ds.newDataRow();
                    row.addColumnValue(fis);            
                    row.addColumnValue(fileNms[0]);   
                    row.addColumnValue(f.length());     
                    ds.addDataRow(row);
        		}
        	}
        }
        ds.flush();
        res.flush();
        res.commit();
        res.close();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            fis.close();
            loader.restoreService(service);
        } catch(Exception e) {
            e.printStackTrace();        
        }
    }
%>
