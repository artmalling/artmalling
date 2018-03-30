<!-- 
/*******************************************************************************
 * 시스템명 : 경영실적 > 기준정보> 경영실적 배부 기준안 관리
 * 작 성 일 : 2011.05.17
 * 작 성 자 : 이정식
 * 수 정 자 : 
 * 파 일 명 : meis0050.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 경영실적 1,2,차 배부 기준안을 등록 관리한다.
 * 이    력 :
 *        2011.05.17 (이정식) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
                                                                       common.vo.SessionInfo,
                                                                       kr.fujitsu.ffw.base.BaseProperty,
                                                                       kr.fujitsu.ffw.util.Date2" %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button" %>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                               *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%    
    String dir        = BaseProperty.get("context.common.dir");
    String strYm      = Date2.addMonth(-1);
%>
<html>
<head>
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
var btnSaveClick = false;
var lo_DivYm     = "";
var lo_IsMasterLoaded; //마스터 그리드가 로딩되었는지 판단
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
function doInit(){
    //Input Data Set Header 초기화
    
    //Output Data Set Header 초기화
    DS_DIV.setDataHeader('<gauce:dataset name="H_SEL_DIV_CD_LIST"/>');
    //EMEDIT 설정
    setEmEdit();

    //콤보 초기화
    setCombo();
    
    //그리드 초기화
    gridCreate();
    enableControl(IMG_PRE1,false);
    enableControl(IMG_PRE2,false);
    
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("meis0050","DS_DIV,DS_DIV1,DS_DIV2,DS_DIV3" );
}

/**
 * setEmEdit()
 * 작 성 자 : 이정식
 * 작 성 일 :  2011-05-17
 * 개    요 : EMEDIT 설정 
 * return값 : void
 */
function setEmEdit(){
	initEmEdit(EM_DIV_YM, "THISMN", PK); //배부기준년월	 
	EM_DIV_YM.text = "<%=strYm%>";
	lo_DivYm = EM_DIV_YM.text;
}

/**
 * setCombo()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 콤보 설정 
 * return값 : void
 */
function setCombo(){
	 getDivMst(DS_DIV_CD, "N"); //배부기준콤보 데이터가져오기 ( gauce.js )
}

/**
 * gridCreate()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 그리드 초기화 
 * return값 : void
 */
function gridCreate(){
    var hdrProperies = '<C>id={currow}  width=30  align=center name="NO"</C>'
                     + '<C>id=DIV_CD    width=90 align=center name="배부기준코드" EditStyle=Lookup data="DS_DIV_CD:CODE:NAME"</C>'
                     ;

    initGridStyle(GD_DIV, "common", hdrProperies, true);

    var hdrProperies1 = '<C>id={currow}      width=30  align=center name="NO"</C>'
                      + '<C>id=CODE          width=50  align=center name="점코드" edit="None"</C>'
                      + '<C>id=NAME          width=80 align=left   name="점명" edit="None" SumText="합계"</C>'
                      ;
         
    var hdrProperies2 = '<C>id={currow}      width=30  align=center name="NO"</C>'
                      + '<C>id=CODE          width=50  align=center name="파트코드" edit="None"</C>'
                      + '<C>id=NAME          width=80 align=left   name="파트명" edit="None" SumText="합계"</C>'
                      ;
             
    var hdrProperies3 = '<C>id={currow}      width=30  align=center name="NO"</C>'
                      + '<C>id=CODE          width=50  align=center name="PC코드" edit="None"</C>'
                      + '<C>id=NAME          width=80 align=left   name="PC명" edit="None" SumText="합계"</C>'
                      ;
                 
    var hdrProperies0 = '<C>id=PRE_DIV_RATE  width=70  align=right  name="전년배부율" edit="None" SumText=@sum</C>'
                      + '<C>id=SALE_AMT      width=80  align=right  name="전년매출액" edit="None" SumText=@sum</C>'
                      + '<C>id=PRE_PROP      width=47  align=right  name="구성비" edit="None" value={Round(SALE_AMT/sum(SALE_AMT)*100,0)} SumText={sum(SALE_AMT)/decode(sum(SALE_AMT),0,1,sum(SALE_AMT))*100}</C>'
                      + '<C>id=SALE_PROF_AMT width=95  align=right  name="전년매출이익액" edit="None" SumText=@sum</C>'
                      + '<C>id=PROP          width=47  align=right  name="구성비" edit="None" value={Round(SALE_PROF_AMT/sum(SALE_PROF_AMT)*100,0)} SumText={sum(SALE_PROF_AMT)/decode(sum(SALE_PROF_AMT),0,1,sum(SALE_PROF_AMT))*100}</C>'
                      + '<C>id=AREA_SIZE 	 width=65  align=right  name="면적(㎡)" edit="None" SumText=@sum</C>'
                      + '<C>id=PROP          width=47  align=right  name="구성비" edit="None" value={Round(AREA_SIZE/sum(AREA_SIZE)*100,0)} SumText={sum(AREA_SIZE)/decode(sum(AREA_SIZE),0,1,sum(AREA_SIZE))*100}</C>'                      
                      + '<C>id=DIV_RATE      width=65  align=right  name="배부율" edit="Numeric" SumText=@sum</C>'
                      ;                              

    initGridStyle(GD_DIV1, "common", hdrProperies1 + hdrProperies0, true);
    GD_DIV1.ViewSummary = "1";

    initGridStyle(GD_DIV2, "common", hdrProperies2 + hdrProperies0, true);
    GD_DIV2.ViewSummary = "1";

    initGridStyle(GD_DIV3, "common", hdrProperies3 + hdrProperies0, true);
    GD_DIV3.ViewSummary = "1";
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
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if( DS_DIV.IsUpdated || DS_DIV1.IsUpdated || DS_DIV2.IsUpdated || DS_DIV3.IsUpdated){
        //변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1){
            EM_DIV_YM.Focus();
            return false;
        }
    }
	
	//1. validation
    if (isNull(EM_DIV_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1003", "배부기준년월"); //(배부기준년월)은/는 반드시 입력해야 합니다.
        EM_DIV_YM.focus();
        return;
    }
    if (!checkYYYYMM(EM_DIV_YM.text)){
        showMessage(EXCLAMATION, OK, "USER-1061", "배부기준년월");//(배부기준년월)은/는 유효하지 않는 날짜입니다.
        EM_DIV_YM.focus();
        return;
    }
    
    //2. 데이터셋 초기화
    DS_DIV.ClearData();
    DS_DIV1.ClearData();
    DS_DIV2.ClearData();
    DS_DIV3.ClearData();
    
    lo_DivYm = EM_DIV_YM.text;
    //3. 조회시작
    lo_IsMasterLoaded = 0;
    var goTo       = "searchDivCdList";
    var action     = "O";
    var parameters = "&strDivYM=" + EM_DIV_YM.text; //배부기준년월
    DS_DIV.DataID  = "/mss/meis005.me?goTo="+goTo+parameters;
    DS_DIV.SyncLoad = "true";
    DS_DIV.Reset();
}

/**
 * subQuery()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 1차배분안 정보 조회
 * return값 : void
 */
function subQuery(row){
	if(DS_DIV.NameValue(row, "DIV_CD") != ""){
		//2. 데이터셋 초기화
	    DS_DIV1.ClearData();
	    DS_DIV2.ClearData();
	    DS_DIV3.ClearData();
	    
	    //3. 조회시작
	    var goTo       = "searchDiv1";
	    var action     = "O";
	    var parameters = "&strDivCd=" + DS_DIV.NameValue(row, "DIV_CD") //배부기준코드
	    	           + "&strDivYM=" + lo_DivYm;                       //배부기준년월
	    DS_DIV1.DataID = "/mss/meis005.me?goTo="+goTo+parameters;
	    DS_DIV1.SyncLoad = "true";
	    DS_DIV1.Reset();
	}
}

/**
 * subQuery1()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 2차배분안 정보 조회
 * return값 : void
 */
function subQuery1(row){
	//2. 데이터셋 초기화
    DS_DIV2.ClearData();
    DS_DIV3.ClearData();
    
    //3. 조회시작
    var goTo       = "searchDiv2";
    var action     = "O";
    var parameters = "&strDivCd=" + DS_DIV1.NameValue(row, "DIV_CD")  //배부기준코드
                   + "&strDivYM=" + DS_DIV1.NameValue(row, "DIV_YM")  //배부기준년월
                   + "&strStrCd=" + DS_DIV1.NameValue(row, "CODE");   //점코드
    DS_DIV2.DataID = "/mss/meis005.me?goTo="+goTo+parameters;
    DS_DIV2.SyncLoad = "true";
    DS_DIV2.Reset();
}

/**
 * subQuery2()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 3차배분안 정보 조회
 * return값 : void
 */
function subQuery2(row){
    //2. 데이터셋 초기화
    DS_DIV3.ClearData();
    
    //3. 조회시작
    var goTo       = "searchDiv3";
    var action     = "O";
    var parameters = "&strDivCd="  + DS_DIV1.NameValue(row, "DIV_CD")  //배부기준코드
                   + "&strDivYM="  + DS_DIV1.NameValue(row, "DIV_YM")  //배부기준년월
                   + "&strOrgCd="  + DS_DIV1.NameValue(row, "CODE");   //점코드
    DS_DIV3.DataID = "/mss/meis005.me?goTo="+goTo+parameters;
    DS_DIV3.SyncLoad = "true";
    DS_DIV3.Reset();
}

/**
 * btn_New()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    DS_DIV.AddRow();
    var row   = DS_DIV.CountRow;
    DS_DIV.NameValue(row, "DIV_YM") = lo_DivYm;
    DS_DIV1.ClearData();
    DS_DIV2.ClearData();
    DS_DIV3.ClearData();
    setFocusGrid(GD_DIV,DS_DIV, row, "DIV_CD");
}

/**
 * btn_Delete()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if( !DS_DIV1.IsUpdated && !DS_DIV2.IsUpdated && !DS_DIV3.IsUpdated){
        //저장할 내용이 없습니다.
        showMessage(INFORMATION, OK, "USER-1028");
        
        if( DS_DIV.CountRow > 0)
        	GD_DIV.Focus();
        else
        	EM_DIV_YM.Focus();
        
        return;
    }
	
	
    //배부기준코드 체크
    if(DS_DIV.IsUpdated){
        var row = DS_DIV.CountRow;
        
        if(DS_DIV.NameValue(row, "DIV_CD") == ""){
            showMessage(EXCLAMATION, OK, "USER-1002", "배분기준코드"); //(배분기준코드)은/는 반드시 선택해야 합니다.
            setFocusGrid(GD_DIV,DS_DIV, row, "DIV_CD");
        	return;
        }
        
        var sameRow = DS_DIV.NameValueRow("DIV_CD", DS_DIV.NameValue(row, "DIV_CD"));
        if(sameRow != 0 && sameRow!= row){
        	showMessage(EXCLAMATION, OK, "USER-1044");
            return;
        }
        
        if(!DS_DIV1.IsUpdated){
        	showMessage(EXCLAMATION, OK, "USER-1000", "1차배분기준안 정보를 입력해야합니다.");
        	GD_DIV.Focus();
        	return;
        }
    }
    
    //1차배분기준코드
    for(var i = 1; i<= DS_DIV1.CountRow ; i++){
    	if(DS_DIV1.RowStatus(i) == "3"){
    		if(DS_DIV1.NameValue(i, "DIV_RATE") < 0 || DS_DIV1.NameValue(i, "DIV_RATE") > 100){
    			showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
    			setFocusGrid(GD_DIV1,DS_DIV1, i, "DIV_RATE");
                return;
    		}
    	}
    }
    
    if(!(GD_DIV1.SummaryString('DIV_RATE', 1) == 0 || GD_DIV1.SummaryString('DIV_RATE', 1) == 100)){
        showMessage(EXCLAMATION, OK, "USER-1000", "배부율의 합은 100입니다.");
        GD_DIV1.Focus();
        return;
    }
    
    //2차배분기준코드
    for(var i = 1; i<= DS_DIV2.CountRow ; i++){
        if(DS_DIV2.RowStatus(i) == "3"){
            if(DS_DIV2.NameValue(i, "DIV_RATE") < 0 || DS_DIV2.NameValue(i, "DIV_RATE") > 100){
                showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
                setFocusGrid(GD_DIV2,DS_DIV2, i, "DIV_RATE");
                return;
            }
        }
    }
    
    if(!(GD_DIV2.SummaryString('DIV_RATE', 1) == 0 || GD_DIV2.SummaryString('DIV_RATE', 1) == 100)){
        showMessage(EXCLAMATION, OK, "USER-1000", "배부율의 합은 100입니다.");
        GD_DIV2.Focus();
        return;
    }
    
    //3차배분기준코드
    for(var i = 1; i<= DS_DIV3.CountRow ; i++){
        if(DS_DIV3.RowStatus(i) == "3"){
            if(DS_DIV3.NameValue(i, "DIV_RATE") < 0 || DS_DIV3.NameValue(i, "DIV_RATE") > 100){
                showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
                setFocusGrid(GD_DIV3,DS_DIV3, i, "DIV_RATE");
                return;
            }
        }
    }
    
    if(!(GD_DIV3.SummaryString('DIV_RATE', 1) == 0 || GD_DIV3.SummaryString('DIV_RATE', 1) == 100)){
        showMessage(EXCLAMATION, OK, "USER-1000", "배부율의 합은 100입니다.");
        GD_DIV3.Focus();
        return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	EM_DIV_YM.Focus();
        return;
    }
    
    btnSaveClick     = true;
    
    TR_MAIN.Action   = "/mss/meis005.me?goTo=save";  
    TR_MAIN.KeyValue = "SERVLET(I:DS_DIV1=DS_DIV1,I:DS_DIV2=DS_DIV2,I:DS_DIV3=DS_DIV3,I:DS_DIV=DS_DIV)"; 
    TR_MAIN.Post();
    
    btnSaveClick     = false;

    //정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	var row  = DS_DIV.RowPosition;
        var row1 = DS_DIV1.RowPosition;
        var row2 = DS_DIV2.RowPosition;
        
        btn_Search();
        
        if(row != 0 )  setTimeout("DS_DIV.RowPosition  = " + row,  40);
        if(row1 != 0 ) setTimeout("DS_DIV1.RowPosition = " + row1, 60);
        if(row2 != 0 ) setTimeout("DS_DIV2.RowPosition = " + row2, 80);
    }
    
    EM_DIV_YM.Focus();
}

/**
 * btn_Excel()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
}

/**
 * btn_Conf()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 : 확정 처리
 * return값 : void
 */
function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
/**
 * getPreData()
 * 작 성 자 : 이정식
 * 작 성 일 : 2011-05-17
 * 개    요 :  전월배부기준 COPY
 * return값 : void
 */
function getPreData(flag){
	var goTo         = "getPreData";
    var action       = "O";
    var obj          = null;
    var obj2         = null;
    var strLvl       = null;
    if(flag ==1){
    	obj    = DS_DIV;
    	obj2   = DS_DIV1;
    	strLvl = "1";
    	
    } else {
    	obj    = DS_DIV1;
    	obj2   = DS_DIV2;
    	strLvl = "2";
    }
    var preDate = addDate("M", -1, obj.NameValue(row, "DIV_YM")+"01", "");
    var msg     = preDate.substr(0,4) + "년 " + preDate.substr(4,2) + "월의<br>" + strLvl + "차";
    //XXXX년 XX월의 X차 배부기준안을 복사하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1185", msg) != 1 ){
        return;
    }
    var row        = obj.RowPosition;
    var parameters = "&strDivCd=" + obj.NameValue(row, "DIV_CD")  //배부기준코드
                   + "&strDivYM=" + obj.NameValue(row, "DIV_YM")  //배부기준년월
                   + "&strCode="  + obj.NameValue(row, "CODE")
                   + "&strLvl="   + strLvl                        //배부기준차수구분
                   ;
    
    DS_COPY.DataID   = "/mss/meis005.me?goTo="+goTo+parameters;
    DS_COPY.SyncLoad = "true";
    DS_COPY.Reset();
    
    if(DS_COPY.CountRow ==0){
    	showMessage(INFORMATION, OK, "USER-1000", "전월 데이터가 존재하지 않습니다.");
    } else {
    	for(var i = 1 ; i <= obj2.CountRow ; i++){
    		obj2.NameValue(i, "DIV_RATE") = 0;
    	}
    	var cnt = 0 ;
    	for(var i = 1 ; i <= DS_COPY.CountRow ; i++){
    		var row = obj2.NameValueRow("ORG_CD", DS_COPY.NameValue(i, "ORG_CD"));
    		if(row != 0){
    			obj2.NameValue(row, "DIV_RATE") = DS_COPY.NameValue(i, "DIV_RATE");
    			cnt++;
    		} else{
                if(flag != 1){
                    row = DS_DIV3.NameValueRow("ORG_CD", DS_COPY.NameValue(i, "ORG_CD"));
                    if(row != 0) {
                        DS_DIV3.NameValue(row, "DIV_RATE") = DS_COPY.NameValue(i, "DIV_RATE");
                        cnt++;
                    }
                }
            }
    	}
    	showMessage(INFORMATION, OK, "USER-1000", cnt + "건 처리되었습니다.");
    }
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
<script language=JavaScript for=DS_DIV event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    setPorcCount("SELECT", rowcnt);
    GD_DIV.Focus();
</script>

<script language=JavaScript for=DS_DIV1 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
    if(rowcnt != 0) enableControl(IMG_PRE1,true);
    else enableControl(IMG_PRE1,false);
</script>

<script language=JavaScript for=DS_DIV2 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
    if(rowcnt != 0) enableControl(IMG_PRE2,true);
    else enableControl(IMG_PRE2,false);
</script>

<script language=JavaScript for=DS_DIV3 event=OnLoadCompleted(rowcnt)>
    if(!isNull(this.ErrorMsg)) 
        showMessage(INFORMATION, OK, "USER-1000", this.ErrorMsg);
    
    if(lo_IsMasterLoaded) setPorcCount("SELECT", rowcnt);
    lo_IsMasterLoaded = 1;
</script>
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<script language=JavaScript for=DS_DIV  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_DIV1  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_DIV2  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_DIV3  event=OnLoadError()>
    dsFailed(this);
</script>

<script language=JavaScript for=DS_COPY  event=OnLoadError()>
    dsFailed(this);
</script>
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_DIV event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick) return;
    if( DS_DIV.IsUpdated){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            return false;
        }
        DS_DIV1.ClearData();
        DS_DIV2.ClearData();
        DS_DIV3.ClearData();
        if( this.RowStatus(row)=="1" ) this.DeleteRow(row); 
        else this.UndoAll();
    }
    
    if(DS_DIV1.IsUpdated || DS_DIV2.IsUpdated || DS_DIV3.IsUpdated){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            return false;
        }
        
    }
</script>

<script language=JavaScript for=DS_DIV event=OnRowPosChanged(row)>
    if (this.CountRow >0 && row>0) {
        subQuery(row);
    } else {
    	enableControl(IMG_PRE1,false);
    }
</script>

<script language=JavaScript for=DS_DIV1 event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick) return;
    
    if( DS_DIV2.IsUpdated || DS_DIV3.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            return false;
        }
    }
</script>

<script language=JavaScript for=DS_DIV1 event=OnRowPosChanged(row)>
    if (this.CountRow >0 && row>0 && DS_DIV1.NameValue(row, "EX_FLAG") !="") {
        subQuery1(row);
        subQuery2(row);
    } else {
    	DS_DIV2.ClearData();
        DS_DIV3.ClearData();
        enableControl(IMG_PRE2,false);
    }
</script>

<script language=JavaScript for=DS_DIV2 event=CanRowPosChange(row)>
    if( row < 1 || btnSaveClick) return;
    
    if( DS_DIV3.IsUpdated ){
        //변경된 상세내역이 존재합니다. 이동 하시겠습니까? 
        if( showMessage(QUESTION, YESNO, "USER-1049") != 1 ){
            return false;
        }
    }
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------->
<script language=JavaScript for=GD_DIV event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_DIV event=OnCloseUp(row,colid)>
    subQuery(row);
</script>

<script language=JavaScript for=GD_DIV1 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_DIV2 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_DIV3 event=OnClick(row,colid)>
    sortColId(eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=GD_DIV1 event=CanColumnPosChange(row,colid)>
    if(colid == "DIV_RATE"){
    	if(DS_DIV1.NameValue(row, colid) < 0 || DS_DIV1.NameValue(row, colid) > 100){
            showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
            return false;
        }
    }
    return true;
</script>

<script language=JavaScript for=GD_DIV2 event=CanColumnPosChange(row,colid)>
    if(colid == "DIV_RATE"){
        if(DS_DIV2.NameValue(row, colid) < 0 || DS_DIV2.NameValue(row, colid) > 100){
            showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
            return false;
        }
    }
    return true;
</script>

<script language=JavaScript for=GD_DIV3 event=CanColumnPosChange(row,colid)>
    if(colid == "DIV_RATE"){
        if(DS_DIV3.NameValue(row, colid) < 0 || DS_DIV3.NameValue(row, colid) > 100){
            showMessage(EXCLAMATION, OK, "USER-1021", "배부율", "100");
            return false;
        }
    }
    return true;
</script>

<script language=JavaScript for=EM_DIV_YM event=OnKillFocus()>
    if(!this.Modified) return;

    lo_DivYm = EM_DIV_YM.text;
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
    <!--[그리드]배부기코드 -->
    <object id="DS_DIV"     classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]1차배부기준안 -->
    <object id="DS_DIV1"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]2차배부기준안 -->
    <object id="DS_DIV2"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드]3차배부기준안 -->
    <object id="DS_DIV3"    classid=<%= Util.CLSID_DATASET %>></object>
    <!--[그리드 콤보]배부기준코드 -->
    <object id="DS_DIV_CD"  classid=<%= Util.CLSID_DATASET %>></object>
    <!--전월배부기준복사용 -->
    <object id="DS_COPY"    classid=<%= Util.CLSID_DATASET %>></object>
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
<body onLoad="doInit();" class="PL10 PT15 ">

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">배부기준년월</th>
            <td>
              <comment id="_NSID_">
                <object id=EM_DIV_YM classid=<%=Util.CLSID_EMEDIT%> width=80 onblur="checkDateTypeYM(this, '<%=strYm%>');" align="absmiddle"></object>
              </comment><script> _ws_(_NSID_);</script>
              <img src="/<%=dir%>/imgs/btn/date.gif" class="PR03"
                onclick="javascript:openCal('M',EM_DIV_YM)" align="absmiddle" />
            </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="160"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_DIV width="100%" height=502 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_DIV">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td class="PL10 "><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 1차 배부기준안</td>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/copy_lastmonth.gif" id=IMG_PRE1 onclick="javascript:getPreData(1);" />
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_DIV1 width="100%" height=125 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_DIV1">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td class="sub_title PB03 PT10" ><img src="/<%=dir%>/imgs/comm/ring_blue.gif"  class="PR03" align="absmiddle"/> 2차 배부기준안</td>
                <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/copy_lastmonth.gif" id=IMG_PRE2 onclick="javascript:getPreData(2);" />
                </td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_DIV2 width="100%" height=165 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_DIV2">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
          <tr>
            <td class="PT05"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr valign="top">
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
                  <tr>
                    <td>
                      <comment id="_NSID_"><object id=GD_DIV3 width="100%" height=146 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_DIV3">
                      </object></comment><script>_ws_(_NSID_);</script>
                    </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
</body>
</html>
