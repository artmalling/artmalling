<!-- 
/*******************************************************************************
 * 시스템명 : 의류단품 매입발주 등록 - 엑셀업로드 팝업
 * 작 성 일 : 2010.02.23
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : pord1041.jsp
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
<title>의류단품 매입발주 엑셀 업로드</title>
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
var strPumbunCd    = dialogArguments[2];    // 브랜드
var strPrcAppDt    = dialogArguments[3];    // 가격적용일


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-02-23
 * 개    요 : initialize
 * return값 : void
**/
function doInit() 
{     	
	
	// Output Data Set Header 초기화
	DS_O_RESULT.setDataHeader('SKU_CD:STRING(13),STYLE_CD:STRING(54),COLOR_CD:STRING(3),SIZE_CD:STRING(3),ORD_QTY:INT(9)');
	DS_O_SKU.setDataHeader('<gauce:dataset name="H_SKU_UPLOAD"/>');
	
    //그리드 초기화
    gridCreate1();
  
    // EMedit 초기화
    initEmEdit(EM_FILS_LOC, "GEN^300^0", READ); //EXCEL경로
} 

function gridCreate1(){
    var hdrProperies = '<FC>id=SEL                name=""              width=20     align=center  HeadCheckShow=true EditStyle=CheckBox</FC>'
                     + '<FC>ID="SKU_CD"           name="단품코드"       width=100,   edit=none,   align="center"  </FC>'
                     + '<FC>ID="SKU_NM"           name="단품명"         width=120,   edit=none,   align="center"  </FC>'
                     + '<FC>ID="STYLE_CD"         name="스타일코드"     width=120,    edit=none,  align="center"  </FC>'
                     + '<FC>ID="COLOR_CD"         name="칼라"           width=60,    edit=none,   align="center"  </FC>'
                     + '<FC>ID="SIZE_CD"          name="사이즈"         width=60,    edit=none,   align="center"  </FC>'
                     + '<FC>ID="SALE_UNIT_NM"     name="단위"          width=80,    edit=none,   align="left"  </FC>'
                     + '<FC>ID="ORD_QTY"          name="수량"           width=60,    edit=none,   align="right"   </FC>'
                     + '<FC>ID="ERR_YN"           name="오류여부"       width=60,    edit=none,   align="center"   </FC>'
                     + '<FC>ID="ERR_DESC"         name="오류내용"       width=160,    edit=none,  align="left"   </FC>';
                     
 
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-02-23
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
  * 작 성 자 : 김경은
  * 작 성 일 : 2010.02.23
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
 	var strStartRow   = 1;                 //시작Row
 	var strEndRow     = 0;                 //끝Row
 	var strReadType   = 0;                 //읽기모드
 	var strBlankCount = 0;                 //공백row개수
 	var strLFTOCR     = 0;                 //줄바꿈처리 
 	var strFireEvent  = 1;                 //이벤트발생
 	var strSheetIndex = 1;                 //Sheet Index 추가
 
 	
 	var strOption = strExcelFileName
 	    + "," + strStartRow + "," + strEndRow + "," + strReadType 
 	    + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
 	    + "," + strSheetIndex;
 	
 	DS_O_RESULT.ClearData();
 	DS_O_SKU.ClearData();
 	// Excel파일 DateSet에 저장               
     DS_O_RESULT.Do("Excel.Application", strOption);
 	// Excel에서 가져온 DATASET을 화면에 보여줄 DATASET에 복사한다.
 	var strData = DS_O_RESULT.ExportData(1,DS_O_RESULT.CountRow, true );
 	DS_O_SKU.ImportData(strData);
 
 	// 중복체크 후 구별을 쉽게하기 위해 정렬한다.
 	DS_O_SKU.SortExpr = "+" + "SKU_CD";
 	DS_O_SKU.Sort();
 
 	// Excel에서 가져온 데이터의 정합성 체크를 한다.
 	checkValidation();
 }


 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-02-23
  * 개    요        : UPLOAD된 값 체크 
  * return값 : void
  */
 function checkValidation() {
 
 	var intRowCount = DS_O_SKU.CountRow;  // 업로드된 데이트
 	
 	
 	var strSkuCd    = "";                                             // 단품코드
 	  
     var goTo       = "getSkuInfo" ;    
     var action     = "O";     
     var parameters = "";
 	
 	for(var i = 1; i <= intRowCount; i++){
 		strSkuCd = DS_O_SKU.NameValue(i, "SKU_CD");
 
 		parameters = "&strStrCd="	+encodeURIComponent(strStrCd)
 		           + "&strPumbunCd="+encodeURIComponent(strPumbunCd)
 		           + "&strPrcAppDt="+encodeURIComponent(strPrcAppDt)    
 		           + "&strSkuCd="	+encodeURIComponent(strSkuCd);
 		TR_MAIN.Action="/dps/pord104.po?goTo="+goTo+parameters;  
 		TR_MAIN.KeyValue="SERVLET("+action+":DS_O_SKU_INFO=DS_O_SKU_INFO)";     // 조회는 O
 		TR_MAIN.Post();
 	
 		if(DS_O_SKU_INFO.CountRow == 0){
 			DS_O_SKU.NameValue(i, "ERR_YN")   = "Y";                                 // 오류여부
 			DS_O_SKU.NameValue(i, "ERR_DESC") = "존재하지 않는 단품코드";              // 오류내용
 			
 
 		}else {
 			
             var intSkuInfoCount = DS_O_SKU_INFO.CountRow;
             for(var j=1; j <= intSkuInfoCount; j++){
 
 				if(   DS_O_SKU.NameValue(i, "STYLE_CD") != DS_O_SKU_INFO.NameValue(j, "STYLE_CD")){
 					DS_O_SKU.NameValue(i, "ERR_YN")         = "Y";                                        // 오류여부
 		            DS_O_SKU.NameValue(i, "ERR_DESC")       = "단품코드에 맞는 스타일이 아님";                // 오류내용
 				}else if(DS_O_SKU.NameValue(i, "COLOR_CD") != DS_O_SKU_INFO.NameValue(j, "COLOR_CD")
 						 || DS_O_SKU.NameValue(i, "SIZE_CD") != DS_O_SKU_INFO.NameValue(j, "SIZE_CD")){
                     DS_O_SKU.NameValue(i, "ERR_YN")         = "Y";                                        // 오류여부
                     DS_O_SKU.NameValue(i, "ERR_DESC")       = "단품코드에 맞는 칼라,사이즈가 아님";           // 오류내용
                 }else if(DS_O_SKU.NameValue(i, "COLOR_CD") != DS_O_SKU_INFO.NameValue(j, "COLOR_CD")){
 					DS_O_SKU.NameValue(i, "ERR_YN")         = "Y";                                        // 오류여부
                     DS_O_SKU.NameValue(i, "ERR_DESC")       = "단품코드에 맞는 칼라가 아님";                  // 오류내용
 				}else if(DS_O_SKU.NameValue(i, "SIZE_CD")  != DS_O_SKU_INFO.NameValue(j, "SIZE_CD")){
 					DS_O_SKU.NameValue(i, "ERR_YN")         = "Y";                                        // 오류여부
                     DS_O_SKU.NameValue(i, "ERR_DESC")       = "단품코드에 맞는 사이즈가 아님";                // 오류내용
                 }else{
 					DS_O_SKU.NameValue(i, "ERR_YN")         = "N";                                        // 오류여부
 		            DS_O_SKU.NameValue(i, "ERR_DESC")       = "정상";                                     // 오류내용
 				}
 
 				DS_O_SKU.NameValue(i, "SKU_NM")       = DS_O_SKU_INFO.NameValue(j, "SKU_NAME");
 				DS_O_SKU.NameValue(i, "SALE_UNIT_CD") = DS_O_SKU_INFO.NameValue(j, "SALE_UNIT_CD");
 				DS_O_SKU.NameValue(i, "SALE_UNIT_NM") = DS_O_SKU_INFO.NameValue(j, "SALE_UNIT_NM");
 				
 				// 중복체크
 	            checkDup(DS_O_SKU, "SKU_CD");
 				
             }
          
 		}
 	}
 }


 /**
 * checkDup
 * 작 성 자 : 김경은
 * 작 성 일 : 2010-02-24
 * 개    요 : dataSet, Keys("||" delimiter)로 중복체크를 한다.
 *           
 */
 function checkDup (gauceDataSet, strKeys) {
   var strKey = strKeys.split("||");
   var intChk;
   for (var i=1, n=gauceDataSet.CountRow; i<n; i++) {
     for (var j=i+1, m=gauceDataSet.CountRow; j<=m; j++) {
       intChk = 0;
       for (var k = 0, o=strKey.length; k<o; k++) {
         if(gauceDataSet.RowLevel(i) == 0){
           if ((gauceDataSet.NameValue(i, strKey[k]) == gauceDataSet.NameValue(j, strKey[k])) &&
               (gauceDataSet.NameValue(i, strKey[k]) != "" )) {
         	   if(DS_O_SKU.NameValue(j, "ERR_YN") == "N"){ // 정상브랜드일 경우에만 중복체크한다.
	        	   DS_O_SKU.NameValue(j, "ERR_YN")         = "Y";                                        // 오류여부
	               DS_O_SKU.NameValue(j, "ERR_DESC")       = "중복된 단품코드";                           // 오류내용
         	   }
           }
         }
       }
     }
   }
 }
 

  
 /**
  * btn_DeleteRow()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-02-24
  * 개    요        : 선택된 단품을 삭제한다.
  * return값 : void
  */
 function btn_DeleteRow(){
 	var intRowCount =  DS_O_SKU.CountRow;
 	for(var i=intRowCount; i >= 1; i--){
 		if(DS_O_SKU.NameValue(i, "SEL") == 'T'){
 			DS_O_SKU.DeleteRow(i);
 		}
 	}
 	//그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('SEL','HeadCheck')= "false";
 	checkValidation();
 }
 
 /**
  * btn_Apply()
  * 작 성 자     : 김경은
  * 작 성 일     : 2010-02-24
  * 개    요        : 선택된 단품을 적용한다.
  * return값 : void
  */
 function btn_Apply(){
     var selCount = 0;
     for(var i = 1; i <= DS_O_SKU.CountRow; i++){
     	var strErrYN = DS_O_SKU.NameValue(i, "ERR_YN");
         var strSel   = DS_O_SKU.NameValue(i, "SEL");
         if(strSel == "T"){
         	if(strErrYN == "Y"){
 	            showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 단품에 오류가 있습니다.");
 	            DS_O_SKU.RowPosition = i;
 	            //GD_EXCEL_DATA.SetColumn("SKU_CD");
 	            //GD_EXCEL_DATA.Focus(); 
 	            return;
         	}
         	selCount++;
         }
     }
     
     if(selCount <= 0){
     	showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 단품내역이 없습니다.");
     	return;
     }
     	
 	window.returnValue = DS_O_SKU.ExportData(1,DS_O_SKU.CountRow, true );
     //그리드 CHEKCBOX헤더 체크해제
     GD_EXCEL_DATA.ColumnProp('SEL','HeadCheck')= "false";
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
        	DS_O_SKU.NameValue(i, "SEL") = 'T';
        }
    }else{  // 전체체크해제
        for (var i=1; i<=DS_O_SKU.CountRow; i++){
        	DS_O_SKU.NameValue(i, "SEL") = 'F';
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

<!-- =============== Output용 -->
<comment id="_NSID_"><object id=DS_O_RESULT     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id=DS_O_SKU        classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SKU_INFO"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

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
              <SPAN id="title1" class="PL03">단품 엑셀 업로드 </SPAN>
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
				        <td width="75" align="center"><a
		                    href="/dps/samplefiles/SKU_UPLOAD(Sample).xls"> <img
		                    style="vertical-align: middle;"
		                    src="/<%=dir%>/imgs/btn/excel_down.gif" width="82" height="18" /></a>
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
