<!-- 
/*******************************************************************************
 * 시스템명 : 영업관리 > 매출관리 > 협력사 평가
 * 작 성 일 : 2011.07.01
 * 작 성 자 : 김경은
 * 수 정 자 : 
 * 파 일 명 : psal7060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 월평가내역확정
 * 이    력 :
 * 
 ******************************************************************************/
-->

<%@ page language="java" contentType="text/html;charset=utf-8"
    import="common.util.Util,common.vo.SessionInfo,kr.fujitsu.ffw.base.BaseProperty"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld"      prefix="c"%>
<%@ taglib uri="/WEB-INF/tld/gauce40.tld"   prefix="gauce"%>
<%@ taglib uri="/WEB-INF/tld/app.tld"       prefix="loginChk"%>
<%@ taglib uri="/WEB-INF/tld/button.tld"    prefix="button"%>
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
<script language="javascript"   src="/<%=dir%>/js/common.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/gauce.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/global.js"        type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/message.js"       type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup.js"         type="text/javascript"></script>
<script language="javascript"   src="/<%=dir%>/js/popup_dps.js"     type="text/javascript"></script>

<!--*************************************************************************-->
<!--* B. 스크립트 시작                                                        *-->
<!--*************************************************************************-->

<script LANGUAGE="JavaScript">
<!--
var rtnVal            = false;
var intSearchCnt      = 0;                             // 조회버튼클릭 여부(0일 경우 마스터조회 건수)
var bfListRowPosition = 0;                             // 이전 List Row Position
var strToday          = "";
var roundFlag         = "";
var score             = "";                            // 등록 평가점수
/*************************************************************************
 * 1. 초기설정
 *************************************************************************/
/**
 * doInit()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-07-01
 * 개    요 : 해당 페이지 LOAD 시  
 * return값 : void
 */

 function doInit(){

     strToday = getTodayDB("DS_O_RESULT");
     
     // Input Data Set Header 초기화
     DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_MASTER"/>');
     DS_O_TEAM.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     DS_O_PC.setDataHeader('CODE:STRING(2),NAME:STRING(40)');
     // Output Data Set Header 초기화

     //그리드 초기화
     gridCreate1(); //마스터
     
     // EMedit에 초기화
     initEmEdit(EM_S_EVALU_YM         ,"THISMN"        ,PK);             // 평가년월
     
     //콤보 초기화 (조회용)
     initComboStyle(LC_S_STR         ,DS_O_STR           ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 점     
     initComboStyle(LC_S_BUMUN       ,DS_O_DEPT          ,"CODE^0^30,NAME^0^80"   ,1  ,PK);         // 팀     
     initComboStyle(LC_S_TEAM        ,DS_O_TEAM          ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // 파트     
     initComboStyle(LC_S_PC          ,DS_O_PC            ,"CODE^0^30,NAME^0^80"   ,1  ,NORMAL);     // PC  
     
     getStore("DS_O_STR", "Y", "", "N");
     getEtcCode("DS_O_GRADE", "D", "P605", "N");         // 등급
     
     LC_S_STR.index       = 0;
     LC_S_STR.Focus(); 
     
     setMasterObject(false, false);
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}          name="NO"            width=30    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=center </FC>'
                      + '<FC>id=SEL               name="선택"          width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=center show=false</FC>'                 
                      + '<FC>id=ORG_CD            name="조직"          width=80    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=center Edit=none </FC>'                           
                      + '<FC>id=ORG_NM            name="조직명"        width=100   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=left   Edit=none subsumtext="코너평균" </FC>'                           
                      + '<FC>id=PUMBUN_CD         name="브랜드"          width=60    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=center Edit=none </FC>'                           
                      + '<FC>id=PUMBUN_NM         name="브랜드명"        width=100   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=left   Edit=none  </FC>'                           
                      + '<FC>id=TOT_SCORE         name="총평가;점수"   width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(TOT_SCORE)}</FC>'
                      
                      + '<G> name="총매출"'                                       
                      + '<C>id=NORM_SAMT         name="정상"      width=100    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(NORM_SAMT)}</C>'                        
                      + '<C>id=EVT_SAMT          name="행사"      width=100    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(EVT_SAMT)} </C>'                        
                      + '<C>id=EVALU_SAMT        name="합계"      width=120    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(TOT_SAMT)} </C>'
                      + '</G> '    
                      
                      + '<C>id=PUMBUN_GRADE      name="등급"      width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=center  EditStyle=Lookup Data="DS_O_GRADE:CODE:NAME" Edit=none </C>'
                      + '<C>id=PUMBUN_WEIGHT     name="가중치"    width=70    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none </C>'
                      
                      + '<G> name="평가매출"'                                       
                      + '<C>id=EVALU_SAMT        name="매출"      width=120    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(TOT_SAMT)}</C>'                        
                      + '<C>id=SALE_SCORE        name="점수"      width=50     SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'                        
                      + '</G> '
                      
                      + '<G> name="이익액"'                                       
                      + '<C>id=SALE_PROF_AMT     name="이익"      width=120    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(SALE_PROF_AMT)} </C>'                        
                      + '<C>id=PROF_SCORE        name="점수"      width=50     SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'                        
                      + '</G> '
                      
                      + '<G> name="이익율" show="false"'                                       
                      + '<C>id=SALE_PROF_RATE         name="율"        width=70  show="false"  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(SALE_PROF_RATE)} </C>'                     
                      + '<C>id=PROF_RATE_SCORE   name="점수"      width=50  show="false"  SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'                        
                      + '</G> ' 
                      
                      + '<G> name="매출신장율"'                                       
                      + '<C>id=SALE_IRATE             name="율"        width=70    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(SALE_IRATE)} </C>'                        
                      + '<C>id=EXPAN_RATE_SCORE  name="점수"      width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'                        
                      + '</G> '
                      
                      + '<G> name="평효율"'                                       
                      + '<C>id=AREA_SIZE         name="면적"       width=80    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(AREA_SIZE)} </C>'                        
                      + '<C>id=PYUNG_SALE        name="평당매출"   width=120   SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(PYUNG_SALE)} </C>'
                      + '<C>id=PYUNG_RATE_SCORE  name="점수"       width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'
                      + '</G> '
                      
                      + '<G> name="매장 CS평가"'                                       
                      + '<C>id=PRO_TOT_CNT      name="약속;전체건수"     width=70    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(PRO_TOT_CNT)} </C>'                        
                      + '<C>id=PRO_DEF_CNT      name="약속;불이행건수"   width=70    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(PRO_DEF_CNT)} </C>'
                      + '<C>id=CUST_CSMS_CNT    name="고객;수선건수"     width=70    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(CUST_CSMS_CNT)} </C>'
                      + '<C>id=CS_SCORE         name="점수"             width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</FC>'
                      + '</G> '
                      
                      + '<G> name="바이어평가"'                                       
                      + '<C>id=TOT_CNT          name="발주건수"               width=80    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(TOT_CNT)} </C>'                        
                      + '<C>id=IN_CNT           name="납품예정일;초과입고건수" width=80    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none SubSumText={SubAvg(IN_CNT)} </C>'
                      + '<C>id=BUYER_SCORE      name="점수"                   width=50    SubBgColor={decode(curlevel,1,"#FFFFE0",2,"#FFFACD")} align=right  Edit=none subsumtext=""</C>'
                      + '</G> '
                      + '<FC> id=level          name=레벨 Value={CurLevel}    width=50   show=false</FC>'
                      ;
     initGridStyle(GR_MASTER, "common", hdrProperies, true);
      
     //GR_MASTER.ViewSummary = "1";
     
     GR_MASTER.GTitleHeight = 25;
     GR_MASTER.TitleHeight  = 35;
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
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-07-01
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {
     if(checkValidation("Search")){
         DS_IO_MASTER.ClearData();  
         intSearchCnt = 0;
         bfListRowPosition = 0;
         getMaster();
         // 조회결과 Return
         setPorcCount("SELECT", GR_MASTER);
     }
}

/**
 * btn_New()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : Grid 레코드 추가
 * return값 : void
 */
function btn_New() {

}

/**
 * btn_Delete()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-07-01
 * 개    요 : Grid 레코드 삭제
 * return값 : void
 */
function btn_Delete() {
}

/**
 * btn_Save()
 * 작 성 자     : 김경은
 * 작 성 일     : 
 * 개    요        : DB에 저장 / 수정처리
 * return값 : void
 */
function btn_Save() {
        
    
}


/**
 * btn_Excel()
 * 작 성 자 : 김경은
 * 작 성 일 :
 * 개    요 : 엑셀로 다운로드
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : 페이지 프린트 인쇄
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 김경은
 * 작 성 일 : 
 * 개    요 : 확정 처리
 * return값 : void
 */

function btn_Conf() {
}

/*************************************************************************
 * 3. 함수
 *************************************************************************/
 /**
  * setMasterObject(flag, updateFlag)
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-07-01
  * 개    요        : 마스터 Object의 활성화/비활성화를 제어한다.
  * return값 : void
  */
 function setMasterObject(flag, updateFlag){
//     GR_MASTER.Editable                 = flag;

 }  
 /**
 * getMaster()
 * 작 성 자 : 김경은
 * 작 성 일 : 2011-07-01
 * 개    요 :  마스터  조회
 * return값 : void
 */
 function getMaster(){

    // 조회조건 셋팅
    var strStrCd         = LC_S_STR.BindColVal;                      // 점
    var strBumun         = LC_S_BUMUN.BindColVal;                    // 팀
    var strTeam          = LC_S_TEAM.BindColVal;                     // 파트
    var strPc            = LC_S_PC.BindColVal;                       // PC
    var strOrgCd         = strStrCd + strBumun + strTeam + strPc;    // 조직   
    var strEvaluYm       = EM_S_EVALU_YM.Text;                       // 평가년월
    
    var goTo       = "getMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="+encodeURIComponent(strStrCd)     
                   + "&strBumun="+encodeURIComponent(strBumun)     
                   + "&strTeam="+encodeURIComponent(strTeam)      
                   + "&strPc="+encodeURIComponent(strPc)     
                   + "&strOrgCd="+encodeURIComponent(strOrgCd)
                   + "&strEvaluYm="+encodeURIComponent(strEvaluYm); 
    
    TR_S_MAIN.Action  = "/dps/psal706.ps?goTo="+goTo+parameters;  
    TR_S_MAIN.KeyValue= "SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_S_MAIN.Post();
 }

 /**
  * checkValidation()
  * 작 성 자     : 김경은
  * 작 성 일     : 2011-07-01
  * 개    요        :  값 체크 
  * return값 : void
  */
 function checkValidation(Gubun) {
 
      var strStrCd      = LC_S_STR.BindColVal;                                  // 점
      var strEvaluYm    = EM_S_EVALU_YM.Text;                                   // 평가년월
      var strPreEvaluYm = addDate("m", -1, strEvaluYm+"01", "").substring(0,6); // 평가년월
      
      //조회버튼 클릭시 Validation Check
      if(Gubun == "Search"){   
         if(EM_S_EVALU_YM.Text.length == 0){
              showMessage(INFORMATION, OK, "USER-1002", "평가년월");
              EM_S_EVALU_YM.Focus();
              return false;
          }
      
      }
   
      return true;
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
<script language=JavaScript for=TR_S_MAIN event=onSuccess>
    for(i=0;i<TR_S_MAIN.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_S_MAIN.SrvErrMsg('UserMsg',i));
    }
</script>
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>
<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_MAIN event=onFail>
    trFailed(TR_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_S_MAIN event=onFail>
    trFailed(TR_S_MAIN.ErrorMsg);
</script>
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<script language=JavaScript for=DS_IO_MASTER event=OnColumnChanged(row,colid)>
   
</script>
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<script language=JavaScript for=GR_MASTER event=OnSelChanged(colid,index)>

</script>

<script language=JavaScript for=GR_MASTER event=OnSelChange(colid,index)>
  return true;
</script>

<script language=JavaScript for=GR_MASTER event=OnClick(row,colid)>
    sortColId( eval(this.DataID), row, colid);
</script>
<!-- GR_MASTER OnPopup event 처리 -->
<script language=JavaScript for=GR_MASTER event=OnPopup(row,colid,data)>
</script>

<!-- 그리드 CHECK BOX 전체 선택 -->
<script language="javascript"  for=GR_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    //헤더 전체 체크/체크해제 컨트롤
    var dataSet = eval(this.DataID);
    for( var i=1 ; i<=dataSet.CountRow; i++){
        if(dataSet.NameValue(i,"CONF_DT") == " ")
           dataSet.NameValue(i,Colid) = bCheck=='0'?'F':'T';
    }
</script>


<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_S_STR event=OnSelChange()>
    if(LC_S_STR.BindColVal != "%"){
        getDept("DS_O_DEPT", "Y", LC_S_STR.BindColVal, "N");   // 팀 
        LC_S_BUMUN.Index = 0;
    }

</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_S_BUMUN event=OnSelChange()>
    if(LC_S_BUMUN.BindColVal != "%"){
        getTeam("DS_O_TEAM", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, "Y"); // 파트  
    }else{
        DS_O_TEAM.ClearData();
        insComboData( LC_S_TEAM, "%", "전체",1);
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_TEAM.Index = 0;
        
</script>

<!-- 파트(조회)  변경시  -->
<script language=JavaScript for=LC_S_TEAM event=OnSelChange()>
    if(LC_S_TEAM.BindColVal != "%"){
        getPc("DS_O_PC", "Y", LC_S_STR.BindColVal, LC_S_BUMUN.BindColVal, LC_S_TEAM.BindColVal, "Y");     // PC  
    }else{
        DS_O_PC.ClearData();
        insComboData( LC_S_PC, "%", "전체",1);
    }
    LC_S_PC.Index = 0;
    
</script>

<!-- PC(조회)  변경시  -->
<script language=JavaScript for=LC_S_PC event=OnSelChange()>
</script>

<!-- 평가년월 KillFocus -->
<script language=JavaScript for=EM_S_EVALU_YM event=onKillFocus()>
    //변경된 내역이 없으면 무시
    if(!this.Modified)
        return;

    checkDateTypeYM(EM_S_EVALU_YM);
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

<comment id="_NSID_"><object id="DS_O_STR"          classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_DEPT"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_TEAM"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_PC"           classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_GRADE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_BIZ_TYPE"  classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_I_COMMON"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_I_CONDITION"    classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_RESULT"       classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<!-- ===============- Output용 -->
<comment id="_NSID_"><object id="DS_IO_MASTER"      classid=<%= Util.CLSID_DATASET %>>
<Param Name="SubsumExpr" VALUE="1:CORNER_CD">
</object></comment><script>_ws_(_NSID_);</script>

<comment id="_NSID_"><object id="DS_O_LIST"         classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_VALCHECK"     classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_CHECK"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>
<comment id="_NSID_"><object id="DS_O_SCORE"        classid=<%= Util.CLSID_DATASET %>></object></comment><script>_ws_(_NSID_);</script>


<!--------------------- 2. Transaction  --------------------------------------->
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
<comment id="_NSID_">
<object id="TR_DETAIL" classid=<%=Util.CLSID_TRANSACTION%>>
  <param name="KeyName" value="Toinb_dataid4">
</object>
</comment><script>_ws_(_NSID_);</script>
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
<DIV id="testdiv" class="testdiv">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
   <tr>
      <td class="PT01 PB03">
      <table width="100%" border="0" cellspacing="0" cellpadding="0"
         class="o_table">
         <tr>
            <td>
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="s_table">
                <tr>
                    <th class="point" width="70">점</th>
                    <td width="110">
                      <comment id="_NSID_"> 
                          <object id=LC_S_STR classid=<%=Util.CLSID_LUXECOMBO%> height=100 width=100 align="absmiddle" tabindex=1> </object> 
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th class="point" width="70">팀</th>
                    <td width="110">
                      <comment id="_NSID_"> 
                          <object id=LC_S_BUMUN classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">파트</th>
                    <td width="110">
                      <comment id="_NSID_"> 
                          <object id=LC_S_TEAM classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                    <th width="70">PC</th>
                    <td>
                      <comment id="_NSID_"> 
                          <object id=LC_S_PC classid=<%=Util.CLSID_LUXECOMBO%> width=100 align="absmiddle" tabindex=1> </object> 
                      </comment><script>_ws_(_NSID_);</script>
                    </td>
                </tr>
                <tr>
                <th class="point">평가년월</th>
                <td colspan="7">
                      <comment id="_NSID_">
                          <object id=EM_S_EVALU_YM classid=<%=Util.CLSID_EMEDIT%>  width=85 tabindex=1 align="absmiddle">
                          </object>
                      </comment>
                      <script> _ws_(_NSID_);</script>
                      <img src="/<%=dir%>/imgs/btn/date.gif" onclick="javascript:openCal('M',EM_S_EVALU_YM)"  align="absmiddle"/>
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
    <tr>
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <!-- <tr>
            <td class="right PB02" valign="bottom"><img src="/<%=dir%>/imgs/btn/copy.gif"
                             hspace="2" onclick="javascript:copy();" /> </td>
         </tr> -->
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <comment id="_NSID_"> <object
                     id=GR_MASTER width=100% height=482 classid=<%=Util.CLSID_GRID%> tabindex=1>
                     <param name="DataID" value="DS_IO_MASTER">
                     <Param Name="IndicatorInfo"       value='
                       <INDICATORINFO width="20" fontsize="9" indexnumber="true"/>'>
                     <Param Name="sort"      value="false">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

</table>


</DIV>
 <!-----------------------------------------------------------------------------
  Gauce Bind Component Declaration
------------------------------------------------------------------------------>
<comment id="_NSID_">
    <object id=BD_MASTER classid=<%=Util.CLSID_BIND%>>
        <param name=DataID          value=DS_IO_MASTER>
        <param name="ActiveBind"    value=true>
        <param name=BindInfo        value='
        '>
    </object>
</comment><script>_ws_(_NSID_);</script>

</body>
</html>

