<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 마진코드> 마진관리(긴급)
 * 작 성 일 : 2010.01.17
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcod3040.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 브랜드별 마진정보를 관리한다
 * 이    력 :
 *        2010.01.17 (정진영) 신규작성
 *        2010.02.17 (박종은)
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
	import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
	String dir = BaseProperty.get("context.common.dir");
%>
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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
	type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">


/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){

    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL2"/>');
    DS_O_MG_INFO.setDataHeader('<gauce:dataset name="H_SEL_MGINFO"/>');
    DS_O_PUMBUN_CHECK.setDataHeader('<gauce:dataset name="H_SEL_PUMBUNINFO"/>');
     
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //정상마진정보
    gridCreate3(); //행사 마진 정보

    // EMedit에 초기화
    //조회
    initEmEdit(EM_VEN_CD,            "CODE^6^0",    NORMAL);          //협력사(조회)
    initEmEdit(EM_VEN_NAME,          "GEN^40",      NORMAL);          //협력사(조회)
    initEmEdit(EM_PUMBUN_CD,         "CODE^6^0",    NORMAL);          //브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME,       "GEN^40",      NORMAL);          //브랜드(조회)
    initEmEdit(EM_REP_VEN_CD,        "CODE^6^0",    NORMAL);          //대표협력사(조회)
    initEmEdit(EM_REP_VEN_NAME,      "GEN^40",      READ);            //대표협력사(조회)
    initEmEdit(EM_REP_PUMBUN_CD,     "CODE^6^0",    NORMAL);          //대표브랜드(조회)
    initEmEdit(EM_REP_PUMBUN_NAME,   "GEN^40",      READ);            //대표브랜드(조회)
    
    //등록
    initEmEdit(EM_PUMBUN_CD_I,       "CODE^6^0",    PK);              //브랜드
    initEmEdit(EM_PUMBUN_NAME_I,     "GEN^40",      READ);              //브랜드명
    initEmEdit(EM_EVENT_FLAG_I,      "CODE^2^0",  PK);               //행사구분

    initEmEdit(EM_REMARK,            "GEN^100",     NORMAL);            //비고
    //콤보 초기화
    //조회
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);              //점
    getStore("DS_STR_CD", "Y", "1", "N");   
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    LC_STR_CD.Focus();
    
    initComboStyle(LC_MG_FLAG,DS_MG_FLAG, "CODE^0^30,NAME^0^120", 1, NORMAL);            //마진구분
    getEtcCode("DS_MG_FLAG",   "D", "P016", "Y");
    LC_MG_FLAG.Index = 0;
    
    //등록
    initComboStyle(LC_STR_CD_I,DS_STR_CD_I, "CODE^0^30,NAME^0^140", 1, PK);          //점
    getStore("DS_STR_CD_I", "Y", "1", "N");  
    initComboStyle(LC_MG_FLAG_I,DS_MG_FLAG_I, "CODE^0^30,NAME^0^120", 1, PK);        //마진구분
    getEtcCode("DS_MG_FLAG_I",   "D", "P016", "N");
    
    
    getEtcCode("DS_MG_FLAG_G",   "D", "P016", "Y");
    setObject(false);

    registerUsingDataset("pcod304","DS_IO_DETAIL, DS_IO_MASTER" );
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}     name="NO"         width=25   align=center   edit="none"</FC>'
                     + '<FC>id=STR_CD       name="점"          width=50   align=center   edit="none" show=false </FC>'
                     + '<FG>                name="브랜드"'
                     + '<FC>id=PUMBUN_CD    name="코드"     width=60   align=center   edit="none" </FC>'
                     + '<C>id=PUMBUN_NAME   name="명"       width=75   align=left   edit="none" </C>'
                     + '</FG>'
                     + '<C>id=MG_FLAG       name="마진구분"     width=60   align=left   edit="none" EditStyle=Lookup   Data="DS_MG_FLAG_G:CODE:NAME"</C>'
                     + '<C>id=EVENT_FLAG    name="행사구분"     width=60   align=center   edit="none" </C>'
                     + '<C>id=REMARK        name="행사구분명"         width=200   align=left   edit="none" </C>';

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    
}

function gridCreate2(){
	
    var hdrProperies = '<FC>id={currow}       name="NO"         width=30   align=center</FC>'
                     + '<FG>                  name="마진코드"       '
                     + '<FC>id=EVENT_FLAG     name="행사구분"     width=82   align=center     edit=none </FC>'
                     + '<FC>id=EVENT_RATE     name="행사율"       width=82   align=center     edit=none </FC>'
                     + '</FG>                 '
                     + '<FC>id=NORMAL_MG_RATE name="마진율"       width=80   align=light     edit={IF(APP_S_DT >"'+getTodayFormat("YYYYMMDD")+'" , "true", "false" )} </FC>'
                     + '<FC>id=APP_S_DT       name="적용시작일"    width=90   align=center     Edit=Numeric Mask="XXXX/XX/XX"   EditStyle=Popup edit={IF(APP_S_DT="","true",IF(Status="I" AND SysStatus="I" ,"true",IF(APP_S_DT>="'+getTodayFormat("YYYYMMDD")+'" AND APP_E_DT="99991231" AND Status<>"I","true","false")))} </FC>'
                     + '<FC>id=APP_E_DT       name="적용종료일"    width=90   align=center     Edit=Numeric Mask="XXXX/XX/XX"   EditStyle=Popup </FC>';

    initGridStyle(GD_DETAIL, "common", hdrProperies, true);
}

function gridCreate3(){
    var hdrProperies = '<FC>id={currow}         name="NO"             width=30   align=center</FC>'
        + '<FG>name="마진코드"       '
        + '<FC>id=EVENT_FLAG       name="행사구분"         width=60   align=center</FC>'
        + '<FC>id=EVENT_RATE       name="행사율"           width=50  align=center</FC>'
        + '</FG>                     '
        + '<FC>id=NORMAL_MG_RATE  name="정상;마진율"       width=50   align=light</FC>'
        + '<FC>id=EVENT_MG_RATE    name="행사;마진율"       width=50   align=light</FC>'
        + '<FC>id=APP_S_DT         name="행사;시작일"       width=80   align=center edit=none Mask="XXXX/XX/XX"</FC>'
        + '<FC>id=APP_E_DT         name="행사;종료일"       width=80   align=center edit=none Mask="XXXX/XX/XX"</FC>'
        + '<FC>id=EVENT_CD         name="행사코드"         width=90   align=center</FC>'
        + '<FC>id=EVENT_NAME       name="행사 명"           width=120  align=left</FC>';

initGridStyle(GD_DETAIL2, "common", hdrProperies, false);


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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated ) {
        ret = showMessage(QUESTION, YESNO, "USER-1059");
        if (ret != "1") {
            return false;
        } 
    }
    
    DS_IO_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    DS_IO_DETAIL.ClearData();
    
    searchMaster();
    searchDetail();
    searchDetail2();
    setObject(false);
    newchk = "0";
    
    maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
    //maxAppSDt = getRawData(addDate('d',1,(maxAppSDt==''?getTodayFormat("YYYYMMDD"):maxAppSDt)));
    
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
	
    if(!newMaster){
    	if( DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated)
            if( showMessage(QUESTION, YESNO, "USER-1050") != 1)
                return;
    }else{
    	
        if( showMessage(QUESTION, YESNO, "USER-1051") != 1){
        	return;   
        }
        else{
        	getStore("DS_STR_CD_I", "Y", "1", "N");  
        	LC_STR_CD_I.BindColVal = LC_STR_CD.BindColVal;
        	EM_PUMBUN_CD_I.Text   = "";
            EM_PUMBUN_NAME_I.Text   = "";
            EM_EVENT_FLAG_I.Text  = "";
            getEtcCode("DS_MG_FLAG_I",   "D", "P016", "N");
            DS_IO_DETAIL.ClearData();
            DS_O_DETAIL.ClearData();
            LC_MG_FLAG_I.Index = 0;
            setObject(true);
            LC_STR_CD_I.focus();
            newMaster = true;
            return;
        }   
        
    }
          
    DS_IO_MASTER.Addrow();
    DS_IO_DETAIL.ClearData();
    DS_O_DETAIL.ClearData();
    
    setObject(true);
    LC_STR_CD_I.BindColVal = LC_STR_CD.BindColVal;
    LC_MG_FLAG_I.Index = 0;
    LC_STR_CD_I.focus();
    newMaster = true;
    newchk = "1";
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
	if (!DS_IO_DETAIL.IsUpdated && !DS_IO_MASTER.IsUpdated) {
        showMessage(INFORMATION, OK, "USER-1028");
        if(DS_IO_MASTER.CountRow > 0 ){
            setFocusGrid(GD_MASTER, DS_IO_MASTER, DS_IO_MASTER.RowPosition, "STR_CD");
        }
        else{
            LC_STR_CD.Focus();
        }
        return;
        
    }
	
	//1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("save")) return;
	
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;
    
    var strStrCd     = LC_STR_CD_I.BindColVal;
    var strPumbunCd  = EM_PUMBUN_CD_I.Text;
    var strEventFlag = EM_EVENT_FLAG_I.Text;
    var strMgFlag    = LC_MG_FLAG_I.BindColVal;
    var strBigo      = EM_REMARK.Text;
    
    var parameters =  "&strStrCd="           +encodeURIComponent(strStrCd)
				    + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
				    + "&strEventFlag="       +encodeURIComponent(strEventFlag)
                    + "&strMgFlag="          +encodeURIComponent(strMgFlag)
                    + "&strBigo="            +encodeURIComponent(strBigo);

    TR_MAIN.Action="/dps/pcod304.pc?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL, I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    newMaster = false;
    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
	    btn_Search();
	    DS_IO_MASTER.RowPosition = getNameValueRow(DS_IO_MASTER, "PUMBUN_CD||EVENT_FLAG",strPumbunCd+"||"+strEventFlag);
	    var row = DS_IO_MASTER.RowPosition
        row = row<1?1:row;
	    
	    DS_IO_MASTER.RowPosition = row;
	    GD_MASTER.focus();
    }
    
}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
	 
}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 var newMaster = false;
 /**
 * searchMaster()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-18
 * 개    요 :  마진마스터 리스트 조회
 * return값 : void
 */
 function searchMaster(){

	
    DS_IO_MASTER.ClearData();
     
    
    //1. validation Master 그리드 필수 입력 체크 
    if(!chkValidation("search")) return;
  
    var strStrCd        = LC_STR_CD.BindColVal;         //점
    var strVenCd        = EM_VEN_CD.text;               //협력사
    var strPumbunCd     = EM_PUMBUN_CD.text;            //브랜드
    var strMgFlag       = LC_MG_FLAG.BindColVal;        //마진구분
    var strRepVenCd     = EM_REP_VEN_CD.text;           //대표협력사
    var strRepPumbunCd  = EM_REP_PUMBUN_CD.text;        //대표브랜드
    var strVenName        = EM_VEN_NAME.text;               //협력사명
    var strPumbunName     = EM_PUMBUN_NAME.text;            //브랜드명
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strVenCd="           +encodeURIComponent(strVenCd)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                   + "&strMgFlag="          +encodeURIComponent(strMgFlag)
                   + "&strRepVenCd="        +encodeURIComponent(strRepVenCd)
                   + "&strRepPumbunCd="     +encodeURIComponent(strRepPumbunCd)
                   + "&strVenName="         +encodeURIComponent(strVenName)
                   + "&strPumbunName="      +encodeURIComponent(strPumbunName);
    
    TR_MAIN.Action="/dps/pcod304.pc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    newMaster = false;
    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
}

 /**
 * setObject(flag)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-18
 * 개    요 :  마진마스터 bind 잠금 여부 체크
 * return값 : void
 */
 function setObject(flag){
    LC_STR_CD_I.Enable              = flag;  
    EM_PUMBUN_CD_I.Enable           = flag;  
    EM_EVENT_FLAG_I.Enable          = flag;  
    LC_MG_FLAG_I.Enable             = flag;  
    enableControl(IMG_PUMBUN_CD_I, flag);
    
 }
 
 /**
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 :  점별협력사 리스트 조회
 * return값 : void
 */
 function searchDetail(){

     DS_O_DETAIL.ClearData();

     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD"); //LC_STR_CD_I.BindColVal;          //점
     var strPumbunCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");    //EM_PUMBUN_CD_I.text;             //브랜드
     var strEventFlag    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_FLAG");    //EM_EVENT_FLAG_I.text;            //행사구분
     var strMgFlag       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MG_FLAG");     //LC_MG_FLAG_I.BindColVal;         //마진구분
     
     
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strStrCd="      +encodeURIComponent(strStrCd)
				    + "&strPumbunCd="   +encodeURIComponent(strPumbunCd)
				    + "&strEventFlag="  +encodeURIComponent(strEventFlag)
				    + "&strMgFlag="     +encodeURIComponent(strMgFlag);
     
     TR_DETAIL.Action="/dps/pcod304.pc?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_DETAIL.CountRow);
 }

 /**
 * searchDetail2()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 :  협력사담당자 리스트 조회
 * return값 : void
 */
 function searchDetail2(){

     DS_O_DETAIL.ClearData();

     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD"); //LC_STR_CD_I.BindColVal;          //점
     var strPumbunCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");    //EM_PUMBUN_CD_I.text;             //브랜드
     var strEventFlag    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_FLAG");    //EM_EVENT_FLAG_I.text;            //행사구분
     var strMgFlag       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MG_FLAG");     //LC_MG_FLAG_I.BindColVal;         //마진구분
     
     var goTo       = "searchDetail2" ;    
     var action     = "O";     
     var parameters = "&strStrCd="      +encodeURIComponent(strStrCd)
				    + "&strPumbunCd="   +encodeURIComponent(strPumbunCd)
				    + "&strEventFlag="  +encodeURIComponent(strEventFlag)
				    + "&strMgFlag="     +encodeURIComponent(strMgFlag);
     
     TR_DETAIL2.Action="/dps/pcod304.pc?goTo="+goTo+parameters;  
     TR_DETAIL2.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL2.Post();

     // 조회결과 Return
     //setPorcCount("SELECT", DS_O_DETAIL.CountRow);
     GD_MASTER.focus();
 }

 /**
  * btn_Add1()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-02-14
  * 개    요 : 점별협력사 그리드 Row추가 
  * return값 : void
*/
function btn_Add1(){
	
    if(DS_IO_MASTER.RowPosition > 0) {
    	if(EM_EVENT_FLAG_I.Text == "") return;
    	for(i=1; i <= DS_IO_DETAIL.CountRow;i++){
            if(DS_IO_DETAIL.RowStatus(i) == "1" || DS_IO_DETAIL.RowStatus(i) == "3") return;
        }
        var strVEN_CD = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD");
        //EVENT_FLAG
        DS_IO_DETAIL.Addrow();
        if(EM_EVENT_FLAG_I.Text != ""){
        	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_FLAG") = EM_EVENT_FLAG_I.Text;
        }
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_RATE") = "00";
        
        //maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
        maxAppSDt = getRawData(addDate('d',1,(maxAppSDt==''?getTodayFormat("YYYYMMDD"):maxAppSDt)));
        var lowMagin = marginChk();
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE") = lowMagin;
        if(maxAppSDt <= varToday){
        	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('d',1,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));
        }
        else{
        	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = maxAppSDt;
        }
        
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_E_DT") = "99991231";
        GD_DETAIL.ColumnProp("APP_E_DT","Edit")="";
    }
}


/**
 * btn_add_emg()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-02-14
 * 개    요 : 점별협력사 그리드 Row추가 
 * return값 : void
*/
function btn_add_emg(){
	
   if(DS_IO_MASTER.RowPosition > 0) {
   	if(EM_EVENT_FLAG_I.Text == "") return;
   	for(i=1; i <= DS_IO_DETAIL.CountRow;i++){
           if(DS_IO_DETAIL.RowStatus(i) == "1" || DS_IO_DETAIL.RowStatus(i) == "3") return;
       }
       var strVEN_CD = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"VEN_CD");
       
       var lowMagin ;
       lowMagin = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE");
       
       //EVENT_FLAG
       DS_IO_DETAIL.Addrow();
       if(EM_EVENT_FLAG_I.Text != ""){
       	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_FLAG") = EM_EVENT_FLAG_I.Text;
       }
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_RATE") = "00";
       
       //maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
       maxAppSDt = getRawData(addDate('d',1,(maxAppSDt==''?getTodayFormat("YYYYMMDD"):maxAppSDt)));
       //var lowMagin = marginChk();
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE") = lowMagin;
       //if(maxAppSDt <= varToday){
       //	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('d',0,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));
       //}
       //else{
       //	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('d',0,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));
       //}
       
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('d',0,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));
       DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_E_DT") = getRawData(addDate('d',0,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));
       GD_DETAIL.ColumnProp("APP_E_DT","Edit")="";
   }
}

/**
 * process()
 * 작 성 자     : 김경은
 * 작 성 일     : 2010-06-10
 * 개    요        : 처리버튼 클릭시
 * return값 : void
 */
function btn_send_mg_emg(){
	
		var strPumbunCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");    //EM_PUMBUN_CD_I.text;
		var strProcDt       = getRawData(addDate('D',1,getTodayFormat('YYYYMMDD')));

        if( strPumbunCd == ''){
        	showMessage(EXCLAMATION, OK, "USER-1000","브랜드가 존재하지 않습니다.");
        	return;
        }
        
	    if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){
	 
	        var parameters    = "&strStrCd="   + encodeURIComponent(LC_STR_CD.BindColVal)
	    					  + "&strProcDt="  + encodeURIComponent(strProcDt)
	    					  + "&strPumbunCd="  + encodeURIComponent(strPumbunCd)
	    					  ;
	       
	    	TR_MAIN.Action = "/dps/pcod304.pc?goTo=sendmgemg"+parameters;
	    	TR_MAIN.KeyValue = "SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)";
	    	//searchSetWait("B"); // 프로그래스바
	    	TR_MAIN.Post();        
	    }
}

/**
  * btn_Del1()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-02-14
  * 개    요 : 점별협력사 그리드 Row 삭제 
  * return값 : void
*/
function btn_Del1(){
	
	if(DS_IO_DETAIL.RowPosition != 0){
	    var row = DS_IO_DETAIL.RowPosition;
	    if( DS_IO_DETAIL.RowStatus(row) == "1")    //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
	        {DS_IO_DETAIL.DeleteRow(row);
	        maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
	        var dRow = DS_IO_DETAIL.RowPosition;
	        DS_IO_DETAIL.RowPosition = 0;
	        LC_STR_CD.focus();
	        setFocusGrid(GD_DETAIL, DS_IO_DETAIL,dRow,"APP_S_DT");
	        }
	    else
	        {showMessage(INFORMATION, OK, "USER-1052");}
	    
	    if(DS_IO_DETAIL.CountRow > 0){
		    if( DS_IO_DETAIL.RowStatus(row) == "0")    //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
		        {setObject(false);}
		    else
		        {setObject(true);}
	    }
	}
	
}

/**
 * chkValidation(gbn)
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function chkValidation(gbn){
    
    switch (gbn) {
    case "search" :  
        //점
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            // 메세지설명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","점");
            //LC_STR_CD_I.focus();//document.form.copdt.focus(); 
            return false;
        }
        return true;
        break;
    case "save" : 

        //점
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD")=="" ) {
            // 메세지설명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","점");
            LC_STR_CD_I.focus();//document.form.copdt.focus(); 
            return false;
        }
        //브랜드코드
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD")=="" ) {
            // 메세지설명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","브랜드코드");
            EM_PUMBUN_CD_I.focus();//document.form.copdt.focus(); 
            return false;
        }
        
        //마진구분
        if (DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"MG_FLAG")=="" ) {
            // 메세지설명은/는 반드시 입력해야 합니다.
            showMessage(EXCLAMATION, OK, "USER-1003","마진구분");
            LC_MG_FLAG_I.focus();//document.form.copdt.focus(); 
            return false;
        }
        
        //행사구분 숫자 체크
        //var strEventFlag = EM_EVENT_FLAG_I.text;
        if(isNumber(EM_EVENT_FLAG_I) == false){
            showMessage(Information, OK, "USER-1005","행사구분");
            EM_EVENT_FLAG_I.focus();//document.form.copdt.focus(); 
            return false;
        }
        if (EM_EVENT_FLAG_I.text.replace(" ","").length != 2 ) {
            showMessage(Information, OK, "USER-1027","행사구분","2");
            return false;
        }
        
        if(EM_REMARK.Text != ""){
        	colSize = DS_IO_MASTER.ColumnSize(DS_IO_MASTER.ColumnIndex("REMARK"));
            colVal  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REMARK");
            colName = "비고";
            result  = checkByteLengthStr(colVal,colSize,"N");
            if( result){
                showMessage(EXCLAMATION, OK, "GAUCE-1000", colName+ " 은/는 "+ colSize + "Byte 이상 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
                EM_REMARK.Text = result;
                setFocusGrid(GD_MASTER, DS_IO_MASTER,DS_IO_MASTER.RowPosition, "REMARK");
                return false ;
            }
        }
        
        
        if(DS_IO_DETAIL.CountRow <= 0){
            // 메세지설명은/는 반드시 입력해야 합니다.
           showMessage(EXCLAMATION, OK, "USER-1003","정상마진정보");
            setFocusGrid(GD_DETAIL, DS_IO_DETAIL,DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE");
            return false;
        }
        for(var i=1; i<=DS_IO_DETAIL.CountRow; i++ ) {
            if( DS_IO_DETAIL.RowStatus(i) != "0"){    //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
                if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE") == 0 ) {
                    if(showMessage(QUESTION, YESNO, "USER-1000","마진율이 0입니다. 등록하시겠습니까?") != "1") {
                    	setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"NORMAL_MG_RATE");
                        return false;
                    }
                    
                }
                var lowMagin = marginChk();
                if (DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"NORMAL_MG_RATE") < lowMagin ) {
                    showMessage(Information, OK, "USER-1020", "마진율","최저마진율  " + lowMagin);
                    setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"NORMAL_MG_RATE");
                    return false;
                }
                
//                if (DS_IO_DETAIL.NameValue(i,"APP_S_DT") <= varToday && DS_IO_DETAIL.NameValue(i,"APP_E_DT") == "99991231"){
				//if (DS_IO_DETAIL.NameValue(i,"APP_S_DT") <= varToday ){
                //    showMessage(Information, OK, "USER-1000", "적용시작일은 오늘 일자보다 커야 합니다.");
                //    setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
                //    
                //    return false;
                //}
                //거래시작일 종료일 비교
//                if (isBetweenFromTo(DS_IO_DETAIL.NameValue(i,"APP_S_DT"), DS_IO_DETAIL.NameValue(i,"APP_E_DT")) == "false"){
                if (DS_IO_DETAIL.NameValue(i,"APP_S_DT") > DS_IO_DETAIL.NameValue(i,"APP_E_DT")){
					showMessage(Information, OK, "USER-1015");
                    setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
                    return false;
                }
                for(k=1; k<= DS_IO_DETAIL.CountRow; k++){
                	if(DS_IO_DETAIL.NameValue(i, "APP_S_DT") <= DS_IO_DETAIL.NameValue(k, "APP_S_DT") && i != k && DS_IO_DETAIL.RowStatus(i) == "1"){
                		showMessage(Information, OK, "USER-1000", "적용시작일은 기존의 적용시작일보다  커야 합니다.");

                        maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
                        //maxAppSDt = getRawData(addDate('d',1,(maxAppSDt==''?getTodayFormat("YYYYMMDD"):maxAppSDt)));
                        
                        setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
                        DS_IO_DETAIL.NameValue(i, "APP_S_DT") = maxAppSDt;
                        return false;
                	}
                	else{
                		if(DS_IO_DETAIL.NameValue(i, "APP_S_DT") <=  varToday && DS_IO_DETAIL.RowStatus(i) == "1"){
                            //showMessage(Information, OK, "USER-1000", "적용시작일은 당일보다  커야 합니다.");

                            //maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
                            //maxAppSDt = getRawData(addDate('d',1,(maxAppSDt==''?getTodayFormat("YYYYMMDD"):maxAppSDt)));
                            
                            //setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
                            //DS_IO_DETAIL.NameValue(i, "APP_S_DT") = getRawData(addDate('d',1,(varToday==''?getTodayFormat("YYYYMMDD"):varToday)));;
                            //return false;
                        }
                		else{
	                		if(	DS_IO_DETAIL.RowStatus(i) == "3" &&
	                				DS_IO_DETAIL.NameValue(i, "NORMAL_MG_RATE") != DS_IO_DETAIL.OrgNameValue(i, "NORMAL_MG_RATE") &&
	                				DS_IO_DETAIL.NameValue(i, "APP_S_DT") == DS_IO_DETAIL.OrgNameValue(i, "APP_S_DT")){
	                			//showMessage(Information, OK, "USER-1000", "적용시작일은 기존의 적용시작일보다  커야 합니다.");
	                            //setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
	                			//DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('D',1,DS_IO_DETAIL.NameValue(k, "APP_S_DT")));
	                            //return true;
	                		}
	                		else{
	                			if(DS_IO_DETAIL.NameValue(i, "APP_S_DT") <= DS_IO_DETAIL.NameValue(k, "APP_S_DT") && i != k && 
	                                    DS_IO_DETAIL.RowStatus(i) == "3" ){
		                			showMessage(Information, OK, "USER-1000", "적용시작일은 기존의 적용시작일보다  커야 합니다.");
	                                setFocusGrid(GD_DETAIL, DS_IO_DETAIL,i,"APP_S_DT");
	                                //DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"APP_S_DT") = getRawData(addDate('D',1,DS_IO_DETAIL.NameValue(k, "APP_S_DT")));
	                                return false;
	                			}
	                		}
                		}
                	}
                }
                //종료일자 넣기
                if(DS_IO_DETAIL.NameValue(i, "APP_E_DT") == "" ){
                	DS_IO_DETAIL.NameValue(i, "APP_E_DT") = "99991231";
                }
            }   
        }
		
        //중복된 데이터 체크 
        if(DS_IO_DETAIL.IsInsert){
        	var retChk  = checkDupKey(DS_IO_MASTER, "STR_CD||PUMBUN_CD||EVENT_FLAG");
	        if (retChk != 0) {
	            showMessage(Information, OK, "USER-1044",retChk);
	            return;
	        }
        	
        }
        if(DS_IO_DETAIL.IsInsert){
	        var retCnt = marginDBChk();
	        if (retCnt != 0) {
	            showMessage(Information, OK, "USER-1044");
	            return;
	        }
        }
        
        if( getCloseCheck('DS_CLOSECHECK','',getTodayFormat("YYYYMMDD"),'PCOD','01','0','T') == 'TRUE'){
            showMessage(EXCLAMATION, Ok,  "USER-1068", "", "");
            return false;
        }
        return true;
        break;
    }
}


/**
 * marginChk()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 최저마진율 체크
 * return값 : void
 */
function marginChk() {

    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD"); //LC_STR_CD_I.BindColVal;          //점
    var strPumbunCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");    //EM_PUMBUN_CD_I.text;             //브랜드
     
    var goTo       = "searchMargin" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      +encodeURIComponent(strStrCd)
                   + "&strPumbunCd="   +encodeURIComponent(strPumbunCd);
    
    TR_DETAIL2.Action="/dps/pcod304.pc?goTo="+goTo+parameters;  
    TR_DETAIL2.KeyValue="SERVLET("+action+":DS_O_MARGIN=DS_O_MARGIN)"; //조회는 O
    TR_DETAIL2.Post();
    
    return DS_O_MARGIN.NameValue(1, "LOW_MG_RATE");
    
    
}


/**
 * marginDBChk()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 브랜드별마진 DB 중복 체크
 * return값 : void
 */
function marginDBChk() {
	
    if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) != 1) return 0;
    var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");       //점
    var strPumbunCd     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PUMBUN_CD");    //브랜드
    var strEventFlag    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"EVENT_FLAG");   //행사구분
     
    var goTo       = "searchDBMargin" ;    
    var action     = "O";     
    var parameters = "&strStrCd="      +encodeURIComponent(strStrCd)
                   + "&strPumbunCd="   +encodeURIComponent(strPumbunCd)
                   + "&strEventFlag="  +encodeURIComponent(strEventFlag);
    
    TR_DETAIL2.Action="/dps/pcod304.pc?goTo="+goTo+parameters;  
    TR_DETAIL2.KeyValue="SERVLET("+action+":DS_O_CHK=DS_O_CHK)"; //조회는 O
    TR_DETAIL2.Post();
    
    return DS_O_CHK.CountRow;
	
    
}


/**
 * searchMgInfo()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-23
 * 개    요 : 마진구분 변경시 실행
 * return값 : void
**/
function searchMgInfo(vMgFlag){
	 
	 DS_O_MG_INFO.ClearData();

	var strMgFlag = vMgFlag;

	var goTo         = "searchMgInfo";
	var action       = "O";
	var parameters   = "&strMgFlag=" + encodeURIComponent(strMgFlag);
	TR_SEARCH.Action   = "/dps/pcod304.pc?goTo=" + goTo + parameters;
	TR_SEARCH.KeyValue = "SERVLET(" + action + ":DS_O_MG_INFO=DS_O_MG_INFO)";  
	TR_SEARCH.Post();

}

function searchPumbunCheck(vPumbunCd){
	 
	 DS_O_PUMBUN_CHECK.ClearData();

	var strPumbunCd = vPumbunCd;

	var goTo         = "searchPumbunCheck";
	var action       = "O";
	var parameters   = "&strPumbunCd=" + encodeURIComponent(strPumbunCd);
	TR_SEARCH2.Action   = "/dps/pcod304.pc?goTo=" + goTo + parameters;
	TR_SEARCH2.KeyValue = "SERVLET(" + action + ":DS_O_PUMBUN_CHECK=DS_O_PUMBUN_CHECK)";  
	TR_SEARCH2.Post();

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

<!--  ===================DS_MASTER============================ -->
<!-- Grid DS_MASTER 변경시 DS_DETAIL의 마스터 내용 변경 -->
<script language=JavaScript for=DS_IO_MASTER
	event=OnColumnChanged(row,colid)>
    
</script>
<!--  ===================DS_MASTER============================ -->

<!--  ===================GD_MASTER============================ -->
<!-- Grid Master oneClick event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
  
  if (DS_IO_MASTER.RowStatus(row) == "1"){
      setObject(true);
  }
  else {
      setObject(false);
  }
</script>

<!-- Grid master 상하키 event 처리 -->
<script language=JavaScript for=GD_MASTER event=onKeyPress(keycode)>
    

</script>
<script language=Javascript>
    // 이전 Focus에 대한 정보를 저장한다.
    var old_Row = 0;
    var newchk = "0";
    var old_Row_Detail = 0;
    var old_Row_Detail2 = 0;
    
    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;
    var varToday = now.getYear().toString()+ mon + day;
    var maxAppSDt = "";
</script>

 <script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

 if(row > 0 && old_Row != row ){

    if(DS_IO_MASTER.RowStatus(row) != "1"){
	    //저장되지 않은 내용이 있을경우 경고   
	    if (DS_IO_MASTER.IsUpdated || DS_IO_DETAIL.IsUpdated ) {
	    	
	        ret = showMessage(QUESTION, YESNO, "USER-1074");
	        if (ret != "1") {
	            DS_IO_MASTER.RowPosition = old_Row;
	            if(DS_IO_MASTER.RowStatus(old_Row) == 1){
	            	setObject(true);
	            }
	            
	            return;
	        
	        } else {
	            if (DS_IO_MASTER.RowStatus(old_Row) == "1") //신규입력만 삭제 가능 0:조회, 1:신규, 3:수정
	            {
	            	DS_IO_MASTER.DeleteRow(old_Row);
	            	newMaster = false;
	                
	            } else {
	                //변경된 데이터 원상복귀
	                var ColCnt = this.CountColumn;
	                for( var i=1; i<=ColCnt;i++){
	                    if(this.RWStatus(old_Row,i) != 0)
	                        this.NameValue( old_Row, this.ColumnID(i)) = this.OrgNameValue(old_Row,this.ColumnID(i));
	                }
	                
	                ColCnt = DS_IO_DETAIL.CountColumn;
	                for( var j=1; j<=DS_IO_DETAIL.CountRow;j++){
	                    for( var i=1; i<=ColCnt;i++){
	                        if(DS_IO_DETAIL.RWStatus(j,i) != 0){
	                            if(DS_IO_DETAIL.RowStatus(j) == 1){
	                                DS_IO_DETAIL.DeleteRow(j);
	                                break;
	                            }
	                            DS_IO_DETAIL.NameValue( j, DS_IO_DETAIL.ColumnID(i)) = DS_IO_DETAIL.OrgNameValue(j,DS_IO_DETAIL.ColumnID(i));
	                        }
	                    }
	                }
	                
	            }
	        }
	    }
    }
    searchDetail();
    searchDetail2();
    maxAppSDt = DS_IO_DETAIL.Max(DS_IO_DETAIL.ColumnIndex("APP_S_DT"),0,0);
 }
 old_Row = row;
 </script>

<!-- 마스터 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_MASTER
	event=OnColumnPosChanged(Row,Colid)>
    
</script>

<script language=JavaScript for=DS_IO_MASTER
	event=onColumnChanged(Row,Colid)>
old_Row = Row;
old_Colid = Colid;
// 이 Event에서 SerColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
</script>

<script language=JavaScript for=DS_IO_DETAIL
	event=onColumnChanged(Row,Colid)>
old_Row_Detail = Row;

// 이 Event에서 SerColumn을 사용하는 것은 의미가 없다. Changed를 수행한 후 SetColumn이 자동으로 수행되기 때문이다.
</script>


<!--  ===================GD_MASTER============================ -->

<!--  ===================GD_DETAIL============================ -->
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

 <script language=JavaScript for=DS_IO_DETAIL event=OnRowPosChanged(row)>

 if (DS_IO_DETAIL.RowStatus(row) != 1){
     
    	 if(varToday >= DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") || 
    			 maxAppSDt > DS_IO_DETAIL.NameValue(row,"APP_S_DT") && 
    			 DS_IO_DETAIL.RowStatus(row) == 0 && DS_IO_DETAIL.NameValue(row,"APP_E_DT") !=""){
    		 
    		 if(varToday < DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "APP_S_DT") && DS_IO_DETAIL.NameValue(row,"APP_E_DT") == "99991231"){
                 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="";
             }
             else{
                 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="none";
             }
    	 }
    	 else{
    		 if(maxAppSDt > DS_IO_DETAIL.NameValue(row,"APP_S_DT") && 
                     DS_IO_DETAIL.RowStatus(row) == 3 ){
    			 if(DS_IO_DETAIL.NameValue(row,"APP_E_DT") == "99991231"){
    				 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="";
    			 }
    			 else{
    				 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="none";
    			 }
    		     
    		 }
    		 else{
    			 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="";
    		 }
    	 }
 }
 else {
	 
     if(maxAppSDt > DS_IO_DETAIL.NameValue(row,"APP_S_DT") && DS_IO_DETAIL.RowStatus(row) != 1 && DS_IO_DETAIL.NameValue(row,"APP_E_DT") !=""){
    	 if(DS_IO_DETAIL.NameValue(row,"APP_E_DT") == "99991231"){
             GD_DETAIL.ColumnProp("APP_S_DT","Edit")="";
         }
         else{
             GD_DETAIL.ColumnProp("APP_S_DT","Edit")="none";
         }
     }
     else{
         GD_DETAIL.ColumnProp("APP_S_DT","Edit")="";
         //GD_DETAIL.ColumnProp("NORMAL_MG_RATE","Edit")="";
     }
 }

if(DS_IO_DETAIL.NameValue(row,"APP_E_DT")>=varToday){
	if(row==DS_IO_DETAIL.CountRow){
		 GD_DETAIL.ColumnProp("APP_E_DT","Edit")=true;
		 if(DS_IO_DETAIL.NameValue(row,"APP_S_DT")>varToday){
			 GD_DETAIL.ColumnProp("APP_S_DT","Edit")=true;
		 }else{
			 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="none";
		 }
		 
		
	}else{
		GD_DETAIL.ColumnProp("APP_E_DT","Edit")="none";
		 GD_DETAIL.ColumnProp("APP_S_DT","Edit")="none";
	}
}else{
	
	GD_DETAIL.ColumnProp("APP_E_DT","Edit")="none";
}

 </script>

<!-- 상세 그리드 컬럼 변경시 저장 체크 처리 -->
<script language=Javascript for=GD_DETAIL
    event=OnColumnPosChanged(Row,Colid)>
    
</script>
<script language=JavaScript for=GD_DETAIL2 event=OnClick(row,colid)>
  sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬

</script>

<script language=JavaScript for=GD_DETAIL
	event=OnExit(row,colid,olddata)>

</script>

<!-- Grid GD_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GD_DETAIL event=OnPopup(row,colid,data)>
	
	switch (colid) {
	case "APP_S_DT" :
	    openCal(GD_DETAIL, row, colid);   //그리드 달력 
	    break;
	case "APP_E_DT" :
	    openCal(GD_DETAIL, row, colid);   //그리드 달력 
	    break;
	   
} 
</script>

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
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 조회용 협력사  키업이벤트 -->

<!-- 협력사코드 변경시 -->
<script language=JavaScript for=EM_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_VEN_NAME.Text = "";
        return;
    }  
    setVenNmWithoutPop( "DS_O_VEN_CD", this, EM_VEN_NAME, '0');
</script>

<!-- 브랜드코드 변경시 -->       
<script language=JavaScript for=EM_PUMBUN_CD event=onKillFocus()>

setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", this, EM_PUMBUN_NAME, 'Y','0');
if(DS_O_PUMBUN_CD.NameValue(1, "BIZ_TYPE") == '5' && this.text != ''){
    showMessage(EXCLAMATION, Ok,  "USER-1000", "임대을Btyp은 조회할 수 없습니다.");
    EM_PUMBUN_CD.Text   = "";
    EM_PUMBUN_NAME.Text = "";
    return;
	
}
else{
	//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    if(this.text==''){
        EM_PUMBUN_NAME.Text = "";
        return;
    }  
    setStrPbnNmWithoutPop( "DS_O_PUMBUN_CD", this, EM_PUMBUN_NAME, 'Y','0');
}
</script>

<!-- 대표협력사코드 변경시 -->
<script language=JavaScript for=EM_REP_VEN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_REP_VEN_NAME.Text = "";
        return;
    }  
    setRepVenNmWithoutPop( "DS_O_REP_VEN_CD", this, EM_REP_VEN_NAME, '1');
</script>

<!-- 대표브랜드코드 변경시 -->
<script language=JavaScript for=EM_REP_PUMBUN_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
    	EM_REP_PUMBUN_NAME.Text = "";
        return;
    }  
    setRepPumbunNmWithoutPop( "DS_O_REP_PUMBUN_CD", this, EM_REP_PUMBUN_NAME, 'Y', '1');
</script>

<!-- 점코드변경시(등록)-->       
<script language=JavaScript for=LC_STR_CD_I event=OnSelChange()>
EM_PUMBUN_CD_I.text = "";
EM_PUMBUN_NAME_I.Text = "";
</script>


<!-- 브랜드코드 변경시(등록 -->       
<script language=JavaScript for=EM_PUMBUN_CD_I event=onKillFocus()>

setStrPbnNmWithoutPop("DS_O_PUMBUN_CD",this,EM_PUMBUN_NAME_I, "Y", 1,'',LC_STR_CD_I.bindcolval,'','','','','Y');
if(DS_O_PUMBUN_CD.NameValue(1, "BIZ_TYPE") == '5' && EM_PUMBUN_CD_I.Text != ""){
	showMessage(EXCLAMATION, Ok,  "USER-1000", "임대을Btyp은 등록 할 수 없습니다.");
    EM_PUMBUN_CD_I.Text   = "";
    EM_PUMBUN_NAME_I.Text = "";
    return;
}
else{
	//변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
        
    if(this.text==''){
        EM_PUMBUN_NAME_I.Text = "";
        return;
    }
    setStrPbnNmWithoutPop("DS_O_PUMBUN_CD",this,EM_PUMBUN_NAME_I, "Y", 1,'',LC_STR_CD_I.bindcolval,'','','','','Y');
}

</script>

<!-- 마진구분(등록)-->  
      
<script language=JavaScript for=LC_MG_FLAG_I event=OnSelChange()>

	

</script>

<!-- 행사구분 변경시 -->       
<script language=JavaScript for=EM_EVENT_FLAG_I event=OnKillFocus()> 
	DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"EVENT_FLAG") = EM_EVENT_FLAG_I.text;
</script>


 
<script language=JavaScript for=DS_IO_MASTER event=onColumnChanged(row,colid)>
	
	var vReserved1 = "";
	var vReserved2 = "";
	var vBizType = "";
	
	if (colid == "MG_FLAG") { 
		searchMgInfo(DS_IO_MASTER.NameValue(row,"MG_FLAG"));
		DS_IO_MASTER.NameValue(row,"EVENT_FLAG") = "";
		
		
		if(DS_IO_MASTER.NameValue(row,"MG_FLAG") == "5") { // 타사상품권(5)
			
			if(DS_IO_MASTER.NameValue(row,"PUMBUN_CD").replace(" ","").length != 0){
				searchPumbunCheck(DS_IO_MASTER.NameValue(row,"PUMBUN_CD"));
				vBizType = DS_O_PUMBUN_CHECK.NameValue(1,"BIZ_TYPE");
				
				// MARIO OUTLET 2011.08.10 (특정, 임대을인 경우만 타사상품권 마진 등록 가능)
				if(vBizType != "3" && vBizType != "2" ) { // 임대을A 코드값비교
					showMessage(Information, OK, "USER-1000","타사상품권은 거래형태 특정 매입 또는 임대을 브랜드만 등록 가능합니다.");
					LC_MG_FLAG_I.Index = 0;
				} 
			}
		}
		
		
	}
	
	if(DS_IO_MASTER.RowStatus(row) == "1") {
		if (colid == "EVENT_FLAG") {
			if (DS_IO_MASTER.NameValue(row,"EVENT_FLAG").replace(" ","").length == 2 ) {
				if(DS_O_MG_INFO.CountRow > 0) {	
				
					
					vReserved1 = DS_O_MG_INFO.NameValue(1,"RESERVED1");
					vReserved2 = DS_O_MG_INFO.NameValue(1,"RESERVED2");
					
					if(DS_O_MG_INFO.NameValue(1,"RESERVED1") > DS_IO_MASTER.NameValue(row,"EVENT_FLAG")
					|| DS_O_MG_INFO.NameValue(1,"RESERVED2") < DS_IO_MASTER.NameValue(row,"EVENT_FLAG")) {
						
						showMessage(Information, OK, "USER-1000","("+vReserved1+" ~ "+vReserved2+") 구간에서 입력하십시요.");
						EM_EVENT_FLAG_I.Text = "";
						EM_EVENT_FLAG_I.focus();
					}
				} else {
					EM_EVENT_FLAG_I.Text = "";
					LC_MG_FLAG_I.focus();
					showMessage(Information, OK, "USER-1000","마진구분을 먼저 선택하십시요.");
					
				}
			} 
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
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MG_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_STR_CD_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MG_FLAG_I" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MG_FLAG_G" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
   
<comment id="_NSID_">
<object id="DS_O_VEN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_REP_VEN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_REP_PUMBUN_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_CLOSECHECK classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=DS_O_MARGIN classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_MG_INFO" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_PUMBUN_CHECK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
	<param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_DETAIL2" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SEARCH" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="TR_SEARCH2" classid=<%=Util.CLSID_TRANSACTION%>>
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
<body onLoad="doInit();" class="PL10 PT15 ">

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
						<td width="150"><comment id="_NSID_"> <object
							id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=150 
							tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80">협력사</th>
						<td width="150"><comment id="_NSID_"> <object
							id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:venPop(EM_VEN_CD, EM_VEN_NAME);   EM_VEN_NAME.focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=70 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script></td>
						<th width="80">브랜드</th>
						<td><comment id="_NSID_"> <object id=EM_PUMBUN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=110
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
					</tr>
					<tr>
						<th>마진구분</th>
						<td><comment id="_NSID_"> <object id=LC_MG_FLAG
							classid=<%=Util.CLSID_LUXECOMBO%> width=150 tabindex=1 align="absmiddle">
						</object> </comment><script>_ws_(_NSID_);</script></td>
						<th>대표협력사</th>
						<td><comment id="_NSID_"> <object id=EM_REP_VEN_CD
							classid=<%=Util.CLSID_EMEDIT%> width=45 tabindex=1
							align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:repVenPop(EM_REP_VEN_CD, EM_REP_VEN_NAME); EM_REP_PUMBUN_CD.focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_REP_VEN_NAME classid=<%=Util.CLSID_EMEDIT%> width=70
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
						<th>대표브랜드</th>
						<td><comment id="_NSID_"> <object
							id=EM_REP_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=45
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
							onclick="javascript:repPumbunPop(EM_REP_PUMBUN_CD,EM_REP_PUMBUN_NAME, 'Y'); LC_STR_CD.focus();"
							align="absmiddle" /> <comment id="_NSID_"> <object
							id=EM_REP_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=110
							tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						</td>
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
	<tr valign="top">
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr valign="top">
				<td width="320">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="BD4A">
					<tr>
						<td><comment id="_NSID_"><object id=GD_MASTER
							width="100%" height=481 classid=<%=Util.CLSID_GRID%>>
							<param name="DataID" value="DS_IO_MASTER">
						</object></comment><script>_ws_(_NSID_);</script></td>
					</tr>
				</table>
				</td>
				<td class="PL10">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="s_table">
							<tr>
								<th width="80" class="point">점</th>
								<td width="100"><comment id="_NSID_"> <object
									id=LC_STR_CD_I classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
								<th width="80">브랜드</th>
								<td><comment id="_NSID_"> <object
									id=EM_PUMBUN_CD_I classid=<%=Util.CLSID_EMEDIT%> width=45
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" id=IMG_PUMBUN_CD_I
									onclick="javascript:strPbnPop(EM_PUMBUN_CD_I,EM_PUMBUN_NAME_I,'Y','',LC_STR_CD_I.bindcolval,'','','','','Y');EM_PUMBUN_CD_I.focus();"
									align="absmiddle" /> <comment id="_NSID_"> <object
									id=EM_PUMBUN_NAME_I classid=<%=Util.CLSID_EMEDIT%> width=105
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
							<tr>
                                <th class="point">마진구분</th>
                                <td><comment id="_NSID_"> <object id=LC_MG_FLAG_I
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script></td>
								<th class="point">행사구분</th>
								<td><comment id="_NSID_"> <object
									id=EM_EVENT_FLAG_I classid=<%=Util.CLSID_EMEDIT%> width=180
									tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
								</td>
							</tr>
                            <tr>
                                <th >행사구분명</th>
                                <td colspan="3"><comment id="_NSID_"> <object id=EM_REMARK
                                    classid=<%=Util.CLSID_EMEDIT%> width=382 tabindex=1 align="absmiddle">
                                </object> </comment><script>_ws_(_NSID_);</script></td>
                            </tr>
                            <tr>
                              <td  colspan="4" class="FS10">정상:00~10,행사:11~69,기획:70~75,균일:76~80,인하:81~89,타사상품권:90,직원가족초대:91~94
			                  </td>
			                </tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 정상마진정보</td>
									
								<td class="right PB02" valign="bottom">
								    <!-- 
								    <img src="/<%=dir%>/imgs/btn/add_row.gif"
									hspace="2" onclick="javascript:btn_Add1();" /> 
									 -->
									 <img src="/<%=dir%>/imgs/btn/del_row.gif"
									onclick="javascript:btn_Del1();" /></td>
									
									        <td>
						            		<table width="100%">
						                    <td align="right">
												<table border="0" cellspacing="0" cellpadding="0">
												  <tr>
												    <td class="btn_l"> </td>
												    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_add_emg()">긴급마진등록</a></td>
												    <td class="btn_r"></td>
												    <td class="btn_l"> </td>
												    <td class="btn_c"><a href="#" tabindex=1 onclick="btn_send_mg_emg()">긴급마진전송</a></td>
												    <td class="btn_r"></td>
												  </tr>
												</table>                
							                </td>			
										</tr>
									</table>				
						            </td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><object id=GD_DETAIL
											width="100%" height=163 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_IO_DETAIL">
										</object></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="sub_title PB03 PT10"><img
									src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
									align="absmiddle" /> 행사 마진 정보</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr valign="top">
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="BD4A">
									<tr>
										<td><comment id="_NSID_"><object id=GD_DETAIL2
											width="100%" height=163 classid=<%=Util.CLSID_GRID%>>
											<param name="DataID" value="DS_O_DETAIL">
										</object></comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>


<comment id="_NSID_"> <object id=BO_MASTER
	classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value='
        <c>Col=STR_CD               Ctrl=LC_STR_CD_I                param=BindColVal</c>
        <c>Col=PUMBUN_CD            Ctrl=EM_PUMBUN_CD_I             param=Text</c>
        <c>Col=PUMBUN_NAME          Ctrl=EM_PUMBUN_NAME_I           param=Text</c>
        <c>Col=EVENT_FLAG           Ctrl=EM_EVENT_FLAG_I            param=Text</c>
        <c>Col=MG_FLAG              Ctrl=LC_MG_FLAG_I               param=BindColVal</c>
        <c>Col=REMARK               Ctrl=EM_REMARK                  param=Text</c>
        '>
</object> </comment><script>_ws_(_NSID_);</script></div>
<body>
</html>
