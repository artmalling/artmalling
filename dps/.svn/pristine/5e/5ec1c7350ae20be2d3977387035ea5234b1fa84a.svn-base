<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 행사코드> 점별행사장관리
 * 작 성 일 : 2010.02.09
 * 작 성 자 : 이재득
 * 수 정 자 : 
 * 파 일 명 : pcod7020.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 행사장정보를 관리한다
 * 이    력 :
 *        2010.02.09 (이재득) 작성
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
<script language="javascript" src="/<%=dir%>/js/common.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js"
	type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">


/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    //그리드 초기화
    gridCreate1(); //마스터
    
    // EMedit에 초기화( gauce.js )

    //콤보 초기화
    initComboStyle(LC_O_STR_CD,DS_O_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)   
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_O_FLOR_CD", "D", "P061", "Y");
    
    //콤보에 전체표시를 공백으로 표시
    if(DS_O_FLOR_CD.NameValue(1 , "CODE") == "%"){        
        DS_O_FLOR_CD.NameValue(1 , "CODE") = "";
        DS_O_FLOR_CD.NameValue(1 , "NAME") = "";       
    }

    //점콤보 가져오기 ( gauce.js )     
    getStore("DS_O_STR_CD", "N", "1", "N");
    getStore("DS_I_STR_CD", "N", "1", "N");
    
    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_O_STR_CD, "01"); 
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("pcod702","DS_IO_MASTER" );
    
    LC_O_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            name="NO"           width=30    align=center    edit="none"</FC>'
                     + '<FC>id=STR_CD              name="*점"           width=80    align=left    edit={IF(EVENT_PLACE_CD="","true","false")}   EditStyle=Lookup   Data="DS_I_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=EVENT_PLACE_CD      name="행사장코드"    width=90   align=center    edit="none"</FC>'
                     + '<FC>id=EVENT_PLACE_NAME    name="*행사장명 "     width=184  align=left</FC>'
                     + '<FC>id=EVENT_POSITION      name="행사장위치 "   width=180   align=left</FC>'
                     + '<FC>id=AREA_SIZE           name="면적"         width=70    align=right</FC>'
                     + '<FC>id=FLOR_CD             name="층"           width=70    align=left    EditStyle=Lookup    Data="DS_O_FLOR_CD:CODE:NAME"</FC>'
                     + '<FC>id=USE_YN              name="*사용여부"     width=80    align=left    EditStyle=Combo    Data="Y:YES,N:NO"</FC>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
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
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_IO_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하세겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1084") != 1 ){           
            GD_MASTER.Focus();
            return;
        }
    }
    DS_IO_MASTER.ClearData();

    var strStrCd   = LC_O_STR_CD.BindColVal;
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd);
    
    TR_MAIN.Action="/dps/pcod702.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT", GD_MASTER);
}

/**
 * btn_New()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-10
 * 개    요 : DB에 저장 / 수정 
 * return값 : void
*/
function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }    
    
    for( var i = 1 ; i <= DS_IO_MASTER.CountRow; i++){
        if( DS_IO_MASTER.NameValue( i, "EVENT_PLACE_NAME") == "" ){
            showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "행사장명");            
            DS_IO_MASTER.NameValue(i, "EVENT_PLACE_NAME")    = "";
            GD_MASTER.SetColumn("EVENT_PLACE_NAME");            
            DS_IO_MASTER.RowPosition = i; 
            GD_MASTER.SetColumn("EVENT_PLACE_NAME");
            GD_MASTER.Focus();
            return false;
        }
        if(DS_IO_MASTER.NameValue( i, "STR_CD") == ""){
        	showMessage(EXCLAMATION, Ok,  "GAUCE-1005", "점"); 
        	setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"STR_CD");
        	return false;
        }
        
        if( DS_IO_MASTER.NameValue( i, "USE_YN") == "") {
            // ()은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "GAUCE-1005", "사용여부");
            setFocusGrid(GD_MASTER,DS_IO_MASTER,DS_IO_MASTER.RowPosition,"USE_YN");
            return;
        }  
    }
    for(var i = 1 ; i <= DS_IO_MASTER.CountRow; i++){
    	if( !checkInputByte( GD_MASTER, DS_IO_MASTER, i, 'EVENT_PLACE_NAME', '행사장명',  null, 40))
            return;
        
        if( !checkInputByte( GD_MASTER, DS_IO_MASTER, i, 'EVENT_POSITION', '행사장위치',  null, 40))
            return;
        
        if( DS_IO_MASTER.NameValue( i, "AREA_SIZE") < 0 ){
        	showMessage(EXCLAMATION , Ok,  "USER-1008", "면적", "0");
        	DS_IO_MASTER.NameValue( i, "AREA_SIZE") = DS_IO_MASTER.OrgNameValue( i, "AREA_SIZE");
        	setFocusGrid(GD_MASTER,DS_IO_MASTER,i,"AREA_SIZE");
        	return;
        }
    }    

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    TR_MAIN.Action="/dps/pcod702.pc?goTo=save";
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    btn_Search();
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-09
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

/**
 * btn_Add1()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-10
 * 개    요 : 그리드 Row추가 
 * return값 : void
*/
function btn_Add1(){
   if( LC_O_STR_CD.BindColVal == '') {
       // ()은/는 반드시 입력해야 합니다.
       showMessage(EXCLAMATION, OK, "USER-1003", "점");
       LC_O_STR_CD.Focus();
       return;
   }
   
   DS_IO_MASTER.Addrow(); 
   DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") = LC_O_STR_CD.BindColVal;
   DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "USE_YN") = "Y";
   setFocusGrid(GD_MASTER,DS_IO_MASTER, DS_IO_MASTER.RowPosition ,"STR_CD");  
}

/**
 * btn_Del1()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-02-10
 * 개    요 : 그리드 Row 삭제 
 * return값 : void
*/
function btn_Del1(){
   var row = DS_IO_MASTER.RowPosition;
   if( DS_IO_MASTER.RowStatus(row) == "1")
	   DS_IO_MASTER.DeleteRow(row);
   else
       showMessage(INFORMATION, OK, "USER-1052");
   
   GD_MASTER.Focus();
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
    trFailed(TR_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER
	event=OnDataError(row,colid)>
var colName = GD_MASTER.GetHdrDispName(-3, colid);
if( this.ErrorCode == "50018" ) {
    showMessage(EXCLAMATION, OK, "GAUCE-1005", colName);
} else if ( this.ErrorCode == "50019") {
    showMessage(EXCLAMATION, OK, "GAUCE-1007", row);
} else {
    showMessage(EXCLAMATION, OK, "USER-1000", this.ErrorMsg);
}
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

    sortColId( eval(this.DataID), row, colid);
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
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_FLOR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_STR_CD" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15">
<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->
<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td class="PT01 PB03">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="o_table">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td><comment id="_NSID_"> <object id=LC_O_STR_CD
							classid=<%= Util.CLSID_LUXECOMBO %> width=140 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td class="dot"></td>
	</tr>
	<tr>
		<td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/add_row.gif"
			onclick="javascript:btn_Add1();" hspace="2" /> <img
			src="/<%=dir%>/imgs/btn/del_row.gif" onclick="javascript:btn_Del1();" /></td>
		</td>
	</tr>
	<tr>
		<td class="PT05">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="BD4A">
			<tr>
				<td><comment id="_NSID_"><object id=GD_MASTER
					width="100%" height=480 classid=<%=Util.CLSID_GRID%>>
					<param name="DataID" value="DS_IO_MASTER">
				</object></comment><script>_ws_(_NSID_);</script></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

</body>
</html>

