<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 사은행사관리 > 사은품 지급/취소 > 사은행사참여영수증반품확인
 * 작 성 일 : 2017.12.04
 * 작 성 자 : jyk
 * 수 정 자 : 
 * 파 일 명 : MCAE4500.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 사은행사참여영수증반품확인
 * 이    력 :
 *        2017.12.04 (jyk) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                              *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");

	//PID 확인을 위한
	String pageName = request.getRequestURI();
	int nSubStrFr = pageName.lastIndexOf("/") + 1 ;
	int nSubStrTo = pageName.lastIndexOf(".jsp") - 1 ;
	pageName = pageName.substring(nSubStrFr, nSubStrTo).toUpperCase();

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
<script language="javascript" src="/<%=dir%>/js/popup_mss.js"
    type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                      *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--


/*************************************************************************
 * 0. 전역변수
 *************************************************************************/
var g_select =false;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 340;		//해당화면의 동적그리드top위치
 var g_strPid           = "<%=pageName%>";                 // PID
function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
    // Input Data Set Header 초기화

    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1();
    gridCreate2();
    
    // EMedit에 초기화
    //initEmEdit(EM_S_DATE,       "SYYYYMMDD",    PK);            //기간S
    //initEmEdit(EM_E_DATE,       "YYYYMMDD",     PK);            //기간E
    initEmEdit(EM_SALE_DATE,    "YYYYMM",         PK);            //기간 - 매출일
    initEmEdit(EM_POS_CD,       "NUMBER3^4",    NORMAL);        //POS코드
    initEmEdit(EM_POS_NM,       "GEN",          READ);          //POS명
    initEmEdit(EM_TRAN_NO,      "NUMBER3^5",    NORMAL);        //POS코드
    initEmEdit(EM_EVENT_CD,   "NUMBER3^11^0", NORMAL);        //행사코드
    initEmEdit(EM_EVENT_NAME, "GEN^40",       READ);          //행사명
    //콤보 초기화
    initComboStyle(LC_S_STR_CD,DS_S_STR_CD, "CODE^0^30,NAME^0^80", 1, PK);      //점
     
    EM_SALE_DATE.Text         = getTodayFormat("YYYYMM");     //기간E
    
    getStore("DS_S_STR_CD", "Y", "1", "N");   //점(조회) 
    LC_S_STR_CD.Index = 0;
    LC_S_STR_CD.Focus();
}


function gridCreate1(){ 
    var hdrProperies ='<FC>id={currow}          name="NO"          	width=50   	align=center BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=STR_CD            name="점"          	width=100  	align=center EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" show=false </FC>'
			        + '<FC>id=STR_NM            name="점명"        	width=150  	align=left   show=false </FC>'
			       	+ '<FG>						name="반품내역"	'
			        + '<FC>id=RTN_DT	        name="일자"    		width=100  	align=center MASK="XXXX/XX/XX" show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=RTN_POS           name="포스번호"     width=80   	align=center   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=RTN_POS_NM      	name="포스명"      	width=100   align=center   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=RTN_TRAN          name="거래번호" 	width=80   	align=center  show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '</FG>	'
			        + '<G>						name="원거래내역"	'
			        + '<C>id=O_SALE_DT	        name="일자"    		width=100  	align=center MASK="XXXX/XX/XX" show=true  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<C>id=O_POS_NO          	name="포스번호"     width=80   	align=center   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<C>id=O_TRAN_NO         	name="거래번호" 	width=80   	align=center  show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '</G>	'
			        + '<G>					   	name="사은행사정보"	'
			        + '<C>id=EVENT_CD          	name="코드"     	width=100  	align=left   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=EVENT_NAME        	name="명"       	width=200  	align=left   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '</G>	'
			        + '<C>id=SALE_TOT_AMT      	name="결제금액"     width=100  	align=right            BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
			        + '<G>					   	name="사은품내역"	'
			        + '<C>id=SKU_CD            	name="코드"    	   	width=100  	align=left show=true  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
                    + '<C>id=SKU_NAME          	name="명"  		   	width=200  	align=left   show=true  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
                    + '<C>id=PRSNT_QTY         	name="수량"     	width=50  	align=center show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
                    + '<C>id=PRSNT_AMT         	name="금액"       	width=100  	align=right   show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} </C>'
			        + '</G>	'
			        + '<C>id=PRSNT_DT          	name="지급일"       width=100  	align=center show=true MASK="XXXX/XX/XX"  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=PRSNT_NO          	name="지급번호"     width=80  	align=center show=true  BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=SEQ_NO            	name="영수증순번"   width=80   	align=center show=true BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
                    ;
                     
    initGridStyle(GD_MASTER, "common", hdrProperies, false);
    //GD_MASTER.ViewSummary = "1";
}


function gridCreate2(){ 
    var hdrProperies ='<FC>id={currow}          name="NO"          	width=50   align=center FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=STR_CD            name="점"          	width=100  align=center EDITSTYLE=LOOKUP   DATA="DS_S_STR_CD:CODE:NAME" show=false </FC>'
			        + '<FC>id=STR_NM            name="점명"        	width=150  align=left   show=false </FC>'
			        + '<C>id=PRSNT_DT          	name="지급일"       width=100  align=center show=true MASK="XXXX/XX/XX"  FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=PRSNT_NO          	name="지급번호"     width=80  align=center show=true  FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=SEQ_NO            	name="영수증순번"   width=80   align=center show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<FG>						name="원거래내역"	'
			        + '<FC>id=SALE_DT	        name="일자"    		width=100  align=center MASK="XXXX/XX/XX" show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} sumtext="합  계"</FC>'
			        + '<FC>id=POS_NO          	name="포스번호"     width=80   align=center   show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=POS_NM      		name="포스명"      	width=100   align=center   show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=TRAN_NO         	name="거래번호" 	width=80   align=center  show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</FC>'
			        + '<FC>id=RTN_AMT      		name="결제금액"     width=100  align=right    FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")} sumtext=@Sum </FC>'
			        + '</FG>	'
			        + '<G>						name="반품내역"	'
			        + '<C>id=RTN_YN	        	name="반품유무"    	width=100  align=center show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=RTN_DT	        	name="일자"    		width=100  align=center MASK="XXXX/XX/XX" show=true FontStyle={if(DT > RTN_DT, "bold","none")}  color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=RTN_POS           	name="포스번호"     width=80   align=center   show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=RTN_POS_NM   		name="포스명"      	width=100   align=center   show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '<C>id=RTN_TRAN           name="거래번호" 	width=80   align=center  show=true FontStyle={if(DT > RTN_DT, "bold","none")} color={if(DT > RTN_DT, "red","black")} BgColor={decode(currow-(currow/2)*2,0,"#FBFBFB",1,"#FFFFFF")}</C>'
			        + '</G>	'
                    ;
                     
    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
    
    GD_DETAIL.ViewSummary = "1";
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
    
	 DS_MASTER.ClearData();
	 DS_DETAIL.ClearData();
	 
	 if( EM_SALE_DATE.TEXT == ""){
        // (점)은/는 반드시 입력해야 합니다.
        showMessage(EXCLAMATION, OK, "USER-1002", "기준일");
        EM_DATE_DT.Focus();
        return;
    }
    
     
    // 조회조건 셋팅
    var strStrCd       	= LC_S_STR_CD.BindColVal;
    var strSaleFrDt    	= EM_SALE_DATE.Text+"01";
    var strSaleToDt    	= EM_SALE_DATE.Text+"31";
    var strPosNo       	= EM_POS_CD.Text;
    var strTranNo      	= EM_TRAN_NO.Text;
    var strEventCd	    = EM_EVENT_CD.Text;
   
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd ="+ encodeURIComponent(strStrCd)
                   + "&strSaleFrDt="+ encodeURIComponent(strSaleFrDt)
                   + "&strSaleToDt="+ encodeURIComponent(strSaleToDt)
                   + "&strPosNo ="+ encodeURIComponent(strPosNo)
                   + "&strTranNo="+ encodeURIComponent(strTranNo)
                   + "&strEventCd="+ encodeURIComponent(strEventCd)
                   ;
    
    TR_MAIN.Action="/mss/mcae450.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    g_select = true;
    TR_MAIN.Post();
    
    setPorcCount("SELECT", GD_MASTER);
    
    if (DS_MASTER.CountRow > 0){
    	searchDetail(1);
    	g_select = false;
    }
}

/**
 * btn_New()
 * 작 성 자 : shryu
 * 작 성 일 : 2006-06-20
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {
    
}

/**
 * btn_Delete()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
//    DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

}

/**
 * btn_Excel()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

	var ExcelTitle = "사은행사참여영수증반품확인" 
	    
		var strStrCd    = LC_S_STR_CD.BindColVal;
		var strMonth    = EM_SALE_DATE.Text;	
		var strEventCd  = EM_EVENT_CD.Text; 
		
		
		var params = "점:"    + strStrCd
		               + " 행사코드:"  + strEventCd
		               + " 조회기간:"    + strMonth
						;		
		//openExcel2(GD_MASTER, ExcelTitle, params, true );
		openExcel5(GD_MASTER, ExcelTitle, params, true, "",g_strPid );
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
 /**

/**
 * openPosPop()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-15, 2011-09-26
 * 개    요 : 포스팝업 오픈
 * return값 : void
 */
function openPosPop() {
   
     posNoPop(EM_POS_CD,EM_POS_NM,LC_S_STR_CD.BindColVal,"");
}

/**
 * openPosPop()
 * 작 성 자 : 
 * 작 성 일 : 2011-03-15, 2011-09-26
 * 개    요 : 포스팝업 오픈
 * return값 : void
 */
function lpadStr(obj) {
	
	var strTemp 	=  obj.text;
	var nMaxlength	= obj.maxlength;
	var nTemp 		= strTemp.length

	if (nTemp != 0 ) {
		for (var i=1;i<=nMaxlength-nTemp;i++) {
			strTemp = "0" + strTemp;
		}
		obj.text = strTemp;
	}
}

function searchDetail(nRow) {
	

	var obj = DS_MASTER;
	
	var strStrCd       	= obj.NameValue(nRow,"STR_CD");
    var strDt			= obj.NameValue(nRow,"RTN_DT");
	var strPrsntDt		= obj.NameValue(nRow,"PRSNT_DT");
	var strPrsntNo		= obj.NameValue(nRow,"PRSNT_NO");
	
	if (nRow==0) 
		return false;
	
	
    var goTo       = "getDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd ="	+ encodeURIComponent(strStrCd)
                   + "&strDt="		+ encodeURIComponent(strDt)
                   + "&strPrsntDt="	+ encodeURIComponent(strPrsntDt)
                   + "&strPrsntNo ="+ encodeURIComponent(strPrsntNo)
                   ;
    
    TR_MAIN.Action="/mss/mcae450.mc?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_DETAIL=DS_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    
    
	
}
-->
</script>
</head>


<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                     	*-->
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
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    //정렬
    if (row == 0){
        sortColId(eval(this.DataID), row, colid);
    }    
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
if(clickSORT) return; 

if (!g_select) {
	searchDetail(row);
}

</script>

<script language=JavaScript for=DS_DETAIL event=OnRowPosChanged(row)>
if(clickSORT) return; 
</script>

<script language=JavaScript for=GD_DETAIL event=OnDblClick(row,colid)>
//if(row == 0)
	return; 
//openPop();
</script>

<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- 포스 조회 -->
<script language=JavaScript for=EM_POS_CD event=onKillFocus()>
//변경된 내역이 없으면 무시
if(!this.Modified)
    return;
//코드가 존재 하지 않으면 명을 클리어 후 리턴
if( EM_POS_CD.Text ==""){
    EM_POS_NM.Text = "";
       return;
   }

   if(EM_POS_CD.Text != null){
        if(EM_POS_CD.Text.length > 0){
            
            setPosNoNmWithoutPop("DS_O_RESULT", EM_POS_CD, EM_POS_NM , 1, LC_S_STR_CD.BindColVal, "");
            if(DS_O_RESULT.CountRow == 1){
                EM_POS_CD.Text = DS_O_RESULT.NameValue(1, "POS_NO");
                EM_POS_NM.Text = DS_O_RESULT.NameValue(1, "POS_NAME");
            }
        }
    } 
</script>

<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
EM_POS_CD.Text = "";
EM_POS_NM.Text = ""; 
</script>


<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리 끝                                              *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                  *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_S_STR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_DETAIL"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<!-- 공통 -->
<comment id="_NSID_">
<object id="DS_O_RESULT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->

<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";

    
}
</script>


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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
	          <th width="60" class="point">점</th>
	          <td width="120" >
	              <comment id="_NSID_">
                      <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> tabindex=1  height=100 width=120 align="absmiddle">
                      </object>
                  </comment><script>_ws_(_NSID_);</script>   
	          </td>
	          <th width="60" class="point">반품일자</th>
	          <td width="100" > 
	              <comment id="_NSID_">
	                      <object id=EM_SALE_DATE classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle" onblur="javascript:checkDateTypeYM(this);">
	                      </object>
	              </comment><script>_ws_(_NSID_);</script>
	              <img src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle" onclick="javascript:openCal('M',EM_SALE_DATE)" />
	              
	          </td>  
	          <th width="100" >반품포스번호</th>
              <td width="200">
                  <comment id="_NSID_">
                          <object id=EM_POS_CD classid=<%= Util.CLSID_EMEDIT %> width=60 tabindex=1 align="absmiddle">
                          </object>
			                  </comment><script>_ws_(_NSID_);</script>  
			                  <img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:openPosPop();"  align="absmiddle"/>
			                  <comment id="_NSID_">
                          <object id=EM_POS_NM classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle"></object>
                  </comment><script>_ws_(_NSID_);</script>  
              </td>
              <th width="100" >반품거래번호</th>
              <td width="130" align="absmiddle">
                  <comment id="_NSID_">
                          <object id=EM_TRAN_NO classid=<%= Util.CLSID_EMEDIT %> width=100 tabindex=1 align="absmiddle" onblur="javascript:lpadStr(EM_TRAN_NO);">
                          </object>
                  </comment><script>_ws_(_NSID_);</script>
			  </td>
			  <th width="60" >행사코드</th>
              <td ><comment id="_NSID_"> <object
                  id=EM_EVENT_CD classid=<%=Util.CLSID_EMEDIT%> width=70
                  tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
              <img id=IMG_EVENT src="/<%=dir%>/imgs/btn/detail_search_s.gif"
                  class="PR03" onclick="javascript: mssEventMstPop('SEL_STR_EVENT_POP',EM_EVENT_CD,EM_EVENT_NAME,LC_S_STR_CD.BindColVal,  '4/5/6','05');"
                  align="absmiddle" /> <comment id="_NSID_"> <object
                  id=EM_EVENT_NAME classid=<%=Util.CLSID_EMEDIT%> width=135
                  tabindex=1 align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script>
              </td>
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>   
  <tr>
    <td class="dot"></td>
  </tr>   
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">                
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_MASTER width=100% height=400 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_MASTER">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="5"></td>
  </tr>
  <tr>
    <td class="dot"></td>
  </tr>
  <tr>
    <td height="20">
    	<p style="font-size:14px;"><img src ="/<%=dir%>/imgs/comm/title_head.gif" /><b>  사은행사 지급번호 상세 내역</b></p>
    </td>
  </tr>  
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">                
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td>
                <comment id="_NSID_"><OBJECT id=GD_DETAIL width=100% height=200 classid=<%=Util.CLSID_GRID%>>
                <param name="DataID" value="DS_DETAIL">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
            </td>  
          </tr>
        </table></td>
      </tr>
    </table></td>
  </tr>

</table>
</DIV>
</body>
</html>

