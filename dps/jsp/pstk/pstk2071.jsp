<!-- 
/*******************************************************************************
 * 시스템명 : 실사재고등록 - 엑셀업로드 팝업
 * 작 성 일 : 2010-04-25
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pstk2071.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 엑셀업로드 팝업
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
<title>실사재고등록 엑셀 업로드</title>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"  type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"   type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
var returnParam    = dialogArguments[0];
var strStrCd       = dialogArguments[1];    // 점
var strPumbunCdA    = dialogArguments[2];    // 브랜드
var strPrcAppDt    = dialogArguments[3];    // 가격적용일


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
/**
 * doInit()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010-04-25
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     	
	
	// Output Data Set Header 초기화
	DS_O_RESULT.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	DS_O_SKU.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
	
    //그리드 초기화
    gridCreate1();
  
    // EMedit 초기화
    initEmEdit(EM_FILS_LOC, "GEN^300^0", READ); //EXCEL경로    
} 

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}        name="NO"              width=30     align=center    edit=none </FC>'
    	             + '<FC>id=CHECK1          name="선택"             width=45    align=center EditStyle=CheckBox  HeadCheckShow="true"  edit={IF(CLOSE_DT="", "true", "false")}</FC>'
                     + '<FC>id=PUMBUN_CD       name="*브랜드코드"         width=80    align=center edit=none  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=PUMBUN_NAME     name="브랜드명"           width=90    align=left  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>' 
                     + '<FC>id=PUMMOK_CD       name="*품목코드"         width=85    align=center  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=PUMMOK_NAME     name="품목명"           width=90    align=left  edit=none</FC>' 
                     + '<FG> name="마진코드" '
                     + '<FC>id=EVENT_FLAG      name="*행사구분"        width=60    align=center     edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=EVENT_RATE      name="*행사율"           width=55    align=center    edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=MG_RATE         name="*마진율"           width=55    align=center    edit=none    BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '</FG> '
                     /*
                     + '<FG> name="장부재고" '
                     + '<FC>id=STK_QTY         name="수량"            width=50    align=right   edit=none  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=STK_AMT         name="금액"           width=70    align=right  edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '</FG> '                                       
                     */
                     + '<FG> name="실사재고" '
                     + '<FC>id=SRVY_QTY        name="수량"            width=50    align=right    edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=SRVY_AMT        name="금액"            width=70    align=right    edit=none   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '</FG> '                                        
                     + '<FC>id=STR_CD          name="점"              width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=STK_YM          name="실사년월"              width=50    align=left  edit=none  show="false"  BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=FLAG            name="EDIT구분자"       width=50    align=left  edit=none  show="false"   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>'
                     + '<FC>id=ERROR_CHECK     name="에러체크"        width=50    align=left  edit=none  show="false"   BgColor={if(ERROR_CHECK = "","white","orange") }</FC>';                     
        
    initGridStyle(GD_EXCEL_DATA, "common", hdrProperies, true);
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
 * 작 성 자 : 이재득
 * 작 성 일 : 2010-04-25
 * 개    요  : 
 * return값 : void
**/
function btn_Search() 
{ 
      
      
}       
/*************************************************************************
 * 3. 함수
*************************************************************************/

 /**
  * btn_Close()
  * 작 성 자 : 
  * 작 성 일 :
  * 개    요 : Close
  * return값 : void
 **/  
 function btn_Close()
 {
 
 }
 
 /**
  * btn_Conf()
  * 작 성 자 : 
  * 작 성 일 : 
  * 개    요 : 확인버튼  처리
  * return값 : void
 **/  
 function btn_Conf()
 {
 
 }    
 
     
 /**
  * loadExcelData()
  * 작 성 자 : 이재득
  * 작 성 일 : 2010-04-25
  * 개    요 : Excel파일 DateSet에 저장
  * return값 :
  */
 function loadExcelData() {
 
 	INF_EXCELUPLOAD.Open();
 	
 	//loadExcelData 옵션처리
 	var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
 	if (strExcelFileName == "''")
 	    return;
 	
 	EM_FILS_LOC.text  = strExcelFileName;  //경로명 표기
 	
 	var strStartRow = 7; //시작Row
    var strEndRow = 0; //끝Row
    var strReadType = 0; //읽기모드
    var strBlankCount = 0; //공백row개수
    var strLFTOCR = 0; //줄바꿈처리 
    var strFireEvent = 1; //이벤트발생
    var strSheetIndex = 1; //Sheet Index 추가
    var strtrEtc = "1";//엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
    var strtrcol = 0;//Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

    var strOption = strExcelFileName
    + "," + strStartRow + "," + strEndRow + "," + strReadType 
    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
    + "," + strSheetIndex + "," + strtrEtc+ "," + strtrcol;
 	
 	DS_O_RESULT.ClearData();
 	DS_O_SKU.ClearData();
 	// Excel파일 DateSet에 저장               
    DS_O_RESULT.Do("Excel.Application", strOption);
	
    DS_O_RESULT.DeleteRow(1);    
    
 	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
 	var strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
 	
 	if(strData == "") {
 		 showMessage(INFORMATION, OK, "USER-1000", "업로드파일 양식에 오류가 있습니다.");
 		return false;
 	}
 	DS_O_SKU.ImportData(strData);
 	
 	errorChk();
 
 	// 중복체크 후 구별을 쉽게하기 위해 정렬한다.
 	//DS_O_SKU.SortExpr = "+" + "SKU_CD";
 	//DS_O_SKU.Sort();
 
 	// Excel에서 가져온 데이터의 정합성 체크를 한다.
 	
 }
 
 /**
  * errorChk()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : UPLOAD된 값 체크 
  * return값 : void
  */
  function errorChk(){
      for(i=0; i <= DS_O_SKU.CountRow; i++){
          j = i;
          
          var txtStrCd        = strStrCd;//점
          var txtPumbunCd     = strPumbunCdA;//브랜드
          var txtStkYm        = strPrcAppDt;//실사년월
            
          var strStrCd        = DS_O_SKU.NameValue(i,"STR_CD");  
            
          var strPumbunCd     = DS_O_SKU.NameValue(i,"PUMBUN_CD");        
          var strPummokCd     = DS_O_SKU.NameValue(i,"PUMMOK_CD");
          var strEventFlag    = DS_O_SKU.NameValue(i,"EVENT_FLAG");
          var strEventRate    = DS_O_SKU.NameValue(i,"EVENT_RATE");
          var strMgRate       = DS_O_SKU.NameValue(i,"MG_RATE");
          var strStkYm        = DS_O_SKU.NameValue(i,"STK_YM");
          
          if(strStrCd.length == 2 && strPumbunCd.length == 6 && strStkYm.length == 6 && strPummokCd.length ==8 && strStkYm.length == 6 
                && strEventFlag.length == 2 && strEventRate.length == 2 
                && !isNull(strStrCd)    && !isNull(strPumbunCd) && !isNull(strPummokCd) && !isNull(strEventFlag) && !isNull(strEventRate)   
                && txtStrCd == strStrCd && strStkYm == txtStkYm){
                
                var goTo       = "searchCheck" ;    
                var action     = "O";    
                var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                               + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                               + "&strPummokCd="        +encodeURIComponent(strPummokCd)
                               + "&strEventFlag="        +encodeURIComponent(strEventFlag)
                               + "&strEventRate="        +encodeURIComponent(strEventRate)
                               + "&strMgRate="        +encodeURIComponent(strMgRate)
                               ;
                
                TR_MAIN.Action="/dps/pstk207.pt?goTo="+goTo+parameters;  
                TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_CHECK=DS_IO_CHECK)"; //조회는 O
                TR_MAIN.Post();
                i = j;
                
                
                if (DS_IO_CHECK.NameValue(1 , "CNT") == 0) {
                	DS_O_SKU.NameValue(i,"ERROR_CHECK")= "T";                    
                }
                DS_IO_CHECK.ClearData();
            }else{
            	DS_O_SKU.NameValue(i,"ERROR_CHECK")= "T";
            }          
       }
   }
 
 /**
  * btn_DeleteRow()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : 선택된 단품을 삭제한다.
  * return값 : void
  */
 function btn_DeleteRow(){
 	var intRowCount =  DS_O_SKU.CountRow;
 	for(var i=intRowCount; i >= 1; i--){
 		if(DS_O_SKU.NameValue(i, "CHECK1") == 'T'){
 			DS_O_SKU.DeleteRow(i);
 		}
 	}
 	//그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('CHECK1','HeadCheck')= "false"; 	
 }
 
 /**
  * btn_Apply()
  * 작 성 자     : 이재득
  * 작 성 일     : 2010-04-25
  * 개    요        : 선택된 단품을 적용한다.
  * return값 : void
  */
 function btn_Apply(){
     var selCount = 0;
     for(var i = 1; i <= DS_O_SKU.CountRow; i++){
         var strSel        = DS_O_SKU.NameValue(i, "CHECK1");
         var strerrorCheck = DS_O_SKU.NameValue(i, "ERROR_CHECK");
         if(strSel == "T"){
         	if(strerrorCheck != ""){
 	            showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 비단품에 오류가 있습니다.");
 	            DS_O_SKU.RowPosition = i;
 	            return;
         	}
         	selCount++;
         }
     }
     
     if(selCount <= 0){
     	showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 비단품내역이 없습니다.");
     	return;
     }
     	
 	window.returnValue = DS_O_SKU.ExportData(1,DS_O_SKU.CountRow, true );
     //그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('CHECK1','HeadCheck')= "false";
     window.close();
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
<script language=JavaScript for=DS_O_SKU event=OnColumnChanged(row,colid)>

</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GD_EXCEL_DATA event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    if (bCheck == '1'){ // 전체체크
        for(var i=1; i<=DS_O_SKU.CountRow; i++){
        	DS_O_SKU.NameValue(i, "CHECK1") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_SKU.CountRow; i++){
        	DS_O_SKU.NameValue(i, "CHECK1") = 'F';
        }
    }
</script>

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*    3. Excelupload
<!--*************************************************************************-->
<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<comment id="_NSID_"><object id=DS_I_COND classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SIZE_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_SALE_UNIT_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CMP_SPEC_UNIT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_SKU        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_CHECK" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <object id="TR_MAIN"        classid="<%=Util.CLSID_TRANSACTION%>">
      <param name="KeyName"   value="Toinb_dataid4">
    </object>
</comment>
<script> _ws_(_NSID_);</script>

<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

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
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">비단품 엑셀 업로드 </SPAN>
            </td>
            <td align="right"><img id="IMG_ADD_ROW"  src="/<%=dir%>/imgs/btn/del.gif" onclick="javascript:btn_DeleteRow();" hspace="2"  align="absmiddle"/><img id="IMG_DEL_ROW"
                    style="vertical-align: middle;"
                    src="/<%=dir%>/imgs/btn/apply.gif" onclick="javascript:btn_Apply();"  align="absmiddle"/>
                </td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td class="PT03 Pb03">
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
               <td>
				  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="s_table">
				    <tr>
				       <th>파일선택</th>
				        <td width="650"><comment id="_NSID_"><object
		                    id=EM_FILS_LOC style="vertical-align: middle;"
		                    classid=<%=Util.CLSID_EMEDIT%> width="585"></object></comment><script>_ws_(_NSID_);</script><img
		                    id="IMG_FILE_SEARCH" style="vertical-align: middle;"
		                    src="/<%=dir%>/imgs/btn/file_search.gif" width="62" height="18"
		                    onclick="loadExcelData();" />
		                </td>				          
				     </tr>
				   </table>
				</td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
      <td class="dot">
      </td>
      </tr>
      
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
        <tr>
        <td>
            <!-- 마스터 -->
            <comment id="_NSID_"><OBJECT id=GD_EXCEL_DATA height="275px" width="100%" classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_O_SKU">
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
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>
