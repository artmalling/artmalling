<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기초자료> 계정별비용계획관리
 * 작 성 일 : 2011.05.23
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0261.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 엑셀 업로드
 * 이    력 :
 *        2011.05.23 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.*" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir      = BaseProperty.get("context.common.dir");
    String strStrCd = String2.trimToEmpty(request.getParameter("strStrCd"));
    String strPlanY = String2.trimToEmpty(request.getParameter("strPlanY"));
%>
<html>
<head>
<title>계정별비용계획관리 EXCEL UPLOAD</title>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"     type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js"    type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js"   type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                                    *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    DS_EXCEL.setDataHeader('<gauce:dataset name="H_BIZ_UPLOAD"/>');
    DS_EXCEL_TEMP.setDataHeader('<gauce:dataset name="H_EXCEL_TEMP"/>');
    
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();

    //그리드 초기화
    gridCreate();
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0261","DS_ACC_PLAN" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-05-23
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	 initEmEdit(EM_FILS_LOC, "GEN^300^0", READ); //EXCEL경로
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
	var hdrProperies = '<C>id={currow}   width=30  align=center name="NO"</C>'
                     + '<C>id=CHECK_FLAG width=20  align=center name="" EditStyle=checkbox HeadCheck=false HeadCheckShow=true</C>'
                     + '<C>id=STR_CD     width=50  align=center name="점코드" edit="None"</C>'
                     + '<C>id=STR_NM     width=70  align=left   name="점명" edit="None" </C>'
                     + '<C>id=ACC_CD     width=70  align=center name="계정항목" edit="None"</C>'
                     + '<C>id=ACC_NM     width=95  align=left   name="항목명" edit="None" </C>'
                     + '<C>id=ORG_CD     width=85  align=center name="조직코드" edit="None"</C>'
                     + '<C>id=ORG_NM     width=95  align=left   name="조직명" edit="None" </C>'
                     + '<C>id=PLAN_YM    width=60  align=center name="년월" edit="None" mask="XXXX/XX"</C>'
                     + '<C>id=AMT        width=80  align=right  name="금액" edit="None" </C>'
                     + '<C>id=ETC        width=205 align=left   name="오류내용" edit="None" </C>'
                     ;
        
    initGridStyle(GD_EXCEL, "common", hdrProperies, true);
}
/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * btn_DeleteRow()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개       요  : 선택된 항목 삭제한다.
 * return값 : void
 */
function btn_DeleteRow(){
    var intRowCount =  DS_ACC_PLAN.CountRow;
    for(var i=intRowCount; i >= 1; i--){
    	if(DS_ACC_PLAN.NameValue(i, "CHECK_FLAG") == 'T') DS_ACC_PLAN.DeleteRow(i);
    }
    
    //그리드 CHEKCBOX헤더 체크해제
    GD_EXCEL.ColumnProp('SEL','HeadCheck')= "false";
}

/**
 * btn_Apply()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개       요 : 선택된 항목을 적용한다.
 * return값 : void
 */
function btn_Apply(){
	if (DS_ACC_PLAN.NameValueRow("CHECK_FLAG","T") == 0){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
	
    for(var i = 1; i <= DS_ACC_PLAN.CountRow; i++){
    	if(DS_ACC_PLAN.NameValue( i, "CHECK_FLAG") == "T"){
    		if(DS_ACC_PLAN.NameValue( i, "ETC") != ""){
    			showMessage(INFORMATION, OK, "GAUCE-1000", "선택된 항목에 오류가 있습니다.");
    			setFocusGrid(GD_EXCEL,DS_ACC_PLAN, i, "ETC");
    			return;
    		}
    	}
    }
    
    TR_MAIN.Action   = "/mss/meis026.me?goTo=uploadExcel";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_ACC_PLAN=DS_ACC_PLAN)"; 
    TR_MAIN.Post();
    
    if( TR_MAIN.ErrorCode == 0){
    	window.returnValue = "1";
    	window.close();
    }
}

/**
 * loadExcelData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {
    INF_EXCELUPLOAD.Open();
    
    if (!INF_EXCELUPLOAD.SelectState) return;
    
    //loadExcelData 옵션처리
    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
    if (strExcelFileName == "''") return;
    
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
    
    DS_EXCEL_TEMP.ClearData();
    DS_ACC_PLAN.ClearData();
    //Excel파일 DateSet에 저장               
    DS_EXCEL_TEMP.Do("Excel.Application", strOption);
    DS_EXCEL_TEMP.SortExpr = "+ORG_CD";
    DS_EXCEL_TEMP.Sort();
    
    var row;
    for(var i=1; i<=DS_EXCEL_TEMP.CountRow; i++){
    	for(var y=1 ; y<=12; y++){
            DS_EXCEL.AddRow();
            row = DS_EXCEL.CountRow;
            DS_EXCEL.NameValue(row, "STR_CD")  = "<%=strStrCd%>";
            DS_EXCEL.NameValue(row, "ACC_CD")  = DS_EXCEL_TEMP.NameValue(i, "ACC_CD");
            DS_EXCEL.NameValue(row, "ORG_CD")  = DS_EXCEL_TEMP.NameValue(i, "ORG_CD");
            DS_EXCEL.NameValue(row, "PLAN_YM") = "<%=strPlanY%>" + lpad(""+y, 2, "0");
            DS_EXCEL.NameValue(row, "AMT")     = DS_EXCEL_TEMP.NameValue(i, ""+y);
    	}
    }

    //Excel에서 가져온 데이터의 정합성 체크를 한다.
    checkValidation();
}

/**
 * checkValidation()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-23
 * 개    요 : Excel에서 가져온 데이터의 정합성 체크를 한다.
 * return값 :
 */
function checkValidation() {
	TR_MAIN.Action   = "/mss/meis026.me?goTo=checkValidation";  
    TR_MAIN.KeyValue = "SERVLET(O:DS_ACC_PLAN=DS_ACC_PLAN,I:DS_EXCEL=DS_EXCEL)"; 
    TR_MAIN.Post();
}
-->
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                                         *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                                         *-->
<!--*    1. TR Success 메세지 처리
<!--*    2. TR Fail 메세지 처리
<!--*    3. DataSet Success 메세지 처리
<!--*    4. DataSet Fail 메세지 처리
<!--*    5. DataSet 이벤트 처리
<!--*    6. 컴포넌트 이벤트 처리
<!--*************************************************************************-->
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<!----------------------- 2. TR Fail 메세지 처리  ----------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->

<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->

<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<!--헤더 체크시 일괄체크 처리-->
<script language="javascript"  for=GD_EXCEL event=OnHeadCheckClick(col,colid,bCheck)>
    this.ReDraw = "false";    // 그리드 전체 draw 를 false 로 지정
    if (bCheck == '1'){       // 전체체크
        for(var i=1; i<=DS_ACC_PLAN.CountRow; i++) DS_ACC_PLAN.NameString(i, colid) = 'T';
    }else{                    // 전체체크해제
        for(var i=1; i<=DS_ACC_PLAN.CountRow; i++) DS_ACC_PLAN.NameString(i, colid) = 'F';
    }
    this.ReDraw = "true";       
</script>
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                                                                                                                   *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                                                                              *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->
<comment id="_NSID_">
<!-- ====================Output용================== -->
    <object id="DS_EXCEL"       classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_EXCEL_TEMP"  classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_ACC_PLAN"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]계정/예산항목 구분코드 -->
    <object id="DS_ACC_FLAG"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]항목레벨 -->
    <object id="DS_BIZ_LVL"   classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]보고서사용 -->
    <object id="DS_RPT_YN"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]사용여부 -->
    <object id="DS_USE_YN"    classid=<%= Util.CLSID_DATASET %>></object>
<!-- ====================Input용================== -->

<!-- ===========gauce.js 공통함수 호출용=========== -->
    <object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
    <object id="DS_I_COMMON"    classid=<%= Util.CLSID_DATASET %>></object>
</comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
    <!-- ===========gauce.js 공통함수 호출용=========== -->
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
            <td width="" class="title">
              <img src="/<%=dir%>/imgs/comm/title_head.gif" width="15" height="13" align="absmiddle" class="popR05 PL03"/>
              <SPAN id="title1" class="PL03">계정별비용계획관리 엑셀 업로드 </SPAN>
            </td>
            <td align="right">
              <img src="/<%=dir%>/imgs/btn/del.gif"   onclick="javascript:btn_DeleteRow();" align="absmiddle" hspace="2"  />
              <img src="/<%=dir%>/imgs/btn/apply.gif" onclick="javascript:btn_Apply();"     align="absmiddle"/>
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
                        <td width="650">
                          <comment id="_NSID_">
                            <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width="585" align="absmiddle"></object>
                          </comment><script>_ws_(_NSID_);</script>
                          <img src="/<%=dir%>/imgs/btn/file_search.gif" onclick="loadExcelData();" align="absmiddle"/>
                        </td>
                        <td width="75" align="center">
                          <a href="/mss/samplefiles/ME_ACCPLAN_UPLOAD.xls">
                            <img src="/<%=dir%>/imgs/btn/excel_down.gif" width="82" height="18" align="absmiddle"/>
                          </a>
                        </td>   
                     </tr>
                   </table>
                </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr><td class="dot"></td></tr>
      <tr>
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0"  class="BD4A">      
          <tr>
            <td>
              <!-- 마스터 -->
              <comment id="_NSID_">
                <OBJECT id=GD_EXCEL height="275px" width="100%" classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_ACC_PLAN">
                </OBJECT>
              </comment><script>_ws_(_NSID_);</script>
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
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%> width="0" height="0">
    <param name="Text"              value='FileOpen'>
    <param name="FileFilterString"  value="16">
    <param name="Enable"            value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>
