<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 발주매입 > 택발행> 택발행 의뢰등록(품목)
 * 작 성 일 : 2010.02.25
 * 작 성 자 : 박래형
 * 수 정 자 : 
 * 파 일 명 : pord3010.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 택발행 의뢰등록한다
 * 이    력 :
 *        2010.02.27 (박래형) 신규작성
 ******************************************************************************/
-->
<%@ page language="java" contentType="text/html;charset=utf-8" import="common.util.Util, 
   common.vo.SessionInfo, kr.fujitsu.ffw.base.BaseProperty"   %>
 <% request.setCharacterEncoding("utf-8"); %> 
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"         prefix="gauce" %>  
<%@ taglib uri="/WEB-INF/tld/app.tld"             prefix="loginChk" %>
<%@ taglib uri="/WEB-INF/tld/button.tld"          prefix="button" %>

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
var strToday          = "";      // 현재날짜
var strStyleType      = 0;       // 단품종류 1 = A, 2 = B
var blnSkuChanged     = false;   // 단품코드 변경 여부
var saveFlag          = false;   // CanRowPosChange 구분위한
var searchFlag        = false;   // 마스터 건수를 표시할지 디테일 건수를 표시할지 여부
var inta              = 0;
var bfListRowPosition = 0;       // 이전 List Row Position
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */
 var top  = 125;		//해당화면의 동적그리드top위치
 var top2 = 320;		//해당화면의 동적그리드top위치
function doInit(){
	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GR_MASTER"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
	 
	 var obj   = document.getElementById("GR_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top2) + "px";
	
     
    strToday = getTodayDB("DS_O_RESULT")   //현재날짜

    // Output Data Set Header 초기화
    DS_O_LIST.setDataHeader('<gauce:dataset name="H_SEL_LIST"/>');
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');    

    DS_EVENT_FLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
    DS_SETEVNFLAG.setDataHeader('<gauce:dataset name="H_MARGIN_FLAG"/>');
    DS_EVENT_RATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
    DS_SETEVNRATE.setDataHeader('<gauce:dataset name="H_MARGIN_RATE"/>'); 
    DS_PUMMOK_INFO.setDataHeader('<gauce:dataset name="H_PUMMOK_INFO"/>');     //품목코드 정보
    
    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //단품 디테일    
    
    // 상단 조회 컴퍼넌트 초기화    
    initComboStyle(LC_S_STR_CD,  DS_STR,   "CODE^0^30,NAME^0^140", 1, PK);               //조회용 점    
    initEmEdit(EM_S_PRT_REQ_DT,       "SYYYYMMDD",     PK);                                 //조회용 의뢰일자
    initEmEdit(EM_S_PRT_REQ_DT2,      "TODAY",     PK);                                 //조회용 의뢰일자
    initEmEdit(EM_S_PRT_REQ_SEQ_NO,   "GEN",   NORMAL);                                 //조회용 의뢰번호
    initEmEdit(EM_S_PUMBUN_CD,        "000000", NORMAL);                                 //조회용 픔번코드
    initEmEdit(EM_PUMBUN_NM,          "GEN",     READ);                                 //조회용 브랜드명     
    
    // 단품 컴퍼넌트 초기화    
    
    initComboStyle(LC_I_STR_CD,   DS_STR,       "CODE^0^30,NAME^0^140", 1, PK);          //입력용 점
    initComboStyle(LC_I_TAG_FLAG, DS_TAG_FLAG,  "CODE^0^30,NAME^0^80", 1, PK);          //입력용 택구분    
    initEmEdit(EM_I_PRT_REQ_DT,     "YYYYMMDD",   PK);                                  //입력용 의뢰일자
    initEmEdit(EM_O_PRT_REQ_SEQ_NO, "GEN^5",   READ);                                   //출력용 의뢰번호
    initEmEdit(EM_I_PUMBUN_CD,      "000000",   PK);                                     //입력용 브랜드(코드)
    initEmEdit(EM_O_PUMBUN_NM,      "GEN",   READ);                                     //출력용 브랜드명    
    initEmEdit(EM_I_APP_DT,         "YYYYMMDD",   PK);                                  //입력용 마진적용일           
    initEmEdit(EM_VEN_CD,           "000000",   READ);                                     //협력사코드
    initEmEdit(EM_VEN_NM,           "GEN",   READ);                                     //협력사 명  
    initEmEdit(EM_I_YYYY,           "YYYY",  PK);                                       // 생산년도
    
    initComboStyle(LC_I_EVENT_FLAG, DS_EVENT_FLAG,  "EVENT_FLAG^0^30,EVENT_FLAG_NM^0^0", 1, PK);              //입력용 행사구분 
    initComboStyle(LC_I_EVENT_RATE, DS_EVENT_RATE,  "EVENT_RATE^0^30,EVENT_RATE_NM^0^0", 1, PK);              //입력용 행사율     
    
//    EM_VEN_CD.style.display         = "none";
//    EM_VEN_NM.style.display         = "none";
    
    //시스템 코드 공통코드에서 가지고 오기( popup.js )
    getStore("DS_STR", "Y", "", "N");                   // 점      
    getEtcCode("DS_TAG_FLAG", "D", "P228", "N");        //택구분      
    
    //사용할 데이터셋 레지에 등록
    registerUsingDataset("pord301","DS_O_LIST,DS_IO_MASTER,DS_IO_DETAIL,DS_PUMMOK_INFO" );
    
    LC_S_STR_CD.Index = 0;      //점코드 초기 셋팅
//    LC_I_STR_CD.Index = 0;    
//    LC_I_TAG_FLAG.Index = 0;    

    LC_S_STR_CD.Focus();       //로드시 점코드 포커스 이동
/*    
    //조회부 정렬
    EM_S_PRT_REQ_SEQ_NO.alignment  = 1;
    EM_S_PUMBUN_CD.alignment  = 1;
    
    //입력부 정렬
    EM_O_PRT_REQ_SEQ_NO.alignment  = 1;
    EM_I_PUMBUN_CD.alignment  = 1;
    EM_VEN_CD.alignment  = 1;
    
    setTempEvnDataset();       //행사구분 행사율 데이터셋 임시지정
    setEventFlagDs();          //행사구분 행사율 데이터셋 복사
    
*/
    LC_I_EVENT_FLAG.Enable = false;
    LC_I_EVENT_RATE.Enable = false;    
    setObject(false);    
}

function gridCreate1(){         //택발행의뢰HEADER
    var hdrProperies = '<FC>id=PRT_REQ_SEQ_NO   name="의뢰번호"     width=60   align=center </FC>'
                     + '<FC>id=TAG_FLAG_NM      name="TAG구분"      width=90   align=center </FC>'
                     + '<FC>id=PRT_REQ_NM       name="의뢰자"       width=60   align=left </FC>'
                     + '<FC>id=PROC_FLAG_NM     name="구분"         width=40   align=center </FC>';

    initGridStyle(GR_MASTER, "common", hdrProperies, false);
}
//edit={IF(TAG_PRT_YN="N","true","false")}

function gridCreate2(){         //단품 - 택발행의뢰DETAIL(규격과 의류일때 달라짐)
    var hdrProperies = '<FC>id={currow}          name="NO"          width=30    align=center  Edit=none </FC>'
                     + '<FC>id=CHECK1            name=""            width=18    align=center  HeadCheckShow=true EditStyle=CheckBox edit={IF(TAG_PRT_YN="N","true","false")}</FC>'
                     + '<FC>id=PUMMOK_SRT_CD     name="* 단축코드"   width=65    align=center  EditStyle=Popup  sumtext="합계" edit={IF(TAG_PRT_YN="N","true","false")}  </FC>'
                     + '<FC>id=PUMMOK_CD         name="품목코드"     width=80    align=center  Edit=none sumtext="합계" edit={IF(TAG_PRT_YN="N","true","false")} show=false</FC>'
                     + '<FC>id=PUMMOK_NAME         name="품목명"       width=80    align=left   edit="none" SHOW=FALSE</FC>'  
                     + '<FC>id=RECP_NAME       name="영수증명"     width=110   align=left   edit="none"</FC>'  
                     + '<FC>id=PRT_REQ_SEQ_NO    name="의뢰"         width=30    align=left   Edit=none show="false"</FC>'
                     + '<FC>id=PRT_DTL_SEQ_NO    name="디테일"       width=30    align=left   Edit=none show="false"</FC>'
                     + '<FC>id=SKU_CD            name="단품코드"     width=120   align=left   Edit=none  show="false"</FC>'
                     + '<FC>id=SKU_NAME            name="단품명"       width=100   align=left   Edit=none show="false"</FC>'
                     + '<FC>id=PUMBUN_CD         name="브랜드"         width=50    align=left   Edit=none show="false"</FC>'
                     + '<FC>id=PUMBUN_NAME         name="브랜드명"       width=100   align=left   Edit=none show="false"/FC>'  
                     + '<FC>id=VEN_CD            name="협력사코드"   width=70    align=left   Edit=none show="false"</FC>'                  
                     + '<FC>id=VEN_NAME            name="협력사명"     width=100   align=left   Edit=none show="false"</FC>'
                     + '<FC>id=REQ_CNT           name="* 의뢰수량"   width=65    align=right  Edit=Numeric edit={IF(TAG_PRT_YN="N","true","false")} sumtext=@sum</FC>'
                     + '<FG> name="판 매 가"'
                     + '<FC>id=SALE_PRC          name="단가"       width=80    align=right  Edit=Numeric edit={IF(TAG_PRT_YN="N","true","false")} sumtext=@sum</FC>'
                     + '<FC>id=SALE_AMT          name="금액"         width=120    align=right  Edit=none  sumtext=@sum</FC>'
                     + '</FG>'
                     + '<FC>id=TAG_PRT_YN        name="발행여부"     width=60    align=center Edit=none  </FC>'
                     + '<FC>id=PRT_YYYY          name="생산년도"      width=55     align=right     edit=none show=false</FC>'
                     ;

    initGridStyle(GR_DETAIL, "common", hdrProperies, true);
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
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() { 	 
	 
	// CanRowPosChange 구분위한
	saveFlag = false;

    // 변경, 추가내역이 있을 경우
    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1073") != 1 )
           return;
    }
   
    if(checkValidation("Search")){
        DS_O_LIST.ClearData();  
        DS_IO_DETAIL.ClearData();
        inta = 0;
        bfListRowPosition = 0;        
        getList();
        setPorcCount("SELECT", GR_MASTER);
        
        if(DS_O_LIST.CountRow <= 0){
            setObject(false);    
            LC_S_STR_CD.Focus();     
            return;
        }
        GR_MASTER.Focus();
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
     
    // CanRowPosChange 구분위한
    saveFlag = false;
    
    // 전표마스터 추가후 행추가, 삭제 버튼 활성화 (저장되지 않은 내용이 있을경우 추가되지 않음)
    if(DS_O_LIST.NameValue(DS_O_LIST.CountRow, "PRT_REQ_SEQ_NO") == ""){
          if(showMessage(QUESTION, YESNO, "USER-1072") != 1 ){
              return;
          }else{
        	  clearObject();
              DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
        	  return;
          }
    }else{
        DS_O_LIST.Addrow(); 
    }   

    DS_IO_MASTER.Addrow();   
    LC_I_STR_CD.Index = 0;   
    EM_I_PRT_REQ_DT.Text = strToday;    //의뢰일자
    EM_I_APP_DT.Text = strToday;        //마진적용일
    EM_I_YYYY.Text = strToday.substring(0,4);
    DS_IO_DETAIL.ClearData();
    LC_I_TAG_FLAG.Index = 0;
    
    setObject(true); 
    LC_I_EVENT_FLAG.Text = "";
    LC_I_EVENT_RATE.Text = "";
    LC_I_EVENT_FLAG.Enable = false;
    LC_I_EVENT_RATE.Enable = false;

    LC_I_STR_CD.Focus();
}

/**
 * btn_Delete()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요    : 택 발행 의뢰 마스터 삭제
 * return값 : void
 */
function btn_Delete() {    
    
    // CanRowPosChange 구분위한
    saveFlag = true;
    
    // 삭제할 데이터 없는 경우
    if (DS_IO_MASTER.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    // 신규 전표인 경우 데이터셋에서만 삭제
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PRT_REQ_SEQ_NO").length == 0){
        DS_IO_DETAIL.ClearData();
        DS_IO_MASTER.ClearData();
        DS_O_LIST.DeleteRow(DS_O_LIST.RowPosition);
        setObject(false);
        return;
    }    

    if(!checkValidation("Delete")) 
    	return;    	
        
    if(showMessage(QUESTION, YESNO, "USER-1023") == 1){ 
	    var strStrCd       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");
	    var strPrtReqDt    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_DT");
	    var strPrtReqSeqNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");	
	    
	    var goTo       = "saveMaster";  
	    var parameters = "&strFlag=deleMaster" 
	                   + "&strStrCd="+encodeURIComponent(strStrCd)
	                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
	                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo);
	
	    DS_IO_MASTER.DeleteRow(DS_IO_MASTER.RowPosition);
	    
	    TR_S_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters;  
	    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
	    TR_S_MAIN.Post(); 
	    
    }
    saveFlag = false;

    btn_Search();
}

/**
 * btn_Save()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
     
    // CanRowPosChange 구분위한
     saveFlag = true;

    // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated && !DS_O_LIST.IsUpdated){
       //저장할 내용이 없습니다
       showMessage(EXCLAMATION, OK, "USER-1028");
       return;
    }
   

  
    if(DS_IO_DETAIL.CountRow <= 0){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
        GR_DETAIL.Focus();
        return;
    }
    
    if(!checkValidation("Save"))
        return;
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 ){
    	return;
    }
    
    saveMaster();                  // 저장          
    LC_I_EVENT_FLAG.Enable = false;     
    saveFlag = false;
    blnSkuChanged = false;
    bfListRowPosition = 0;

    btn_Search(); 
}

/**
 * btn_Excel()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-12-12
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 박래형
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
 * setObject(flag)
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 :  컴퍼넌트 셋팅
 * return값 : void
 */
 function setObject(flag){

     LC_I_STR_CD.Enable     = flag;
     EM_I_PRT_REQ_DT.Enable = flag;
     EM_I_PUMBUN_CD.Enable  = flag;
     EM_I_APP_DT.Enable     = flag;
     EM_I_YYYY.Enable       = flag;
     LC_I_TAG_FLAG.Enable   = flag;
     
     LC_I_EVENT_FLAG.Enable = flag;
     LC_I_EVENT_RATE.Enable = flag;
     
     //이미지버튼
     enableControl(IMG_PRT_REQ_DT, flag);  //의뢰일자 이미지
     enableControl(IMG_PUMBUN_CD,flag);    //브랜드 이미지
     enableControl(IMG_APP_DT,     flag);  //마진적용일 이미지
 }


 /**
 * clearObject()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-04-25
 * 개    요 :  그리드초기화 셋팅
 * return값 : void
 */
 function clearObject(){

	 DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO") = "";
	 DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "TAG_FLAG_NM") = "";
	 DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_NM") = "";
	 DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PROC_FLAG_NM") = "";
 }
 /**
 * getList()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  리스트 리스트 조회
 * return값 : void
 */
 function getList(){
	 

//     DS_O_LIST.ClearData();  
//     DS_IO_DETAIL.ClearData();
     
     var strStrCd          = LC_S_STR_CD.BindColVal;
     var strPrtReqDt       = EM_S_PRT_REQ_DT.Text;
     var strPrtReqDt2      = EM_S_PRT_REQ_DT2.Text;
     var strPumbunCd       = EM_S_PUMBUN_CD.Text;
     var strPrtReqSeqNo    = EM_S_PRT_REQ_SEQ_NO.Text;
     
     var goTo       = "getList" ;    
     var action     = "O";     
     var parameters = "&strStrCd=" +encodeURIComponent(strStrCd) 
				    + "&strPrtReqDt=" +encodeURIComponent(strPrtReqDt)
				    + "&strPrtReqDt2=" +encodeURIComponent(strPrtReqDt2)
                    + "&strPumbunCd=" +encodeURIComponent(strPumbunCd)
                    + "&strPrtReqSeqNo=" +encodeURIComponent(strPrtReqSeqNo);
     TR_L_MAIN.Action  ="/dps/pord301.po?goTo="+goTo+parameters;  
     TR_L_MAIN.KeyValue="SERVLET("+action+":DS_O_LIST=DS_O_LIST)";
     TR_L_MAIN.Post();
 }
 

 /**
 * getMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 :  마스터 리스트 조회
 * return값 : void
 */
 function getMaster(){     

     var strStrCd          = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");
     var strPumbunCd       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PUMBUN_CD");
     var strMgAppDt        = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "MG_APP_DT");
     var strPrtReqDt       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_DT");
     var strPrtReqSeqNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");     

     getMarginFlag(strStrCd, strPumbunCd, strMgAppDt);     //행사구분
     
     var goTo       = "getMaster" ;    
     var action     = "O";     
     var parameters = "&strStrCd=" +encodeURIComponent(strStrCd) 
                    + "&strPrtReqDt=" +encodeURIComponent(strPrtReqDt)
                    + "&strPrtReqSeqNo=" +encodeURIComponent(strPrtReqSeqNo);
     TR_S_MAIN.Action  ="/dps/pord301.po?goTo="+goTo+parameters;  
     TR_S_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)";
     TR_S_MAIN.Post();
 }
 
  
  /**
   * getPbnPmk()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-28
   * 개    요 :  단품 디테일 리스트 조회
   * return값 : void
   */
   function getDetail(){
       var strStrCd          = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");
       var strPrtReqDt       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_DT");
       var strPrtReqSeqNo    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");
       var strSkuFlag        = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "SKU_FLAG");

       var goTo       = "getDetail" ;    
       var action     = "O";     
       var parameters = "&strStrCd=" +encodeURIComponent(strStrCd) 
                      + "&strPrtReqDt=" +encodeURIComponent(strPrtReqDt)
                      + "&strPrtReqSeqNo=" +encodeURIComponent(strPrtReqSeqNo)
                      + "&strSkuFlag=" +encodeURIComponent(strSkuFlag);
       TR_MAIN.Action  ="/dps/pord301.po?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_DETAIL=DS_IO_DETAIL)";
       TR_MAIN.Post();       

       GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
       
   }
 
 /**
  * addDetailRow()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-02-28
  * 개    요 :  디테일에 리스트 추가
  * return값 : void
  */
  function addDetailRow(){
	  
	//바인드시킨 값을 잃어버렸기 때문에 다시 셋팅
//	getMarginRate(LC_I_EVENT_FLAG.BindColVal);    
      
    // CanRowPosChange 구분위한
    saveFlag = false;

    
    //마스터 전표상태가 Y인 경우
    if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PROC_FLAG") == "Y"){
        showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리되어 추가 할수 없습니다."); 
        return;
    }     
    
    if(DS_O_LIST.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "의뢰정보를 먼저 입력해주세요.");
        return;
    }
       

    if(EM_I_PUMBUN_CD.Text.length == 0){
        showMessage(EXCLAMATION, OK, "USER-1000", "브랜드을 먼저 입력해 주세요.");
        return;
    }
      
    //행추가시 마스터 입력부 컴퍼넌트를 수정할 수 없게 막는다.
    if(DS_IO_DETAIL.CountRow > 0 || DS_O_LIST.RowStatus(DS_O_LIST.RowPosition) == 1){
        setObject(false);  //마스터 입력부 컨트롤 비활성화
        LC_I_EVENT_RATE.Enable = false;
    }
    if(checkValidation("Add")){
    	
        DS_IO_DETAIL.Addrow();
        //래형래형
        DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "TAG_PRT_YN")       = "N";

        setObject(false); 
        //GR_DETAIL.SetColumn("PUMMOK_CD");
        GR_DETAIL.SetColumn("PUMMOK_SRT_CD");
        GR_DETAIL.Focus();
    }else{
    	
    	if(LC_I_EVENT_FLAG.Text ==""){
            setObject(true); 
            LC_I_EVENT_RATE.Enable = false;
    	}else{
            setObject(true); 
    	}

    }
  }
 
  /**
   * delDetailRow()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-28
   * 개    요 :  디테일에 리스트 삭제
   * return값 : void
   */
 function delDetailRow(){ 
       
    // CanRowPosChange 구분위한
    saveFlag = false;
    
    if(DS_IO_DETAIL.CountRow == 0){
        showMessage(EXCLAMATION, OK, "USER-1019");
        return;
    }
    sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );
    

    //그리드 CHEKCBOX헤더 체크해제
    GR_DETAIL.ColumnProp('CHECK1','HeadCheck')= "FALSE";
    
    //디테일부에 데이터 없으면 마스터입력부 활성화
    if(DS_IO_DETAIL.CountRow == 0){
        setObject(true);        
    }else{
        LC_I_EVENT_RATE.Enable = false;
    }
 }  

/**
 * saveMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-02-28
 * 개    요 : 마스터 내용 저장
 * return값 : void
 */
function saveMaster() {     
           
//    if(!checkDSBlank(GD_DETAIL, "1,2,4")) return; //필수 입력부 체크함수    
/*
    if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PROC_FLAG") != 'N'){   //진행상태가 N이 아니면 수정할수 없다.
        alert("저장할 수 없습니다.");
        return;
    }
*/        
    // 조회조건 셋팅
    var strStrCd          = "";
    var strPrtReqDt       = "";
    var strPrtReqSeqNo    = "";
    var strPumbunCd       = "";     
    var strVenCd          = "";
    var strMgAppDt        = "";
    var strEventFlag      = "";         
    var strEventRate      = "";
    var strTagFlag        = "";
    var strProductYear    = "";

    strStrCd          = LC_I_STR_CD.BindColVal;
    strPrtReqDt       = EM_I_PRT_REQ_DT.Text;
    strPrtReqSeqNo    = EM_O_PRT_REQ_SEQ_NO.Text;
    strPumbunCd       = EM_I_PUMBUN_CD.Text;     
    strVenCd          = EM_VEN_CD.Text;
    strMgAppDt        = EM_I_APP_DT.Text;
    strEventFlag      = LC_I_EVENT_FLAG.BindColVal;        
    strEventRate      = LC_I_EVENT_RATE.BindColVal;        
    strTagFlag        = LC_I_TAG_FLAG.BindColVal;
    strProductYear    = EM_I_YYYY.Text;
    
    var goTo       = "saveMaster" ;    
    var action     = "I";     
    var parameters = "&strFlag=save"     
                   + "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo)
                   + "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                   + "&strVenCd="+encodeURIComponent(strVenCd)     
                   + "&strMgAppDt="+encodeURIComponent(strMgAppDt)
                   + "&strEventFlag="+encodeURIComponent(strEventFlag)     
                   + "&strEventRate="+encodeURIComponent(strEventRate)
                   + "&strTagFlag="+encodeURIComponent(strTagFlag)
                   + "&strPrtYYYY="+encodeURIComponent(strProductYear)
                   ;     
    TR_S_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)";
    TR_S_MAIN.Post(); 
}

/**
 * checkValidation()
 * 작 성 자     : 박래형
 * 작 성 일     : 2010-03-04
 * 개    요        : 조회, 저장시  값 체크 
 * return값 : void
 */
function checkValidation(Gubun) {
     
     var messageCode = "USER-1001";
     
     //조회버튼 클릭시 Validation Check
     if(Gubun == "Search"){   
         if(LC_S_STR_CD.Text.length == 0){                                          // 점
               showMessage(EXCLAMATION, OK, messageCode, "점");
               LC_S_STR_CD.Focus();
               return false;
         }  
         
         if(EM_S_PRT_REQ_DT.Text.length == 0){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1002", "조회시작일");
             EM_S_PRT_REQ_DT.Focus();
             return false;
        }
         
         if(EM_S_PRT_REQ_DT.Text > EM_S_PRT_REQ_DT2.Text){                              // 조회일 정합성
             showMessage(EXCLAMATION, OK, "USER-1015");
             EM_S_PRT_REQ_DT.Focus();
             return false;
        }
     }
     
     // 저장버튼 클릭시 Validation Check
     if(Gubun == "Add"){
         
         if(EM_I_PRT_REQ_DT.Text.length == 0){                                    // 의뢰일자
             showMessage(EXCLAMATION, OK, "USER-1002", "의뢰일자");
             EM_I_PRT_REQ_DT.Focus();
//             setObject(true);
             return false;
          } 
         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PUMBUN_CD.Focus();
//             setObject(true);
             return false;
         }
         
         // 존재하는 브랜드 코드인지 확인한다.
         if(!savePumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PUMBUN_CD.Focus();
//             setObject(true);
             return false;
         }
         
         
         if(EM_I_APP_DT.Text.length == 0){                                    // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "마진적용일");
             EM_I_APP_DT.Focus();
//             setObject(true);
             return false;
          } 

         if(LC_I_EVENT_FLAG.Text == ""){                                      // 행사구분
             showMessage(EXCLAMATION, OK, "USER-1002", "행사구분");
             LC_I_EVENT_FLAG.Focus();
//             setObject(true);   
             return false;
          } 
                                                                                
         if(LC_I_EVENT_RATE.Text == ""){                                     // 행사율
             showMessage(EXCLAMATION, OK, "USER-1002", "행사율");
             LC_I_EVENT_RATE.Focus();
//             setObject(true);   
             return false;
         } 
         
         var intRowCount   = DS_IO_DETAIL.CountRow;
         var strPummokCd   = "";                       // 품목코드
         var strPmkSrtCd   = "";                       // 단축 품목코드
         var intQty        = 0;                        // 의뢰수량       
         var intNewSalePrc = 0;                        // 매가단가  
         var intNewSaleAmt = 0;                        // 매가금액
         
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
            	 strPmkSrtCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_SRT_CD");
                 strPummokCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_CD");
                 intQty        = DS_IO_DETAIL.NameValue(i, "REQ_CNT");
                 intNewSalePrc = DS_IO_DETAIL.NameValue(i, "SALE_PRC");
                 intNewSaleAmt = DS_IO_DETAIL.NameValue(i, "SALE_AMT");
                 
                 
                 //품목코드 없을시 체크한다.
                 if(strPmkSrtCd.length <= 0){ 
                     return true;
                 }

                 /*                 
                 //품목코드 없을시 체크한다.
                 if(strPummokCd.length <= 0){ 
                     return true;
                 }
                 
                 // 존재하는 품목 코드인지 확인한다.
                 if(!getPbnPmkPop(row, colid, '1')){
                     showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                     GR_DETAIL.SetColumn("PUMMOK_CD");  
                     DS_IO_DETAIL.RowPosition = i;  
                     return false;
                 } 
                */
                
                /*
                // 존재하는 품목 코드인지 확인한다.
                if(!getPbnPmkPop2(i)){
                    showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                    GR_DETAIL.SetColumn("PUMMOK_CD");  
                    DS_IO_DETAIL.RowPosition = i;  
                    return false;
                }
                */

                /*
                 // 중복체크
                var dupRow = checkDupKey(DS_IO_DETAIL, "PUMMOK_CD");
                if (dupRow > 0) {
                    showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);  
                    
                    DS_IO_DETAIL.RowPosition = dupRow;
                    GR_DETAIL.SetColumn("PUMMOK_CD");
                    GR_DETAIL.Focus(); 
                    return false;
                }
                */
                 if(intQty <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "의뢰수량");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("REQ_CNT");
                     GR_DETAIL.Focus(); 
 
                     return false;
                 }
                 /* 
                 if(intNewSalePrc <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "매가단가");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("SALE_PRC");
                     GR_DETAIL.Focus();
                     
                     return false;
                 }
                  
                 if(intNewSaleAmt <= 0){
                     showMessage(EXCLAMATION, OK, "USER-1003", "매가금액");
                     DS_IO_DETAIL.RowPosition = i;
                     GR_DETAIL.SetColumn("SALE_AMT");
                     GR_DETAIL.Focus();
                     
                     return false;
                 }
                 */
             }
         }
      }
     
     // 저장버튼 클릭시 Validation Check
     if(Gubun == "Save"){
         
         if(EM_I_PRT_REQ_DT.Text.length == 0){                                    // 의뢰일자
             showMessage(EXCLAMATION, OK, "USER-1002", "의뢰일자");
             EM_I_PRT_REQ_DT.Focus();
//             setObject(true);
             return false;
          } 
         
         if(EM_I_PUMBUN_CD.Text.length == 0){                                 // 브랜드
             showMessage(EXCLAMATION, OK, "USER-1002", "브랜드");
             EM_I_PUMBUN_CD.Focus();
//             setObject(true);
             return false;
         }
         
         // 존재하는 브랜드 코드인지 확인한다.
         if(!savePumbunValCheck()){
             showMessage(EXCLAMATION, OK, "USER-1069", "브랜드");
             EM_I_PUMBUN_CD.Focus();
//             setObject(true);
             return false;
         }
         
         
         if(EM_I_APP_DT.Text.length == 0){                                    // 마진적용일
             showMessage(EXCLAMATION, OK, "USER-1002", "마진적용일");
             EM_I_APP_DT.Focus();
//             setObject(true);
             return false;
          } 

         if(LC_I_EVENT_FLAG.Text == ""){                                      // 행사구분
             showMessage(EXCLAMATION, OK, "USER-1002", "행사구분");
             LC_I_EVENT_FLAG.Focus();
//             setObject(true);   
             return false;
          } 
                                                                                
         if(LC_I_EVENT_RATE.Text == ""){                                     // 행사율
             showMessage(EXCLAMATION, OK, "USER-1002", "행사율");
             LC_I_EVENT_RATE.Focus();
//             setObject(true);   
             return false;
         } 
         
         var intRowCount   = DS_IO_DETAIL.CountRow;
         var strPmkSrtCd   = "";                       // 단축 품목코드
         var strPummokCd   = "";                    // 품목코드
         var intQty        = 0;                        // 의뢰수량       
         var intNewSalePrc = 0;                        // 매가단가  
         var intNewSaleAmt = 0;                        // 매가금액
         
         if(intRowCount > 0){
             for(var i=1; i <= intRowCount; i++){
                 
            	 strPmkSrtCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_SRT_CD");
            	 strPummokCd   = DS_IO_DETAIL.NameValue(i, "PUMMOK_CD");
                 intQty        = DS_IO_DETAIL.NameValue(i, "REQ_CNT");
                 intNewSalePrc = DS_IO_DETAIL.NameValue(i, "SALE_PRC");
                 intNewSaleAmt = DS_IO_DETAIL.NameValue(i, "SALE_AMT");

                 // if(strPummokCd == ""){
                 if (strPmkSrtCd == "") {
                     //showMessage(EXCLAMATION, OK, "USER-1003", "품목코드");
                     //GR_DETAIL.SetColumn("PUMMOK_CD");  
                     //DS_IO_DETAIL.RowPosition = i;  
                     //return false;
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "T";
                     
                 }else{         
                     DS_IO_DETAIL.NameValue(i, "CHECK1") = "F";      
                	/*                 
                    // 존재하는 품목 코드인지 확인한다.
                    if(!getPbnPmkPop(row, colid, '1')){
                        showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                        GR_DETAIL.SetColumn("PUMMOK_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    } 
                    */

                     // 존재하는 품목 코드인지 확인한다.
                     if(!getPbnPmkSrtPop2(i)){
                         showMessage(EXCLAMATION, OK, "USER-1069", "단축코드");
                         GR_DETAIL.SetColumn("PUMMOK_SRT_CD");  
                         DS_IO_DETAIL.RowPosition = i;  
                         return false;
                     }

                    // 존재하는 품목 코드인지 확인한다.
                    if(!getPbnPmkPop2(i)){
                        showMessage(EXCLAMATION, OK, "USER-1069", "품목코드");
                        GR_DETAIL.SetColumn("PUMMOK_CD");  
                        DS_IO_DETAIL.RowPosition = i;  
                        return false;
                    }

                    /*
                     // 중복체크
                    var dupRow = checkDupKey(DS_IO_DETAIL, "PUMMOK_CD");
                    if (dupRow > 0) {
                        showMessage(EXCLAMATION, Ok,  "USER-1044", dupRow);  
                        
                        DS_IO_DETAIL.RowPosition = dupRow;
                        GR_DETAIL.SetColumn("PUMMOK_CD");
                        GR_DETAIL.Focus(); 
                        return false;
                    }
                    */
                     if(intQty <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "의뢰수량");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("REQ_CNT");
                         GR_DETAIL.Focus(); 
     
                         return false;
                     }
                     /* 
                     if(intNewSalePrc <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "매가단가");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("SALE_PRC");
                         GR_DETAIL.Focus();
                         
                         return false;
                     }
                     
                     if(intNewSaleAmt <= 0){
                         showMessage(EXCLAMATION, OK, "USER-1003", "매가금액");
                         DS_IO_DETAIL.RowPosition = i;
                         GR_DETAIL.SetColumn("SALE_AMT");
                         GR_DETAIL.Focus();
                         
                         return false;
                     } */               
                 }  
             }
         }

         sel_DeleteRow( DS_IO_DETAIL, "CHECK1" );

         if(DS_IO_DETAIL.CountRow <= 0){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "상세데이터 등록후 저장하십시오."); 
             GR_DETAIL.Focus();
             return;
         }
      }
     
     if(Gubun == "Delete"){
         if(DS_O_LIST.NameValue(DS_O_LIST.RowPosition,"PROC_FLAG") != "N"){
             showMessage(EXCLAMATION, OK, "GAUCE-1000", "처리되어 삭제할 수 없습니다."); 
             return false;
         }
     }
     return true; 
 }
/**
 * deleMaster()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-03
 * 개    요 : 디테일 내용 삭제시(디테일 내용 없을떄) 마스터 내용 삭제
 * return값 : void
 */
function deleMaster(){

    var strStrCd       = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "STR_CD");
    var strPrtReqDt    = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_DT")
    var strPrtReqSeqNo = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");

    DS_O_LIST.DeleteRow(DS_O_LIST.RowPosition);   
    var goTo       = "saveMaster";    
    var action     = "I";     
    var parameters = "&strFlag=deleMaster" 
                   + "&strStrCd="+encodeURIComponent(strStrCd)
                   + "&strPrtReqDt="+encodeURIComponent(strPrtReqDt)
                   + "&strPrtReqSeqNo="+encodeURIComponent(strPrtReqSeqNo);
    TR_S_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters; 
    TR_S_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER,I:DS_IO_DETAIL=DS_IO_DETAIL)"; 
    TR_S_MAIN.Post(); 
    
    DS_IO_PBNPMK.ClearData();    
    DS_IO_DETAIL.ClearData();   
}
 


 /**
  * searchPumbunPop()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-27
  * 개    요 :  조회조건 브랜드팝업
  * return값 : void
  */
  function searchPumbunPop(){   
      var tmpOrgCd        = LC_S_STR_CD.BindColVal;
      var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
      var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
      var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
      var strVenCd        = "";                                                        // 협력사
      var strBuyerCd      = "";                                                        // 바이어
      var strPumbunType   = "";                                                        // 브랜드유형
      var strUseYn        = "Y";                                                       // 사용여부
      var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
      var strSkuType      = "";                                                        // 단품종류(1:규격단품)
      var strItgOrdFlag   = "";                                                        // 통합발주여부
      var strBizType      = "2";                                                       // 거래형태(1:직매입) 
      var strSaleBuyFlag  = "";                                                        // 판매분매입구분

      var rtnMap = strPbnPop( EM_S_PUMBUN_CD, EM_PUMBUN_NM, 'Y'
                             , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                             , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                             , strBizType,strSaleBuyFlag);
      if(rtnMap !=null){
    	  return;
      }else{
          return;
//    	  EM_S_PUMBUN_CD.Text = "";
//          EM_PUMBUN_NM.Text = "";
      }
    	  

  }

  /**
   * searchPumbunNonPop()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-27
   * 개    요 :  조회조건 브랜드팝업
   * return값 : void
   */
   function searchPumbunNonPop(){   
       var tmpOrgCd        = LC_S_STR_CD.BindColVal;
       var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
       var strStrCd        = LC_S_STR_CD.BindColVal;                                    // 점
       var strOrgCd        = tmpOrgCd + "00000000";                                     // 조직코드
       var strVenCd        = "";                                                        // 협력사
       var strBuyerCd      = "";                                                        // 바이어
       var strPumbunType   = "";                                                        // 브랜드유형
       var strUseYn        = "Y";                                                       // 사용여부
       var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
       var strSkuType      = "";                                                        // 단품종류(1:규격단품)
       var strItgOrdFlag   = "";                                                        // 통합발주여부
       var strBizType      = "2";                                                       // 거래형태(1:직매입) 
       var strSaleBuyFlag  = "";                                                        // 판매분매입구분

  	   var rtnMap =  setStrPbnNmWithoutPop( "DS_O_RESULT", EM_S_PUMBUN_CD, EM_PUMBUN_NM, "Y", "1"
                                 , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                 , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                 , strBizType,strSaleBuyFlag);       
       
       
       if(EM_PUMBUN_NM.Text ==""){
    	   setTimeout("EM_S_PUMBUN_CD.Focus()",50);
       }else{
           GR_MASTER.Focus();
       }
       
       
       if(rtnMap != null){
           EM_S_PUMBUN_CD.Text = rtnMap.get("PUMBUN_CD");
           EM_PUMBUN_NM.Text = rtnMap.get("PUMBUN_NAME");
    	   return true;
       }else{
           return false;
       }       
   }
 
 

 /**
 * getPumbunInfo()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-27
 * 개    요 :  브랜드팝업 관련 데이터 조회 및 세팅
 * param : 
 * return값 : void
 */
 function getPumbunInfo(){
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
     var strOrgCd        = "";                                                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

     var rtnMap = strPbnPop(EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, 'Y'
                            ,strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                            ,strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                            ,strBizType,strSaleBuyFlag);
                                   
        if(rtnMap != null){
            EM_VEN_CD.Text    = rtnMap.get("VEN_CD");    //협력사
            EM_VEN_NM.Text    = rtnMap.get("VEN_NAME");  //협력사명  
        	pumbunValCheck();
        	LC_I_EVENT_FLAG.Enable = true;
        }
 }
 
 


 /**
 * pumbunValCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-22
 * 개    요 :  브랜드  Validation Check
 * return값 : void
 */
 function pumbunValCheck(){
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
     var strOrgCd        = "";                                                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

     var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", "0"
                                       , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                       , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                       , strBizType,strSaleBuyFlag);

     if(DS_O_RESULT.CountRow == 1){
         EM_VEN_CD.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");    //협력사
         EM_VEN_NM.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");  //협력사명  
         LC_I_EVENT_FLAG.Enable = true;
         getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);
         return true;        
     }else
         return false;
 }

 
 /**
 * savePumbunValCheck()
 * 작 성 자 : 박래형
 * 작 성 일 : 2010-03-22
 * 개    요 :  브랜드  Validation Check
 * return값 : void
 */
 function savePumbunValCheck(){
     var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
     var strStrCd        = LC_I_STR_CD.BindColVal;                                  // 점
     var strOrgCd        = "";                                                        // 조직코드
     var strVenCd        = "";                                                        // 협력사
     var strBuyerCd      = "";                                                        // 바이어
     var strPumbunType   = "";                                                        // 브랜드유형
     var strUseYn        = "Y";                                                       // 사용여부
     var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
     var strSkuType      = "";                                                        // 단품종류(1:규격단품)
     var strItgOrdFlag   = "";                                                        // 통합발주여부
     var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
     var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

     var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", "0"
                                       , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                       , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                       , strBizType,strSaleBuyFlag);

     if(DS_O_RESULT.CountRow == 1){
         return true;        
     }else
         return false;
 }

 
 
 /**
  * clearPumbunInfo()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-08
  * 개    요 :  브랜드정보 Clear
  * return값 : void
  */
 function clearPumbunInfo(){
      EM_O_PUMBUN_NM.Text    = "";
      EM_VEN_CD.Text         = "";
      EM_VEN_NM.Text         = "";
      LC_I_EVENT_FLAG.Text   = "";
      LC_I_EVENT_FLAG.Text   = "";
 }
 
 /**
  * setStrPbnNmWithoutPopCall()
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-10
  * 개    요 :  브랜드입력시 부가정보 바로세팅
  * return값 : void
  */
  function setStrPbnNmWithoutPopCall(){
         var strUsrCd        = '<c:out value="${sessionScope.sessionInfo.USER_ID}" />';   // 세션 사원번호
         var strStrCd        = LC_I_STR_CD.BindColVal;                                    // 점
         var strOrgCd        = "";                                                        // 조직코드
         var strVenCd        = "";                                                        // 협력사
         var strBuyerCd      = "";                                                        // 바이어
         var strPumbunType   = "";                                                        // 브랜드유형
         var strUseYn        = "Y";                                                       // 사용여부
         var strSkuFlag      = "2";                                                       // 단품구분(1:단품)
         var strSkuType      = "";                                                        // 단품종류(1:규격단품)
         var strItgOrdFlag   = "";                                                        // 통합발주여부
         var strBizType      = "";                                                        // 거래형태(1:직매입,2:특정)
         var strSaleBuyFlag  = "";                                                        // 판매분매입구분(1:사전매입)

         if(EM_I_PUMBUN_CD.Text != ""){
             var rtnMap = setStrPbnNmWithoutPop( "DS_O_RESULT", EM_I_PUMBUN_CD, EM_O_PUMBUN_NM, "Y", '1'
                                   , strUsrCd,strStrCd,strOrgCd,strVenCd,strBuyerCd
                                   , strPumbunType,strUseYn,strSkuFlag,strSkuType,strItgOrdFlag
                                   , strBizType,strSaleBuyFlag);
             
//             alert(DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD"));
             EM_VEN_CD.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_CD");    //협력사
             EM_VEN_NM.Text    = DS_O_RESULT.NameValue(DS_O_RESULT.RowPosition, "VEN_NAME");  //협력사명
         }
         
  }
 
 
 

  /**
   * getMarjinFlag()
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-02-21
   * 개    요 :  마진적용일에 대한 행사구분 콤보로 조회
   * return값 : void
   */
   function getMarginFlag(strCd, pumbunCd, marginAppDt){
      // 조회조건 셋팅
      var strStrCd        = strCd;            //점
      var strPumbunCd     = pumbunCd;         //브랜드
      var strMarginAppDt  = marginAppDt;      //마진적용일
           
      var goTo       = "getMarginFlag" ;    
      var action     = "O";     
      var parameters =  "&strStrCd="+encodeURIComponent(strStrCd)     
                      + "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                      + "&strMarginAppDt="+encodeURIComponent(strMarginAppDt);    
      TR_S_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters;  
      TR_S_MAIN.KeyValue="SERVLET("+action+":DS_EVENT_FLAG=DS_EVENT_FLAG)"; //조회는 O
      TR_S_MAIN.Post();    
      
      LC_I_EVENT_FLAG.Index = 0;      
   }   
   
   /**
    * getMarjinRate()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-02-21
    * 개    요 :  마진적용일에 대한 행사구분의행사율을 콤보로 조회
    * return값 : void
    */
    function getMarginRate(strCd, pumbunCd, mgAppDt, evnFlag){
       // 조회조건 셋팅
       var strStrCd        = strCd;       //점
       var strPumbunCd     = pumbunCd;    //브랜드
       var strMarginAppDt  = mgAppDt;     //마진적용일
       var strMarginGbn    = evnFlag;     //행사구분
       
//       alert(EM_I_PUMBUN_CD.Text);
       
       var goTo       = "getMarginRate" ;    
       var action     = "O";     
       var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                      + "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                      + "&strMarginAppDt="+encodeURIComponent(strMarginAppDt)
                      + "&strMarginGbn="+encodeURIComponent(strMarginGbn);     
       TR_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_EVENT_RATE=DS_EVENT_RATE)"; //조회는 O
       TR_MAIN.Post(); 

//       LC_I_EVENT_RATE.BindColVal = objCd;
       LC_I_EVENT_RATE.Index = 0;

    }
   

    /**
    * setTempEvnDataset()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-17
    * 개    요    : 행사구분, 행사율에 적용할 데이터셋을 임시로 지정
    * return값 : void
    */
    function setTempEvnDataset(){
        for(var i = 0; i < 100; i++){
            DS_SETEVNFLAG.Addrow();
            if(i < 10){
                DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = '0' + i;
                DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = '0' + i;
            }else{
                DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG") = i;    
                DS_SETEVNFLAG.NameValue(i+1,"EVENT_FLAG_NM") = i;       
            }
        }   
    }
   
    /**
    * setEventFlagDs()
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-17
    * 개    요    : 행사구분 데이터셋 복사
    * return값 : void
    */
    
    function setEventFlagDs(){

        DS_EVENT_FLAG.ClearData();         //복사될 데이터셋 초기화  
        DS_EVENT_RATE.ClearData();         //복사될 데이터셋 초기화  
        var setEvnFlag = DS_SETEVNFLAG.ExportData(1,DS_SETEVNFLAG.CountRow, true ); 
        DS_EVENT_FLAG.ImportData(setEvnFlag);
        DS_EVENT_RATE.ImportData(setEvnFlag);      
    }  
   
    
 /**
  * getPbnPmkPop(row, colid, popFlag)
  * 작 성 자 : 박래형
  * 작 성 일 : 2010-03-08
  * 개    요 :  브랜드에 따른 품목
  * return값 : void
  */
  function getPbnPmkPop(row, colid, popFlag){
      
    var strPummokCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_CD"); //품목코드
    var strPumbunCd  = EM_I_PUMBUN_CD.Text;
/*    
    if(strPummokCd != ""){
        var rtnMap = setPbnPmkNmWithoutToGridPop( "DS_O_RESULT", strPummokCd, "", strPumbunCd, 
                                                  popFlag, "");
        if(rtnMap != null){         

            DS_IO_DETAIL.NameValue(row, "STR_CD")           = LC_I_STR_CD.BindColVal;
            DS_IO_DETAIL.NameValue(row, "PRT_REQ_DT")       = EM_I_PRT_REQ_DT.Text;
            DS_IO_DETAIL.NameValue(row, "PRT_REQ_SEQ_NO")   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");
            
            DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
            DS_IO_DETAIL.NameValue(row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");  
            DS_IO_DETAIL.NameValue(row, "RECP_NAME")        = rtnMap.get("RECP_NAME");  

            DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")        = EM_I_PUMBUN_CD.Text;
            DS_IO_DETAIL.NameValue(row, "PUMBUN_NM")        = EM_O_PUMBUN_NM.Text;

            DS_IO_DETAIL.NameValue(row, "VEN_CD")           = EM_VEN_CD.Text;
            DS_IO_DETAIL.NameValue(row, "VEN_NM")           = EM_VEN_NM.Text;

            DS_IO_DETAIL.NameValue(row, "TAG_PRT_YN")       = "N";
            
        }
    }else{
*/    	
    	
        var rtnList = pbnPmkMultiSelPop(strPummokCd,"",strPumbunCd,"", "", "N");
        
        if(rtnList != null){
            for(var i = 0; i < rtnList.length; i++){
                if(i != 0 ){
                    DS_IO_DETAIL.AddRow();  
                    DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_YN")       = "N";  
                }                                 
                
                DS_IO_DETAIL.NameValue(row+i, "STR_CD")           = LC_I_STR_CD.BindColVal;
                DS_IO_DETAIL.NameValue(row+i, "PRT_REQ_DT")       = EM_I_PRT_REQ_DT.Text;

                DS_IO_DETAIL.NameValue(row+i, "PRT_REQ_SEQ_NO")   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");

                DS_IO_DETAIL.NameValue(row+i, "PUMMOK_SRT_CD")    = rtnList[i].PUMMOK_SRT_CD;
                DS_IO_DETAIL.NameValue(row+i, "PUMMOK_CD")        = rtnList[i].PUMMOK_CD;
                DS_IO_DETAIL.NameValue(row+i, "PUMMOK_NM")        = rtnList[i].PUMMOK_NAME;
                DS_IO_DETAIL.NameValue(row+i, "RECP_NAME")        = rtnList[i].RECP_NAME;  
                
                DS_IO_DETAIL.NameValue(row+i, "PUMBUN_CD")        = EM_I_PUMBUN_CD.Text;
                DS_IO_DETAIL.NameValue(row+i, "PUMBUN_NM")        = EM_O_PUMBUN_NM.Text;
                
                DS_IO_DETAIL.NameValue(row+i, "VEN_CD")           = EM_VEN_CD.Text;
                DS_IO_DETAIL.NameValue(row+i, "VEN_NM")           = EM_VEN_NM.Text; 

                DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_YN")       = "N";
            }
            if(rtnList.length > 1){
                setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"REQ_CNT");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동             
            }
        }      
//    }
        
    // 품목코드 존재여부 확인을 위해
    if(rtnList != null) return true;
    else return false;
  }  
  
  /**
   * getPbnPmkPop2(row, colid)
   * 작 성 자 : 박래형
   * 작 성 일 : 2010-03-08
   * 개    요 :  브랜드에 따른 품목체킹
   * return값 : void
   */
   function getPbnPmkPop2(row){
       
     var strPummokCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_CD"); //품목코드
     var strPumbunCd  = EM_I_PUMBUN_CD.Text;

     var rtnMap = setPbnPmkNmWithoutToGridPop( "DS_O_RESULT", strPummokCd, "", strPumbunCd, '0', "");   
     
     if(rtnMap != null){
    	 DS_IO_DETAIL.NameValue(row, "STR_CD")           = LC_I_STR_CD.BindColVal;
	     DS_IO_DETAIL.NameValue(row, "PRT_REQ_DT")       = EM_I_PRT_REQ_DT.Text;
	     DS_IO_DETAIL.NameValue(row, "PRT_REQ_SEQ_NO")   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");
	     
	     DS_IO_DETAIL.NameValue(row, "PUMMOK_SRT_CD")    = rtnMap.get("PUMMOK_SRT_CD");
	     DS_IO_DETAIL.NameValue(row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
	     DS_IO_DETAIL.NameValue(row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
	     DS_IO_DETAIL.NameValue(row, "RECP_NAME")        = rtnMap.get("RECP_NAME");  	
//	     DS_IO_DETAIL.NameValue(row, "PUMBUN_CD")        = EM_I_PUMBUN_CD.Text;
//	     DS_IO_DETAIL.NameValue(row, "PUMBUN_NM")        = EM_O_PUMBUN_NM.Text;	
//	     DS_IO_DETAIL.NameValue(row, "VEN_CD")           = EM_VEN_CD.Text;
//	     DS_IO_DETAIL.NameValue(row, "VEN_NM")           = EM_VEN_NM.Text;	
	     DS_IO_DETAIL.NameValue(row, "TAG_PRT_YN")       = "N";
     }
     
     if(rtnMap != null){
         return true;    
     }else 
    	 return false;         

   }  

   /**
    * getPmkSrtInfo()
    * 작 성 자 : DHL
    * 작 성 일 : 2012-05-11
    * 개    요 :  브랜드별 품목 단축코드  정합성 체크
    * return값 : void
    */
/*     
   function getPmkSrtInfo(){
        
//      alert("브랜드에 따른 품목 제대로 체크하나");
       // 조회조건 셋팅
       var strPumbunCd     = EM_I_PB_CD.Text;          //브랜드
       var strPmkSrtCd     = DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition, "PUMMOK_SRT_CD");    //단축코드
     
       var goTo       = "getPmkSrtInfo" ;    
       var action     = "O";     
       var parameters = "&strPumbunCd="+encodeURIComponent(strPumbunCd)     
                      + "&strPmkSrtCd="+encodeURIComponent(strPmkSrtCd);   
       TR_S_MAIN.Action="/dps/pord301.po?goTo="+goTo+parameters;  
       TR_S_MAIN.KeyValue="SERVLET("+action+":DS_PUMMOK_SRT_INFO=DS_PUMMOK_SRT_INFO)"; //조회는 O
       TR_S_MAIN.Post(); 
       
       if(DS_PUMMOK_SRT_INFO.CountRow <= 0){
//     	  alert("뭐가이상한거지");
           return false;        
       }else{
           return true;
       }
    } 
 */   
 
   /**
    * getPbnPmkSrtPop(row, colid, popFlag)
    * 작 성 자 : 박래형
    * 작 성 일 : 2010-03-08
    * 개    요 :  브랜드에 따른  단축코드
    * return값 : void
    */
    function getPbnPmkSrtPop(row, colid, popFlag){
        
      var strPmkSrtCd  = DS_IO_DETAIL.NameValue(row,"PUMMOK_SRT_CD"); //단축코드
      var strPumbunCd  = EM_I_PUMBUN_CD.Text;
      //var rtnList = pbnPmkMultiSelPop(strPummokCd,"",strPumbunCd,"", "", "N");
      var rtnList = pbnPmkMultiSelLevelPop(strPmkSrtCd,"",strPumbunCd,"", "", "N");
          
          if(rtnList != null){
              for(var i = 0; i < rtnList.length; i++){
                  if(i != 0 ){
                      DS_IO_DETAIL.AddRow();  
                      DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_YN")       = "N";  
                  }                                 
                  
                  DS_IO_DETAIL.NameValue(row+i, "STR_CD")           = LC_I_STR_CD.BindColVal;
                  DS_IO_DETAIL.NameValue(row+i, "PRT_REQ_DT")       = EM_I_PRT_REQ_DT.Text;

                  DS_IO_DETAIL.NameValue(row+i, "PRT_REQ_SEQ_NO")   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");

                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_SRT_CD")    = rtnList[i].PUMMOK_SRT_CD;
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_CD")        = rtnList[i].PUMMOK_CD;
                  DS_IO_DETAIL.NameValue(row+i, "PUMMOK_NM")        = rtnList[i].PUMMOK_NAME;
                  DS_IO_DETAIL.NameValue(row+i, "RECP_NAME")        = rtnList[i].RECP_NAME;  
                  
                  DS_IO_DETAIL.NameValue(row+i, "PUMBUN_CD")        = EM_I_PUMBUN_CD.Text;
                  DS_IO_DETAIL.NameValue(row+i, "PUMBUN_NM")        = EM_O_PUMBUN_NM.Text;
                  
                  DS_IO_DETAIL.NameValue(row+i, "VEN_CD")           = EM_VEN_CD.Text;
                  DS_IO_DETAIL.NameValue(row+i, "VEN_NM")           = EM_VEN_NM.Text; 

                  DS_IO_DETAIL.NameValue(row+i, "TAG_PRT_YN")       = "N";
                  
              }
              if(rtnList.length > 1){
                  setFocusGrid(GR_DETAIL, DS_IO_DETAIL,row,"REQ_CNT");      //멀티 품목 선택시 입력 첫번재 행의 수량으로 포커스 이동             
              }
          }      
//      }
          
      // 품목코드 존재여부 확인을 위해
      if(rtnList != null) return true;
      else return false;
    }  
   
   /**
    * getPbnPmkSrtPop2(Row)
    * 작 성 자 : DHL
    * 작 성 일 : 2012-05-11
    * 개    요 :  브랜드에 따른 단축코드
    * return값 : void
    */
    function getPbnPmkSrtPop2(Row){
        
 	 //alert( "여기를 왜 들어오나 Row  =  " + Row);
      var strPmkSrtCd  = DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD"); //단축코드
      var strPummokCNm = DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM"); //품목명
      var strPumbunCd  = EM_I_PUMBUN_CD.Text;     

      var rtnMap = setPbnPmkSrtNmWithoutToGridPop( "DS_O_RESULT", strPmkSrtCd, strPummokCNm, strPumbunCd, 
                                                "1", "");
      if(rtnMap != null){         
          DS_IO_DETAIL.NameValue(Row, "STR_CD")           = LC_I_STR_CD.BindColVal;
	      DS_IO_DETAIL.NameValue(Row, "PRT_REQ_DT")       = EM_I_PRT_REQ_DT.Text;
	      DS_IO_DETAIL.NameValue(Row, "PRT_REQ_SEQ_NO")   = DS_O_LIST.NameValue(DS_O_LIST.RowPosition, "PRT_REQ_SEQ_NO");

	      DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD")    = rtnMap.get("PUMMOK_SRT_CD");
          DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD")        = rtnMap.get("PUMMOK_CD");
          DS_IO_DETAIL.NameValue(Row, "PUMMOK_NM")        = rtnMap.get("PUMMOK_NAME");
  	      DS_IO_DETAIL.NameValue(Row, "RECP_NAME")        = rtnMap.get("RECP_NAME");  	
// 	     DS_IO_DETAIL.NameValue(Row, "PUMBUN_CD")        = EM_I_PUMBUN_CD.Text;
// 	     DS_IO_DETAIL.NameValue(Row, "PUMBUN_NM")        = EM_O_PUMBUN_NM.Text;	
// 	     DS_IO_DETAIL.NameValue(Row, "VEN_CD")           = EM_VEN_CD.Text;
// 	     DS_IO_DETAIL.NameValue(Row, "VEN_NM")           = EM_VEN_NM.Text;	
          DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")       = "N";
          
      }else{
          GR_MASTER.SetColumn("PUMMOK_SRT_CD"); 
          GR_DETAIL.Focus();
      }

      if(rtnMap != null) return true;
      else return false;
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
    for(i=0;i<TR_L_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_L_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_MAIN event=onSuccess>
    for(i=0;i<TR_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<script language=JavaScript for=TR_S_MAIN event=onSuccess> 
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(EXCLAMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_L_MAIN event=onFail>
    trFailed(TR_L_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>

<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->

<!--  ===================DS_MASTER============================ -->           
<script language=JavaScript for=DS_O_LIST event=CanRowPosChange(row)>
//CanRowPosChange 구분위한

    if (DS_IO_DETAIL.IsUpdated || DS_IO_MASTER.IsUpdated){
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_O_LIST.NameValue(row, "PRT_REQ_SEQ_NO") == "")
                DS_O_LIST.DeleteRow(row);
            
            return true;
        }
    }else{
        return true;
    } 
/*
    if(saveFlag) return true;
    
    if(DS_O_LIST.IsUpdated){       //마스터 변경시
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            if(DS_O_LIST.NameValue(row, "PRT_REQ_SEQ_NO") == "")
                DS_O_LIST.DeleteRow(row);
            return true;
        }       
    }else if(DS_IO_DETAIL.IsUpdated){      //디테일 변경시
        if( showMessage(QUESTION, YESNO, "USER-1074") != 1 ){
            return false;
        }else {
            return true;
        }
    }else{
        return true;
    }
*/   
</script>

<script language=JavaScript for=DS_O_LIST event=onRowPosChanged(row)>
if(clickSORT)
    return;
    
    var strPrtReqSeqNo = DS_O_LIST.NameValue(row, "PRT_REQ_SEQ_NO");
    
    if(row != 0){
        if( bfListRowPosition == row)
            return;
        bfListRowPosition = row;
        
    	if(strPrtReqSeqNo != ""){
            setTimeout("setObject(false)", 50);  
            getMaster();
            getDetail(); 
    	}
    	if(strPrtReqSeqNo !=""){
            if(inta == 0){  
                inta++;
            }else{
                setPorcCount("SELECT", DS_IO_DETAIL.CountRow);      
            }    		
    	}
    }
    
</script>

<!-- 단품 디테일 입력시 중복 체크 -->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
    
//    alert("colid = " + colid);
    switch (colid) {
    case "PUMBUN_CD":  
//        LC_I_EVENT_RATE.Enable = false; 
//        LC_I_EVENT_FLAG.Text = "";
//        LC_I_EVENT_RATE.Text = "";
/*        
        if(EM_I_PUMBUN_CD.Text.length == 6 && EM_O_PUMBUN_NM.Text != ""){
            getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);
        }
*/        
    	/*      
    	        if(EM_I_PUMBUN_CD.Text.length != 6){
    	            LC_I_EVENT_FLAG.Text = "";
    	            LC_I_EVENT_RATE.Text = "";
    	            LC_I_EVENT_FLAG.Enable = false
    	            LC_I_EVENT_RATE.Enable = false
    	            clearPumbunInfo();
    	            return
    	        }        
    	        getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);
    	*/        
//    	        else if(EM_I_PUMBUN_CD.Text.length == 6){
//    	            if(pumbunValCheck()){             
//    	               getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);     //행사율  
//    	               return
//    	            }else{
//    	              getPumbunInfo();
//    	            }
//    	        }

//    	        DS_IO_DETAIL.ClearData(); 
        
        break;
/*        
    case "PRT_REQ_DT":   
    	if(EM_I_PRT_REQ_DT.Text.length == 8){
            if(EM_I_PRT_REQ_DT.Text < strToday){
                showMessage(EXCLAMATION, OK, "USER-1030", "의뢰일자");
                EM_I_PRT_REQ_DT.Text = strToday;
                EM_I_PRT_REQ_DT.Focus();
                return false;           
            }else checkDateTypeYMD( EM_I_PRT_REQ_DT );    		
    	}
        break;
    case "MG_APP_DT":    
    	if(EM_I_APP_DT.Text.length == 8){
            if(EM_I_APP_DT.Text < strToday){
                showMessage(EXCLAMATION, OK, "USER-1030", "마진적용일");
                EM_I_APP_DT.Text = strToday;
                EM_I_APP_DT.Focus();
                return false;           
            }else checkDateTypeYMD( EM_I_APP_DT );             		
    	}
        getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);     //행사구분
        LC_I_EVENT_RATE.Text = "";
        LC_I_EVENT_RATE.Enable = true;
        LC_I_EVENT_RATE.Index = 0;
//        getMarginRate(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text, LC_I_EVENT_FLAG.BindColVal);     //행사율    
        break;
*/
/*        
    case "EVENT_FLAG": 
//    	LC_I_EVENT_RATE.Enable = true;
//    	getMarginRate(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text, LC_I_EVENT_FLAG.BindColVal);     //행사율  
    	

        getMarginRate(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text, LC_I_EVENT_FLAG.BindColVal);         
        if(LC_I_EVENT_FLAG.Text.length == 0){
        	LC_I_EVENT_RATE.Enable = false;
        }else{
            LC_I_EVENT_RATE.Enable = true;
        }
       
        break;
*/        
    }
</script>

<script language=JavaScript for=DS_IO_DETAIL event=onRowPosChanged(row)>

if(clickSORT)
    return;
</script>

<!-- 단품 디테일 입력시 중복 체크 -->
<script language=JavaScript for=DS_IO_DETAIL event=OnColumnChanged(row,colid)>

    var strReqCnt  = parseInt(DS_IO_DETAIL.NameValue(row, "REQ_CNT"));    //의뢰수량(Grid)
    var strSalePrc = parseInt(DS_IO_DETAIL.NameValue(row, "SALE_PRC"));   //매가단가(Grid)
    var strSaleAmt = 0;
    
    strSaleAmt = strReqCnt*strSalePrc;
    DS_IO_DETAIL.NameValue(row, "SALE_AMT") = strSaleAmt;                 //매가금액
    
    var orgValue = DS_IO_DETAIL.OrgNameValue(row, "PUMMOK_SRT_CD");
    var newValue = DS_IO_DETAIL.NameValue(row, "PUMMOK_SRT_CD");
    var orgVaPmk = DS_IO_DETAIL.OrgNameValue(row, "PUMMOK_CD");
    var newVaPmk = DS_IO_DETAIL.NameValue(row, "PUMMOK_CD");
    
    switch (colid) {
    case "PUMMOK_SRT_CD":
        if(orgValue.length > 0)
            if(orgValue != newValue){
                DS_IO_DETAIL.OrgNameValue(row, "PUMMOK_SRT_CD") = newValue;
                blnSkuChanged = true;
            }
        break;
        
    case "PUMMOK_CD":
        if(orgVaPmk.length > 0)
            if(orgVaPmk != newVaPmk){
                DS_IO_DETAIL.OrgNameValue(row, "PUMMOK_CD") = newVaPmk;
                blnSkuChanged = true;
            }
        break;
    }


</script>


<!-- GR_DETAIL CanColumnPosChange(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=CanColumnPosChange(Row,Colid)>

    switch (Colid) {
    case "PUMMOK_SRT_CD":
        if(DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD") == "")
            return;
        
        var blnSkuChk = getPbnPmkSrtPop2(Row);
        if(blnSkuChk) {
//          getSkuPop(Row,Colid);
            return true;
        }else if (!blnSkuChk && DS_IO_DETAIL.NameValue(Row,"PUMMOK_SRT_CD") == ""){
        	setTimeout("showMessage(EXCLAMATION, OK, 'USER-1003', '단축')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }else {
            //if(this.NameValue(row,"PUMMOK_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단축')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }         
        
        if (blnSkuChanged) {
            //if(this.NameValue(row,"PUMMOK_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 단축')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_SRT_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }else{
            return true;
        }       
        
    case "PUMMOK_CD":
        if(DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") == "")
            return;
        
        var blnSkuChk = getPbnPmkPop2(Row);
        if(blnSkuChk) {
//          getSkuPop(Row,Colid);
            return true;
        }else if (!blnSkuChk && DS_IO_DETAIL.NameValue(Row,"PUMMOK_CD") == ""){
        	setTimeout("showMessage(EXCLAMATION, OK, 'USER-1003', '품목')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "CHECK1") = 'T';
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }else {
            //if(this.NameValue(row,"PUMMOK_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 품목')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }         
        
        if (blnSkuChanged) {
            //if(this.NameValue(row,"PUMMOK_CD") != "")
            setTimeout("showMessage(EXCLAMATION, OK, 'USER-1065', '정확한 품목')", 50);
            DS_IO_DETAIL.DeleteRow(Row);
            DS_IO_DETAIL.InsertRow(Row);
            DS_IO_DETAIL.NameValue(Row, "PUMMOK_CD") = "";
            DS_IO_DETAIL.NameValue(Row, "TAG_PRT_YN")   = "N";
            GR_DETAIL.Focus();
            return false;
        }else{
            return true;
        }   

    }
   
</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>

sortColId( eval(this.DataID), row , colid);
/*
    if( row < 1){
        if( DS_O_LIST.IsUpdated || DS_IO_DETAIL.IsUpdated){
            showMessage(INFORMATION, OK, "USER-1000","변경된 상세내역이 존재하여 정렬 할 수 없습니다.");
            return;
        }
        sortColId( eval(this.DataID), row , colid );
    }   
*/
</script>

<script language=JavaScript for=GR_DETAIL event=OnClick(row,colid)>

sortColId( eval(this.DataID), row , colid);

</script>


<!-- GR_DETAIL OnColumnPosChanged(Row,Colid) event 처리 -->
<script language="javascript"  for=GR_DETAIL event=OnColumnPosChanged(Row,Colid)>

    switch (Colid) {
    case "REQ_CNT":
    	if(blnSkuChanged)
    		//getPbnPmkPop(Row, Colid, '0')
    		getPbnPmkSrtPop(Row, Colid, '0')
        break;
    }

</script>


<!-- 품목 그리드 헤더 선택시 전체 선택/해제 -->
<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_DETAIL event=OnHeadCheckClick(Col,Colid,bCheck)>	
	
	//헤더 전체 체크/체크해제 컨트롤
	if (bCheck == '1'){ // 전체체크
	    for(var i=1; i<=DS_IO_DETAIL.CountRow; i++){
	        if(DS_IO_DETAIL.NameValue(i,"TAG_PRT_YN") == "Y"){              
	        }else{
	            DS_IO_DETAIL.NameValue(i, "CHECK1") = 'T';
	        }
	    }
	}else{  // 전체체크해제
	    for (var i=1; i<=DS_IO_DETAIL.CountRow; i++){
	        DS_IO_DETAIL.NameValue(i, "CHECK1") = 'F';
	    }
	}
</script>

<!-- GD_DETAIL OnPopup event 처리 -->
<script language=JavaScript for=GR_DETAIL event=OnPopup(row,colid,data)>
    //getPbnPmkPop(row, colid, '1');
	if(colid == "PUMMOK_SRT_CD"){
		getPbnPmkSrtPop(row, colid, '1');
	}else if (colid == "PUMMOK_CD") {
		getPbnPmkPop(row, colid, '1');
	}
</script>





<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!--*************************************************************************-->

<!-- 
 <script language=JavaScript for=EM_S_PUMBUN_CD event=OnKeyUp(kcode,scode)>
	 if(EM_PUMBUN_NM.Text != ""){
	     EM_PUMBUN_NM.Text  = "";
	 }
</script>

 -->

<!-- 조회부 브랜드 KillFocus -->
<script language=JavaScript for=EM_S_PUMBUN_CD event=onKillFocus()>	   
	if(EM_S_PUMBUN_CD.Text != ""){
	    searchPumbunNonPop();
	}else
	EM_PUMBUN_NM.Text = "";  
</script>

<!-- 브랜드 KillFocus -->
<script language=JavaScript for=EM_I_PUMBUN_CD event=onKillFocus()>
	if(EM_I_PUMBUN_CD.Text.length == 6){
	    if(pumbunValCheck()){ 
//	    	alert("들어오나");
//	        getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);
	        return;
	    }else{
            LC_I_EVENT_FLAG.Text = "";
            LC_I_EVENT_RATE.Text = "";
            LC_I_EVENT_FLAG.Enable = false
            LC_I_EVENT_RATE.Enable = false
            clearPumbunInfo();
	        getPumbunInfo();
	    }
	}else if(EM_I_PUMBUN_CD.Text.length == 0){
        LC_I_EVENT_FLAG.Text = "";
        LC_I_EVENT_RATE.Text = "";
        LC_I_EVENT_FLAG.Enable = false
        LC_I_EVENT_RATE.Enable = false
        clearPumbunInfo();
	    return;
	}else{
        LC_I_EVENT_FLAG.Text = "";
        LC_I_EVENT_RATE.Text = "";
        LC_I_EVENT_FLAG.Enable = false
        LC_I_EVENT_RATE.Enable = false
        clearPumbunInfo();
	    getPumbunInfo();
	}

</script>

<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR_CD event=OnSelChange()>
	EM_S_PUMBUN_CD.Text = "";
	EM_PUMBUN_NM.Text   = "";
</script>

<!-- 점(입력)  변경시  -->
<script language=JavaScript for=LC_I_STR_CD event=OnSelChange()>
	EM_I_PUMBUN_CD.Text  = "";
	EM_O_PUMBUN_NM.Text  = "";
    LC_I_EVENT_FLAG.Text = "";
    LC_I_EVENT_RATE.Text = "";
    LC_I_TAG_FLAG.Index  = 0;
    LC_I_EVENT_FLAG.Enable = false
    LC_I_EVENT_RATE.Enable = false
//    clearPumbunInfo();
</script>

<!-- 마진적용일 KillFocus -->
<script language=JavaScript for=EM_I_APP_DT event=onKillFocus()>

    checkDateTypeYMD( EM_I_APP_DT ); 
    
    if(EM_I_APP_DT.Text < strToday){
        showMessage(EXCLAMATION, OK, "USER-1030", "마진적용일");
        EM_I_APP_DT.Text = strToday;
        EM_I_APP_DT.Focus();
        return false;           
    }                  

    getMarginFlag(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text);     //행사구분
    LC_I_EVENT_RATE.Text = "";
    LC_I_EVENT_RATE.Enable = true;
    LC_I_EVENT_RATE.Index = 0; 
</script>

<!-- 의뢰일자 KillFocus -->
<script language=JavaScript for=EM_I_PRT_REQ_DT event=onKillFocus()>  

    checkDateTypeYMD( EM_I_PRT_REQ_DT );
//    alert("2");
    if(EM_I_PRT_REQ_DT.Text < strToday){
//    	alert("3");
        showMessage(EXCLAMATION, OK, "USER-1030", "의뢰일자");
        EM_I_PRT_REQ_DT.Text = strToday;
        EM_I_PRT_REQ_DT.Focus();
        return false;           
    } 
</script>

<!-- 행사구분 변경시  -->
<script language=JavaScript for=LC_I_EVENT_FLAG event=OnSelChange()>
	getMarginRate(LC_I_STR_CD.BindColVal, EM_I_PUMBUN_CD.Text, EM_I_APP_DT.Text, LC_I_EVENT_FLAG.BindColVal);	
	LC_I_EVENT_RATE.Enable = true;
</script>

<!-- 조회부 의뢰일자 변경시  -->
<script lanaguage=JavaScript for=EM_S_PRT_REQ_DT event=OnKillFocus()>
    checkDateTypeYMD( EM_S_PRT_REQ_DT );
</script>

<!-- 조회부 의뢰일자2 변경시  -->
<script lanaguage=JavaScript for=EM_S_PRT_REQ_DT2 event=OnKillFocus()>
    checkDateTypeYMD( EM_S_PRT_REQ_DT2 );
</script>


<!--* C. 가우스 이벤트 처리 끝                                               *-->
<!--*************************************************************************-->

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의                                   *-->
<!--*    1. DataSet
<!--*    2. Transaction
<!--*************************************************************************-->

<!--------------------- 1. DataSet  ------------------------------------------->

<!-- 서브 시스템 값 가져오기  -->
<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- =============== Input용 -->
<!-- 검색용 -->
<comment id="_NSID_"><object id="DS_STR"            classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_TAG_FLAG"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_SKU_SALEPRC"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_IO_DETAIL"      classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_EVENT_FLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETEVNFLAG"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_EVENT_RATE"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_SETEVNRATE"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_PUMMOK_INFO"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<!--------------------- 2. Transaction  --------------------------------------->
<comment id="_NSID_">
<object id="TR_L_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="TR_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_">
    <object id="TR_S_MAIN" classid=<%=Util.CLSID_TRANSACTION%>>
        <param name="KeyName" value="Toinb_dataid4">
    </object>
</comment><script>_ws_(_NSID_);</script>

<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GR_MASTER");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top+150) {
    	grd_height = top;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
    
	var obj   = document.getElementById("GR_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)) <= top2) {
    	grd_height = top2;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top2);
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
<DIV id="testdiv" class="testdiv">

<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td class="PT01 PB03"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="o_table">
      <tr>
        <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
          <tr>
            <th width="80" class="point">점</th>
            <td width="140">
              <comment id="_NSID_">
                <object id=LC_S_STR_CD classid=<%= Util.CLSID_LUXECOMBO %> width=140 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
            <th width="80" class="point">의뢰일자</th>
            <td width="220">
              <comment id="_NSID_">
                <object id=EM_S_PRT_REQ_DT classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_PRT_REQ_DT)" align="absmiddle" />
              ~<comment id="_NSID_">
                <object id=EM_S_PRT_REQ_DT2 classid=<%= Util.CLSID_EMEDIT %> width=70 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('G',EM_S_PRT_REQ_DT2)" align="absmiddle" />
            </td>
            <th width="80">의뢰번호</th>
            <td >
              <comment id="_NSID_">
                <object id=EM_S_PRT_REQ_SEQ_NO classid=<%= Util.CLSID_EMEDIT %> width=150 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
          <tr>
            <th>브랜드</th>
            <td colspan="5">
              <comment id="_NSID_">
                <object id=EM_S_PUMBUN_CD classid=<%= Util.CLSID_EMEDIT %> width=116 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/detail_search_s.gif"  class="PR03" onclick="javascript:searchPumbunPop()"  align="absmiddle" /><comment id="_NSID_">
                &nbsp;<object id=EM_PUMBUN_NM classid=<%= Util.CLSID_EMEDIT %> width=200 tabindex=1 align="absmiddle">
                </object>
              </comment><script>_ws_(_NSID_);</script>
            </td>
          </tr>
        </table></td>
        </tr>
    </table></td>
  </tr>
  <tr>
    <td class="dot"  ></td>
  </tr> 
  <tr valign="top">
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr valign="top">
        <td width="250">
          <table  width="100%" border="0" cellspacing="0" cellpadding="0" class="BD4A" >
            <tr>
              <td>
                <comment id="_NSID_"><OBJECT id=GR_MASTER  width=290 height=780 classid=<%=Util.CLSID_GRID%>>
                  <param name="DataID" value="DS_O_LIST">
                </OBJECT></comment><script>_ws_(_NSID_);</script>
              </td>
            </tr>
          </table>
        </td>
        <td class="PL10" >
                <table width="100%" border="0" cellspacing="0" cellpadding="0" >
                <tr>
                <td class="PT01 PB03">
                  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                    <tr>
                      <th width="100" class="point">점</th>
                        <td width="140">
                          <comment id="_NSID_">
                            <object id=LC_I_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                        <th class="point" width="140">택구분</th>
                        <td >
                          <comment id="_NSID_">
                            <object id=LC_I_TAG_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                      <th width="100" class="point">의뢰일자</th>
                        <td width="140">
                          <comment id="_NSID_">
                            <object id=EM_I_PRT_REQ_DT classid=<%=Util.CLSID_EMEDIT%> width=115  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_PRT_REQ_DT onclick="javascript:openCal('G',EM_I_PRT_REQ_DT)" align="absmiddle" />
                        </td>
                        <th width="100">의뢰번호</th>
                        <td >
                          <comment id="_NSID_">
                            <object id=EM_O_PRT_REQ_SEQ_NO classid=<%=Util.CLSID_EMEDIT%> width=140  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                    </tr>
                    <tr>
                      <th class="point">브랜드</th>
                        <td colspan="3">
                          <comment id="_NSID_">
                            <object id=EM_I_PUMBUN_CD classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script><img src="/<%=dir%>/imgs/btn/detail_search_s.gif" id=IMG_PUMBUN_CD class="PR03" onclick="javascript:getPumbunInfo()"  align="absmiddle" />
                          &nbsp;<comment id="_NSID_">
                            <object id=EM_O_PUMBUN_NM classid=<%=Util.CLSID_EMEDIT%> width=259 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>                          
                        </td>
                    </tr>
                      
                    <tr>
                      <th>협력사</th>
                        <td colspan="3">
                          <comment id="_NSID_">
                            <object id=EM_VEN_CD classid=<%=Util.CLSID_EMEDIT%> width=115 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          &nbsp;&nbsp;<comment id="_NSID_">
                            <object id=EM_VEN_NM classid=<%=Util.CLSID_EMEDIT%> width=278 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>                        
                        </td> 
                    </tr>
                      
                    <tr>
                      <th class="point">마진적용일</th>
                        <td>
                          <comment id="_NSID_">
                            <object id=EM_I_APP_DT classid=<%=Util.CLSID_EMEDIT%> width=115  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script></script><img src="/<%=dir%>/imgs/btn/date.gif" id=IMG_APP_DT onclick="javascript:openCal('G',EM_I_APP_DT)" align="absmiddle" />
                        </td>
                      <th class="point">행사구분/행사율</th>
                        <td>
                          <comment id="_NSID_">
                            <object id=LC_I_EVENT_FLAG classid=<%=Util.CLSID_LUXECOMBO%> width=70  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                          <comment id="_NSID_">
                            <object id=LC_I_EVENT_RATE classid=<%=Util.CLSID_LUXECOMBO%> width=70  tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>
                        </td>
                    </tr> 
                    <tr>
                      <th class="point">생산년도</th> 
                        <td colspan="3">
                          <comment id="_NSID_">
                            <object id=EM_I_YYYY classid=<%=Util.CLSID_EMEDIT%> width=50 tabindex=1 align="absmiddle">
                            </object>
                          </comment>
                          <script> _ws_(_NSID_);</script>  
                          <b>↗ 위 행사구분/행사율이 선택되지 않을시 마진적용일을 확인하세요.</b>
                          
                        </td>
                        	<b>↗ 위 행사구분/행사율이 선택되지 않을시 마진적용일을 확인하세요.</b>
                        
                      </tr>
                  </table></td>
                  </tr>                
                  
                  <tr>
                    <td class="dot"  ></td>
                  </tr>
                  <tr>
                     <td class="right"><img src="/<%=dir%>/imgs/btn/add_row.gif" id="IMG_SKU_ADD"  width="52" height="18" hspace="2" onclick="javascript:addDetailRow();" /><img src="/<%=dir%>/imgs/btn/del_row.gif" id="IMG_SKU_DEL" width="52" height="18" onclick="javascript:delDetailRow();" />
                     </td>
                  </tr> 
                  <tr>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="BD4A" width="100%" >
                      <tr>
                        <td>
                          <comment id="_NSID_"><OBJECT id=GR_DETAIL width="100%" height=600 classid=<%=Util.CLSID_GRID%>>
                            <param name="DataID" value="DS_IO_DETAIL">
                            <Param Name="ViewSummary" value="1">
                          </OBJECT></comment><script>_ws_(_NSID_);</script>
                        </td>
                        
                      </tr>
                    </table></td>
                  </tr>
                </table>
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
<object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
            
        <c>Col=PRT_REQ_DT           Ctrl=EM_I_PRT_REQ_DT      param=Text</c>
        <c>Col=PRT_REQ_SEQ_NO       Ctrl=EM_O_PRT_REQ_SEQ_NO  param=Text</c>
        <c>Col=PUMBUN_CD            Ctrl=EM_I_PUMBUN_CD       param=Text</c>
        <c>Col=PUMBUN_NM            Ctrl=EM_O_PUMBUN_NM       param=Text</c>
        <c>Col=VEN_CD               Ctrl=EM_VEN_CD            param=Text</c>
        <c>Col=VEN_NM               Ctrl=EM_VEN_NM            param=Text</c>
        <c>Col=MG_APP_DT            Ctrl=EM_I_APP_DT          param=Text</c>      
        <c>Col=PRT_YYYY             Ctrl=EM_I_YYYY            param=Text</c>  
        <c>Col=STR_CD               Ctrl=LC_I_STR_CD          param=BindColVal</c>  
        <c>Col=TAG_FLAG             Ctrl=LC_I_TAG_FLAG        param=BindColVal</c>
        
        <c>Col=EVENT_FLAG           Ctrl=LC_I_EVENT_FLAG      param=BindColVal</c>  
        <c>Col=EVENT_RATE           Ctrl=LC_I_EVENT_RATE      param=BindColVal</c>
        '>
</object>
</comment><script>_ws_(_NSID_);</script>
</body>
</html>
