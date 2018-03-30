<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 기준정보 > 기타관리> 타임아웃관리
 * 작 성 일 : 2010.07.05
 * 작 성 자 : 정진영
 * 수 정 자 : 
 * 파 일 명 : pcodB010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 점별 타임아웃 정보를 관리한다
 * 이    력 :
 *        2010.07.05 (정진영) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>

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
<script language="javascript"  src="/<%=dir%>/js/popup.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dps.js" type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->


<script LANGUAGE="JavaScript">
<!--

/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
var bfStrCd;

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
    DS_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_MASTER2.setDataHeader('<gauce:dataset name="H_SEL_MASTER2"/>');
    
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //마스터
    
    initComboStyle2(LC_SIDO_NEW,    DS_O_SIDO_NEW,    "NAME^0^130", 1, PK);  
    initComboStyle2(LC_SIGUNGU_NEW, DS_O_SIGUNGU_NEW, "NAME^0^130", 1, PK);  
    initEmEdit(EM_ADDR_OLD,               "GEN^80",      NORMAL);        //주소
    initEmEdit(EM_POST_NO_I,            "NUMBER^6^0",  NORMAL);         //우편번호
    initEmEdit(EM_POST_NO_I2,            "NUMBER^6^0",  NORMAL);        //우편번호
    initEmEdit(EM_ROADNM_NEW,               "GEN^80",      NORMAL);        //주소
    
    EM_POST_NO_I.Format = "000-000";
    EM_POST_NO_I.Alignment = 1;
    EM_POST_NO_I2.Format = "000-000";
    EM_POST_NO_I2.Alignment = 1;
    
    
    registerUsingDataset("pcodB01","DS_MASTER");
    registerUsingDataset("pcodB01","DS_MASTER2");
   }

function gridCreate1(){
	var hdrProperies = '<FC>id={currow}     name="NO"               width=30,       align=center  	</FC>' 
					 + '<FC>id=SEL          name="선택"              width=50        align="center"   EditStyle="CheckBox" HeadCheckShow="true" </FC>'
					 + '<FC>ID=POST_SEQ     name="일련번호"           width=90,       align="center" Edit=none</C>' 
			         + '<FC>ID=POST_NO      name="*우편번호"           width=95,       edit="Numeric"      align="center" mask="XXX-XXX" Edit={IF(CONF_FLAG="N","true","false")}</C>' 
			         + '<FC>ID=SI_DO        name="시/도"              width=90,      align="center"	</C>' 
			         + '<FC>ID=SI_GUN_GU    name="시/군/구"           width=90,       align="center" </C>' 
			         + '<FC>ID=EUP_DONG     name="읍/면/동"           width=90,       align="center" </C>' 
			         + '<FC>ID=LI           name="리"                 width=90,      align="center" </C>' 
			         + '<FC>ID=ISLAND       name="도서"               width=90,      align="center" </C>'
			         + '<FC>ID=DESTINATION  name="아파트/건물명"        width=150,     align="center" </C>'
			         + '<FC>ID=TYPE_NM      name="동/번지"             width=90,      align="center" </C>'
			         + '<FC>ID=STR_ADDR1    name="시작 동/번지1"        width=90,      align="center" </C>'
			         + '<FC>ID=STR_ADDR2    name="시작 동/번지2"        width=90,      align="center" </C>'
			         + '<FC>ID=END_ADDR1    name="종료 동/번지1"        width=90,      align="center" </C>'
			         + '<FC>ID=END_ADDR2    name="종료 동/번지2"        width=90,      align="center" </C>'
			         + '<FC>ID=FULL_ADDR    name="전체주소"            width=250,     align="center" </C>'
			         + '<FC>ID=ADDR1        name="주소1"              width=150,     align="center" </C>'
			         + '<FC>ID=ADDR2        name="주소2"              width=190,     align="center" </C>'
			         + '<FC>ID=REG_DATE     name="입력날짜"            width=140,    align="center" </C>'
			         + '<FC>ID=CONF_FLAG     name="확정"              width=140,     show=false   align="center" </C>'
			         ;

                                 
    initGridStyle(GD_MASTER, "common", hdrProperies, true);

} 
function gridCreate2(){
	var hdrProperies = '<FC>id={currow}     name="NO"             width=30,    align=center  	</FC>'
					 + '<FC>id=SEL          name="선택"               width=50    align="center"   EditStyle="CheckBox" HeadCheckShow="true" </FC>'
					 + '<FC>ID=POST_SEQ     name="일련번호"           width=90,   Edit=none  align="center"</C>' 
			         + '<FC>ID=POST_NO      name="*우편번호"        width=95,     edit="Numeric"   align="center" mask="XXX-XXX" Edit={IF(CONF_FLAG="N","true","false")} </C>' 
			         + '<FC>ID=SI_DO        name="시/도"          width=90,     align="center"</C>' 
			         + '<FC>ID=SI_GUN_GU    name="시/군/구"        width=90,    align="center"</C>' 
			         + '<FC>ID=EUP_DONG     name="읍/면/동"             width=90,     align="center"</C>' 
			         + '<FC>ID=ROAD_NM      name="도로명"         width=90,     align="center"</C>' 
			         + '<FC>ID=FULL_ADDR    name="전체주소"        width=250,        align="center"</C>'
			         + '<FC>ID=ADDR1        name="주소1"               width=90,          align="center"</C>'
			         + '<FC>ID=ADDR2        name="주소2"           width=190,      align="center"</C>'
			         + '<FC>ID=REG_DATE     name="입력날짜"        width=140,       align="center"</C>'
			         + '<FC>ID=CONF_FLAG     name="확정"      width=140,     show=false  align="center" </C>'
			         ;

                                 
    initGridStyle(GD_MASTER2, "common", hdrProperies, true);

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
  * 작 성 자 : 김영진
  * 작 성 일 : 2010-05-11
  * 개    요  : 조회 처리
  * return값 : void
  */
 function btn_Search() 
 {	 
    var strSrchGubun = RD_NEW_YN.CodeValue;
     DS_MASTER.ClearData();
     DS_MASTER2.ClearData();
    // DS_MASTER.Addrow();
 	
     if(strSrchGubun == "N"){
         
         if(EM_ADDR_OLD.text == ""){
             showMessage(EXCLAMATION, OK, "USER-1003",  "지역명");
             EM_ADDR_OLD.Focus();
             return;
         }
     }else{
         if(EM_ROADNM_NEW.text == ""){
             showMessage(EXCLAMATION, OK, "USER-1003",  "도로명");
             EM_ROADNM_NEW.Focus();
             return;
         }
     	/* if(LC_SIDO_NEW.text == ""){
             showMessage(EXCLAMATION, OK, "USER-1002",  "시/도");
             LC_SIDO_NEW.Focus();
             return;
         }
     	if(LC_SIGUNGU_NEW.text == ""){
             showMessage(EXCLAMATION, OK, "USER-1002",  "시/군/구");
             LC_SIGUNGU_NEW.Focus();
             return;
         } */
    }
     	searchMaster();
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
    var strSrchGubun = RD_NEW_YN.CodeValue;
    if(strSrchGubun=="N"){
	    if (!DS_MASTER.IsUpdated ){
	        //저장할 내용이 없습니다
	        showMessage(INFORMATION, OK, "USER-1028");
	        if( DS_MASTER.CountRow < 1){
	           // LC_STR_CD.Focus();
	        }else{
	           // GD_MASTER.Focus();
	        }
	        return;
	    }
	
	    if( !checkMasterValidation())
	        return;
	
	    //변경또는 신규 내용을 저장하시겠습니까?
	    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
	        GD_MASTER.Focus();
	        return; 
	    }
	    
	 for(var masterChkCnt = 1; masterChkCnt<=DS_MASTER.CountRow+1; masterChkCnt++){
	   if(DS_MASTER.NameValue(masterChkCnt,"SEL") == "T"){
		 
	   }else{
		 
	   }	
	   var strSrchGubun = RD_NEW_YN.CodeValue;
	    
	    var parameters = "&strSrchGubun="     +encodeURIComponent(strSrchGubun);    
	    
	    TR_MAIN.Action="/dps/pcodB01.pc?goTo=save"+parameters;  
	    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER=DS_MASTER)"; //조회는 O
	    TR_MAIN.Post();  
	    
	    
	    GD_MASTER.SetColumn("SEL");
	    GD_MASTER.Focus();  
	 }
	        	   
	       
	    
    }else{
    	
    	if (!DS_MASTER2.IsUpdated ){
	        //저장할 내용이 없습니다
	        showMessage(INFORMATION, OK, "USER-1028");
	        if( DS_MASTER2.CountRow < 1){
	           // LC_STR_CD.Focus();
	        }else{
	           // GD_MASTER.Focus();
	        }
	        return;
	    }
	
	    if( !checkMasterValidation())
	        return;
	    
	    //변경또는 신규 내용을 저장하시겠습니까?
	    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
	        GD_MASTER2.Focus();
	        return; 
	    }
	    for(var masterChkCnt = 1; masterChkCnt<=DS_MASTER2.CountRow+1; masterChkCnt++){
			 
	 	   if(DS_MASTER2.NameValue(masterChkCnt,"SEL") == "T"){
	 		    
	 		   
	 	   }else{
	 		   
	 	   }
	 	   var strSrchGubun = RD_NEW_YN.CodeValue;
		    
		    var parameters = "&strSrchGubun="     +encodeURIComponent(strSrchGubun);    
		    
		    TR_MAIN.Action="/dps/pcodB01.pc?goTo=save"+parameters;  
		    TR_MAIN.KeyValue="SERVLET(I:DS_MASTER2=DS_MASTER2)"; //조회는 O
		    TR_MAIN.Post();  
		    
		    if(TR_MAIN.ErrorCode == 0){
		        //searchMaster();        
		    }
		    GD_MASTER2.SetColumn("SEL");
		    GD_MASTER2.Focus();  
	 	}
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
	 var strSrchGubun = RD_NEW_YN.CodeValue;
		
	 if(strSrchGubun == "N"){
         var strEmPostNoI    = EM_POST_NO_I.text  // 우편번호       
         
     }else{
    	 var strEmPostNoI    = EM_POST_NO_I2.text  // 우편번호
    	 
     }
	  //var strEmAddrOld    = EM_ADDR_OLD.text; //지역명 
	 var strEmAddrOld       = EM_ADDR_OLD.text;    
     var strEmRoadNMNew     = EM_ROADNM_NEW.text;   
     var strLcSidoNew       = LC_SIDO_NEW.text;   //시도
     var strLcSigunguNew    = LC_SIGUNGU_NEW.text;//시/군/구
	if(DS_MASTER.CountRow <= 0){
	      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
	        return;
	    }
	var strTitle = "우편번호등록";
	if(strSrchGubun=="N"){
		var parameters  = " 우편번호 "     +strEmPostNoI                         
						+ ",지번주소 "     +strEmAddrOld 
						;
	}else{
		
	    var parameters  = " 우편번호 "     +strEmPostNoI                           
						+ ",도로이름 "   +strEmRoadNMNew                       
						+ ",시/도 "     +strLcSidoNew          
						+ ",시/군/구 "  +strLcSigunguNew                      
						;   
	}
	
	    
	    
	    GD_MASTER.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
	    openExcel2(GD_MASTER, strTitle, parameters, true );
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
 * controlGrid()
 * 작 성 자 : 박종은
 * 작 성 일 : 2011-03-14
 * 개    요 :   그리드 숨김 표시
 * return값 : void
 */
 function controlGrid(){    
	 

}

/**
 * btn_addRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행추가
 * return값 : void
 */
function btn_addRow(){
	var strSrchGubun = RD_NEW_YN.CodeValue;
	
		if(strSrchGubun=="N"){
        	if (DS_MASTER.RowPosition >=0) { 
				var check=checkvalidation();
				if(check=="Y"){
				
				DS_MASTER.AddRow();
				var row = DS_MASTER.CountRow;
				DS_MASTER.NameValue(DS_MASTER.CountRow , "CONF_FLAG") = "N"
				setFocusGrid(GD_MASTER, DS_MASTER, row, "POST_NO");
				}
			}
		}else{
			if (DS_MASTER2.RowPosition >=0) { 
				var check=checkvalidation();
				if(check=="Y"){
					
				    DS_MASTER2.AddRow();
					var row = DS_MASTER2.CountRow;
				    DS_MASTER2.NameValue(DS_MASTER2.CountRow , "CONF_FLAG") = "N"
				    setFocusGrid(GD_MASTER2, DS_MASTER2, row, "POST_NO");
				}
		    }
		}
}
function checkvalidation(){
	var strSrchGubun = RD_NEW_YN.CodeValue;
	if(strSrchGubun=="N"){
		var intRowCount   = DS_MASTER.CountRow;
	    var strPostNo      = "";                    
	    var strPostSeq      = "";                   
	    
	    if(intRowCount > 0){
	        for(var i=1; i <= intRowCount; i++){
	            
	     	  var strRowStatus = DS_MASTER.RowStatus(i);               //신규, 수정 구분값
	     	  
	     	 strPostSeq     = DS_MASTER.NameValue(i, "POST_SEQ");
	     	 strPostNo      = DS_MASTER.NameValue(i, "POST_NO");
	     	 if(strPostNo.length <= 0){
	                showMessage(INFORMATION, OK, "USER-1003", "우편번호");
	                GD_MASTER.SetColumn("POST_NO");  
	                DS_MASTER.RowPosition = i;  
	               
	                return "N";
	            }
	            
	        }
	    }
	}else{
		
		var intRowCount   = DS_MASTER2.CountRow;
	    var strPostNo      = "";                    
	    var strPostSeq      = "";                   
	    
	    if(intRowCount > 0){
	        for(var i=1; i <= intRowCount; i++){
	            
	     	  var strRowStatus = DS_MASTER2.RowStatus(i);               //신규, 수정 구분값
	     	  
	     	 strPostSeq     = DS_MASTER2.NameValue(i, "POST_SEQ");
	     	 strPostNo      = DS_MASTER2.NameValue(i, "POST_NO");
	     	 if(strPostNo.length <= 0){
	                showMessage(INFORMATION, OK, "USER-1003", "우편번호");
	                GD_MASTER2.SetColumn("POST_NO");  
	                DS_MASTER2.RowPosition = i;  
	               
	                return "N";
	            }
	            
	        }
	    }
	}
    
	return "Y";  
}

/**
 * btn_delRow()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-01-24
 * 개    요 :  행삭제
 * return값 : void
 */
function btn_delRow(){
	var strSrchGubun = RD_NEW_YN.CodeValue;
	if(strSrchGubun=="N"){
		
		if(showMessage(Question, YESNO, "USER-1023") != 1)
	        return;
	    
		var intRowCount =  DS_MASTER.CountRow;
	    for(var i=intRowCount; i >= 1; i--){
	        if(DS_MASTER.NameValue(i, "SEL") == 'T'){
	            DS_MASTER.DeleteRow(i);
	        }
	   
	    }
	} else{
		if(showMessage(Question, YESNO, "USER-1023") != 1)
	        return;
	    
		var intRowCount =  DS_MASTER.CountRow;
	    for(var i=intRowCount; i >= 1; i--){
	        if(DS_MASTER.NameValue(i, "SEL") == 'T'){
	            DS_MASTER.DeleteRow(i);
	        }
	    }
	}
}

/**
 * searchMaster()
 * 작 성 자 : 정진영
 * 작 성 일 : 2010-02-18
 * 개    요 :  판매사원 리스트 조회
 * return값 : void
 */
function searchMaster(){
	 //DS_O_MASTER.ClearData();
	 var strSrchGubun = RD_NEW_YN.CodeValue;
	
	 if(strSrchGubun == "N"){
         var strEmPostNoI    = EM_POST_NO_I.text  // 우편번호       
         
     }else{
    	 var strEmPostNoI    = EM_POST_NO_I2.text  // 우편번호
    	 
     }
	  //var strEmAddrOld    = EM_ADDR_OLD.text; //지역명 
	 var strEmAddrOld       = EM_ADDR_OLD.text;    
     var strEmRoadNMNew     = EM_ROADNM_NEW.text;   
     var strLcSidoNew       = LC_SIDO_NEW.text;   //시도
     var strLcSigunguNew    = LC_SIGUNGU_NEW.text;//시/군/구
     
     var goTo="searchMaster";                                              
     var action     = "O";                                                
     var parameters = "&strSrchGubun="     +encodeURIComponent(strSrchGubun)     
     				+ "&strEmPostNoI="     +encodeURIComponent(strEmPostNoI)                         
    				+ "&strEmAddrOld="     +encodeURIComponent(strEmAddrOld)                           
     				+ "&strEmRoadNMNew="   +encodeURIComponent(strEmRoadNMNew)                       
     				+ "&strLcSidoNew="     +encodeURIComponent(strLcSidoNew)          
     				+ "&strLcSigunguNew="  +encodeURIComponent(strLcSigunguNew)                      
     				;                                                            
    if(strSrchGubun=="N"){
	    TR_MAIN.Action="/dps/pcodB01.pc?goTo="+goTo+parameters;               
	    TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER=DS_MASTER)"; //조회는 O
	    TR_MAIN.Post(); 
    	
	    //스크롤바 위치 조정
	    GD_MASTER.SETVSCROLLING(0);
	    GD_MASTER.SETHSCROLLING(0);
	    controlGrid();
	    
	  
	    
    }else{
    	TR_MAIN.Action="/dps/pcodB01.pc?goTo="+goTo+parameters;               
        TR_MAIN.KeyValue="SERVLET("+action+":DS_MASTER2=DS_MASTER2)"; //조회는 O
        TR_MAIN.Post(); 
        
        //스크롤바 위치 조정
        GD_MASTER2.SETVSCROLLING(0);
        GD_MASTER2.SETHSCROLLING(0);
        controlGrid();
        GD_MASTER.Editable = true;
      
    } 
} 
/**
* initComboStyle2
* 작  성 자 : 김영진
* 작  성 일 : 2010-04-13
* 개        요 : LuxeCombo의 Style 및 기본적 PARAMETER SETTING
* 사 용 법  : initComboStyle(LC_DEAL_GUBN_S, ds_deal_gubn, "ETC_CODE^0^20,ETC_NAME^0^100", 1, PK/READ/NORMAL);
*          initComboStyle(LuxeCombo ID, Dataset Name, ExprForamt, SearchColumn Index, PK)
*/
function initComboStyle2(objCombo, strDataSet, strExprFormat, intSearchColumn,  strType, strDsBindFlag){
    objCombo.ComboDataID      = strDataSet.id;
    objCombo.ListExprFormat   = strExprFormat;
    objCombo.FontSize         = "9";
    objCombo.FontName         = "돋움";
    objCombo.ListCount        = 10;
    //objCombo.SearchColumn   = strExprFormat.split(",")[intSearchColumn].split("^")[0];
    objCombo.BindColumn       = strExprFormat.split(",")[0].split("^")[0];
    objCombo.InheritColor   = true;
    if (strDsBindFlag != true){
        objCombo.SyncComboData    = false;
    }
    objCombo.WantSelChgEvent  = true;
    switch(THEME){
      case SPRING :
        break;
      case SUMMER :
        break;
      case FALL   :
        break;
      case WINTER :
        setObjTypeStyle( objCombo, "COMBO", strType );
        break;
      default :
      break;
    }
}
/**
 * getSiGunGuNew()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-12
 * 개      요  : 시군구조회
 * return값 :
 */
function getSiGunGuNew(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1),SIDO_NEW:STRING(50)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    DS_I_COMMON.NameValue(1, "SIDO_NEW")  = LC_SIDO_NEW.Text;
    
    TR_MAIN.Action  = "/<%=dir%>/ccom430.cc?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
}
/**
 * getSidoNew()
 * 작 성 자 : 김영진
 * 작 성 일 : 2010-05-12
 * 개      요  : 시도조회
 * return값 :
 */
function getSidoNew(strDataSet, sysPart, commPart, allGb, nulGb, objComboNm) { 
    DS_I_COMMON.setDataHeader('SYS_PART:STRING(1),COMM_PART:STRING(4),ALL_GB:STRING(1),NUL_GB:STRING(1),SIDO_NEW:STRING(50)');

    DS_I_COMMON.ClearData();
    DS_I_COMMON.Addrow();
    DS_I_COMMON.NameValue(1, "SYS_PART")  = sysPart;
    DS_I_COMMON.NameValue(1, "COMM_PART") = commPart;
    DS_I_COMMON.NameValue(1, "ALL_GB")    = allGb ;
    DS_I_COMMON.NameValue(1, "NUL_GB")    = nulGb == null ? 'N' : nulGb ;
    DS_I_COMMON.NameValue(1, "SIDO_NEW")  = "ALL";
        
    TR_MAIN.Action  = "/<%=dir%>/ccom430.cc?goTo=getEtcCode";
    TR_MAIN.KeyValue= "SERVLET(I:DS_I_COMMON=DS_I_COMMON,O:DS_O_COMMON="+strDataSet+")";
    TR_MAIN.Post();
    
    if (typeof(objComboNm) == "object" ) objComboNm.index = '0';
}



/**
 * checkMasterValidation
 * 작 성 자 : 
 * 작 성 일 : 2010-03-03
 * 개    요 : 브랜드이동관리 마스터 입력 체크
 * return값 : void
**/
function checkMasterValidation(){
	var strSrchGubun = RD_NEW_YN.CodeValue;
	if(strSrchGubun=="N"){
	    var check=false;
	    for(var i = 1; i <= DS_MASTER.CountRow; i++ ) {
	        var rowStatus = DS_MASTER.RowStatus(i);
	
	        if( rowStatus == 0 || rowStatus == 2|| rowStatus == 4)
	                continue;
	         if( DS_MASTER.NameValue( i, "POST_NO") == ''){
	            check = true;
	            titleNm = "우편번호";
	            columnId = "POST_NO";
	            row = i;
	            break;;
	        } 
	        if(DS_MASTER.NameValue( i, "POST_NO").length<6){
	        	showMessage(EXCLAMATION, OK, "USER-1000", "우편번호의 자리수는 6자리입니다");
	            setFocusGrid( GD_MASTER, DS_MASTER, i, "POST_NO");
	            return false;
	        }
	        
	    }
	    if( check ){
	        // ()은/는 반드시 입력해야 합니다.
	        showMessage(EXCLAMATION, OK, "USER-1003", POST_NO);
	        setFocusGrid( GD_MASTER, DS_MASTER, row, columnId);
	        return false;
	    }
	    return true;
		
	}else{
		
		var check=false;
	    for(var i = 1; i <= DS_MASTER2.CountRow; i++ ) {
	        var rowStatus = DS_MASTER2.RowStatus(i);

	        if( rowStatus == 0 || rowStatus == 2|| rowStatus == 4)
	                continue;
	        if( DS_MASTER2.NameValue( i, "POST_NO") == ''){
	            check = true;
	            titleNm = "우편번호";
	            columnId = "POST_NO";
	            row = i;
	            break;;
	        } 
	        if(DS_MASTER2.NameValue( i, "POST_NO").length<6){
	        	showMessage(EXCLAMATION, OK, "USER-1000", "우편번호의 자리수는 6자리입니다");
	            setFocusGrid( GD_MASTER2, DS_MASTER2, i, "POST_NO");
	            return false;
	        }
	        
	    }
	    if( check ){
	        // ()은/는 반드시 입력해야 합니다.
	        showMessage(EXCLAMATION, OK, "USER-1003", POST_NO);
	        setFocusGrid( GD_MASTER2, DS_MASTER2, row, columnId);
	        return false;
	    }
	    return true;
	}
    
}
-->

</script>
<script language="javascript">
    var today    = new Date();
    var old_Row = 0;
    var searchChk = "";

    // 오늘 일자 셋팅 
    var now = new Date();
    var mon = now.getMonth()+1;
    if(mon < 10)mon = "0" + mon;
    var day = now.getDate();
    if(day < 10)day = "0" + day;

    var varToday = now.getYear().toString()+"-"+ mon +"-"+ day+" "+ now.getHours()+":"+now.getMinutes()+":"+now.getSeconds();
    var varToMon = now.getYear().toString()+ mon;
    
    	
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
<script language=JavaScript for=DS_MASTER event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if( colid == "STR_CD"){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
    	}else{
            showMessage(EXCLAMATION, OK, "USER-1003", "마감단위업무");
    	}
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER.ErrorMsg);       
    }
</script>
<script language=JavaScript for=DS_MASTER2 event=OnDataError(row,colid)>
    var errorCode = DS_MASTER.ErrorCode;
    if(errorCode == "50019"){
        showMessage(EXCLAMATION, OK, "USER-1044");
    }else if( errorCode == "50018"){
    	if( colid == "STR_CD"){
            showMessage(EXCLAMATION, OK, "USER-1002", "점");
    	}else{
            showMessage(EXCLAMATION, OK, "USER-1003", "마감단위업무");
    	}
    }else{
        showMessage(EXCLAMATION, OK, "USER-1000",DS_MASTER2.ErrorMsg);       
    }
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<script language=JavaScript for=GD_MASTER2 event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid );
</script>
<!-- 조회구분 OnSelChange() -->
<script language=JavaScript for=RD_NEW_YN event=OnSelChange()>
    if(RD_NEW_YN.CodeValue == "N"){
    	document.getElementById("divOld").style.display = "";
        document.getElementById("divNew").style.display = "none";
        document.getElementById("td_old").style.display = "";
        document.getElementById("td_new").style.display = "none";
        DS_MASTER.ClearData();

        LC_SIDO_NEW.Text    = "";
        LC_SIGUNGU_NEW.Text = "";
        EM_ROADNM_NEW.Text  = "";
        
        controlGrid();
        //GD_SEARCH.height = "317";
    }else{
        document.getElementById("divOld").style.display = "none";
        document.getElementById("divNew").style.display = "";
        document.getElementById("td_old").style.display = "none";
        document.getElementById("td_new").style.display = "";
        DS_MASTER.ClearData();
        
        //EM_ADDR_OLD.Text = "";
        //GD_SEARCH.height = "292";
        getSidoNew("DS_O_SIDO_NEW", "", "", "Y");
        LC_SIGUNGU_NEW.Enable = false;
        controlGrid();
    }
</script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid,olddata)>
    if(row < 1 ){
        return;
    }
    var value = DS_MASTER.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'E_TIME':
        	
            if( !checkHHMI(value) && value != "" ){
                showMessage(INFORMATION, OK, "USER-1000", "유효하지 않는 시간형식 입니다.");
                DS_MASTER.NameValue(row,colid) = olddata;
            }
            break;
    
    }
</script> 
<script language=JavaScript for=GD_MASTER event="OnHeadCheckClick(Col,Colid,bCheck)">
    if (Colid == "SEL") {
        if (bCheck == 1) {
            GD_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
            	DS_MASTER.NameValue(i + 1, "SEL") = "T";
            }    
            GD_MASTER.Redraw = true;
        }
        else if (bCheck == 0) {
            GD_MASTER.Redraw = false;
            for (var i = 0; i < DS_MASTER.CountRow; i++)
            {
            	DS_MASTER.NameValue(i + 1, "SEL") = "F";
            } 
            GD_MASTER.Redraw = true;
        }
    }
</script>
<script language=JavaScript for=GD_MASTER2 event="OnHeadCheckClick(Col,Colid,bCheck)">
	if (Colid == "SEL") {
	    if (bCheck == 1) {
	        GD_MASTER2.Redraw = false;
	        for (var i = 0; i < DS_MASTER2.CountRow; i++)
	        {
	        	DS_MASTER2.NameValue(i + 1, "SEL") = "T";
	        }    
	        GD_MASTER2.Redraw = true;
	    }
	    else if (bCheck == 0) {
	        GD_MASTER2.Redraw = false;
	        for (var i = 0; i < DS_MASTER2.CountRow; i++)
	        {
	        	DS_MASTER2.NameValue(i + 1, "SEL") = "F";
	        } 
	        GD_MASTER2.Redraw = true;
	    }
	}
</script>
<script language=JavaScript for=GD_MASTER2 event=OnExit(row,colid,olddata)>
    if(row < 1 ){
        return;
    }
    var value = DS_MASTER2.NameValue(row,colid);
    if( value == olddata)
        return;
    
    switch(colid){
        case 'E_TIME':
        	
            if( !checkHHMI(value) && value != "" ){
                showMessage(INFORMATION, OK, "USER-1000", "유효하지 않는 시간형식 입니다.");
                DS_MASTER2.NameValue(row,colid) = olddata;
            }
            break;
    
    }
</script> 
<!-- 시도 OnSelChange() -->
<script language=JavaScript for=LC_SIDO_NEW event=OnSelChange()>
    getSiGunGuNew("DS_O_SIGUNGU_NEW", "", "", "Y");  
    LC_SIGUNGU_NEW.Enable = true;
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
    
<comment id="_NSID_"><object id="DS_STR_CD"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_TASK_FLAG"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_CLOSE_TASK_FLAG_I"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSE_FLAG_I"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"      classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"   classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SEARCH_NM"     classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_CLOSECHECK"    classid=<%=Util.CLSID_DATASET%>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_MASTER"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_MASTER2"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_POPUP classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_SIDO_NEW classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id=DS_O_SIGUNGU_NEW classid=<%=Util.CLSID_DATASET%>></object>
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
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
        
          
          <tr>
			<th width="60">주소타입</th>
			<td><comment id="_NSID_"> <object id=RD_NEW_YN
				classid=<%=Util.CLSID_RADIO%> style="height: 20; width: 200"
				tabindex=1>
				<param name=Cols value="2">
				<param name=Format value="N^지번주소,Y^도로명주소">
				<param name="AutoMargin" value="true">
				<param name=CodeValue value="N">
					</object> </comment> <script> _ws_(_NSID_);</script></td>
		 </tr>
          
        </table></td>
      		</tr>
   			 </table></td>
  				</tr>
  					<tr>
						<td class="PT01 PB03">
						<div id="divOld" >
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="o_table">
							<tr>
								<td>

								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
           							<th  width=60 >우편번호</th>
										<td width="140"><comment id="_NSID_"> <object
										id=EM_POST_NO_I classid=<%=Util.CLSID_EMEDIT%> width=60
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
									
									<th width="60"  class="point">지역명</th>
										<td colspan="2" ><comment id="_NSID_"> <object
											id=EM_ADDR_OLD classid=<%=Util.CLSID_EMEDIT%> height=20 tabindex=1
											width=127 onKeyDown="if(event.keyCode == 13) btn_Search();" onkeyup="javascript:checkByteStr(EM_ADDR_OLD, 100, '');">
										</object> </comment><script>_ws_(_NSID_);</script></td>
									
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</div>
						<div id="divNew" style="display: none">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="o_table">
							<tr>
								<td>

								<table width="100%" border="0" cellpadding="0" cellspacing="0"
									class="s_table">
									<tr>
           							<th  width=60 >우편번호</th>
										<td ><comment id="_NSID_"> <object
										id=EM_POST_NO_I2 classid=<%=Util.CLSID_EMEDIT%> width=60
										tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
										
									<th width="60" class="point">도로명</th>
                                        <td colspan="3"><comment id="_NSID_"> <object
                                            id=EM_ROADNM_NEW classid=<%=Util.CLSID_EMEDIT%> height=20
                                            width=127 tabindex=1 onkeyup="javascript:checkByteStr(EM_ROADNM_NEW, 60, '');">
                                        </object> </comment><script>_ws_(_NSID_);</script></td>
                                    </tr>
									<tr>
										<th width="60" class="point">시/도</th>
										<td width="138"><comment id="_NSID_"><object id=LC_SIDO_NEW
									classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
									align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									<th width="90" class="point">시/군/구</th>
                                        <td><comment id="_NSID_"><object id=LC_SIGUNGU_NEW
                                    classid=<%=Util.CLSID_LUXECOMBO%> width=131 tabindex=1
                                    align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
  					<tr>
    <td class="dot"></td>
  </tr>
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td ><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
               <td class="right PB03"><img 
               src="/<%=dir%>/imgs/btn/add_row.gif" onClick="javascript:btn_addRow();" hspace="2" /><img 
               src="/<%=dir%>/imgs/btn/del_row.gif" onClick="javascript:btn_delRow();"  /></td>
           </tr>
        </table></td>
      </tr>
      <tr valign="top">
        <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A">
          <tr>
            <td id=td_old >
              <comment id="_NSID_">
                <object id=GD_MASTER width=100% height=460 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <td id=td_new style="display: none" >
              <comment id="_NSID_">
                <object id=GD_MASTER2 width=100% height=456 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_MASTER2">
                </object>
              </comment>
              <script>_ws_(_NSID_);</script>
            </td>
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

<body>
</html>


