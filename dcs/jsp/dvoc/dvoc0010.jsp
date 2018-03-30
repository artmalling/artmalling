<!-- 
/*******************************************************************************
 * 시스템명 : 경영지원 > 고객관리 > VOC관리 > 컴플레인등록
 * 작 성 일 : 2016.11.28
 * 작 성 자 : 윤지영
 * 수 정 자 : 
 * 파 일 명 : dvoc0010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : VOC를 관리 한다.
 * 이    력 :
 *        2016.11.28 (윤지영) 신규작성 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ page import="common.vo.SessionInfo" %>
<%@ page import="common.util.Util"  %>
<%@ page import="kr.fujitsu.ffw.base.BaseProperty"  %>

<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld" prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld" prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld" prefix="button"%>

<!--*************************************************************************-->
<!--* A. 로그인 유무, 기본설정                                                                                                                      *-->
<!--*************************************************************************-->
<loginChk:islogin />
<%
    String dir = BaseProperty.get("context.common.dir");
%>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<link href="/<%=dir%>/css/mds.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/<%=dir%>/js/common.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/gauce.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/global.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/message.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup.js" type="text/javascript"></script> 
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>
<script language="javascript" src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                                                                                                    *-->
<!--*************************************************************************-->
<script LANGUAGE="JavaScript">

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
 
 /**
 * doInit()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개       요     : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top = 480;		//해당화면의 동적그리드top위치
 function doInit(){
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	
    strToday = getTodayDB("DS_O_RESULT");
	
    // Input, Output Data Set Header 초기화
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    
    //그리드 초기화
    gridCreate1(); //마스터

    //콤보 초기화[조회부] 
    initComboStyle(LC_S_STR, DS_O_S_STR, "CODE^0^30,NAME^0^80", 1, PK);          	  //점구분[조회]
    initComboStyle(LC_S_PROC_GBN, DS_O_S_PROC_GBN, "CODE^0^30,NAME^0^80", 1, PK);     //처리구분[조회] -  M015
    initComboStyle(LC_S_CLM_KIND, DS_O_S_CLM_KIND, "CODE^0^30,NAME^0^80", 1, NORMAL); //클레임종류[조회] -  M010
     
    //콤보 초기화[입력부] 
    initComboStyle(LC_CLM_GRADE, DS_I_CLM_GRADE, "CODE^0^30,NAME^0^80", 1, PK);       //클레임등급 -  M011
    initComboStyle(LC_REC_TYPE, DS_I_REC_TYPE, "CODE^0^30,NAME^0^80", 1, PK);         //접수형태  -  M012 
    initComboStyle(LC_STR_CD, DS_I_STR, "CODE^0^30,NAME^0^80", 1, PK);                //점
    initComboStyle(LC_CLM_KIND, DS_I_CLM_KIND, "CODE^0^30,NAME^0^80", 1, PK);         //클레임종류 -  M010
    initComboStyle(LC_PROC_GBN, DS_I_PROC_GBN, "CODE^0^30,NAME^0^80", 1, READ);         //처리구분  -  M015 
     
    initEmEdit(EM_S_REC_DT, "TODAY", PK);          //접수기간FROM[조회]
    initEmEdit(EM_E_REC_DT, "TODAY", PK);          //접수기간TO[조회]      
    initEmEdit(EM_S_CUST_NAME, "GEN^25", NORMAL);  //고객명[조회]
    initEmEdit(EM_S_REC_TITLE, "GEN^500", NORMAL); //제목[조회]   
    
    initEmEdit(EM_CUST_ID,   "GEN^25", NORMAL);    //회원번호 
    initEmEdit(EM_CUST_NAME, "GEN^25", PK);        //고객명 
    initEmEdit(EM_MOBILE_PH1, "0000",  PK);        //전화번호
    initEmEdit(EM_MOBILE_PH2, "0000",  PK);  
    initEmEdit(EM_MOBILE_PH3, "0000",  PK);    
    initEmEdit(EM_SALE_ORG_CD, "CODE^10", NORMAL);   //판매조직
    initEmEdit(EM_SALE_ORG_NM, "GEN^40", READ);    //판매조직명 
    initEmEdit(EM_PUMBUN_CD,   "CODE^10", NORMAL);//브랜드
    initEmEdit(EM_PUMBUN_NAME, "GEN^40", READ);   //브랜드명
    initEmEdit(EM_REC_DT,      "TODAY" , PK);     //접수일자 
    initEmEdit(EM_REC_ID,     "CODE^10", READ);     //접수자사번 
    initEmEdit(EM_REC_NAME,   "GEN^40", READ);    //접수자명
    
    initEmEdit(EM_SUBJECT,    "GEN^50", PK);    //제목
    initEmEdit(TXT_EM_MEMO,   "GEN^1000", PK); //내용
    initEmEdit(TXT_EM_MEMO_S, "GEN^1000", PK);//요약  
  	
    getStore("DS_O_S_STR", "N", "", "N");
    DS_O_S_STR.Filter();     //점구분 : 지점만 셋팅 
    getEtcCode("DS_O_S_CLM_KIND", "M", "M010", "Y");
    getEtcCode("DS_O_S_PROC_GBN", "M", "M015", "Y"); 
    getEtcCode("DS_I_CLM_GRADE", "M", "M011", "N");
    getEtcCode("DS_I_REC_TYPE", "M", "M012", "N");  
    getStore("DS_I_STR", "N", "", "N");
    DS_I_STR.Filter();     //점구분 : 지점만 셋팅
    getEtcCode("DS_I_CLM_KIND", "M", "M010", "N");
    getEtcCode("DS_I_PROC_GBN", "M", "M015", "N");
    getEtcCode("DS_I_PROC_DEPT", "M", "M016", "N");
    
    //초기값 셋팅
	LC_S_STR.Index = 0; 
	LC_S_STR.Focus(); 
	LC_S_CLM_KIND.Index = 0;
	LC_S_PROC_GBN.Index = 0; 
	LC_CLM_GRADE.Index = 0;
	LC_REC_TYPE.Index = 0; 
	
	//컨트롤 셋팅
	setGrid();

    //화면에서 사용자가 입력,수정,삭제 한 데이터가 있는지 확인하는 함수-해당 페이지를 닫을 때 ‘저장하시겠습니까?’ 로직 처리를 위해 필요함
    registerUsingDataset("dvoc001","DS_IO_MASTER");
 }

 function gridCreate1(){ 
	 
	var hdrProperies = 
		  '<FC>id={currow}    	  name="NO"       	    width=30    	align=center 	 </FC>'
        + '<FC>id=STR_CD          name="점"             width=86    	align=center     show=false</FC>' 
        + '<FC>id=REC_DT          name="접수일자"       width=86    	align=center     mask="XXXX/XX/XX" </FC>'
        + '<FC>id=REC_SEQ         name="접수번호"     	width=70    	align=center     </FC>' 
        + '<FC>id=REC_CONT        name="내용"       	width=86    	align=center     show=false</FC>'
        + '<FC>id=REC_SUMMARY     name="요약"           width=86    	align=center     show=false</FC>'
        + '<FC>id=CLM_KIND        name="클레임종류"     width=100    	align=left     Editstyle=lookup    Data="DS_I_CLM_KIND:CODE:NAME"</FC>'
        + '<FC>id=REC_TITLE       name="제목"      	    width=150    	align=left     </FC>'
        + '<FC>id=BRAND_CD   	  name="브랜드"         width=120   	align=left       show=false</FC>' 
        + '<FC>id=PUMBUN_NAME     name="브랜드"         width=110   	align=left       </FC>' 
        + '<FC>id=CLM_GRADE       name="클레임등급"     width=86    	align=center     show=false</FC>' 
        + '<FC>id=MBR_GBN         name="고객구분"       width=110   	align=center     show=false</FC>'  
        + '<FC>id=CUST_NAME       name="고객명"         width=110  		align=left       </FC>'
        + '<FC>id=MOBILE_PH       name="연락처"         width=120   	align=left       </FC>'
        + '<FC>id=MOBILE_PH1      name="연락처1"        width=120   	align=left       show=false</FC>'
        + '<FC>id=MOBILE_PH2      name="연락처2"        width=110   	align=left       show=false</FC>'
        + '<FC>id=MOBILE_PH3      name="연락처3"        width=110   	align=left       show=false</FC>' 
        + '<FC>id=CUST_ID         name="회원번호"       width=110   	align=left       </FC>'
        + '<FC>id=REC_TYPE        name="접수형태"       width=70    	align=center     Editstyle=lookup    Data="DS_I_REC_TYPE:CODE:NAME"</FC>'
        + '<FC>id=SALE_ORG_CD     name="브랜드판매조직" width=110   	align=left       show=false</FC>'  
        + '<FC>id=SALE_ORG_NM     name="브랜드판매조직명"  width=110   	align=left       show=false</FC>'  
        + '<FC>id=REC_ID   	  	  name="접수자"         width=90   	align=left       </FC>' 
        + '<FC>id=REC_NM   	  	  name="접수자명"       width=110   	align=left       show=false</FC>' 
        + '<FC>id=PROC_GBN   	  name="처리구분"       width=80   	align=left       Editstyle=lookup    Data="DS_I_PROC_GBN:CODE:NAME"</FC>' 
        + '<FC>id=PROC_DEPT   	  name="조치부서"       width=110   	align=left       show=false</FC>'  
        ;
         
   initGridStyle(GR_MASTER, "COMMON", hdrProperies, false);  
 } 

/*************************************************************************
 * 2. 공통버튼
     (1) 조회       - btn_Search(), subQuery()
     (2) 신규       - btn_New()
     (3) 저장       - btn_Save()
     (4) 엑셀       - btn_Excel()
     
 *************************************************************************/
 
 /**
 * btn_Search()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개       요     : 조회시 호출
 * return값 : void
 */
 function btn_Search() {
	 
	if (DS_IO_MASTER.IsUpdated) {
		if(showMessage(StopSign, YESNO, "USER-1059") != 1 ){
			setTimeout("LC_CLM_GRADE.Focus();",50);
	        return false;
		} 
    }  
    
    if(!checkValidation("Search"))    // validation 체크
        return;
    
	//조회
	var strJumCd       = LC_S_STR.BindColVal; 
	var strFromDt      = EM_S_REC_DT.text;
	var strToDt        = EM_E_REC_DT.text;   
	var strClmKind     = LC_S_CLM_KIND.BindColVal;
	var strProcGbn     = LC_S_PROC_GBN.BindColVal; 
	var strCustNm      = EM_S_CUST_NAME.text;  
	var strTitle       = EM_S_REC_TITLE.text;  

	
	DS_IO_MASTER.ClearData(); 
	
    var parameters  = "&strJumCd=" 		+ encodeURIComponent(strJumCd) 
                      + "&strFromDt=" 	+ encodeURIComponent(strFromDt)
                      + "&strToDt="     + encodeURIComponent(strToDt)
                      + "&strClmKind=" 	+ encodeURIComponent(strClmKind)
                      + "&strProcGbn="  + encodeURIComponent(strProcGbn) 
    				  + "&strCustNm="   + encodeURIComponent(strCustNm) 
    				  + "&strTitle="    + encodeURIComponent(strTitle)  
    				  ;
     
    TR_MAIN.Action  = "/dcs/dvoc001.dv?goTo=searchMaster"+parameters;  
    TR_MAIN.KeyValue="SERVLET(O:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    
    //조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow); 
    
 } 
	
 /**
 * btn_New()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개       요     : 신규시 호출
 * return값 : void
 */
 function btn_New(){
	 
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.CountRow, "REC_SEQ") == ""){
        if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
            return;
        }else{
            DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        }
    }  
    
   	DS_IO_MASTER.Addrow();   
   	
   	//값 셋팅
	LC_CLM_GRADE.Index = 0;  //클레임등급 
	LC_REC_TYPE.Index = 0;   //접수형태
	LC_STR_CD.Index = 0;     //점
	LC_PROC_GBN.Index = 0;   //처리구분:0(접수)
	LC_CLM_KIND.Index = 0;   //클레임 종류 
	RD_MBR_GBN.CodeValue = "0";//고객구분  
	EM_REC_DT.Text = strToday;  //접수일자 
	LC_CLM_GRADE.Focus(); 
	//컨트롤 셋팅
	setGrid(); 
       
 }
 
 /**
 * btn_Delete()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요        : 삭제버튼 클릭 (신규등록일 경우 DS_IO_MASTER 삭제, 기존데이터일 경우 삭제 Action실행)
 * return값 : void
 */
 function btn_Delete() {
      
     // 삭제할 데이터 없는 경우
     if (DS_IO_MASTER.CountRow == 0){
         showMessage(EXCLAMATION, OK, "USER-1019");
         return;
     }

     // 신규 전표인 경우 데이터셋에서만 삭제
     if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REC_SEQ").length == 0){ 
         DS_IO_DETAIL.DeleteRow(DS_IO_DETAIL.RowPosition);
         return;
     }
     
     if(!checkValidation("Delete")) 
         return;
     
     // 삭제 메세지 
     if(showMessage(QUESTION, YESNO, "USER-1023") == 1){
         // 기존데이터일 경우 삭제 Action실행 
         var params = "&strFlag=delete"
                    + "&strStrCd="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD"))
                    + "&strRecDt="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REC_DT"))
                    + "&strRecSeq="+encodeURIComponent(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "REC_SEQ"));
         
         DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition); 
         TR_SAVE.Action="/dcs/dvoc001.dv?goTo=save"+params;  
         TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
         TR_SAVE.Post(); 
      }

 }
  
 /**
 * btn_Save()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
 function btn_Save() {
    // 저장할 데이터 없는 경우
    if (!DS_IO_MASTER.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }  

    if(!checkValidation("Save"))    // validation 체크
        return;
    
    if(DS_IO_MASTER.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "데이터 입력 후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    } 
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") == 1 ){ 
    	
        var params = "&strFlag=save";
        
        TR_SAVE.Action="/dcs/dvoc001.dv?goTo=save"+params;  
        TR_SAVE.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
        TR_SAVE.Post();

    }   
 } 
	
/*************************************************************************
 * 3. 함수
 *************************************************************************/  
 /**
 * checkValidation()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요        : 조회조건 값 체크 
 * return값 : void
 */
 function checkValidation(Gubun) {
      
	var messageCode = "USER-1001";
      
    //조회버튼 클릭시 Validation Check
	if(Gubun == "Search"){   
		if(LC_S_STR.Text.length == 0){                                 // 점
		      showMessage(EXCLAMATION, OK, messageCode, "점");
		      LC_S_STR.Focus();
		      return false;
		}   
		if(EM_S_REC_DT.Text.length == 0){                              // 조회일 정합성
		     showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
		     EM_S_START_DT.Focus();
		     return false;
		}
	    if(EM_E_REC_DT.Text.length == 0){                              // 조회일 정합성
	        showMessage(EXCLAMATION, OK, "USER-1002", "조회종료일");
	        EM_S_END_DT.Focus();
	        return false;
	    }
	    if(EM_S_REC_DT.Text > EM_E_REC_DT.Text){                       // 조회일 정합성
	         showMessage(EXCLAMATION, OK, "USER-1015");
	         EM_S_START_DT.Focus();
	         return false;
	    }
	}
      
	// 저장버튼 클릭시 Validation Check
	if(Gubun == "Save"){
     	
		if(LC_CLM_GRADE.Text.length == 0){                                 // 클레임등급
		    showMessage(EXCLAMATION, OK, "USER-1002", "클레임등급");
		    LC_CLM_GRADE.Focus();
		    return false;
		}
         
        if(LC_REC_TYPE.Text.length == 0){                                    // 접수형태
           showMessage(EXCLAMATION, OK, "USER-1002", "접수형태");
           LC_REC_TYPE.Focus();
           return false;
        }  
        
        if(EM_CUST_NAME.Text.length == 0){                                   // 고객명
           showMessage(EXCLAMATION, OK, "USER-1003", "고객명");
           EM_CUST_NAME.Focus(); 
           return false;
        } 
         
        
        if(EM_MOBILE_PH1.Text.length+EM_MOBILE_PH2.Text.length+EM_MOBILE_PH3.Text.length == 0){  // 전화번호
            showMessage(EXCLAMATION, OK, "USER-1003", "전화번호");
            EM_MOBILE_PH1.Focus(); 
            return false;
         }  
        
        
        if(LC_STR_CD.Text.length == 0){                                   // 점
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
            LC_STR_CD.Focus(); 
            return false;
        }  
        
        if(LC_PROC_GBN.Text.length == 0){                                 // 처리구분
            showMessage(EXCLAMATION, OK, "USER-1002", "처리구분");
            LC_PROC_GBN.Focus(); 
            return false;
        }  
        
        if(LC_CLM_KIND.Text.length == 0){                                 // 클레임종류
            showMessage(EXCLAMATION, OK, "USER-1002", "클레임종류");
            LC_CLM_KIND.Focus(); 
            return false;
        } 
        
        if(EM_REC_DT.Text.length == 0){                                 //  접수일자
            showMessage(EXCLAMATION, OK, "USER-1002", "접수일자");
            EM_REC_DT.Focus(); 
            return false;
        } 
        
        if(EM_SUBJECT.Text.length == 0){                                 //  제목
            showMessage(EXCLAMATION, OK, "USER-1003", "제목");
            EM_SUBJECT.Focus(); 
            return false;
        } 
        
        if(TXT_EM_MEMO.Text.length == 0){                                 //  내용
            showMessage(EXCLAMATION, OK, "USER-1003", "내용");
            TXT_EM_MEMO.Focus(); 
            return false;
        } 
        
		if(TXT_EM_MEMO_S.Text.length == 0){                              //  요약
		    showMessage(EXCLAMATION, OK, "USER-1003", "요약");
		    TXT_EM_MEMO_S.Focus(); 
		    return false;
		} 
        
		var intRowCount   = DS_IO_MASTER.CountRow;
        
        if(intRowCount > 0){
            for(var i=1; i <= intRowCount; i++){ 
                if(DS_IO_MASTER.NameValue(i, "CUST_NAME")==""){
                    showMessage(EXCLAMATION, OK, "USER-1001", "고객명");
                    GR_MASTER.SetColumn("CUST_NAME");  
                    DS_IO_MASTER.RowPosition = i;  
                    return false;
                }
            }
        }    
	}
      
	if(Gubun == "Delete"){
        if(LC_PROC_GBN.BindColVal != "0"){ // 처리구분(0:접수)
        	showMessage(EXCLAMATION, OK, "USER-1000", "처리구분이 접수인 경우만 삭제 할 수 있습니다. 처리구분을 확인해주세요.");
            LC_PROC_GBN.Focus(); 
            return false;
        }  	  
	}
	return true; 
 }
 
 
 /**
 * setGrid()
 * 작 성 자     : 윤지영
 * 작 성 일     : 2016-11-28
 * 개    요       : 처리구분에 따른 컨트롤 제어 
 * return값 : void
 */
 function setGrid(){
	
	//처리구분 (0:접수,1:해결,2:미해결,3:보류)
    var strProcGbn = LC_PROC_GBN.BindColVal; 
	 
	if(strProcGbn == "0" ){ //접수인경우 등록 가능
		enableControl(LC_CLM_GRADE    ,true);
		enableControl(LC_REC_TYPE     ,true); 
		enableControl(EM_CUST_ID      ,true);
		enableControl(EM_CUST_NAME    ,true);
		enableControl(EM_MOBILE_PH1   ,true);
		enableControl(EM_MOBILE_PH2   ,true);
		enableControl(EM_MOBILE_PH3   ,true);
		enableControl(LC_STR_CD       ,true);
		enableControl(EM_SALE_ORG_CD  ,true);
		enableControl(EM_SALE_ORG_NM  ,true); 
		enableControl(EM_PUMBUN_CD    ,true);
		enableControl(IMG_PUMBUN_CD   ,true);
		enableControl(EM_PUMBUN_NAME  ,true);
		enableControl(LC_CLM_KIND     ,true);
		enableControl(EM_REC_DT       ,true); 
		enableControl(imgOrgcd        ,true);
		enableControl(EM_REC_ID       ,true);
		enableControl(EM_REC_NAME     ,true); 
		enableControl(EM_SUBJECT      ,true); 
		TXT_EM_MEMO.Enable = true;
		TXT_EM_MEMO_S.Enable = true;
		RD_MBR_GBN.Enable = true;  
		
	} else {
		enableControl(LC_CLM_GRADE    ,false);
		enableControl(LC_REC_TYPE     ,false); 
		enableControl(EM_CUST_ID      ,false);
		enableControl(EM_CUST_NAME    ,false);
		enableControl(EM_MOBILE_PH1   ,false);
		enableControl(EM_MOBILE_PH2   ,false);
		enableControl(EM_MOBILE_PH3   ,false);
		enableControl(LC_STR_CD       ,false);
		enableControl(EM_SALE_ORG_CD  ,false);
		enableControl(EM_SALE_ORG_NM  ,false); 
		enableControl(EM_PUMBUN_CD    ,false);
		enableControl(IMG_PUMBUN_CD   ,false);
		enableControl(EM_PUMBUN_NAME  ,false);
		enableControl(LC_CLM_KIND     ,false);
		enableControl(EM_REC_DT       ,false); 
		enableControl(imgOrgcd        ,false);
		enableControl(EM_REC_ID       ,false);
		enableControl(EM_REC_NAME     ,false); 
		enableControl(EM_SUBJECT      ,false);
		TXT_EM_MEMO.Enable = false;
		TXT_EM_MEMO_S.Enable = false; 
		RD_MBR_GBN.Enable = false;
	}   
 }
 
 /**
  * getVocPop()
  * 작 성 자 : 윤지영
  * 작 성 일 : 2016-11-28
  * 개    요 : 조치결과 POPUP 호출
  * return값 :
  */
 function getVocPop() { 
	var strStrCd    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"STR_CD");  //점
	var strRecDt    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REC_DT");   //접수일자
	var strRecSeq   = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REC_SEQ");  //접수번호
	var strProcDept = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_DEPT");//처리부서
	var strRecId    = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"REC_ID");   //처리담당자
	var strProcGbn  = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"PROC_GBN"); //처리구분 
	   
	var arrArg  = new Array();
	
	arrArg.push(strStrCd);
	arrArg.push(strRecDt);
	arrArg.push(strRecSeq);
	arrArg.push(strProcDept);
	arrArg.push(strRecId);
	arrArg.push(strProcGbn); 

	if(DS_IO_MASTER.CountRow >= 1) { 
		var row = DS_IO_MASTER.RowPosition;  
		var returnVal = window.showModalDialog(//"/dcs/dvoc001.dv?goTo=getVocPop",
						"/dcs/jsp/dvoc/dvoc0011.jsp?",
						arrArg,
						"dialogWidth:900px;dialogHeight:230px;scroll:no;" +
						"resizable:no;help:no;unadorned:yes;center:yes;status:no");
		
		btn_Search();//재조회
		DS_IO_MASTER.RowPosition = row;  
   } else {
		showMessage(INFORMATION, OK, "USER-1000", "컴플레인 조회 후 등록 가능합니다.");
		   return;
   }
 }
 
 /** 
 * getOrgPop()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-28
 * 개    요 : 조직 팝업을 실행한다.
 * return값 : void
 */
 function getOrgPop( orgCdObj , orgNmObj, flag){
 	if( LC_STR_CD.BindColVal == ''){
         // (점)은/는 반드시 선택해야 합니다.
         showMessage(EXCLAMATION, OK, "USER-1002", "점");
         LC_STR_CD.Focus();
         return;
 	}
 	var rtnVal = orgPop( orgCdObj, orgNmObj, 'N','','',flag=='BUY'?'2':'1',flag=='BUY'?'4':'5','Y',LC_STR_CD.BindColVal);
 	if(rtnVal != null){		
 		if(flag=='BUY'){
 			if( rtnVal.get("PC_CD") == "00" || rtnVal.get("CORNER_CD") !="00"){
 		        showMessage(EXCLAMATION, OK, "USER-1000", "매입조직은 PC 레벨에서 선택하여야 합니다.");
                 DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_CD") = "";
                 DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_BUYER_NM") = "";
 		        orgNmObj.Text = "";
 		        orgCdObj.Focus();
 		        return;			
 			}
 		} else{
             if(  rtnVal.get("CORNER_CD") =="00"){
                 showMessage(EXCLAMATION, OK, "USER-1000", "판매조직은 코너 레벨에서 선택하여야 합니다.");
                 DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_CD") = "";
                 DS_STRPBN.NameValue(DS_STRPBN.RowPosition, "CHAR_SM_NM") = "";
                 orgNmObj.Text = "";
                 orgCdObj.Focus();
                 return;         
             }			
 		}
 	    //searchMainBuyer(orgCdObj,flag);
 	} 
     orgCdObj.Focus();
 }
</script>
</head>

<!--*************************************************************************-->
<!--* B. 스크립트 끝                                                                                                                                       *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리                                                                                                                             *-->
<!--*    1. TR Success 메세지 처리                                                                                                        *-->
<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_MAIN.SrvErrMsg('UserMsg',i).split('|'); 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
</script>

<script language=JavaScript for=TR_SAVE event=onSuccess>
    for(i=0;i<TR_SAVE.SrvErrCount('UserMsg');i++) {
        var strMsg = TR_SAVE.SrvErrMsg('UserMsg',i).split('|'); 
        showMessage(INFORMATION, OK, "USER-1000", strMsg[0]);
    }
    btn_Search();
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>  
<script language=JavaScript for=TR_SAVE event=onFail>
    trFailed(TR_SAVE.ErrorMsg);
</script>  
<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  -------------------------------> 
<script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)> 
    if(clickSORT) return;  
    if(row == 0){ 
    	DS_IO_MASTER.ClearData();
    } 
    setGrid();
</script>   

<!--------------------- 6. 컴포넌트 이벤트 처리  --------------------------------> 
<!-- 판매조직정보 변경시 -->
<script language=JavaScript for=EM_SALE_ORG_CD event=OnKillFocus()>
	//[입력용]판매조직코드  자동완성 및 팝업호출 
	if(!this.Modified)
        return;
     
    if(this.text==''){
    	EM_SALE_ORG_NM.Text = "";
        return;
    }  
	
    //단일건 체크 
    setOrgNmWithoutPop( "DS_O_RESULT", this, EM_SALE_ORG_NM, '0'); 
</script>  

<!-- 품번 변경시 --> 
<script language=JavaScript for=EM_PUMBUN_CD event=OnKillFocus()>
	//[입력용]품번코드  자동완성 및 팝업호출 
	if(!this.Modified)
        return;
     
    if(this.text==''){
    	EM_PUMBUN_NAME.Text = "";
        return;
    }  
	
    //단일건 체크 
    setStrPbnNmWithoutPop( "DS_O_RESULT", this, EM_PUMBUN_NAME, '0'); 
</script> 

<!--*************************************************************************-->
<!--*************************************************************************-->
<!--* C. 가우스 이벤트 처리    끝                                                *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                    *-->
<!--*    1. DataSet									  *-->
<!--*    2. Transaction								  *-->
<!--*************************************************************************-->
<!-- ===============- Input용,Output용 -->
<comment id="_NSID_">
<object id="DS_O_S_STR" classid=<%=Util.CLSID_DATASET%>>
	<param name=UseFilter value=true></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_S_CLM_KIND" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_S_PROC_GBN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CLM_GRADE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_REC_TYPE" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_STR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_CLM_KIND" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_PROC_GBN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_I_PROC_DEPT" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>> </object>
</comment>
<script>_ws_(_NSID_);</script> 
 

<!-- ===============- 공통함수용 -->
<comment id="_NSID_">
<object id="DS_I_COMMON" classid=<%=Util.CLSID_DATASET%>> </object>
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

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script> 

<comment id="_NSID_">
<object id="TR_SAVE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                            *-->
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
                <td><!-- search start -->
				<table width="100%" border="0" cellpadding="0" cellspacing="0"
					class="s_table">
					<tr>
						<th width="80" class="point">점</th>
						<td width="130"><comment id="_NSID_"> <object
							id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=120 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
						<th width="80" class="point">접수기간</th>
						<td width="210"><comment id="_NSID_"> <object
							id=EM_S_REC_DT classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=75 tabindex=1
							align="absmiddle"> </object></comment><script>_ws_(_NSID_);</script> <img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_S_REC_DT)" align="absmiddle" />
						~ <comment id="_NSID_"> <object id=EM_E_REC_DT
							classid=<%=Util.CLSID_EMEDIT%>
							onblur="javascript:checkDateTypeYMD(this);" width=75 tabindex=1
							align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script><img
							src="/<%=dir%>/imgs/btn/date.gif"
							onclick="javascript:openCal('G',EM_E_REC_DT)" align="absmiddle" />
						</td>			
				    	<th width="80" class="point">처리구분</th>
						<td width="140"><comment id="_NSID_"> <object
							id=LC_S_PROC_GBN classid=<%=Util.CLSID_LUXECOMBO%> height=100
							width=120 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script></td>		
					</tr>
					<tr>
						<th width="80">클레임종류</th>
						<td width="80"><comment id="_NSID_"> <object
								id=LC_S_CLM_KIND classid=<%=Util.CLSID_LUXECOMBO%> width=120
								tabindex=1 ></object> </comment> <script> _ws_(_NSID_);</script></td>	  
						<th width="80">고객명</th>
						<td width="140">
	                        <comment id="_NSID_">
	                             <object id=EM_S_CUST_NAME classid=<%=Util.CLSID_EMEDIT%>   width="200" tabindex=1 align="absmiddle" tabindex=1>
	                             </object>
	                         </comment><script> _ws_(_NSID_);</script></td>	
							
														
						<th width="80">제목</th>
						<td><comment id="_NSID_">
	                             <object id=EM_S_REC_TITLE classid=<%=Util.CLSID_EMEDIT%>   width="200" tabindex=1 align="absmiddle" tabindex=1>
	                             </object>
	                         </comment><script> _ws_(_NSID_);</script> </td>					
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
    
   <tr align="right">
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td class="right"> 
             <img src="/<%=dir%>/imgs/btn/btn_result.gif" id="IMG_ADD"   hspace="2" onclick="javascript:getVocPop();" /> 
           </td>
         </tr>
      </table>
    </td>
  </tr>
    
    <tr>
        <td class="PT01">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
            <tr>
                <th width="100" class="point">클레임등급</th>
	                <td width="190"><comment id="_NSID_"> <object
						id=LC_CLM_GRADE classid=<%=Util.CLSID_LUXECOMBO%> width=140
						tabindex=1></object> </comment> <script> _ws_(_NSID_);</script>
	                 </td>
                 <th width="100" class="point">접수형태</th>
	                <td width="190"><comment id="_NSID_">
	                    <object  id=LC_REC_TYPE classid=<%=Util.CLSID_LUXECOMBO%> width=140 tabindex=1> </object> </comment> 
	                    <script> _ws_(_NSID_);</script>
	                 </td>       
                 <th width="100" class="point">고객구분</th>      
	                 <td><comment id="_NSID_"><object id=RD_MBR_GBN
						classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 100"
						align="absmiddle" tabindex=5>
						<param name=Cols value="2">
						<param name=Format value="0^일반,1^회원">
						<param name="AutoMargin" value="true">
						<param name=CodeValue value="0"></object></comment> <script> _ws_(_NSID_);</script>
					 </td>
            </tr>
            <tr>
            	<th width="100">회원번호</th>
					<td><comment id="_NSID_"> <object id=EM_CUST_ID
						classid=<%=Util.CLSID_EMEDIT%> width=140 tabindex=5 
						align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script> 
					</td> 
                <th width="100" class="point">고객명</th>
					<td><comment id="_NSID_"> <object
						id=EM_CUST_NAME classid=<%=Util.CLSID_EMEDIT%> width=138
						tabindex=5
						onkeyup="javascript:checkByteStr(EM_CUST_NAME, 40, '');"
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>       
                 <th width="100" class="point">전화번호</th> 
                 	<td>
                 		<comment id="_NSID_"> <object id=EM_MOBILE_PH1
						classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
						align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script>-
						<comment id="_NSID_"> <object id=EM_MOBILE_PH2
						classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
						align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script>-
						<comment id="_NSID_"> <object id=EM_MOBILE_PH3
						classid=<%=Util.CLSID_EMEDIT%> width=30 tabindex=5
						align="absmiddle"></object>
						</comment> <script> _ws_(_NSID_);</script>
                 	</td>      
            </tr>
            <tr>
				<th width="100" class="point">점</th>
					<td><comment id="_NSID_"> <object
						id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> height=100
						width=140 align="absmiddle" tabindex=1> </object> </comment><script>_ws_(_NSID_);</script></td>
				<th width="100">판매조직</th>
					<td><comment id="_NSID_"> <object
						id=EM_SALE_ORG_CD classid=<%=Util.CLSID_EMEDIT%> width=70
						tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
						<comment id="_NSID_"> 
						<img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03"
						onclick="javascript:getOrgPop(EM_SALE_ORG_CD,EM_SALE_ORG_NM,'BUY');" id=imgOrgcd
						align="absmiddle" /> <object
						id=EM_SALE_ORG_NM classid=<%=Util.CLSID_EMEDIT%> width=90
						tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
					</td>  
				<th width="100" class="point">처리구분</th>
					<td ><comment id="_NSID_"> <object
						id=LC_PROC_GBN classid=<%=Util.CLSID_LUXECOMBO%> height=100
						width=140 tabindex=1> </object> </comment> <script> _ws_(_NSID_);</script>
					</td>	           
            </tr>    
            <tr>
            	 <th width="100">브랜드</th>
					 <td><comment id="_NSID_"> <object
						id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=45
						tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
					    <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" id=IMG_PUMBUN_CD
						onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME,'Y','',LC_STR_CD.bindcolval,'','','','','Y');EM_PUMBUN_CD.focus();"
						align="absmiddle" /> <comment id="_NSID_"> <object
						id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=115
						tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
					 </td> 
				 <th width="100" class="point">클레임종류</th>
					 <td><comment id="_NSID_"> <object
						id=LC_CLM_KIND classid=<%=Util.CLSID_LUXECOMBO%> width=140
						tabindex=1 align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script>
					 </td>		
                 <th width="100" class="point">접수일자</th>
                   <td><comment id="_NSID_"> <object
                        id=EM_REC_DT classid=<%=Util.CLSID_EMEDIT%> width=118 tabindex=1
                        align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> <img
                        src="/<%=dir%>/imgs/btn/date.gif" align="absmiddle"
                        onclick="javascript:openCal('G',EM_REC_DT)" />
                 	</td>      
		     </tr>  
			 <tr> 
			 	<th width="100" class="point">접수자</th>
	                <td colspan="5"><comment id="_NSID_"> <object
	                    id=EM_REC_ID classid=<%=Util.CLSID_EMEDIT%> width=70
	                    align="absmiddle" tabindex=1></object> </comment><script> _ws_(_NSID_);</script>  
	                    <comment id="_NSID_"> <object id=EM_REC_NAME
	                    classid=<%=Util.CLSID_EMEDIT%> width=90 align="absmiddle"
	                    tabindex=1></object> </comment><script>_ws_(_NSID_);</script></td>  
			</tr>   
			<tr>
				<th width="100" class="point">제목</th>
					<td colspan="5" ><comment id="_NSID_"> <object
						id=EM_SUBJECT classid=<%=Util.CLSID_EMEDIT%>  
						style="width: 100%;"
						tabindex=5
						onkeyup="javascript:checkByteStr(EM_SUBJECT, 50, '');"
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
		    </tr>   
		    <tr>
				<th width="100" class="point">내용</th>
					<td colspan="5"><comment id="_NSID_"> <object
						id=TXT_EM_MEMO classid=<%=Util.CLSID_TEXTAREA%> 
						style="width: 100%; height: 100px;"
						tabindex=1
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO, 1000, 'Y');" 
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
					</td>  
		    </tr>
		    <tr>
				<th width="100">요약</th>
					<td colspan="5"><comment id="_NSID_"> <object
						id=TXT_EM_MEMO_S classid=<%=Util.CLSID_TEXTAREA%>  
						style="width: 100%; height: 60px;"
						tabindex=1 
						onkeyup="javascript:checkByteStr(TXT_EM_MEMO_S, 1000, 'Y');"
						align="absmiddle"></object> </comment> <script> _ws_(_NSID_);</script> 
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
	        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
	            <tr>
	                <td><comment id="_NSID_"> <object id=GR_MASTER width="100%" height=270 classid=<%=Util.CLSID_GRID%> tabindex=1>
	                    <param name="DataID" value=DS_IO_MASTER>
	                </object> </comment> <script>_ws_(_NSID_);</script></td>
	            </tr>
	        </table>
        </td>
    </tr>   
      
</table>
</div>
<!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
<object id=BD_IO_MASTER classid=<%=Util.CLSID_BIND%>>
	<param name=DataID value=DS_IO_MASTER>
	<param name="ActiveBind" value=true>
	<param name=BindInfo
		value=' 
        <c>Col=CLM_GRADE        Ctrl=LC_CLM_GRADE       param=BindColVal</c> 
        <c>Col=REC_TYPE         Ctrl=LC_REC_TYPE       	param=BindColVal</c> 
        <c>Col=MBR_GBN          Ctrl=RD_MBR_GBN       	param=CodeValue</c> 
        <c>Col=CUST_ID          Ctrl=EM_CUST_ID       	param=Text</c> 
        <c>Col=CUST_NAME        Ctrl=EM_CUST_NAME       param=Text</c> 
        
        <c>Col=MOBILE_PH1       Ctrl=EM_MOBILE_PH1      param=Text</c>
        <c>Col=MOBILE_PH2       Ctrl=EM_MOBILE_PH2      param=Text</c> 
        <c>Col=MOBILE_PH3       Ctrl=EM_MOBILE_PH3      param=Text</c>
        <c>Col=STR_CD        	Ctrl=LC_STR_CD       	param=BindColVal</c>
         
        <c>Col=SALE_ORG_CD      Ctrl=EM_SALE_ORG_CD     param=Text</c>
        <c>Col=SALE_ORG_NM      Ctrl=EM_SALE_ORG_NM     param=Text</c>
        <c>Col=PROC_GBN         Ctrl=LC_PROC_GBN       	param=BindColVal</c> 
        <c>Col=BRAND_CD         Ctrl=EM_PUMBUN_CD       param=Text</c>
        <c>Col=PUMBUN_NAME      Ctrl=EM_PUMBUN_NAME     param=Text</c>
        <c>Col=CLM_KIND         Ctrl=LC_CLM_KIND       	param=BindColVal</c> 
        <c>Col=REC_DT           Ctrl=EM_REC_DT       	param=Text</c>
        
        <c>Col=REC_ID           Ctrl=EM_REC_ID       	param=Text</c> 
        <c>Col=REC_NM           Ctrl=EM_REC_NAME       	param=Text</c> 
        <c>Col=REC_TITLE        Ctrl=EM_SUBJECT       	param=Text</c>
        <c>Col=REC_CONT         Ctrl=TXT_EM_MEMO       	param=Text</c>
        <c>Col=REC_SUMMARY      Ctrl=TXT_EM_MEMO_S      param=Text</c>  
        '>
</object>
</comment> 
<script>_ws_(_NSID_);</script>
</body>
</html> 
