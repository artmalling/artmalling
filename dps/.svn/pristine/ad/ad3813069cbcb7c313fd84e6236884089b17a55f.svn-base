<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 도면매출 > 도면관리
 * 작 성 일 : 2010.06.27
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : psal4380.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 
 * 이    력 :
 *        2010.06.27 (정진영) 신규작성
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
<%String dir = BaseProperty.get("context.common.dir");
String uploadDir = BaseProperty.get("dps.upload.http")+"floorPlan";
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">    
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript"  src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/gauce.js"  type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->
<style>
<!--
.dragme{position:absolute;}
.v_table{Border:solid 1px #b4d0e1; padding-left:1px; font-size:12px;}
.v_table TH{Border:solid 1px #b4d0e1; background-color:#ebf2f8;  color:#146ab9; height:15px; letter-spacing: -0.1ex; font-size:12px; font-weight:100; text-align:left; padding-left:2px; padding-right:1px;} 
.v_table TD{Border:solid 1px #b4d0e1;  padding-right:2px; padding-left:1px; background-color:#ffffff;  height:15px; letter-spacing:-0.1ex;  font-size:12px;} 


-->
</style>

<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/

//var imgDir = '/<%=dir%>/imgs/test';
var imgDir = '<%=uploadDir%>';
var isOnPopup = false;
var bfFloorCd = "";
var bfStrCd = "";
/**
 * doInit()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
	
    // Input Data Set Header 초기화
    DS_FLOOR_PLAN.setDataHeader('<gauce:dataset name="H_SEL_FLOOR_PLAN"/>');
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    // Output Data Set Header 초기화
    
    //그리드 초기화
    gridCreate1(); //규격단품

    // EMedit에 초기화
    initEmEdit(EM_FILS_LOC, "GEN^200", READ); //EXCEL경로
    
    //콤보 초기화
    initComboStyle( LC_STR_CD,  DS_STR_CD,  "CODE^0^30,NAME^0^140", 1, PK);  //점(조회)
    initComboStyle( LC_FLOOR_CD, DS_FLOOR_CD, "CODE^0^30,NAME^0^70", 1, PK);  //층
    
    //점콤보 가져오기 ( gauce.js )
    getStore("DS_STR_CD", "Y", "", "N");
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getEtcCode("DS_FLOOR_CD", "D", "P061", "N");

    //콤보데이터 기본값 설정( gauce.js )
    setComboData(LC_STR_CD,'<c:out value="${sessionScope.sessionInfo.STR_CD}" />'); //로그인 사용자 점 코드를 기본값으로 설정
    if( LC_STR_CD.Index < 0){
        LC_STR_CD.Index= 0;
    }
    setComboData(LC_FLOOR_CD,"B2");
    
    detailEdit(false);
    enableControl(IMG_FILE_OPEN,false);

    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal438","DS_FLOOR_PLAN,DS_MASTER" );

    bfStrCd = LC_STR_CD.BindColVal;
    bfFloorCd = LC_FLOOR_CD.BindColVal;
    
    LC_STR_CD.Focus();
}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}            width=25  align=center edit="none"  name="NO" </FC>'
                     + '<FG>name="*브랜드"'
                     + '<FC>id=PUMBUN_CD           width=70  align=center edit=Numeric name="코드" editStyle=Popup</FC>'
                     + '<FC>id=PUMBUN_NAME         width=80  align=left   edit="none"  name="명" </FC>'
                     + '</FG>'
                     + '<FC>id=SPOT_X              width=70  align=right  edit=Numeric name="*X좌표"</FC>'
                     + '<FC>id=SPOT_Y              width=70  align=right  edit=Numeric name="*Y좌표"</FC>'
                     + '<FC>id=VIRE_YN             width=70  align=left                name="*요약정보;표시여부" editStyle=Combo data="Y:YES,N:NO"</FC>'
                     + '<FC>id=RETAIL_VIEW_YN      width=70  align=left                name="*상세;팝업여부" editStyle=Combo data="Y:YES,N:NO"</FC>'; 
                     
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
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
	if(LC_STR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "점");
        LC_STR_CD.Focus();
        return;
	}
    if(LC_FLOOR_CD.BindColVal == ""){
        showMessage(EXCLAMATION, OK, "USER-1002", "층");
        LC_FLOOR_CD.Focus();
        return;
    }

    if(DS_MASTER.IsUpdated || DS_FLOOR_PLAN.IsUpdated){
        // 변경된 상세내역이 존재합니다. 조회하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1059") != 1 ){
            GD_MASTER.Focus();
            return;
        }
    }
    searchFloorPlan();
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

	// MARIO OUTLET START 2011.08.17
	/*
	if( DS_FLOOR_PLAN.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
	*/
	if(isNull(DS_FLOOR_PLAN.NameValue(1,"FILENAME"))){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
    }
    
	if(DS_FLOOR_PLAN.NameValue(1,"ROW_STATUS") == "I") {
	
		DS_FLOOR_PLAN.NameValue(1,"FILENAME") 	= "";	
		DS_FLOOR_PLAN.NameValue(1,"FILE_PATH")	= "";
		return;
	}
	// MARIO OUTLET END
	
	if( showMessage(QUESTION, YESNO, "USER-1000","해당 층의 도면파일 정보 및 브랜드정보를 <br>삭제 하시겠습니까?") != 1 ){
        GD_MASTER.Focus();
        return;
    }

    DS_FLOOR_PLAN.deleteRow(DS_FLOOR_PLAN.RowPosition); 

    DS_MASTER.ClearData();
    clearSpot();
    
    var goTo       = "delete" ;    
    var action     = "I";  
    TR_MAIN.Action="/dps/psal438.ps?goTo="+goTo;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_FLOOR_PLAN=DS_FLOOR_PLAN)"; //조회는 O
    TR_MAIN.Post();    

    if(TR_MAIN.ErrorCode == 0){
        searchFloorPlan();
    }
    GD_MASTER.Focus();
}

/**
 * btn_Save()
 * 작 성 자 : FKL
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {

    // 저장할 데이터 없는 경우
    if (!DS_MASTER.IsUpdated && !DS_FLOOR_PLAN.IsUpdated){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        // MARIO OUTLET START 2011.08.17
        /*
        if( DS_DS_FLOOR_PLAN.CountRow < 1){
            LC_STR_CD.Focus();
        }else{
            GD_MASTER.Focus();
        }
        */
        GD_MASTER.Focus();
     	// MARIO OUTLET END
        return;
    }

    if( !checkMasterValidation())
        return;

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
        GD_MASTER.Focus();
        return; 
    }
    
    TR_MAIN.Action="/dps/psal438.ps?goTo=save";  
    TR_MAIN.KeyValue="SERVLET(I:DS_FLOOR_PLAN=DS_FLOOR_PLAN,I:DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();    
    
    if(TR_MAIN.ErrorCode == 0){
    	searchFloorPlan();
    }
    GD_MASTER.Focus();
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
/**
 * detailEdit()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 브랜드정보 수정여부 설정
 * return값 : void
 */
function detailEdit(flag){
	
	enableControl(IMG_RESET_ROW,flag);
	enableControl(IMG_ADD_ROW,flag);
	enableControl(IMG_DEL_ROW,flag);
	GD_MASTER.Editable = flag;
}
/**
 * btn_resetRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 행초기화
 * return값 : void
 */
function btn_resetRow(){
    if( DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1075", "행초기화");
        LC_STR_CD.Focus();
        return
    }
    var row = DS_MASTER.RowPosition;
    if(DS_MASTER.RowStatus(row)=="1"){
        DS_MASTER.NameValue(row,"SPOT_X")         = "0";
        DS_MASTER.NameValue(row,"SPOT_Y")         = "0";
        DS_MASTER.NameValue(row,"VIRE_YN")        = "Y";
        DS_MASTER.NameValue(row,"RETAIL_VIEW_YN") = "Y";
    }else{
    	DS_MASTER.Undo(row);    	
    }
    setSpot(row);
    
}
/**
 * btn_addRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 행추가
 * return값 : void
 */
function btn_addRow(){
    
	// MARIO OUTLET START 2011.08.17
	/*
	if( DS_FLOOR_PLAN.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1075", "행추가");
        LC_STR_CD.Focus();
        return
    }
	*/
	
	if(isNull(DS_FLOOR_PLAN.NameValue(1,"FILENAME"))){
    	showMessage(INFORMATION, OK, "USER-1075", "행추가");
        LC_STR_CD.Focus();
        return
    }
	// MARIO OUTLET END
	
	DS_MASTER.AddRow();
	var row = DS_MASTER.CountRow;
	DS_MASTER.NameValue(row,"STR_CD")         = LC_STR_CD.BindColVal;
	DS_MASTER.NameValue(row,"FLOOR_CD")       = LC_FLOOR_CD.BindColVal;
    DS_MASTER.NameValue(row,"VIRE_YN")        = "Y";
    DS_MASTER.NameValue(row,"RETAIL_VIEW_YN") = "Y";
	
}
/**
 * btn_delRow()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 행삭제
 * return값 : void
 */
function btn_delRow(){
	if( DS_MASTER.CountRow < 1){
        showMessage(INFORMATION, OK, "USER-1019");
        LC_STR_CD.Focus();
        return;     
	}
	removeSpot(DS_MASTER.RowPosition);
    DS_MASTER.deleteRow(DS_MASTER.RowPosition);    
}
/**
 * searchFloorPlan()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면을 조회합니다.
 * return값 : void
 */
function searchFloorPlan(){
	var strCd        = LC_STR_CD.BindColVal;
	var floorCd      = LC_FLOOR_CD.BindColVal;

	var goTo       = "searchFloorPlan" ;    
	var action     = "O";  
	var parameters = "&strStrCd="+encodeURIComponent(strCd)
	               + "&strFloorCd="+encodeURIComponent(floorCd);
	TR_MAIN.Action="/dps/psal438.ps?goTo="+goTo+parameters;      
	TR_MAIN.KeyValue="SERVLET("+action+":DS_FLOOR_PLAN=DS_FLOOR_PLAN)"; //조회는 O
	TR_MAIN.Post();
	
	DS_MASTER.ClearData();
	clearSpot();
	enableControl(IMG_FILE_OPEN,true);
	
	// MARIO OUTLET START 2011.08.17
	/*
	if( DS_FLOOR_PLAN.CountRow < 1){
		DS_FLOOR_PLAN.AddRow();
		DS_FLOOR_PLAN.NameValue(1,"STR_CD")     = strCd;
        DS_FLOOR_PLAN.NameValue(1,"FLOOR_CD")   = floorCd;
        DS_FLOOR_PLAN.NameValue(1,"ROW_STATUS") = 'I';
        
        DIV_BACK_IMG_NO.style.display="";
        DIV_BACK_IMG.style.display="none";
        detailEdit(false);
	}else{
		//alert(imgDir+"/"+DS_FLOOR_PLAN.NameValue(1,"FILENAME"));
        IMG_BACKGROUND.src = imgDir+"/"+DS_FLOOR_PLAN.NameValue(1,"FILENAME");
	    DIV_BACK_IMG_NO.style.display="none";
	    DIV_BACK_IMG.style.display="";
		detailEdit(true);
		
		serachMaster();
	}
	*/
	
	if(isNull(DS_FLOOR_PLAN.NameValue(1,"FILENAME"))) {
	
		DIV_BACK_IMG_NO.style.display="";
        DIV_BACK_IMG.style.display="none";
        detailEdit(false);
		
	} else {
		IMG_BACKGROUND.src = imgDir+"/"+DS_FLOOR_PLAN.NameValue(1,"FILENAME");
	    DIV_BACK_IMG_NO.style.display="none";
	    DIV_BACK_IMG.style.display="";
		
	    detailEdit(true);
	    
		serachMaster();
	}
	// MARIO OUTLET END
}
/**
 * searchFloorPlan()
 * 작 성 자 : 
 * 작 성 일 : 2010-12-12
 * 개    요 : 도면을 조회합니다.
 * return값 : void
 */
function serachMaster(){

    var strCd        = LC_STR_CD.BindColVal;
    var floorCd      = LC_FLOOR_CD.BindColVal;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";  
    var parameters = "&strStrCd="+encodeURIComponent(strCd)
                   + "&strFloorCd="+encodeURIComponent(floorCd);
    TR_MAIN.Action="/dps/psal438.ps?goTo="+goTo+parameters;      
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    //조회후 결과표시
    setPorcCount("SELECT",GD_MASTER);  
    
    
    selSpot(1);
}
/**
 * openFile()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010.02.21
 * 개    요 : 도면파일선택
 * return값 : void
 */  
function openFile() {
	if(DS_FLOOR_PLAN.CountRow < 1){
		showMessage(INFORMATION, OK, "USER-1075", "파일찾기");
		LC_STR_CD.Focus();
		return
	}
	if(DS_MASTER.IsUpdated){
        // 변경된 상세내역이 존재합니다. 도면을 변경하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1063","도면") != 1 ){
            GD_MASTER.Focus();
            return;
        }
	}
	DS_MASTER.UndoAll();
    detailEdit(false);
	
	INF_UPLOAD.Open();
    
    if (INF_UPLOAD.SelectState) {
        var filePath    = INF_UPLOAD.Value; // 파일 full경로
        var fileNm      = filePath.substring(filePath.lastIndexOf("\\") + 1);
        var strFileName = fileNm.substring(0, fileNm.lastIndexOf(".")); // 확장자 제외 파일명
        var strFileExe  = fileNm.substring(fileNm.lastIndexOf(".")+1); // 확장자
        if( !(strFileExe == 'jpg' || strFileExe == 'gif' || strFileExe == 'png' ||strFileExe == 'jpeg') ){
        	showMessage(STOPSIGN, OK, "USER-1000", "파일은 JPEG 또는 GIF , PNG 형식의 파일만 업로드 가능합니다.");
        	return;
        }
        if(getByteValLength(strFileName) > 100)
        {  // 파일명 체크
            showMessage(STOPSIGN, OK, "USER-1000", "파일명은 100Byte(영문,숫자100자)이내로 작성해주세요");
            return;
        } 
        
        if((1024 * 1024 * 5) < INF_UPLOAD.FileInfo("size"))
        {  // 사이즈
            showMessage(STOPSIGN, OK, "USER-1000", "업로드파일은 사이즈는 5M를 넘을 수 없습니다.");
            return;
        }  
        
        DS_FLOOR_PLAN.NameValue(DS_FLOOR_PLAN.RowPosition, "FILENAME")  = fileNm;      
        DS_FLOOR_PLAN.NameValue(DS_FLOOR_PLAN.RowPosition, "FILE_PATH") = filePath; 
    }
}

/**
 * setPumbunCodeToGrid()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.(Grid)(사용안함)
 * return값 : void
 */
function setPumbunCodeToGrid(evnflag, row){
    var code    = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var strCd   = DS_MASTER.NameValue(row,"STR_CD");
    var floorCd = DS_MASTER.NameValue(row,"FLOOR_CD")
    
    if( code == "" && evnflag != "POP" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = strPbnToGridPop(code,'','Y','', strCd, '','','','','Y','','','','','','',floorCd);
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','','','','','','',floorCd);
    }    
    if( rtnMap != null){
        DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
    }else{
        if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
            DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
        }
    }
}
/**
 * setPumbunCodeToGridMulti()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 브랜드명을 등록한다.(Grid, 다중)
 * return값 : void
 */
function setPumbunCodeToGridMulti(evnflag, row){
    var code  = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var strCd = DS_MASTER.NameValue(row,"STR_CD");
    var floorCd = DS_MASTER.NameValue(row,"FLOOR_CD")
    
    if( code == "" && evnflag != "POP" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        return;     
    }
    var rtnMap = null;
    if( evnflag == "POP" ){
        rtnMap = strPbnMultiSelPop(code,'','Y','', strCd, '','','','','Y','','','','','','',floorCd);
    }else if( evnflag == "NAME" ){
        DS_MASTER.NameValue(row,"PUMBUN_NAME") = "";
        rtnMap = setStrPbnNmWithoutToGridPop("DS_SEARCH_NM",code,'',"Y",1,'', strCd, '','','','','Y','','','','','','',floorCd);
    }    
    if( rtnMap != null){
        if(evnflag == "NAME"){
            DS_MASTER.NameValue(row,"PUMBUN_CD")   = rtnMap.get("PUMBUN_CD");
            DS_MASTER.NameValue(row,"PUMBUN_NAME") = rtnMap.get("PUMBUN_NAME");
        }else{
            var total = rtnMap.length;
            if(total < 1){
                if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
                    DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
                }
                return;
            }
            var idx = 0;
            for( var i=0; i<total; i++){
                if( idx!=0 && DS_MASTER.NameValue(row+idx-1,"PUMBUN_CD") !=""){
                    DS_MASTER.AddRow();
                    DS_MASTER.NameValue(row+idx,"STR_CD")         = LC_STR_CD.BindColVal;
                    DS_MASTER.NameValue(row+idx,"FLOOR_CD")       = LC_FLOOR_CD.BindColVal;
                    DS_MASTER.NameValue(row+idx,"VIRE_YN")        = "Y";
                    DS_MASTER.NameValue(row+idx,"RETAIL_VIEW_YN") = "Y";
                }
                DS_MASTER.NameValue(row+idx,"PUMBUN_CD")   = rtnMap[i].PUMBUN_CD;
                DS_MASTER.NameValue(row+idx,"PUMBUN_NAME") = rtnMap[i].PUMBUN_NAME;
                if(checkDupKey(DS_MASTER,"PUMBUN_CD")==0){
               	 idx++;
                }
               
            }
        }
    }else{
        if( DS_MASTER.NameValue(row,"PUMBUN_NAME") == ""){
            DS_MASTER.NameValue(row,"PUMBUN_CD")   = "";
        }
    }
}
/**
 * onClickFloorPlan()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보를 저장한다.
 * return값 : void
 */
function onClickFloorPlan(){
	var row   = DS_MASTER.RowPosition;
	if( row < 1){
		return;
	}
	if( DS_MASTER.NameValue(row,"PUMBUN_CD") == ""){
        showMessage(EXCLAMATION, OK, "USER-1003", "브랜드");
        setFocusGrid(GD_MASTER,DS_MASTER,row,"PUMBUN_CD");
        return;
	}
	var fobj  = event.srcElement;
    if(fobj.id =="IMG_BACKGROUND"){
    	var x = event.offsetX;
    	var y = event.offsetY;
        DS_MASTER.NameValue(row,"SPOT_X")   = x;
        DS_MASTER.NameValue(row,"SPOT_Y")   = y;
        setSpot(row);
    }
}
/**
 * setSpot()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보의 점을 설정한다.
 * return값 : void
 */
function setSpot(row){
	var pumbunCd = DS_MASTER.NameValue(row,"PUMBUN_CD");
	var spotY    = DS_MASTER.NameValue(row,"SPOT_Y");
	var spotX    = DS_MASTER.NameValue(row,"SPOT_X");
	//removeChild
	//appendChild
	var spotObj = document.getElementById(pumbunCd);
	if( !spotObj){
		spotObj    = new Image();
		spotObj.id = pumbunCd;

		spotObj.style.position = "absolute";
		spotObj.style.width    = "12px";
		spotObj.style.height   = "12px";
		spotObj.style.cursor   = "pointer";
		spotObj.src            = "/<%=dir%>/imgs/btn/goal_spot.gif";
		document.getElementById("DIV_BACK_IMG").appendChild(spotObj);
	}

    spotObj.style.top      = (parseInt(spotY)-6)+"px";
    spotObj.style.left     = (parseInt(spotX)-6)+"px";
}

/**
 * setSpot()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보의 점을 설정한다.
 * return값 : void
 */
function selSpot(row){

    var pumbunCd = DS_MASTER.NameValue(row,"PUMBUN_CD");
    if( pumbunCd == "")
    	return;
    for(var i=1, len=DS_MASTER.CountRow; i<=len; i++){
    	if( pumbunCd == DS_MASTER.NameValue(i,"PUMBUN_CD")){
            var spotObj = document.getElementById(pumbunCd);
            if( !spotObj){
                setSpot(row);
                spotObj = document.getElementById(pumbunCd);
            }
            spotObj.src       = "/<%=dir%>/imgs/btn/goal_spot_over.gif";
    	}else{
            var spotObj = document.getElementById(DS_MASTER.NameValue(i,"PUMBUN_CD"));
            if( !spotObj){
                setSpot(i);                
            }else{
            	spotObj.src   = "/<%=dir%>/imgs/btn/goal_spot.gif";
            }
            
    	}
    }
    
}

/**
 * removeSpot()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보의 점을 삭제한다.
 * return값 : void
 */
function removeSpot(row){
    var pumbunCd = DS_MASTER.NameValue(row,"PUMBUN_CD");
    var spotObj = document.getElementById(pumbunCd);
    if( spotObj){
        document.getElementById("DIV_BACK_IMG").removeChild(spotObj);
    }
}

/**
 * clearSpot()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 도면의 위치 정보을 삭제한다.
 * return값 : void
 */
function clearSpot(){
	var imgList = document.getElementById("DIV_BACK_IMG").getElementsByTagName('img');
	var total = imgList.length;
	if( total < 2)
		return;
	var delList = new Array();
	for( var i = 0; i< total ; i++){		
		if( imgList[i].id != 'IMG_BACKGROUND'){
			delList.push(imgList[i]);
		}
	}

    for( var i = 0, len = delList.length; i< len ; i++){        
        document.getElementById("DIV_BACK_IMG").removeChild(delList[i]);        
    }
}
/**
 * checkMasterValidation()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 입력 값을 검증한다.
 * return값 : void
 */
function checkMasterValidation(){
    var row;
    var colid;
    var errYn = false;

    // 점코드 중복체크
    var dupRow = checkDupKey(DS_MASTER, "PUMBUN_CD");
    if (dupRow > 0) {
        showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);
        setFocusGrid(GD_MASTER,DS_MASTER,dupRow,"PUMBUN_CD");
        return ;
    }
    for(var i=1; i<=DS_MASTER.CountRow; i++){
        var rowStatus = DS_MASTER.RowStatus(i);
        if( !(rowStatus == "1" || rowStatus == "3") )
            continue;
        row = i;
        if( DS_MASTER.NameValue(i,"PUMBUN_CD")==""){
            showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"PUMBUN_NAME")==""){
            showMessage(EXCLAMATION, OK, "USER-1036", "브랜드코드");
            errYn = true;
            colid = "PUMBUN_CD";
            break;
        }
        if( DS_MASTER.NameValue(i,"SPOT_X")==""){
            showMessage(EXCLAMATION, OK, "USER-1008", "X좌표",0);
            errYn = true;
            colid = "SPOT_X";
            break;
        }
        if( DS_MASTER.NameValue(i,"SPOT_Y")==""){
            showMessage(EXCLAMATION, OK, "USER-1008", "Y좌표",0);
            errYn = true;
            colid = "SPOT_Y";
            break;
        }
        if( DS_MASTER.NameValue(i,"VIRE_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "요약정보표시여부");
            errYn = true;
            colid = "VIRE_YN";
            break;
        }
        if( DS_MASTER.NameValue(i,"RETAIL_VIEW_YN")==""){
            showMessage(EXCLAMATION, OK, "USER-1002", "상세팝업여부");
            errYn = true;
            colid = "RETAIL_VIEW_YN";
            break;
        }
        
    }
    
    if(errYn){
        setFocusGrid(GD_MASTER,DS_MASTER,row,colid);
        return false;
    }
    return true;
}

/**
 * onImgLoadError()
 * 작 성 자 : 
 * 작 성 일 : 2010-04-04
 * 개    요 : 이미지 로드 실패 시 실행.
 * return값 : void
 */
function onImgLoadError(){

    DIV_BACK_IMG_NO.style.display="";
    DIV_BACK_IMG.style.display="none";
   
}
-->


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

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>

<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
     var errorCode = DS_MASTER.ErrorCode;

     if(errorCode == "50019"){
         showMessage(EXCLAMATION, OK, "USER-1044");
     }else if( errorCode == "50018"){
         showMessage(EXCLAMATION, OK, "USER-1003", "브랜드코드");
     }else{
         showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
     }
</script>

<script language=JavaScript for=DS_MASTER event=OnRowPosChanged(row)>
    if(row < 1)
    	return;
    
    selSpot(row);
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<!-- 팝업  -->
<script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    if(row < 1){
        return;
    }
    isOnPopup = true;
    switch(colid){
        case 'PUMBUN_CD':
        	setPumbunCodeToGridMulti('POP', row);
            break;
            
    }
    isOnPopup = false;
</script>
<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 || isOnPopup){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'PUMBUN_CD':
        	setPumbunCodeToGridMulti('NAME', row);
            break;
        case 'SPOT_X':
        case 'SPOT_Y':
        	if( DS_MASTER.NameValue(row,"PUMBUN_CD") != ""){
        	    var imgWidth  = IMG_BACKGROUND.clientWidth;
        	    var imgHeight = IMG_BACKGROUND.clientHeight;
        	    
        		if(colid=='SPOT_X'){
        			if( imgWidth < value){
        				showMessage(EXCLAMATION, OK, "USER-1021", "X좌표","도면 가로("+imgWidth+")");
        				DS_MASTER.NameValue(row,"SPOT_X") = 0;
        			}
        		}else{
                    if( imgHeight < value){
                        showMessage(EXCLAMATION, OK, "USER-1021", "Y좌표","도면 세로("+imgHeight+")");
                        DS_MASTER.NameValue(row,"SPOT_Y") = 0;
                    }
        			
        		}
                setSpot(row);
        	}
            break;
    
    }
</script>

<!-- 점 (조회) -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    
    if( bfStrCd != this.BindColVal){
    	
    	if( DS_MASTER.IsUpdated || DS_FLOOR_PLAN.IsUpdated){
            // 변경된 상세내역이 존재합니다. 점을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","점") != 1 ){
                setComboData(LC_STR_CD,bfStrCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_FLOOR_PLAN.ClearData();
        DS_MASTER.ClearData();
        clearSpot();
        onImgLoadError();
    	// MARIO OUTLET START 2011.08.17
        enableControl(IMG_RESET_ROW,false);
    	enableControl(IMG_ADD_ROW,false);
    	enableControl(IMG_DEL_ROW,false);
    	GD_MASTER.Editable = false;
    	// MARIO OUTLET END
        enableControl(IMG_FILE_OPEN,false);
    }
    bfStrCd = this.BindColVal;
</script>

<!-- 층 (조회) -->
<script language=JavaScript for=LC_FLOOR_CD event=OnSelChange()>
    if( bfFloorCd != this.BindColVal){
        if( DS_MASTER.IsUpdated || DS_FLOOR_PLAN.IsUpdated){
            // 변경된 상세내역이 존재합니다. 층을 변경하시겠습니까?
            if( showMessage(QUESTION, YESNO, "USER-1063","층") != 1 ){
                setComboData(LC_FLOOR_CD,bfFloorCd);
                GD_MASTER.Focus();
                return;
            }
        }
        DS_FLOOR_PLAN.ClearData();
        DS_MASTER.ClearData();
        clearSpot();
        onImgLoadError();
     	// MARIO OUTLET START 2011.08.17
        enableControl(IMG_RESET_ROW,false);
    	enableControl(IMG_ADD_ROW,false);
    	enableControl(IMG_DEL_ROW,false);
    	GD_MASTER.Editable = false;
    	// MARIO OUTLET END
        enableControl(IMG_FILE_OPEN,false);
    }
    bfFloorCd = this.BindColVal;
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

<comment id="_NSID_"><object id="DS_STR_CD"   classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_FLOOR_CD"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_FLOOR_PLAN"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id=INF_UPLOAD classid=<%=Util.CLSID_INPUTFILE%>
    style="position: absolute; left: 132px; top: 152px; width: 68px; height: 20px; visibility: hidden;">
    <param name="Text" value='FileOpen'>
    <param name="Enable" value="true">
</object>
</comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15" >

<!--공통 타이틀/버튼 -->
<%@ include file="/jsp/common/titleButton.jsp"%>
<!--공통 타이틀/버튼 // -->

<div id="testdiv" class="testdiv">

<table width="100%" border="0" cellspacing="0" cellpadding="0" >
  <tr>
    <td width=300px valign="top"  class="PT01 PB03" >
      <table width="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
            <tr>
              <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                  <th width="50" class="point">점</th>
                  <td width="100">
                    <comment id="_NSID_">
                      <object id=LC_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                  <th width="50" class="point">층</th>
                  <td >
                    <comment id="_NSID_">
                      <object id=LC_FLOOR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=100 tabindex=1  align="absmiddle"></object>
                    </comment><script>_ws_(_NSID_);</script>
                  </td>
                </tr>
              </table></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class="dot"></td>
        </tr>
        <tr>
          <td class="sub_title PB03 PT03"><img
            src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
            align="absmiddle" /> 도면파일</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
              <td>                
                <comment id="_NSID_">
                  <object id=EM_FILS_LOC classid=<%=Util.CLSID_EMEDIT%> width=228 tabindex=1 align="absmiddle" ></object>
                </comment><script>_ws_(_NSID_);</script><img 
                src="/<%=dir%>/imgs/btn/file_search.gif" onclick="openFile();" align="absmiddle" tabindex=1 id="IMG_FILE_OPEN"/>
              </td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td class=" PT05 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="sub_title PB03"><img
                src="/<%=dir%>/imgs/comm/ring_blue.gif" class="PR03"
                align="absmiddle" /> 브랜드정보</td>
              <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/reset_row.gif"
                width="52" height="18" id="IMG_RESET_ROW" hspace="2"
                onClick="javascript:btn_resetRow();" /><img src="/<%=dir%>/imgs/btn/add_row.gif"
                width="52" height="18" id="IMG_ADD_ROW" hspace="2"
                onClick="javascript:btn_addRow();" /><img
                src="/<%=dir%>/imgs/btn/del_row.gif" width="52" height="18"
                id="IMG_DEL_ROW" onClick="javascript:btn_delRow();" /></td>
            </tr>
          </table>
          </td>
          
            
        </tr>
        <tr>
          <td><table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%">
            <tr>
              <td>
                <comment id="_NSID_"><object id=GD_MASTER width="100%" height=438 classid=<%=Util.CLSID_GRID%> tabindex=1>
                  <param name="DataID" value="DS_MASTER">
                </object></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table></td>
        </tr>
      </table>
    </td>
    <td class="PL05 PT01"><table width="100%" height="552" border="0" cellspacing="0" cellpadding="0" class="s_table">
      <tr>
        <td class="PT01 PB03"><div onContextMenu="return false;"
          style="position:relative;height:548px; 
          width:100%;border:0px;" id="DIV_FLOOR_PLAN">
            <div id="DIV_BACK_IMG" style="position:absolute;top:0px;left:0px; display:none;
              overflow:auto;width:100%;height:548px;" align="center"  ><img onmousedown="javascript:onClickFloorPlan();" onerror="javascript:onImgLoadError();"
              id="IMG_BACKGROUND" src= "/<%=dir%>/imgs/comm/ms03.gif" />
            </div>
            <div id="DIV_BACK_IMG_NO" style="position:absolute;top:0px;left:0px;
              overflow:auto;width:100%;height:548px;" align="center">
              <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" height="548px" style="border:0px;">
                <tr>                
                  <td style="border:0px;" width="50%" class="right"><img src= "/<%=dir%>/imgs/comm/ms03.gif" show=false ></td>                
                  <td style="border:0px;" valign="middle" > 도면 파일이 존재하지 않습니다.</td>
                </tr>
              </table>
            </div>
          </div>          
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</div>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>

<comment id="_NSID_">
<object id=BO_HEADER classid=<%= Util.CLSID_BIND %>>
    <param name=DataID value=DS_FLOOR_PLAN>
    <param name="ActiveBind" value=true>
    <param name=BindInfo
        value='
            <c>col=FILENAME          ctrl=EM_FILS_LOC             param=Text</c>            
        '>
</object>
</comment>
<script>_ws_(_NSID_);</script>
</body>
</html>

