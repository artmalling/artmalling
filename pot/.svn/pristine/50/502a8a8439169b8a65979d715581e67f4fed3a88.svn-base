<!-- 
/*******************************************************************************
 * 시스템명 : 우편번호 조회 팝업
 * 작 성 일 : 2010.12.12
 * 작 성 자 : 정지인
 * 수 정 자 : 
 * 파 일 명 : ccom9100.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 우편번호 팝업 관리
 * 이    력 :
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"         prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%String dir = BaseProperty.get("context.common.dir");%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 var returnMap		= dialogArguments[0];
 var searchCode		= dialogArguments[1];
 /**
  * doInit()
  * 작 성 자 : FKL
  * 작 성 일 : 2010-12-12
  * 개    요 : 해당 페이지 LOAD 시  
  * return값 : void
  */
 
 function doInit() 
 {	
 	// Input Data Set Header 초기화 
     DS_I_POPUP.setDataHeader  ('<gauce:dataset name="H_POPUP"/>');
     
     // Output Data Set Header 초기화 
     DS_O_POPUP.setDataHeader  ('<gauce:dataset name="H_SEL_POPUP"/>');
           
     //그리드 초기화
     gridCreate1();

     // EMedit에 초기화
     initEmEdit(EM_SEARCH, "GEN", PK);
//		EM_SEARCH.Text = searchCode;

     EM_SEARCH.Focus();
 } 
 
 function gridCreate1(){
	var hdrProperies = '<FC>ID=ADDR1    name="주소"   width=380,  	edit=none,   align="left"  </C>'
		             + '<FC>ID=POST_NO  name="우편번호" width=83,  edit=none,   align="center" mask="XXX-XXX"</C>'
		             + '<FC>ID=POST_SEQ  name="우편번호SEQ" width=0,  edit=none,   align="center"</C>'
		             + '<FC>ID=POST_NO1  name="우편번호앞" width=0,  edit=none,   align="center" </C>'
		             + '<FC>ID=POST_NO2  name="우편번호뒤" width=0,  edit=none,   align="center" </C>';
                                 
    initGridStyle(GD_SEARCH, "common", hdrProperies, false);

} 

/*************************************************************************
  * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 삭제       - btn_Delete()
     (4) 저장       - btn_Save()
     (5) 엑셀       - btn_Excel()
     (6) 출력       - btn_Print()
     (7) 확정       - btn_Conf()
 *************************************************************************/
	     
/**
 * btn_Search()
 * 작 성 자 : 권홍재
 * 작 성 일 : 2006-08-22
 * 개    요  : 조회 처리
 * return값 : void
 */
function btn_Search() 
{	
	if(trim(EM_SEARCH.text) == ""){
		showMessage(STOPSIGN, OK, "USER-1047",  "1");
		return;
	}
    DS_I_POPUP.ClearData();
    DS_I_POPUP.Addrow();
	
    DS_I_POPUP.NameValue(DS_I_POPUP.RowPosition, "ADDR1"   )  = EM_SEARCH.text;     // 분류코드/명
    TR_MAIN.Action="/<%=dir%>/ccom910.cc?goTo=getPopupData";
    TR_MAIN.KeyValue="SERVLET(I:DS_I_POPUP=DS_I_POPUP,O:DS_O_POPUP=DS_O_POPUP)";
    TR_MAIN.Post();  
    //endTR("R", TR_MAIN, DS_O_POPUP);
}
    
/*************************************************************************
 * 3. 함수
*************************************************************************/


   /**
    * btn_Close()
    * 작 성 자 : 권홍재
    * 작 성 일 : 2006-08-22
    * 개    요 : Close
    * return값 : void
    */  
    function btn_Close()
    {
        window.close();
    }
    
    /**
    * doDoubleClick()
    * 작 성 자 : 권홍재
    * 작 성 일 : 2006-08-22
    * 개    요 : 더블클릭 처리
    * return값 : void
    */  
    function doDoubleClick(row)
    {
    	if( row == undefined ) 
    		row = DS_O_POPUP.RowPosition;

    	if (row > 0) 
    	{
            var strColumnId = "";
            
            for(var i=1;i<=DS_O_POPUP.CountColumn;i++)
            {
                returnMap.put(DS_O_POPUP.ColumnID(i), DS_O_POPUP.NameValue(row, DS_O_POPUP.ColumnID(i)));
            }
            
            window.returnValue = true;
            window.close();
        }
        return false;         
    }
    
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                 *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    showMessage(STOPSIGN, OK, "USER-1000", "Transaction Fail!\n" + "ErrorCode : " + TR_MAIN.ErrorCode + "\n" + "ErrorMsg  : " + TR_MAIN.ErrorMsg);
    for(i=1;i<TR_MAIN.SrvErrCount('GAUCE');i++) {
        showMessage(STOPSIGN, OK, "GAUCE-1000", TR_MAIN.SrvErrMsg('GAUCE',i));
    }
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

 <script language=JavaScript for=GD_SEARCH event=OnDblClick(row,colid)>
// 그리드 double 클릭이벤트에서 처리 할 내역 추가 		
	doDoubleClick(row);    
//
</script> 

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_POPUP classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id=DS_O_POPUP classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body  onLoad="doInit();">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="pop01"></td>
    <td class="pop02" ></td>
    <td class="pop03" ></td>
  </tr>
  <tr>
    <td class="pop04" ></td>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="396" class="title"><img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="PR05 PL03"/>우편번호(주소)조회</td>
            <td><table border="0" align="right" cellpadding="0" cellspacing="0">
              <tr>
                <td><img src="/<%=dir%>/imgs/btn/search.gif" width="50" height="22"  onClick="btn_Search();"/></td>
                <td><img src="/<%=dir%>/imgs/btn/confirm.gif" width="50" height="22" onClick="doDoubleClick()"/></td>
                <td><img src="/<%=dir%>/imgs/btn/close.gif" width="50" height="22"   onClick="btn_Close();"/></td>
                
                </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
          <tr>
            <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
              <tr>
                <th width="100">지역명</th>
                <td>
								<comment id="_NSID_">
 									<object id=EM_SEARCH classid=<%=Util.CLSID_EMEDIT%> height=20 width=90 onKeyDown="if(event.keyCode == 13) btn_Search();" >
 									</object>
   								</comment><script>_ws_(_NSID_);</script>
                </td>
                 </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="g_table">      
        <tr>
        <td>
            <!-- 마스터 -->
            <comment id="_NSID_"><OBJECT id=GD_SEARCH height=300 width="495" classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_POPUP">
            </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>
            </tr>
        </table></td>
      </tr>
    </table></td>
     <td class="pop06" ></td>
  </tr>
  <tr>
     <td class="pop07" ></td>
     <td class="pop08" ></td>
     <td class="pop09" ></td>
  </tr>
</table>
</body>
</html>

