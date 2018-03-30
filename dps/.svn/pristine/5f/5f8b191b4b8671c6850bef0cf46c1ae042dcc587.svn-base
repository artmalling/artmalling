<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 매출실적
 * 작 성 일 : 2010.05.24
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal5320.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : POS별 정산/마감현황
 * 이    력 :2010.05.24 박종은
 * 
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
<script language="javascript" src="/<%=dir%>/js/popup_dcs.js"
   type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">

var check=0;
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

function doInit(){
    
    // Input Data Set Header 초기화
    
    // Output Data Set Header 초기화
    DS_O_MASTER.setDataHeader('<gauce:dataset name="MAIN_MASTER"/>');      
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');   
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
    DS_SETVAT.setDataHeader   ('<gauce:dataset name="H_SETVAT"/>' );
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //서브
    gridCreate3(); //서브2
    // EMedit에 초기화
    
    
    EM_SALE_DT_S.alignment = 1;
    
    initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);    
    initEmEdit(EM_I_ORDERER_CD, "CODE^30", NORMAL);  //제휴몰
    initEmEdit(EM_I_ORDERER_NAME, "GEN", NORMAL);  //제휴몰
    initEmEdit(EM_SALE_DT_S,                      "YYYYMM",                PK);   //년월
    initEmEdit(EM_PUMBUN_CD  , "CODE^6^0"   , NORMAL);//브랜드(조회)
    initEmEdit(EM_PUMBUN_NAME, "GEN^40"     , READ);  //브랜드(조회)
    //현재년도 셋팅
    EM_SALE_DT_S.text =  varToday;

    //콤보 초기화
              //점(조회)
    getEtcCode("DS_I_REASON_CD"  ,"D"   ,"P618"  ,"N" );         // 공제
    getEtcCode("DS_I_VAT_YN"     ,"D"   ,"P417"  ,"N" );         // VAT여부
    getStore("DS_STR_CD", "Y", "", "N");                                                          // 점        

    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    
    GD_MASTER_CROSSTAB.focus();
    LC_STR_CD.Focus();
    //사용되는 데이터셋 등록 ( 종료시 데이터 변경 체크)( common.js )
    registerUsingDataset("psal532","DS_O_MASTER" );
    
}


function gridCreate1(){
    var hdrProperies = '<FC>id={currow}               name="NO"                width=30    align=center    </FC>'
    	             + '<FC>id=PUMBUN_CD              name="브랜드코드"          width=80    align=Center      </FC>'
    	             + '<FC>id=PUMBUN_NM              name="브랜드이름"          width=140    align=left      </FC>'
                     + '<R>'
                     + '<G>           name=$xkeyname_$$ '
                     + '<C>id=ORDERER_COMIS_RATE_$$   name="수수료"             width=100    align=right           </C>'//mask="###,###" Decimal=2  name={IF($TITLE_NM1_$$,"","수수료","수수료")}
                     + '<C>id=AGENCY_PROF_RATE_$$     name="이익율"             width=100    align=right        </C>'//mask="###,###" Decimal=2 name={IF($TITLE_NM2_$$,"인터파크이익율","인터파크이익율","이익율")}  
                     + '</G>'
                     + '</R>' 
                     ;
      
    initGridStyle(GD_MASTER_CROSSTAB, "common", hdrProperies, false);
    
}

function gridCreate2(){
	 
    var hdrProperies = '<FC>id={currow}             name="NO"          width=30    align=center</FC>'
                     + '<FC>id=SEL                  name="선택"         width=50    align=center EditStyle=CheckBox  HeadCheckShow="true" </FC>'  //Edit={IF(CONF_FLAG="Y","true","false")} 
                     + '<FC>id=STR_CD               name="*점"          width=100    align=left    EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME"</FC>'   
                     + '<FC>id=ORDERER_CD           name="*입점몰코드"   width=80 Edit={IF(CONF_FLAG="1",false, true)}   align=center EditStyle=Popup  </FC>'
                     + '<FC>id=ORDERER_NM           name="입점몰이름"    width=80    Edit=none  align=center   </FC>'
                     + '<FC>id=PUMBUN_CD            name="*브랜드코드"   width=80 Edit={IF(CONF_FLAG="1",false, true)}   align=center EditStyle=Popup  </FC>'
                     + '<FC>id=PUMBUN_NAME          name="브랜드이름"    width=140    Edit=none  align=left   </FC>'
                     + '<FC>id=SALE_YM              name="*매출월"       width=80  Edit={IF(CONF_FLAG="1",false, true)}  align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX" </FC>'
                     + '<FC>id=MARIO_COMIS_RATE     name="마리오수수료"   Edit=none    width=80    align=right  </FC>'//Decimal=2
                     + '<FC>id=ORDERER_COMIS_RATE   name="입점몰수수료"   width=80   align=right    </FC>'
                     + '<FC>id=MARIO_PROF_RATE      name="마리오이익율"   width=140  Edit=none    align=right   </FC>'
                     + '<FC>id=AGENCY_PROF_RATE     name="인터파크이익율"  width=90 Edit=none       align=right   </FC>' //sumtext={subsum((MARIO_COMIS_RATE) - (ORDERER_COMIS_RATE) - (MARIO_PROF_RATE))}
                     + '<FC>id=CONF_FLAG            name="확정구분"width=120 align=left show="false"   </FC>'
                     ;   
                     
    initGridStyle(GR_MASTER, "common", hdrProperies, true);
}
function gridCreate3(){
	 
    var hdrProperies = '<FC>id={currow}             name="NO"              width=30    align=center</FC>'
                     + '<FC>id=SEL                  name="선택"             width=50    align=center EditStyle=CheckBox  HeadCheckShow="true" </FC>'  //Edit={IF(CONF_FLAG="Y","true","false")} 
                     + '<FC>id=STR_CD               name="*점"             width=100  Edit={IF(CONF_FLAG="1",false, true)} align=left    EditStyle=Lookup   Data="DS_STR_CD:CODE:NAME"</FC>'
                     + '<FC>id=PUMBUN_CD            name="*브랜드코드"       width=80   Edit={IF(CONF_FLAG="1",false, true)} align=center EditStyle=Popup  </FC>'
                     + '<FC>id=PUMBUN_NAME          name="브랜드이름"        width=140   Edit=none  align=left  </FC>'
                     + '<FC>id=SALE_YM              name="*매출월"          width=80  Edit={IF(CONF_FLAG="1",false, true)}   align=center EditStyle=Popup Edit=Numeric Mask="XXXX/XX" </FC>'
                     + '<FC>id=MARIO_PROF_RATE      name="마리오이익율"      width=140   align=left  </FC>'
                     + '<FC>id=CONF_FLAG            name="확정구분"         width=120   align=left   show="false"</FC>';   
                      
    initGridStyle(GR_MASTER2, "common", hdrProperies, true);
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
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-16
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
    
    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_MASTER.ClearData();
    if(!chkValidation("search")) return;
    
    var strStrCd          = LC_STR_CD.BindColVal;      //점
    var strSaleYm         = EM_SALE_DT_S.text;         //시작일자
    var strOriginAreaCd   = EM_I_ORDERER_CD.text;
    var strPumbunCd       = EM_PUMBUN_CD.text;
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strSaleYm="          +encodeURIComponent(strSaleYm)
                   + "&strOriginAreaCd="    +encodeURIComponent(strOriginAreaCd)
                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
                   ;
    
    TR_MAIN.Action="/dps/psal532.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    /* for(var i=1; i<DS_O_MASTER.CountRow; i++){
    	if(DS_O_MASTER.NameValue(i,"ORDERER_NM2")==" 마리오"){
    	   // alert("마리오");
    	    GD_MASTER_CROSSTAB.ColumnProp('AGENCY_PROF_RATE_$$','Name')='이익율';
    	   
    	}else{
    		//alert("in");
    		GD_MASTER_CROSSTAB.ColumnProp('AGENCY_PROF_RATE_$$','Name')='인터파크이익율';
    	} 
    }
     */
    GD_MASTER_CROSSTAB.focus();
    // 조회결과 Return
   // setPorcCount("SELECT", DS_O_MASTER_CROSSTAB.CountRow);

    //스크롤바 위치 조정
    GD_MASTER_CROSSTAB.SETVSCROLLING(0);
    GD_MASTER_CROSSTAB.SETHSCROLLING(0);
    
    searchMarioeek();
}

/**
 * btn_New()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :   
 * return값 : 
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 :  
 * 작 성 일 :  
 * 개     요 :  
 * return값 : void
 */

function btn_Save() {
	
	// 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated&&!DS_IO_MASTER.IsUpdated){
    		showMessage(StopSign, OK, "USER-1028");
    	       return;
    	}
    
      if(!checkValidation1("Save"))return;
      if(!checkValidation2("Save"))return;    // validation 체크
    

    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(STOPSIGN, YESNO, "USER-1010") == 1 ){
	 	
        TR_DETAIL.Action="/dps/psal532.ps?goTo=save"; 
        TR_DETAIL.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
        TR_DETAIL.Post();
        btn_Search();
    }      
} 
/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Excel() {
  
}


/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Print() {

}

/**
 * btn_Conf()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */

 function btn_Conf() {
	 
 }

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 function searchDitail(){  //우측 하단 SEL 쿼리
	 	DS_IO_MASTER.ClearData();
	    if(!chkValidation("search")) return;
	    
	    var strStrCd          = LC_STR_CD.BindColVal;      //점
	    var strSaleYm         = EM_SALE_DT_S.text;         //시작일자
	    var strOriginAreaCd   = EM_I_ORDERER_CD.text;
	    var strPumbunCd       = EM_PUMBUN_CD.text;
	    
	    var goTo       = "searchDitail" ;    
	    var action     = "O";     
	    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                   + "&strSaleYm="          +encodeURIComponent(strSaleYm)
	                   + "&strOriginAreaCd="    +encodeURIComponent(strOriginAreaCd)
	                   + "&strPumbunCd="        +encodeURIComponent(strPumbunCd)
	                   ;
	    
	    TR_DETAIL.Action="/dps/psal532.ps?goTo="+goTo+parameters;  
	    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	    TR_DETAIL.Post();
	    
} 

/**
 * chkValidation(gbn)
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(gbn){
    switch (gbn){
    case "search" :

        //점 체크
        if (isNull(LC_STR_CD.BindColVal)==true ) {
            showMessage(Information, OK, "USER-1003","점");
            LC_STR_CD.focus();
            return false;
        }
        
        //기간
        if (EM_SALE_DT_S.text.replace(" ","").length != 6 ) {
            showMessage(Information, OK, "USER-1027","매출일자","8");
            EM_SALE_DT_S.focus();
            return false;
        }
        break;
   
    }
    return true;
}
/**
 * checkValidation()
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-05-31
 * 개    요        : validation 체크
 * return값 : void
 */
 
 
function checkValidation1(Gubun) {  //행추가시..........    
	   
     var messageCode = "USER-1001";
    
     //조회버튼 클릭시 Validation Check
	     if(Gubun == "Search"){   
	         if(EM_SALE_DT_S.Text.length == 0){                                // 매출월
	             showMessage(INFORMATION, OK, "USER-1002", "매출월");
	             EM_SALE_DT_S.Focus();
	             return false;
	         }
	     }
	     
	     // 저장버튼 클릭시 Validation Check
	     if(Gubun == "Save"){          
	         var intRowCount   = DS_IO_DETAIL.CountRow;
	         var strStrCd      = "";                     // 점
	         var strSaleYm     = "";                     // 지불년월        
	         var strOrdererCd  = "";                     // 지불주기
	         var intMarioProfRate = "";
	         if(intRowCount > 0){
	             for(var i=1; i <= intRowCount; i++){
	                 
	          	   strRowStatus    = DS_IO_DETAIL.RowStatus(i);               //신규, 수정 구분값            	   
	          	   strStrCd        = DS_IO_DETAIL.NameValue(i, "STR_CD");
	          	   strSaleYm       = DS_IO_DETAIL.NameValue(i, "SALE_YM");
	               strPumbunCd     = DS_IO_DETAIL.NameValue(i, "PUMBUN_CD");
	               intMarioProfRate= DS_IO_DETAIL.NameValue(i, "MARIO_PROF_RATE");
	               
	          	   if(strStrCd.length <= 0){
	                     showMessage(INFORMATION, OK, "USER-1003", "점");
	                     GR_MASTER2.SetColumn("STR_CD");  
	                     DS_IO_DETAIL.RowPosition = i;  
	                     return false;
	                 }
	          	   
	          	   if(strSaleYm.length != 6){
	                     showMessage(INFORMATION, OK, "USER-1003", "매출월");
	                     GR_MASTER2.SetColumn("SALE_YM");  
	                     DS_IO_DETAIL.RowPosition = i;  
	                     return false;
	                 }
	          	  
		          if(strPumbunCd <= 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "브랜드명");
		                GR_MASTER2.SetColumn("ORDERER_CD");  
		                DS_IO_DETAIL.RowPosition = i;  
		                return false;
		            	 }
		          if(intMarioProfRate<=0){
		        	    showMessage(EXCLAMATION, OK, "USER-1041", "마리오이익율");
		                GR_MASTER2.SetColumn("MARIO_PROF_RATE");  
		                DS_IO_DETAIL.RowPosition = i;  
		                return false;
		            	 }
		          }
	          	  	
	          	 // 신규와 수정일때를 구분한다.
	             if(strRowStatus == "1"){        //신규일때
	            	 
	              		if(!checkKeyVlaue1(i,strStrCd,strSaleYm,strPumbunCd)){
	                     showMessage(INFORMATION, OK, "USER-1044", "KEY값");
	                     DS_IO_DETAIL.RowPosition = i;  
	                     DS_IO_DETAIL.NameValue(i,"SEL") = "T";
	                     GR_MASTER2.SetColumn("SEL");
	                     return false;
	              		} 
	                 }
	             }
	         }
     return true; 
 }

function checkValidation2(Gubun) {  //행추가시..........    
	   
    var messageCode = "USER-1001";
   
    //조회버튼 클릭시 Validation Check
	     if(Gubun == "Search"){   
	         if(EM_SALE_DT_S.Text.length == 0){                                // 매출월
	             showMessage(INFORMATION, OK, "USER-1002", "매출월");
	             EM_SALE_DT_S.Focus();
	             return false;
	         }
	     }
	     
	     // 저장버튼 클릭시 Validation Check
	     if(Gubun == "Save"){          
	         var intRowCount   = DS_IO_MASTER.CountRow;
	         var strStrCd      = "";                     // 점
	         var strSaleYm     = "";                     // 지불년월        
	         var strOrdererCd  = "";                     // 지불주기
	         var intMarioComisRate= "";
	         var intOrdererComisRate="";
	         var intMarioProfRate = "";
	         var intAgencyProfRate="";
	         
	         if(intRowCount > 0){
	             for(var i=1; i <= intRowCount; i++){
	                 
	          	   strRowStatus        = DS_IO_MASTER.RowStatus(i);               //신규, 수정 구분값            	   
	          	   strStrCd            = DS_IO_MASTER.NameValue(i, "STR_CD");
	          	   strSaleYm           = DS_IO_MASTER.NameValue(i, "SALE_YM");
	          	   strOrdererCd        = DS_IO_MASTER.NameValue(i, "ORDERER_CD");
	               strPumbunCd         = DS_IO_MASTER.NameValue(i, "PUMBUN_CD");
	               intMarioComisRate   = DS_IO_MASTER.NameValue(i, "MARIO_COMIS_RATE");  //마리오 수수료
	               intOrdererComisRate = DS_IO_MASTER.NameValue(i, "ORDERER_COMIS_RATE");//입점몰 수수료
	               intMarioProfRate    = DS_IO_MASTER.NameValue(i, "MARIO_PROF_RATE");   //마리오 이익율
	               intAgencyProfRate   = DS_IO_MASTER.NameValue(i, "AGENCY_PROF_RATE");  //인터파크 이익율
	               
	          	   if(strStrCd.length <= 0){
	                     showMessage(INFORMATION, OK, "USER-1003", "점");
	                     GR_MASTER.SetColumn("STR_CD");  
	                     DS_IO_MASTER.RowPosition = i;  
	                     return false;
	                 }
	          	   
	          	 if(strSaleYm.length != 6){
                     showMessage(INFORMATION, OK, "USER-1003", "매출월");
                     GR_MASTER2.SetColumn("SALE_YM");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 }
	          	  
		           if(strOrdererCd <= 0){
			                 showMessage(EXCLAMATION, OK, "USER-1041", "입점몰");
			                 GR_MASTER.SetColumn("ORDERER_CD");  
			                 DS_IO_MASTER.RowPosition = i;  
			                 return false;
		                 }   
	                
		          if(strPumbunCd <= 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "브랜드명");
		                GR_MASTER.SetColumn("ORDERER_CD");  
		                DS_IO_MASTER.RowPosition = i;  
		                return false;
		            	 }
		          if(intMarioComisRate <= 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "마리오수수료");
		                GR_MASTER.SetColumn("MARIO_COMIS_RATE");  
		                DS_IO_MASTER.RowPosition = i;  
		                return false;
		            	 }  
		          if(intOrdererComisRate <= 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "입점몰수수료");
		                GR_MASTER.SetColumn("ORDERER_COMIS_RATE");  
		                DS_IO_MASTER.RowPosition = i;  
		                return false;
		            	 } 
		          if(intMarioProfRate <= 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "마리오이익율");
		                GR_MASTER.SetColumn("MARIO_PROF_RATE");  
		                DS_IO_MASTER.RowPosition = i;  
		                return false;
		            	 } 
		          /* if(intAgencyProfRate < 0){
		                showMessage(EXCLAMATION, OK, "USER-1041", "인터파크이익율");
		                GR_MASTER.SetColumn("AGENCY_PROF_RATE");  
		                DS_IO_MASTER.RowPosition = i;  
		                return false;
		            	 }   */
	          	  	
	          	 // 신규와 수정일때를 구분한다.
	             if(strRowStatus == "1"){        //신규일때
	            	 
	              		if(!checkKeyVlaue2(i,strStrCd,strSaleYm,strOrdererCd,strPumbunCd)){
	                     showMessage(INFORMATION, OK, "USER-1044", "KEY값");
	                     DS_IO_MASTER.RowPosition = i;  
	                     DS_IO_MASTER.NameValue(i,"SEL") = "T";
	                     GR_MASTER.SetColumn("SEL");
	                     
	                     return false;
	              		} 
	                 }
	             }
	         }
 		}
    return true; 
}

/**
 * checkKeyVlaue(row)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 : 저장시 키값 중복 체크
 * return값 : void
 */
function checkKeyVlaue1(row,strStrCd,strSaleYm,strPumbunCd) {
	 
    var parameter   = "&strStrCd="     +encodeURIComponent(strStrCd)
				    + "&strSaleYm="    +encodeURIComponent(strSaleYm)
				    + "&strPumbunCd="  +encodeURIComponent(strPumbunCd)
				    ;
    
    TR_CHARGE.Action="/dps/psal532.ps?goTo=checkKeyVlaue"+parameter; 
    TR_CHARGE.KeyValue="SERVLET(O:DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_CHARGE.Post(); 
    

    if(DS_O_RESULT.CountRow > 0){
   	 	return false;
    }else{
	   	 return true;
    
    }
}
function checkKeyVlaue2(row,strStrCd,strSaleYm,strOrdererCd,strPumbunCd) {
    var parameter   = "&strStrCd="     +encodeURIComponent(strStrCd)
				    + "&strSaleYm="    +encodeURIComponent(strSaleYm)
				    + "&strOrdererCd=" +encodeURIComponent(strOrdererCd) 
				    + "&strPumbunCd="  +encodeURIComponent(strPumbunCd) 
				    ;
    
    TR_CHARGE.Action="/dps/psal532.ps?goTo=checkKeyVlaue2"+parameter; 
    TR_CHARGE.KeyValue="SERVLET(O:DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_CHARGE.Post(); 
    

    if(DS_O_RESULT.CountRow > 0){
   	 	return false;
    }else{
	   	 return true;
    
    }
}

/**
 * setCommonPop()
 * 작 성 자 : 
 * 작 성 일 : 2010-03-10
 * 개    요 : 필수 공통코드/명을 등록한다.
 * return값 : void
 */
function setIndiCommonPop(title, comId, evnflag, codeObj, nameObj, svcFlg){
  //setIndiCommonPop('제휴몰', 'P613', 'POP', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'I')
    if(codeObj.Text == "" && evnflag != "POP" ){
        nameObj.Text = "";
        return;
    }

    var comSqlId = svcFlg == 'S' ? 'SEL_COMM_CODE_USE_NONE_ONLY' : 'SEL_COMM_CODE_ONLY';
    
    if( evnflag == "POP" ){
    	
    	var Map =commonPop(title, comSqlId,codeObj ,nameObj,'D',comId);
    	
        return Map;
    }
    return Map;
}
/**
 * addRow()
 * 작 성 자     :박래형
 * 작 성 일     : 2010-05-31
 * 개    요        : ROW 추가
 * return값 : void
 */
function addRow(strCheck){

		if(strCheck=="2"){
		  if(checkValidation2("Save")){
	         DS_IO_MASTER.AddRow();
         //포커스 셋팅
	         GR_MASTER.SetColumn("STR_CD");
	         GR_MASTER.Focus();
	        
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD") 		= LC_STR_CD.BindColVal;
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_CD") 		= EM_PUMBUN_CD.Text;
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PUMBUN_NM") 		= EM_PUMBUN_NAME.Text; 
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "SALE_YM") 		= EM_SALE_DT_S.Text;
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORDERER_CD")  	= EM_I_ORDERER_CD.BindColVal;
	         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "ORDERER_NM")  	= EM_I_ORDERER_NAME.Text;
	         
	         GR_MASTER.SETVSCROLLING(0);
	         GR_MASTER.SETHSCROLLING(0);
		  }
		}else{
			if(checkValidation1("Save")){
			 DS_IO_DETAIL.AddRow();
	         
			 GR_MASTER2.SetColumn("STR_CD");
	         GR_MASTER2.Focus();
	         
	         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "STR_CD") 		= LC_STR_CD.BindColVal;
	         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_CD") 		= EM_PUMBUN_CD.Text;
	         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMBUN_NM") 		= EM_PUMBUN_NAME.Text; 
	         DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "SALE_YM") 		= EM_SALE_DT_S.Text;
	         
	         GR_MASTER2.SETVSCROLLING(0);
	         GR_MASTER2.SETHSCROLLING(0);
		
			}
     }
}
 
/**
* delRow()
* 작 성 자 : 박래형
* 작 성 일 : 2010-05-31
* 개    요    : ROW 삭제
* return값 : void
*/
function delRow(strCheck){
	// 삭제 메세지 
   if(showMessage(Question, YESNO, "USER-1023") != 1)
       return;
   if(strCheck=="2"){
	   var intRowCount =  DS_IO_MASTER.CountRow;
	   for(var i=intRowCount; i >= 1; i--){
	       if(DS_IO_MASTER.NameValue(i, "SEL") == 'T'){
	           DS_IO_MASTER.DeleteRow(i);
	       }
	   }
   }else{
	   var intRowCount =  DS_IO_DETAIL.CountRow;
	   for(var i=intRowCount; i >= 1; i--){
	       if(DS_IO_DETAIL.NameValue(i, "SEL") == 'T'){
	    	   DS_IO_DETAIL.DeleteRow(i);
	       }
	   }
   }
}
/**
 * getPumbunPop()
 * 작 성 자 : 이재득
 * 작 성 일 : 2010.03.28
 * 개    요 :  브랜드GridPopup
 * return값 : void
 */
 function getPumbunPop(row, colid , popFlag, gubun){
	 if(gubun==""||gubun==null){
			    var strStrCd  = DS_IO_MASTER.NameValue(row,"STR_CD");
			    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';
			    var userId  =  '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
			    var strFirstPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
			    var strPumbunCd  = DS_IO_MASTER.NameValue(row,"PUMBUN_CD");
			    DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
			    var strPumbunNm  ="";  
			    var strOrgCd = strStrCd; 
			    
			    // 입력인 경우
			    if(popFlag != "1"){        
			        var rtnMap = setStrPbnNmWithoutToGridPop("DS_O_RESULT", strPumbunCd, strPumbunNm , 'Y' , '1',userId,strStrCd, '','','','0','Y','2','','','','','');
			        if(rtnMap != null){
			           
			            // MARIO OUTLET 2011-10-21
			            if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
			            	DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
			            	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
			            	showMessage(EXCLAMATION, OK, "USER-2003");
			            	return;
			            }
			        	// MARIO OUTLET 2011-10-21
			        	
			            DS_IO_MASTER.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
			            DS_IO_MASTER.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
			           
			        } 
			    // POPUP인 경우
			    }else{
			        if (popFlag =="1"){         
			            var rtnMap = setStrPbnNmWithoutToGridPop("DS_O_RESULT", strPumbunCd, strPumbunNm , 'Y' , '1',userId,strStrCd, '','','','0','Y','2','','','','','');
			            if(rtnMap != null){
			            	
			                // MARIO OUTLET 2011-10-21
			                if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
			                	DS_IO_MASTER.NameValue(row,"PUMBUN_CD")   = "";
			                	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
			                	showMessage(EXCLAMATION, OK, "USER-2003");
			                	return;
			                }
			            	// MARIO OUTLET 2011-10-21
			            	
			            	DS_IO_MASTER.NameValue(row,"PUMBUN_NAME") = "";
			                DS_IO_MASTER.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
			                DS_IO_MASTER.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
			                
			            }
			        }
			    } 
			    return true;
	 	}else{
	 		 var strStrCd  = DS_IO_DETAIL.NameValue(row,"STR_CD");
			    var strcd   = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';
			    var userId  =  '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';
			    var strFirstPumbunCd  = DS_IO_DETAIL.NameValue(row,"PUMBUN_CD");
			    var strPumbunCd  = DS_IO_DETAIL.NameValue(row,"PUMBUN_CD");
			    DS_IO_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
			    var strPumbunNm  ="";  
			    var strOrgCd = strStrCd; 
			    
			    // 입력인 경우
			    if(popFlag != "1"){        
			        var rtnMap = setStrPbnNmWithoutToGridPop("DS_O_RESULT", strPumbunCd, strPumbunNm , 'Y' , '1',userId,strStrCd, '','','','0','Y','2','','','','','');
			        if(rtnMap != null){
			           
			            // MARIO OUTLET 2011-10-21
			            if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
			            	DS_IO_DETAIL.NameValue(row,"PUMBUN_CD")   = "";
			            	DS_IO_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
			            	showMessage(EXCLAMATION, OK, "USER-2003");
			            	return;
			            }
			        	// MARIO OUTLET 2011-10-21
			        	
			            DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
			            DS_IO_DETAIL.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
			           
			        } 
			    // POPUP인 경우
			    }else{
			        if (popFlag =="1"){         
			            var rtnMap = setStrPbnNmWithoutToGridPop("DS_O_RESULT", strPumbunCd, strPumbunNm , 'Y' , '1',userId,strStrCd, '','','','0','Y','2','','','','','');
			            if(rtnMap != null){
			            	
			                // MARIO OUTLET 2011-10-21
			                if (rtnMap.get("BIZ_TYPE") != "1" && rtnMap.get("BIZ_TYPE") != "2") {
			                	DS_IO_DETAIL.NameValue(row,"PUMBUN_CD")   = "";
			                	DS_IO_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
			                	showMessage(EXCLAMATION, OK, "USER-2003");
			                	return;
			                }
			            	// MARIO OUTLET 2011-10-21
			            	
			            	DS_IO_DETAIL.NameValue(row,"PUMBUN_NAME") = "";
			            	DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")    = rtnMap.get("PUMBUN_CD");
			            	DS_IO_DETAIL.NameValue(row, "PUMBUN_NAME")  = rtnMap.get("PUMBUN_NAME");
			                
			            }
			        }
			    } 
			    return true;
	 	}
	 return true;
	 }
/**
 * getVenInfo(code, name, btnFlag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-05-31
 * 개    요 :  브랜드에 따른 협력사 팝업
 * return값 : void
 */
function getVenInfo(code, name, btnFlag){
	 
    var strStrCd        = LC_STR_CD.BindColVal;  
    var strUseYn        = "Y";                             // 사용여부
    var strPumBunType   = "";                              // 브랜드유형
    var strBizType      = "";                              // 거래형태
    var strMcMiGbn      = "";                              // 매출처/매입처구분
    var strBizFlag      = "";                              // 거래구분
   
    if(!btnFlag){
        var rtnMap = setVenNmWithoutPop( "DS_O_RESULT", code, name, "1"
                ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                ,strBizFlag);
    }else{
        var rtnMap = venPop(code, name
                           ,strStrCd,strUseYn,strPumBunType,strBizType,strMcMiGbn
                           ,strBizFlag);
    }
   
}

function searchMarioeek(){//좌측 하단 마리오 이익율 조회
	
	DS_IO_DETAIL.ClearData();
	
	var strStrCd          = LC_STR_CD.BindColVal;      //점
    var strSaleYm         = EM_SALE_DT_S.text;         //시작일자
    var strPumbunCd       = EM_PUMBUN_CD.text;
    
    var parameter   = "&strStrCd="     +encodeURIComponent(strStrCd) 
				    + "&strSaleYm="    +encodeURIComponent(strSaleYm)
				    + "&strPumbunCd="  +encodeURIComponent(strPumbunCd)
				    ;
   
    TR_DETAIL.Action="/dps/psal532.ps?goTo=searchMarioeek"+parameter; 
    TR_DETAIL.KeyValue="SERVLET(O:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_DETAIL.Post();
    
    searchDitail();
    
}

function searchCharge(row, colid){//마리오 수수료 조회
	
	DS_O_RESULT.ClearData();
	var strStrCd       = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strSaleYm      = DS_IO_MASTER.NameValue(row, "SALE_YM");
    var strOrdererCd   = DS_IO_MASTER.NameValue(row, "ORDERER_CD");
    var strPumbunCd    = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");
    
    var parameter   = "&strStrCd="     +encodeURIComponent(strStrCd)
				    + "&strSaleYm="    +encodeURIComponent(strSaleYm)
				    + "&strOrdererCd=" +encodeURIComponent(strOrdererCd) 
				    + "&strPumbunCd="  +encodeURIComponent(strPumbunCd) 
				    ;
   
    TR_CHARGE.Action="/dps/psal532.ps?goTo=searchCharge"+parameter; 
    TR_CHARGE.KeyValue="SERVLET(O:DS_O_RESULT=DS_O_RESULT)"; //조회는 O
    TR_CHARGE.Post();  
    DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE") = DS_O_RESULT.NameValue(1, "MARIO_COMIS_RATE");
    
    if(DS_O_RESULT.NameValue(1, "MARIO_COMIS_RATE")==""||DS_O_RESULT.NameValue(1, "MARIO_COMIS_RATE")==null ){
        showMessage(Information, OK, "USER-1229");
        
        return false;
	}
    
}

function searchInterest(row, colid,check){//마리오 이익율 조회
	
	DS_O_RESULT3.ClearData();
	var strStrCd       = DS_IO_MASTER.NameValue(row, "STR_CD");
    var strSaleYm      = DS_IO_MASTER.NameValue(row, "SALE_YM");
    var strOrdererCd   = DS_IO_MASTER.NameValue(row, "ORDERER_CD");
    var strPumbunCd    = DS_IO_MASTER.NameValue(row, "PUMBUN_CD");
    
    var parameter   = "&strStrCd="     +encodeURIComponent(strStrCd)
				    + "&strSaleYm="    +encodeURIComponent(strSaleYm) 
				    + "&strOrdererCd=" +encodeURIComponent(strOrdererCd) 
				    + "&strPumbunCd="  +encodeURIComponent(strPumbunCd) 
				    ;
   
    TR_CHARGE.Action="/dps/psal532.ps?goTo=searchInterest"+parameter; 
    TR_CHARGE.KeyValue="SERVLET(O:DS_O_RESULT3=DS_O_RESULT3)"; //조회는 O
    TR_CHARGE.Post(); 
    
    
    if(check==0){
    if(DS_O_RESULT3.NameValue(1, "MARIO_PROF_RATE")==""||DS_O_RESULT3.NameValue(1, "MARIO_PROF_RATE")==null){
    	
            showMessage(Information, OK, "USER-1228");
            return false;
    	}
    }
    DS_IO_MASTER.NameValue(row, "MARIO_PROF_RATE") = DS_O_RESULT3.NameValue(1, "MARIO_PROF_RATE");
    
}

function interparkeek(row, colid){//인터파크 이익율 계산
	
	var intMCR        = DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE");
    var intOCR        = DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE");
    var intMPR        = DS_IO_MASTER.NameValue(row, "MARIO_PROF_RATE");
  	var intAPR = intMCR-intOCR-intMPR;
  	DS_IO_MASTER.NameValue(row, "AGENCY_PROF_RATE")=intAPR;
}

function checkMario(row,colid){
	
		if(DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")!=""){
				
			}else{
				if(DS_IO_MASTER.NameValue(row, "STR_CD")!="" && 
				   DS_IO_MASTER.NameValue(row, "PUMBUN_CD")!="" && DS_IO_MASTER.NameValue(row, "SALE_YM")!=""){
			searchCharge(row, colid);
			}
		}
	return true;
}

function searchPro(){
	 var strStrCd  = LC_STR_CD.BindColVal;
	 var strStrDt  = EM_SALE_DT_S.text;
	    
	 //var goTo       = "valCheck" ;    
	 var parameters = "&strStrCd="+encodeURIComponent(strStrCd)
	    			+ "&strStrDt="+encodeURIComponent(strStrDt);
	 DS_IO_PROCESSOR.ClearData();
		    
    //변경또는 신규 내용을 저장하시겠습니까?
        if( showMessage(QUESTION, YESNO, "USER-1204") == 1 ){    
        	TR_VALCHECK.Action="/dps/psal532.ps?goTo=valCheck"+parameters; 
            TR_VALCHECK.KeyValue="SERVLET(O:DS_IO_PROCESSOR=DS_IO_PROCESSOR)"; 
            TR_VALCHECK.Post();
         
	        } 
  
}
</script>

</head>

<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
	
    switch(colid){
    
    case "ORDERER_CD":
        var strOrdererCd = DS_IO_MASTER.NameValue(row, "ORDERER_CD");
        var strOrdererNm = DS_IO_MASTER.NameValue(row, "ORDERER_NM");
      
	    var map= setIndiCommonPop('입점몰', 'P613', 'POP', strOrdererCd, strOrdererNm,'I');
	    DS_IO_MASTER.NameValue(row, "ORDERER_CD") = map.get("CODE_CD");
		DS_IO_MASTER.NameValue(row, "ORDERER_NM") = map.get("CODE_NM");
		DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")="";
		
    	break;
    	
     case "SALE_YM":
        var strSaleYm = DS_IO_MASTER.NameValue(row, "SALE_YM");
        openCal(GR_MASTER,row,colid,'M');
    	break;
    	
     case "PUMBUN_CD" :
    	 
     	getPumbunPop(row , colid , '1'); 
     	DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")=""
     	DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")="";
     	checkMario(row,colid);
     	
        break;
    	 
    }
</script>
<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER2 event=OnPopup(row,colid,data)>
		
    switch(colid){
    
     case "SALE_YM":
        var strSaleYm = DS_IO_MASTER.NameValue(row, "SALE_YM");
        openCal(GR_MASTER,row,colid,'M');
    	break;
    	
     case "PUMBUN_CD" :
     	getPumbunPop(row , colid , '1','2'); 
    
         break;
    	 
    }
</script>
 <script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
	
    switch (colid) {
    	case "STR_CD":
    		DS_IO_MASTER.NameValue(row, "PUMBUN_CD")="";
    		DS_IO_MASTER.NameValue(row, "PUMBUN_NAME")="";
    		DS_IO_MASTER.NameValue(row, "ORDERER_CD")="";
    		DS_IO_MASTER.NameValue(row, "ORDERER_NM")="";
    		DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")="";
    		DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")="";
    		DS_IO_MASTER.NameValue(row, "MARIO_PROF_RATE")="";
    		DS_IO_MASTER.NameValue(row, "AGENCY_PROF_RATE")="";
	    case "PUMBUN_CD" :
	    	if(DS_IO_MASTER.NameValue(row,"PUMBUN_CD")==null || DS_IO_MASTER.NameValue(row,"PUMBUN_CD")==""){
	    	}else{
			        getPumbunPop(row , colid , '');
			        DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")=""
			        DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")="";
			        check=0;
			        checkMario(row,colid);
			        
	    	}
	        break;
	    case "MARIO_COMIS_RATE":
	    	
			if(DS_IO_MASTER.NameValue(row, "STR_CD")!=""  && 
			   DS_IO_MASTER.NameValue(row, "PUMBUN_CD")!="" && DS_IO_MASTER.NameValue(row, "SALE_YM")!="" &&
			   DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")!=""){
			   searchInterest(row, colid,check);
			   check++;
					
				
			}
			
	    case "ORDERER_COMIS_RATE":   //MARIO_PROF_RATE
	    	if(    DS_IO_MASTER.NameValue(row, "MARIO_PROF_RATE")!="" && DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")!="" &&
	 			   DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")!=""){
	 			   interparkeek(row, colid);
	    	}
 }
	
</script> 
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    switch (colid) {
    	case "STR_CD":
    		DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")="";
    		DS_IO_DETAIL.NameValue(row, "PUMBUN_NAME")="";
    		DS_IO_DETAIL.NameValue(row, "ORDERER_CD")="";
    		DS_IO_DETAIL.NameValue(row, "ORDERER_NM")="";
    		DS_IO_DETAIL.NameValue(row, "MARIO_PROF_RATE")="";
	    case "PUMBUN_CD" :
	    	if(DS_IO_DETAIL.NameValue(row,"PUMBUN_CD")==null || DS_IO_DETAIL.NameValue(row,"PUMBUN_CD")==""){
			    
	    	}else{
	    		getPumbunPop(row , colid , '','2');
			    DS_IO_MASTER.NameValue(row, "MARIO_COMIS_RATE")=""
			    DS_IO_MASTER.NameValue(row, "ORDERER_COMIS_RATE")="";
			     
	    	}
	        break;
    } 

</script>

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
<script language=JavaScript for=TR_VALCHECK event=onFail>
    trFailed(TR_VALCHECK.ErrorMsg);
</script>
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_VALCHECK event=onSuccess>
    for(i=0;i<TR_VALCHECK.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_VALCHECK.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL2 event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_CHARGE event=onSuccess>
    for(i=0;i<TR_CHARGE.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_CHARGE.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>



<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

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
    var varToday = now.getYear().toString()+ mon + day;
    var varToMon = now.getYear().toString()+ mon;
</script>

<!-- <script language=JavaScript for=EM_I_ORDERER_CD event=onKillFocus()>

    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;
    setIndiCommonPop('제휴몰', 'P613', 'NAME', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'I');
</script>
 -->
<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row , colid); 
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
<object id="DS_SETVAT" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSNOMM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_POS_FLOOR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_POS_FLAG" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_O_RESULT2" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_RESULT3" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>


<comment id="_NSID_">
<object id="DS_I_CONDITION" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
       
<comment id="_NSID_">
<object id="DS_O_POSNOH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSFLORH" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSFLORMM" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSFLOR" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_SEARCH_NM" classid=<%= Util.CLSID_DATASET %>></object>
</comment>
<script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_SALE_DATE"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>>
</object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL"      classid=<%= Util.CLSID_DATASET %>>
</object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_PROCESSOR"      classid=<%= Util.CLSID_DATASET %>>
</object></comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_MASTER_CROSSTAB" classid=<%=Util.CLSID_DATASET%>>
    <param name=DataID      value="DS_O_MASTER">
    <param name=Logical     value="true">
    <param name=GroupExpr   value="PUMBUN_CD:PUMBUN_NM,ORDERER_NM2,:ORDERER_COMIS_RATE:AGENCY_PROF_RATE"></object> <!-- ORDERER_NM,ORDERER_NM2,ORDERER_COMIS_RATE,:AGEYCY_PROF_RATE -->
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>>
</object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_POSNO" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="TR_VALCHECK" classid=<%=Util.CLSID_TRANSACTION%>>
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
<object id="TR_CHARGE" classid=<%=Util.CLSID_TRANSACTION%>>
    <param name="KeyName" value="Toinb_dataid4">
</object>
</comment>
<script>_ws_(_NSID_);</script>



<comment id="_NSID_"><object id="DS_I_REASON_CD"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_VAT_YN"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                               *-->
<!--*************************************************************************-->


<!--*************************************************************************-->
<!--* E. 본문시작                                                           *-->
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
                  <th width="70" class="point"  >점</th>
                  <td width="105"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=95 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  
                  <th width="70" class="point"  >매출월</th>
                  <td width="105" ><comment id="_NSID_"> <object
                     id=EM_SALE_DT_S classid=<%=Util.CLSID_EMEDIT%> width=75
                     tabindex=1 align="absmiddle"> </object> </comment> <script> _ws_(_NSID_);</script>
                  <img src="/<%=dir%>/imgs/btn/date.gif"
                     onclick="javascript:openCal('M',EM_SALE_DT_S)" align="absmiddle" />
                     
               </tr>
               <tr>
		               <th>브랜드</th>
		            <td>
		               <comment id="_NSID_">
		                 <object id=EM_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=80 align="absmiddle"></object>
		               </comment><script> _ws_(_NSID_);</script>
		               <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" class="PR03" align="absmiddle"
		                 onclick="javascript:strPbnPop(EM_PUMBUN_CD,EM_PUMBUN_NAME, 'Y'); EM_PUMBUN_CD.focus();"/>
		               <comment id="_NSID_">
		                 <object id=EM_PUMBUN_NAME classid=<%=Util.CLSID_EMEDIT%> width=105 align="absmiddle"></object>
		               </comment><script> _ws_(_NSID_);</script>
		            </td>
                     
                      <th >제휴몰</th>
                      <td colspan="3">
                        <comment id="_NSID_">
                          <object id=EM_I_ORDERER_CD classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
                        <img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_ORIGIN_AREA_CD onclick="javascript:setIndiCommonPop('제휴몰', 'P613', 'POP', EM_I_ORDERER_CD, EM_I_ORDERER_NAME,'I');"  align="absmiddle" />
                        <comment id="_NSID_">
                          <object id=EM_I_ORDERER_NAME classid=<%=Util.CLSID_EMEDIT%> width=80 tabindex=1 align="absmiddle"></object>
                        </comment><script> _ws_(_NSID_);</script>
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
      <tr>
                <td class="right">
		             <img src="/<%=dir%>/imgs/btn/copy_last.gif" id="IMG_ADD"  width="80" height="18" hspace="2" onclick="javascript:searchPro();" />
           		</td>
               </tr>
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               
               <tr>
               
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GD_MASTER_CROSSTAB width=100% height=230 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_O_MASTER_CROSSTAB">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>
   
   <tr align="right">
    <td>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
          	<td class="right" width=350 >
             <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addRow('1');" /> 
             <img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delRow('1');" />    
           </td>
            <td class="right">
             <img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_ADD"  width="52" height="18" hspace="2" onclick="javascript:addRow('2');" /> 
             <img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_DEL" width="52" height="18" onclick="javascript:delRow('2');" />    
           </td>
         </tr>
      </table>
    </td>
  </tr>
  
   
	 <tr valign="top">
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr>
            <td width="350">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                class="BD4A">
                <tr>
                    <td><comment id="_NSID_"><object id=GR_MASTER2
                        width=100% height=220 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_DETAIL">
                    </object></comment><script>_ws_(_NSID_);</script></td>
                </tr>
            </table>
            </td>
            <td class="PL10">
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
                class="BD4A">
                <tr>
                    <td><comment id="_NSID_"><object id=GR_MASTER
                        width=100% height=220 classid=<%=Util.CLSID_GRID%>>
                        <param name="DataID" value="DS_IO_MASTER">
                    </object></comment><script>_ws_(_NSID_);</script></td>
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

</div>
<body>
</html>
