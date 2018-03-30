<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업관리 > 매출관리 > 당초계획
 * 작 성 일 : 2010.03.03
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal1030.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 당초파트별월매출계획
 * 이    력 :2010.03.03 박종은
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
 var top = 310;		//해당화면의 그리드top위치
 function doInit(){

	 
	//Master 그리드 세로크기자동조정  2013-07-17
	 var obj   = document.getElementById("GD_DETAIL"); 
	 obj.style.height  = (parseInt(window.document.body.clientHeight)-top) + "px";
     // Input Data Set Header 초기화

     // Output Data Set Header 초기화
     DS_O_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
     DS_IO_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');
     DS_IO_DETAIL_ORG.setDataHeader('<gauce:dataset name="H_SEL_DETAIL_ORG"/>');
    
     //그리드 초기화
     gridCreate1(); //마스터
     gridCreate2(); //디테일
     gridCreate4(); //디테일
     // EMedit에 초기화
     initEmEdit(EM_PLAN_YEAR, "YYYY", PK);                           //계획년
     EM_PLAN_YEAR.alignment = 1;
     
     //콤보 초기화
     initComboStyle(LC_STR_CD,DS_STR_CD, "CODE^0^30,NAME^0^140", 1, PK);             //점(조회)
     
     //팀
     initComboStyle(LC_DEPT_CD,DS_DEPT_CD, "CODE^0^30,NAME^0^80", 1, PK);           //팀(조회)
     
     //파트
     initComboStyle(LC_TEAM_CD,DS_TEAM_CD, "CODE^0^30,NAME^0^80", 1, NORMAL);           //파트(조회)
     
     getStore("DS_STR_CD", "Y", "", "N");                                          // 점        
     getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                         // 팀 
     getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");  // 파트  
    
    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';             // 로그인 점코드
    
    LC_STR_CD.BindColVal = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    GD_MASTER.Focus();
    LC_STR_CD.Focus();
    //현재년도 셋팅
    EM_PLAN_YEAR.text = today.getYear();
    
   registerUsingDataset("psal103","DS_IO_DETAIL,DS_O_MASTER" );
   
 }

 function gridCreate1(){
     var hdrProperies = '<FC>id={currow}            name="NO"               width=30     align=center   </FC>'
    	              + '<FC>id=CONF_FLAG           name="확정"              width=30     align=center       Edit= none     EditStyle=CheckBox        HeadCheck=false   HeadCheckShow=false</FC>'
                      + '<FC>id=STR_CD              name="점"                width=30     align=center    Edit=none   </FC>'
                      + '<FC>id=STR_NAME            name="점명"              width=70     align=left      Edit=none   sumtext="합계" </FC>'
                      + '<FC>id=DEPT_CD             name="팀"              width=40     align=center    Edit=none   </FC>'
                      + '<FC>id=TEAM_CD             name="파트"                width=30     align=center    Edit=none   </FC>'
                      + '<FC>id=ORG_NAME            name="파트명"              width=80     align=left      Edit=none    </FC>'
                      + '<FC>id=PLAN_YEAR           name="목표년도"           width=100    align=left      Edit=none   show=false</FC>'
                      + '<FG>                       name="당초년매출목표합계"'
                      + '<FC>id=ORIGIN_NORM_SAMT    name="정상"              width=100     align=right     Edit=none    sumtext={subsum(ORIGIN_NORM_SAMT)}</FC>'
                      + '<FC>id=ORIGIN_EVT_SAMT     name="행사"              width=100     align=right     Edit=none    sumtext={subsum(ORIGIN_EVT_SAMT)}</FC>'
                      + '<FC>id=ORIGIN_SALE_TAMT    name="총매출"            width=100     align=right     Edit=none    sumtext={subsum(ORIGIN_SALE_TAMT)}</FC>'
                      + '<FC>id=ORIGIN_PROF_TAMT    name="이익"              width=100     align=right     Edit=none    sumtext={subsum(ORIGIN_PROF_TAMT)}</FC>'
                      + '<FC>id=ORIGIN_SALE_CRATE   name="매출구성비"         width=80     align=right     Edit=none    Dec=2 BgColor={decode(ORG_NAME,"","yellow","white")} sumtext={subsum(BFYY_SALE_CRATE)}</FC>'
                      + '<FC>id=ORIGIN_PROF_CRATE   name="이익구성비"         width=80     align=right     Edit=none    Dec=2 BgColor={decode(ORG_NAME,"","yellow","white")} sumtext={subsum(BFYY_PROF_CRATE)}</FC>'
                      + '</FG> '
                      + '<FC>id=CONF_FLAG           name="확정구분"           width=80     align=right     Edit=none    show=false </FC>'
                      ;
                      

     initGridStyle(GD_MASTER, "common", hdrProperies, false);
     //합계표시 아래
     GD_MASTER.ViewSummary = "1";
     GD_MASTER.DecRealData = true;
 }

 function gridCreate4(){
     var hdrProperies = '<FC>id={currow}            name="NO"              width=30    align=center                     </FC>'
                      + '<FC>id=STR_CD              name="점"              width=40    align=center        Edit=none    </FC>'
                      + '<FC>id=STR_NAME            name="점명"            width=80    align=left          Edit=none    </FC>'
                      + '<FC>id=ORG_CD              name="조직코드"        width=120    align=center        Edit=none    </FC>'
                      + '<FC>id=PLAN_YM             name="목표;년월"       width=60    align=center        Edit=none   </FC>'
                      + '<FC>id=ORG_LEVEL           name="조직;레벨"       width=40    align=center        Edit=none   </FC>'
                      + '<FC>id=DEPT_CD             name="팀"            width=40    align=center        Edit=none   </FC>'
                      + '<C>id=DEPT_ORG_NAME        name="팀명"          width=100   align=left          Edit=none   </C>'
                      + '<FC>id=TEAM_CD             name="파트"              width=40    align=center        Edit=none   </FC>'
                      + '<C>id=TEAM_ORG_NAME        name="파트명"            width=100   align=left          Edit=none   </C>'
                      + '<G>                        name="전년매출"'
                      + '<C>id=BFYY_NORM_SAMT       name="정상"            width=100    align=right         Edit=none    </C>'
                      + '<C>id=BFYY_EVT_SAMT        name="행사"            width=100    align=right         Edit=none    </C>'
                      + '<C>id=BFYY_SALE_TAMT       name="총매출"          width=100    align=right         Edit=none    </C>'
                      + '<C>id=BFYY_PROF_TAMT       name="이익"            width=100    align=right         Edit=none    </C>'
                      + '<C>id=BFYY_SALE_CRATE      name="매출구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '<C>id=BFYY_PROF_CRATE      name="이익구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '</G> '
                      + '<G>                        name="목표매출"'
                      + '<C>id=ORIGIN_NORM_SAMT     name="정상"            width=100    align=right         Edit=""      </C>'
                      + '<C>id=ORIGIN_EVT_SAMT      name="행사"            width=100    align=right         Edit=""      </C>'
                      + '<C>id=ORIGIN_SALE_TAMT     name="총매출"          width=100    align=right         Edit=none    </C>'
                      + '<C>id=ORIGIN_PROF_TAMT     name="이익"            width=100    align=right         Edit=""      </C>'
                      + '<C>id=ORIGIN_SALE_CRATE    name="매출구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '<C>id=ORIGIN_PROF_CRATE    name="이익구성비"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '<C>id=ORIGIN_SALE_IRATE    name="매출신장율"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '<C>id=ORIGIN_PROF_IRATE    name="이익신장율"      width=80    align=right Dec=2   Edit=none    </C>'
                      + '</G> '
                      + '<C>id=CONF_FLAG            name="확정구분"      width=80    align=right Dec=2   Edit=none    </C>'
                      ;
                     
     
     initGridStyle(GD_DETAIL_ORG, "common", hdrProperies, true);
     DS_IO_DETAIL_ORG.UseChangeInfo = false;  
 }

 function gridCreate2(){
     var hdrProperies = '<FC>id={currow}            name="NO"        width=30     align=center     BgColor={if(ERROR_CHECK = "","white","orange")} </FC>'
                      + '<FC>id=DEPT_CD             name="팀"       width=40     align=center    show="false" Edit=none    Suppress="2" BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")} </FC>'
                      + '<FC>id=TEAM_CD             name="파트"        width=40      align=center    Edit=none    Suppress="3" BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORG_NAME            name="파트명"       width=90     align=left      Edit=none    Suppress="4" BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=PLAN_YM             name="월"        width=60      align=center    Edit=none    Suppress="1" BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}Mask="XXXX/XX"</FC>'
                      + '<FC>id=GUBUN               name="구분"       textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}    width=70     align=center     Edit=none    BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_NORM_SAMT    name="정상매출"    textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=100     align=right     Edit={if(GUBUN="전년매출",none,if(currow > 24, none,if(CONF_FLAG = "Y" , none, "")))}      BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_EVT_SAMT     name="행사매출"    textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=100     align=right     Edit={if(GUBUN="전년매출",none,if(currow > 24, none,if(CONF_FLAG = "Y" , none, "")))}      BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_SALE_TAMT    name="총매출"      textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=100     align=right    Edit=none    BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_PROF_TAMT    name="이익"        textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=100    align=right     Edit={if(GUBUN="전년매출",none,if(currow > 24, none,if(CONF_FLAG = "Y" , none, "")))}      BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_SALE_CRATE   name="매출구성비"   textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=80    align=right     Dec=2        Edit=none    BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_PROF_CRATE   name="이익구성비"   textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=80    align=right     Dec=2        Edit=none    BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_SALE_IRATE   name="매출신장율"   textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=80    align=right     Dec=2        Edit=none    show=false BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ORIGIN_PROF_IRATE   name="이익신장율"   textcolor={if(GUBUN="전년매출" AND TEAM_CD <> "","lightblue","#3a3a3a")}width=80    align=right     Dec=2        Edit=none    show=false BgColor={if(currow <= 24,if(ERROR_CHECK = "","white","orange"),"skyblue")}</FC>'
                      + '<FC>id=ERROR_CHECK         name="에러체크"     width=80    align=right     Edit=none    show=false BgColor={if(currow <= 24,"white","skyblue")}</FC>'
                      + '<FC>id=CONF_FLAG           name="확정구분"     width=80    align=right     Edit=none    show=false BgColor={if(currow <= 24,"white","skyblue")}</FC>'
                      ;
                      

     initGridStyle(GD_DETAIL, "common", hdrProperies, true);
     
     DS_IO_DETAIL.UseChangeInfo = false;  
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
 * 작 성 일 : 2010-03-04
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

   if (DS_IO_DETAIL.IsUpdated ){
	   ret = showMessage(QUESTION, YESNO, "USER-1084");
       if (ret != "1") {
           return false;
       } 
   }
   

    //점 체크
    if (isNull(LC_STR_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","점");
        return;
    }

    //팀 체크
    if (isNull(LC_DEPT_CD.BindColVal)==true ) {
        showMessage(INFORMATION, OK, "USER-1003","팀");
        return;
    }
    
    //계획년도
    if (isNull(EM_PLAN_YEAR.text) ==true ) {
        showMessage(INFORMATION, OK, "USER-1003","목표년도"); 
        return;
    }
    //계획년도 자릿수, 공백 체크
    if (EM_PLAN_YEAR.text.replace(" ","").length != 4 ) {
        showMessage(INFORMATION, OK, "USER-1027","목표년도","4");
        return;
    }

    //마스터 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_DETAIL_ORG.ClearData();
    DS_IO_DETAIL.ClearData();
    
    var strStrCd        = LC_STR_CD.BindColVal;      //점
    var strDeptCd       = LC_DEPT_CD.BindColVal;     //팀
    var strTeamCd       = LC_TEAM_CD.BindColVal;     //파트
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    
    var goTo       = "searchMaster" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);
    
    TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_O_MASTER=DS_O_MASTER)"; //조회는 O
    TR_MAIN.Post();
    
    GD_MASTER.DoMethod("GetClickGridArea", "true");
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    
}

/**
 * btn_New()
 * 작 성 자 : 박종은  
 * 작 성 일 : 2010-03-07
 * 개    요 :  화면 클리어
 * return값 : 
 */
function btn_New() {

    if (DS_IO_DETAIL.IsUpdated ){
    	ret = showMessage(QUESTION, YESNO, "USER-1085");
        if (ret != "1") {
            return false;
        } 
    }

    //마스터, 디테일 그리드 클리어
    DS_O_MASTER.ClearData();
    DS_IO_DETAIL.ClearData();

    var strcd = '<c:out value="${sessionScope.sessionInfo.STR_CD}" />';     // 로그인 점코드
    LC_STR_CD.bindcolval = strcd;
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
    EM_PLAN_YEAR.text = today.getYear();
    return;
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : 
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : PJE
 * 작 성 일 : 2010-03-04
 * 개    요 : DB에 저장  / 삭제 처리
 * return값 : void
 */
function btn_Save() {
   // 저장할 데이터 없는 경우
    if (!DS_IO_DETAIL.IsUpdated ){
        //저장할 내용이 없습니다
        showMessage(INFORMATION, OK, "USER-1028");
        return;
    }
   
    //당초파트별년매출계획 확정체크
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
    var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
    var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
    var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도

    var goTo       = "searchConfFlag" ;    
    var action     = "O";     
    var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                   + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="     +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_CHKCONFFLAG.countRow == 0) {
      showMessage(INFORMATION, OK, "USER-1000", "당초 파트별 년 매출목표가 미확정된 데이터입니다.확정 후 다시 등록하십시오.");
        return;
    }
    
    var goTo       = "searchConfFlagM" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
    for(i=1; i <= 24; i++){
        if(checkYYYYMM(DS_IO_DETAIL.NameValue(i,"PLAN_YM")) != true){
            showMessage(INFORMATION, OK, "USER-1000", "년월형식이 일치하지 않습니다. 확인하여 주십시오.");
            return;
        }
    }
    
    errorRow ="";
    errcnt = 0;
    errorchk();
    
    if(errcnt > 0){
      showMessage(INFORMATION, OK, "USER-1000",errorRow+" 행이 데이터 정합성이 일치하지 않습니다.");
      var noCheckRow = errorRow.split(",");
      for(i=1; i <= noCheckRow.length; i++){
            for(j=1; j <= DS_IO_DETAIL.CountRow; j++ ){
                if(noCheckRow[i-1] == j ){
                    DS_IO_DETAIL.NameValue(j,"ERROR_CHECK") = "TRUE";
                    break;
                }
            }
        }
      return;
    }
    
    //당초년매출계획과 월매출계획합계 비교
    if(comparecheck() != true){return;}
    
    //중복된 데이터 체크 
    var retChk  = checkDupKey(DS_O_MASTER, "PLAN_YM||DEPT_CD||TEAM_CD||GUBUN");
    
    if (retChk != 0) {
      showMessage(INFORMATION, OK, "USER-1044",retChk);
      return;
    }
    
    //변경또는 신규 내용을 저장하시겠습니까?
    if( showMessage(QUESTION, YESNO, "USER-1010") != 1 )
        return;

    var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                    + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                    + "&strTeamCd="       +encodeURIComponent(strTeamCd);
    
    TR_MAIN.Action="/dps/psal103.ps?goTo=save"+parameters;
    TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
    TR_MAIN.Post();
    

    // 정상 처리일 경우 조회
    if( TR_MAIN.ErrorCode == 0){
    	DS_O_MASTER.RowPosition = DS_O_MASTER.NameValueRow("TEAM_CD",strTeamCd);
        searchDetail();
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
 * return값 : 
 */

function btn_Conf() {

}

/*************************************************************************
 * 3. 함수
 *************************************************************************/

 /**
  * chkSave()
  * 작 성 자 : 박종은
  * 작 성 일 : 2010-03-04
  * 개    요 :  저장
  * return값 : void
  */
 function chkSave(){

       //당초파트별년매출계획 확정체크
       var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
       var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
       var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
       var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도

       var goTo       = "searchConfFlag" ;    
       var action     = "O";     
       var parameters = "&strStrCd="        +encodeURIComponent(strStrCd)
                      + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                      + "&strTeamCd="       +encodeURIComponent(strTeamCd)
                      + "&strPlanYear="     +encodeURIComponent(strPlanYear);

       TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_CHKCONFFLAG=DS_CHKCONFFLAG)"; 
       TR_MAIN.Post();
       
       if (DS_CHKCONFFLAG.countRow == 0) {
           showMessage(INFORMATION, OK, "USER-1000", "당초파트별년매출목표가 미확정된 데이터입니다.<br>확정 후 다시 등록하십시오.");
           return;
       }
       
       var goTo       = "searchConfFlagM" ;    
       var action     = "O";     
       var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                      + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                      + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                      + "&strPlanYear="        +encodeURIComponent(strPlanYear);

       TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
       TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
       TR_MAIN.Post();
       
       if (DS_MCHKCONFFLAG.countRow != 0) {
           showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표가 확정된 데이터입니다.<br>확정취소 후 다시 등록하십시오.");
           return;
       }
       
       for(i=1; i <= 24; i++){
           if(checkYYYYMM(DS_IO_DETAIL.NameValue(i,"PLAN_YM")) != true){
               showMessage(INFORMATION, OK, "USER-1000", "년월형식이 일치하지 않습니다. 확인하여 주십시오.");
               return;
           }
       }
       
       errorRow ="";
       errcnt = 0;
       errorchk();
       
       if(errcnt > 0){
           showMessage(INFORMATION, OK, "USER-1000",errorRow+" 행이 데이터 정합성이 일치하지 않습니다.");
           var noCheckRow = errorRow.split(",");
           for(i=1; i <= noCheckRow.length; i++){
               for(j=1; j <= DS_IO_DETAIL.CountRow; j++ ){
                   if(noCheckRow[i-1] == j ){
                       DS_IO_DETAIL.NameValue(j,"ERROR_CHECK") = "TRUE";
                       break;
                   }
               }
           }
           return;
       }
       
       //당초년매출계획과 월매출계획합계 비교
       if(comparecheck() != true){return;}
       
       //중복된 데이터 체크 
       var retChk  = checkDupKey(DS_O_MASTER, "PLAN_YM||DEPT_CD||TEAM_CD||GUBUN");
       
       if (retChk != 0) {
           showMessage(INFORMATION, OK, "USER-1044",retChk);
           return;
       }
       
       
       

       var parameters =  "&strStrCd="        +encodeURIComponent(strStrCd)
                       + "&strDeptCd="       +encodeURIComponent(strDeptCd)
                       + "&strTeamCd="       +encodeURIComponent(strTeamCd);
       
       TR_MAIN.Action="/dps/psal103.ps?goTo=save"+parameters;
       TR_MAIN.KeyValue="SERVLET(I:DS_IO_DETAIL=DS_IO_DETAIL)"; //조회는 O
       TR_MAIN.Post();
       
       btn_Search();
       DS_O_MASTER.RowPosition = DS_O_MASTER.NameValueRow("TEAM_CD",strTeamCd);
       searchDetail();
}

/**
 * loadExcelData()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개    요 : Excel파일 DateSet에 저장
 * return값 :
 */
function loadExcelData() {

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_DETAIL.IsUpdated || DS_IO_DETAIL_ORG.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1086");
        if (ret != "1") {
            return false;
        } 
    }
    var strStrCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
    var strDeptCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");        //팀코드
    var strTeamCd    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");        //파트코드
    var strPlanYear  = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");      //계획년도
    
    var goTo       = "searchConfFlagM" ;    
    var action     = "O";     
    var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                   + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="        +encodeURIComponent(strPlanYear);

    TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_MCHKCONFFLAG=DS_MCHKCONFFLAG)"; 
    TR_MAIN.Post();
    
    if (DS_MCHKCONFFLAG.countRow != 0) {
        showMessage(INFORMATION, OK, "USER-1000", "당초파트별월매출목표가 확정된 데이터입니다.확정취소 후 다시 등록하십시오.");
        return;
    }
    
     
    if(DS_O_MASTER.CountRow == 0){
        showMessage(INFORMATION, OK, "USER-1000","조회 후 업로드 가능합니다.");
        return;
    }
    // 엑셀 파일명 초기화
    INF_EXCELUPLOAD.Value = '';
    //Fils Open창
    INF_EXCELUPLOAD.Open();

    //loadExcelData 옵션처리
    var strExcelFileName = "'" + INF_EXCELUPLOAD.Value + "'"; //파일이름
    if (strExcelFileName == "''")
        return;

    DS_IO_DETAIL_ORG.ClearData();
    DS_IO_DETAIL.ClearData();

    var strStartRow     = 7;    //시작Row
    var strEndRow       = 0;   //끝Row
    var strReadType     = 0;    //읽기모드
    var strBlankCount   = 0;    //공백row개수
    var strLFTOCR       = 0;    //줄바꿈처리 
    var strFireEvent    = 1;    //이벤트발생
    var strSheetIndex   = 1;    //Sheet Index 추가
    var strtrEtc        = "1";  //엑셀 컬럼에 1000단위 구분기호(,)가 있을 경우, 구분기호를 무시하고 데이터를 가져온다. (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,72    UMX: 2,0,1,72 이상버전 사용가능)
    var strtrcol        = 0;    //Excel 파일에서 읽어 들일 시작 Col 위치 (생략가능, 생략시 디폴트값으로 0세팅 MAX: 1,2,1,80    UMX: 2,0,1,80 이상버전 사용가능)

    //DataSetID.Do("Excel.Application", "'FileName', nStartRow, nEndRow, nReadType, blankCount, LFCR, FireEvent, SheetIndex, DelimiterSymbol, StartCol") 

    var strOption = strExcelFileName
      + "," + strStartRow   + "," + strEndRow + "," + strReadType 
      + "," + strBlankCount + "," + strLFTOCR + "," + strFireEvent
      + "," + strSheetIndex + "," + strtrEtc  + "," + strtrcol;
   
    //Excel파일 DateSet에 저장               
    DS_IO_DETAIL_ORG.Do("Excel.Application", strOption);
  
    //DateSet에 저장 후  Excel Header ROW삭제(첫행)
    DS_IO_DETAIL_ORG.DeleteRow(1);

    //전년매출데이터
    searchBFYY();
    GD_DETAIL.ReDraw = false;
    moveDetail();
    GD_DETAIL.ReDraw = true;

    //수식계산
    changecolumn();
    //에러체크 변경
    checkChange();
    //합계
    ln_sum();
    
    //스크롤바 위치 조정
    GD_DETAIL.SETVSCROLLING(0);

}


/**
* moveDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-16
* 개    요 :  히든그리드 데이터 상세그리드로 출력
* return값 : void
*/
function moveDetail(){
    DS_IO_DETAIL.ClearData();
    
    var j = 1;
    var k = 2;
    var m = 1;
    for(i=1; i <= DS_IO_DETAIL_ORG.CountRow;i++){
        
        DS_IO_DETAIL.AddRow();
        DS_IO_DETAIL.AddRow();
        
        
        DS_IO_DETAIL.NameValue(j,"DEPT_CD")           = DS_IO_DETAIL_ORG.NameValue(i,"DEPT_CD");
        DS_IO_DETAIL.NameValue(j,"TEAM_CD")           = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_CD");
        DS_IO_DETAIL.NameValue(j,"ORG_NAME")          = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_ORG_NAME");
        DS_IO_DETAIL.NameValue(j,"PLAN_YM")           = DS_IO_DETAIL_ORG.NameValue(i,"PLAN_YM");
        DS_IO_DETAIL.NameValue(j,"GUBUN")             = "전년매출";
        
        DS_IO_DETAIL.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_NORM_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_EVT_SAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_TAMT");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_SALE_CRATE");
        DS_IO_DETAIL.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL_ORG.NameValue(i,"BFYY_PROF_CRATE");

        DS_IO_DETAIL.NameValue(j,"CONF_FLAG")         = DS_IO_DETAIL_ORG.NameValue(i,"CONF_FLAG");

        j = j + 2;
        
        

        DS_IO_DETAIL.NameValue(k,"DEPT_CD")           = DS_IO_DETAIL_ORG.NameValue(i,"DEPT_CD");
        DS_IO_DETAIL.NameValue(k,"TEAM_CD")           = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_CD");
        DS_IO_DETAIL.NameValue(k,"ORG_NAME")          = DS_IO_DETAIL_ORG.NameValue(i,"TEAM_ORG_NAME");
        DS_IO_DETAIL.NameValue(k,"PLAN_YM")           = DS_IO_DETAIL_ORG.NameValue(i,"PLAN_YM");
        DS_IO_DETAIL.NameValue(k,"GUBUN")             = "당초목표";
        
        DS_IO_DETAIL.NameValue(k,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_NORM_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_EVT_SAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_TAMT");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_CRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_SALE_IRATE");
        DS_IO_DETAIL.NameValue(k,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL_ORG.NameValue(i,"ORIGIN_PROF_IRATE");

        DS_IO_DETAIL.NameValue(k,"CONF_FLAG")         = DS_IO_DETAIL_ORG.NameValue(i,"CONF_FLAG");
        k = k + 2;
        
        
        
    }
    
}

/**
* moveDetailOrg()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-17
* 개    요 : 상세내역데이터를 히든그리드로 복사
* return값 :
*/
function moveDetailOrg(){
    var j = 1;
    
    for(i=1; i <= DS_IO_DETAIL.CountRow;i=i+2){
        if(DS_IO_DETAIL.NameValue(i,"PUMBUN_NAME") != "합계" && DS_IO_DETAIL.NameValue(i,"PUMBUN_NAME") != "" && 
           DS_IO_DETAIL.NameValue(i,"PUMBUN_NAME") != "오차" ){
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_NORM_SAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_EVT_SAMT")     = DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_TAMT")    = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_JAN") ;
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_SALE_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"BFYY_PROF_CRATE")   = DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_JAN");

            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_NORM_SAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_NORM_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_EVT_SAMT")   = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_EVT_SAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_TAMT")  = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_TAMT_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_CRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_CRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_SALE_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_SALE_IRATE_JAN");
            DS_IO_DETAIL_ORG.NameValue(j,"ORIGIN_PROF_IRATE") = DS_IO_DETAIL.NameValue(i+1,"ORIGIN_PROF_IRATE_JAN");
        
            j++;
        
        }
    }
    
}

/**
 * changecolumn()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개     요 : 데이터셋 컬럼값 변경시 수식계산 적용
 * return값 :
 */
function changecolumn(){
    var bfyySaleCRate = 0; //전년매출
    var bfyyPorfCRate = 0; //전년매출
    var orgSaleCRate = 0;  //당초계획
    var orgPorfCRate = 0;  //당초계획
    
    for(i=1; i <= 24; i++){
        DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT") = round(DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0) + round(DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
         bfyySaleCRate =getRoundDec("1",bfyySaleCRate,0)+ getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
         bfyyPorfCRate =getRoundDec("1",bfyyPorfCRate,0)+ getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
        }
        else{
         orgSaleCRate =getRoundDec("1",orgSaleCRate,0)+ getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            orgPorfCRate =getRoundDec("1",orgPorfCRate,0)+ getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
        }
    }

    for(i=1; i <= 24; i++){
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),2) != 0){
         if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0)/getRoundDec("1",bfyySaleCRate,0)*100.00,2);
         }
         else{
            DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0)/getRoundDec("1",orgSaleCRate,0)*100.00,2);
         }
        }
        else{
         DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE") = 0.00;
        }
        
        if(getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),2) != 0){
         if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
            DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0)/getRoundDec("1",bfyyPorfCRate,0)*100.00,2);
         }
         else{
            DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0)/getRoundDec("1",orgPorfCRate,0)*100.00,2);
         }
        }
        else{
         DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE") = 0.00;
        }
    }
    
    for(i=1; i <= 24; i++){
       if(i> 1){
           if(getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
               DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),2))*100.00,2);
               if(round(DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE"),2) >= 1000.00){
                   DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE") = 999.99;
               }
           }
           else{
               DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_IRATE") = 0.00;
           }
           
           if(round(DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT"),2) != 0 && DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출"){
               DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE") = getRoundDec("1",((getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),2) - getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT"),2))/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT"),2))*100.00,2);
               if(round(DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE"),2) >= 1000.00){
                   DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE") = 999.99;
               }
           }
           else{
               DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_IRATE") = 0.00;
           }
       }
    }
}

/**
 * ExcelDownData()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개     요 : 데이터 내역을 엑셀로 저장
 * return값 :
 */
function ExcelDownData() {
    
    if(DS_O_MASTER.CountRow <= 0){
      showMessage(INFORMATION, OK, "USER-1000","다운 할 내용이 없습니다. 조회 후 엑셀다운 하십시오.");
        return;
    }
    var strTitle = "당초파트별월매출목표";
    GD_DETAIL_ORG.ColumnProp("PLAN_YM", "Mask") ="XXXXXX"

    var strStrCd        = LC_STR_CD.Text;      //점
    var strDeptCd       = LC_DEPT_CD.Text;     //팀
    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"ORG_NAME");        //파트코드
    //var strTeamCd       = LC_TEAM_CD.Text;     //파트
    var strPlanYear     = EM_PLAN_YEAR.text;         //계획년도
    

        var strOriginNormSamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_NORM_SAMT",0);      //정상
        var strOriginEvtSamt       = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_EVT_SAMT",0);       //행사
        var strOriginSaleTamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_SALE_TAMT",0);      //총매출
        var strOriginProfTamt      = GD_MASTER.VirtualString2(DS_O_MASTER.RowPosition,"ORIGIN_PROF_TAMT",0);       //이익

            var parameters = "점= "           +strStrCd
               + " , 팀= "          +strDeptCd
               + " , 파트= "          +strTeamCd
               + " , 년도= "        +strPlanYear
               + " , 정상= "      +strOriginNormSamt
               + " , 행사= "   +strOriginEvtSamt
               + " , 총매출= " +strOriginSaleTamt
               + " , 이익= "   +strOriginProfTamt;
        
    GD_DETAIL_ORG.GridToExcelExtProp("HideColumn") = "{currow}";       // GridToExcel 사용시 숨길 컬럼지정
    openExcel2(GD_DETAIL_ORG, strTitle, parameters, true );
    
    GD_DETAIL_ORG.ColumnProp("PLAN_YM", "Mask") ="XXXX/XX"
}

/**
 * errorchk()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-04
 * 개     요 : 데이터 에러 체크
 * return값 :
 */
function errorchk(){
    var strDeptCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"DEPT_CD");         //팀코드
    var strTeamCd     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"TEAM_CD");         //파트코드
    var strPlanYear   = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"PLAN_YEAR");       //계획년도
    var strOrgName    = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORG_NAME");         //파트명
    
    for(i=1; i <= 24; i++){
        if(DS_IO_DETAIL.NameValue(i,"DEPT_CD") != strDeptCd 
        		|| DS_IO_DETAIL.NameValue(i,"TEAM_CD") != strTeamCd
                || DS_IO_DETAIL.NameValue(i,"ORG_NAME") != strOrgName){
            errcnt     += 1;
            errorRow   += i+",";
        }
        
    }
   
    errorRow = errorRow.substr(0,errorRow.length-1);
}


/**
* searchDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  당초파트별월매출계획 조회
* return값 : void
*/
function searchDetail(){
	DS_IO_DETAIL_ORG.ClearData();
	DS_IO_DETAIL.ClearData();
    
    var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "STR_CD");           //점
    var strDeptCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd       = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
    var strPlanYear     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "PLAN_YEAR");        //계획년도
   
    var goTo       = "searchDetail" ;    
    var action     = "O";     
    var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                   + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                   + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                   + "&strPlanYear="          +encodeURIComponent(strPlanYear);
   
    TR_DETAIL.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
    TR_DETAIL.KeyValue="SERVLET("+action+":DS_IO_DETAIL_ORG=DS_IO_DETAIL_ORG)"; //조회는 O
    TR_DETAIL.Post();
   
    //전년매출이 없을 경우 균등 배분
    //applyDetail();
    //합계표시
    
    GD_DETAIL.ReDraw = false;
    moveDetail();
    changecolumn();
    if(DS_IO_DETAIL.CountRow != 0){
        ln_sum();
        DS_IO_DETAIL.ResetStatus();
    }
    GD_DETAIL.ReDraw = true;
    DS_IO_DETAIL.ResetStatus();
    //스크롤바 위치 조정
    GD_DETAIL.SETVSCROLLING(0);
    GD_DETAIL.SETHSCROLLING(0);
    
    DS_IO_DETAIL.RowPosition = 1;
    setPorcCount("SELECT", DS_IO_DETAIL_ORG.CountRow);
    GD_MASTER.Focus();
}


/**
* ln_sum()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  합계/오차 행추가
* return값 : 
*/
function ln_sum() {
    var bfyyTotal       = 0;  //전년합계
    var originTotal     = 0;  //당초합계
    var gap             = 0;  //차이
    //전년
    var bfyyNormSAmt    = 0;  //정상매출합계
    var bffEvtSAmt      = 0;  //행사매출합계
    var bfyySaleTAmt    = 0;  //총매출합계
    var bfyyProfTAmt    = 0;  //이익합계
    var bfyySaleCRate   = 0;  //매출구성비합계
    var bfyyProfCRate   = 0;  //이익구성비합계
    //당초
    var originNormSAmt  = 0;  //정상매출합계
    var originEvtSAmt   = 0;  //행사매출합계
    var originSaleTAmt  = 0;  //총매출합계
    var originProfTAmt  = 0;  //이익합계
    var originSaleCRate = 0;  //매출구성비합계
    var originProfCRate = 0;  //이익구성비합계

    
    
    for(i=1; i <= 24; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
            bfyyNormSAmt     += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            bffEvtSAmt       += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            bfyySaleTAmt     += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            bfyyProfTAmt     += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
            bfyySaleCRate    += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE"),2);
            bfyyProfCRate    += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE"),2);
        }
        else{
            originNormSAmt   += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            originEvtSAmt    += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            originSaleTAmt   += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            originProfTAmt   += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
            originSaleCRate  += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE"),2);
            originProfCRate  += round(DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE"),2);
        }
    }
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "합계";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "전년매출";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT") = bfyyNormSAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT")  = bffEvtSAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT") = bfyySaleTAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT") = bfyyProfTAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE")= bfyySaleCRate;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE")= bfyyProfCRate;
    
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "당초목표";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT") = originNormSAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT")  = originEvtSAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT") = originSaleTAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT") = originProfTAmt;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_CRATE")= originSaleCRate;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_CRATE")= originProfCRate;

    var orgNormSAmt    = round(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0);   //당초년정상
    var orgEvtSAmt     = round(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0);    //당초년행사
    var orgProfTAmt    = round(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0);   //당초년이익
    var orgSaleTAmt    = round(DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT"),0);   //당초년총매출
    
    DS_IO_DETAIL.Addrow();
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORG_NAME")         = "오차";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"GUBUN")            = "";
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_NORM_SAMT") = getRoundDec("1",getRoundDec("1",orgNormSAmt,0) - getRoundDec("1",originNormSAmt,0),0)  ;
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_EVT_SAMT")  = getRoundDec("1",getRoundDec("1",orgEvtSAmt,0) - getRoundDec("1",originEvtSAmt,0),0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_SALE_TAMT") = getRoundDec("1",getRoundDec("1",orgSaleTAmt,0) - getRoundDec("1",originSaleTAmt,0),0);
    DS_IO_DETAIL.NameValue(DS_IO_DETAIL.RowPosition,"ORIGIN_PROF_TAMT") = getRoundDec("1",getRoundDec("1",orgProfTAmt,0) - getRoundDec("1",originProfTAmt,0),0);


}

/**
* change_ln_sum()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  컬럼변경시 합계/오차 수정
* return값 : 
*/
function change_ln_sum() {
    var bfyyTotal       = 0;  //전년합계
    var originTotal     = 0;  //당초합계
    var gap             = 0;  //차이
    //전년
    var bfyyNormSAmt    = 0;  //정상매출합계
    var bffEvtSAmt      = 0;  //행사매출합계
    var bfyySaleTAmt    = 0;  //총매출합계
    var bfyyProfTAmt    = 0;  //이익합계
    var bfyySaleCRate   = 0;  //매출구성비합계
    var bfyyProfCRate   = 0;  //이익구성비합계
    //당초
    var originNormSAmt  = 0;  //정상매출합계
    var originEvtSAmt   = 0;  //행사매출합계
    var originSaleTAmt  = 0;  //총매출합계
    var originProfTAmt  = 0;  //이익합계
    var originSaleCRate = 0;  //매출구성비합계
    var originProfCRate = 0;  //이익구성비합계

    
    
    for(i=1; i <= 24; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
            bfyyNormSAmt     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            bffEvtSAmt       += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            bfyySaleTAmt     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            bfyyProfTAmt     += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
            bfyySaleCRate    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE"),2);
            bfyyProfCRate    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE"),2);
        }
        else{
            originNormSAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            originEvtSAmt    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            originSaleTAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            originProfTAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
            originSaleCRate  += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE"),2);
            originProfCRate  += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE"),2);
        }
    }
    
    DS_IO_DETAIL.NameValue(25,"ORG_NAME")         = "합계";
    DS_IO_DETAIL.NameValue(25,"GUBUN")            = "전년매출";
    DS_IO_DETAIL.NameValue(25,"ORIGIN_NORM_SAMT") = bfyyNormSAmt;
    DS_IO_DETAIL.NameValue(25,"ORIGIN_EVT_SAMT")  = bffEvtSAmt;
    DS_IO_DETAIL.NameValue(25,"ORIGIN_SALE_TAMT") = bfyySaleTAmt;
    DS_IO_DETAIL.NameValue(25,"ORIGIN_PROF_TAMT") = bfyyProfTAmt;
    DS_IO_DETAIL.NameValue(25,"ORIGIN_SALE_CRATE")= bfyySaleCRate;
    DS_IO_DETAIL.NameValue(25,"ORIGIN_PROF_CRATE")= bfyyProfCRate;
    
    DS_IO_DETAIL.NameValue(26,"ORG_NAME")         = "";
    DS_IO_DETAIL.NameValue(26,"GUBUN")            = "당초목표";
    DS_IO_DETAIL.NameValue(26,"ORIGIN_NORM_SAMT") = originNormSAmt;
    DS_IO_DETAIL.NameValue(26,"ORIGIN_EVT_SAMT")  = originEvtSAmt;
    DS_IO_DETAIL.NameValue(26,"ORIGIN_SALE_TAMT") = originSaleTAmt;
    DS_IO_DETAIL.NameValue(26,"ORIGIN_PROF_TAMT") = originProfTAmt;
    DS_IO_DETAIL.NameValue(26,"ORIGIN_SALE_CRATE")= originSaleCRate;
    DS_IO_DETAIL.NameValue(26,"ORIGIN_PROF_CRATE")= originProfCRate;

    var orgNormSAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0);   //당초년정상
    var orgEvtSAmt     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0);    //당초년행사
    var orgProfTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0);   //당초년이익
    var orgSaleTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT"),0);   //당초년총매출
    
    DS_IO_DETAIL.NameValue(27,"ORG_NAME")         = "오차";
    DS_IO_DETAIL.NameValue(27,"GUBUN")            = "";
    DS_IO_DETAIL.NameValue(27,"ORIGIN_NORM_SAMT") = getRoundDec("1",orgNormSAmt,0) - getRoundDec("1",originNormSAmt,0)  ;
    DS_IO_DETAIL.NameValue(27,"ORIGIN_EVT_SAMT")  = getRoundDec("1",orgEvtSAmt,0) - getRoundDec("1",originEvtSAmt,0);
    DS_IO_DETAIL.NameValue(27,"ORIGIN_SALE_TAMT") = getRoundDec("1",orgSaleTAmt,0) - getRoundDec("1",originSaleTAmt,0);
    DS_IO_DETAIL.NameValue(27,"ORIGIN_PROF_TAMT") = getRoundDec("1",orgProfTAmt,0) - getRoundDec("1",originProfTAmt,0);


}

/**
* applyDetail()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  월별구성비로 배분
* return값 : 
*/
function applyDetail(){
   var orgNormSAmt    = getRoundDec("1",getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0)/12,0);
   var orgEvtSAmt     = getRoundDec("1",getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0)/12,0);
   var orgProfTAmt    = getRoundDec("1",getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0)/12,0);
   var bfyySaleTAmt   = 0;                                                                                            //전년매출총액
   var bfyyProfTAmt   = 0;                                                                                            //전년이익총액
   var orgSaleTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT"),0);                  //당초 총매출
   var orginSaleTAmt  = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0);                  //당초 총이익
   
   for(j=1; j <= 24; j++){
        if(DS_IO_DETAIL.NameValue(j,"GUBUN") == "전년매출"){
            bfyySaleTAmt +=  getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_SALE_TAMT"),0);    //전년총매출합계
            bfyyProfTAmt +=  getRoundDec("1",DS_IO_DETAIL.NameValue(j, "ORIGIN_PROF_TAMT"),0);    //전년이익합계
        }
    }
   
   for(i=2; i <= 24; i++){
      if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && round(DS_IO_DETAIL.NameValue(i-1,"ORIGIN_NORM_SAMT"),0) == 0){
         if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && i < 23){
            DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT") = getRoundDec("1",orgNormSAmt,0);
           }
         else{
            DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT") = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0) - getRoundDec("1",orgNormSAmt,0)*11;
            }
      }
      else{
         if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i-1,"ORIGIN_NORM_SAMT") != 0){
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT") == 0){
                   DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT") = 
                	   getRoundDec("1",getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),0)*100/getRoundDec("1",bfyySaleTAmt,0)*getRoundDec("1",orgSaleTAmt,0)/100,0) * getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_NORM_SAMT"),0)*100/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),0),0)/100,0);
               }
         }
      }
      
      if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && round(DS_IO_DETAIL.NameValue(i-1,"ORIGIN_EVT_SAMT"),0) == 0){
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && i < 23){
                DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT") = getRoundDec("1",orgEvtSAmt,0);
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT") = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0) - getRoundDec("1",orgEvtSAmt,0)*11;
            }
        }
        else{
            if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i-1,"ORIGIN_EVT_SAMT") != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT") == 0){
                    DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT") = getRoundDec("1",getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),0)*100/getRoundDec("1",bfyySaleTAmt,0)*getRoundDec("1",orgSaleTAmt,0)/100,0) * (100 - getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_NORM_SAMT"),0)*100/getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_SALE_TAMT"),0),0))/100,0);
                }
            }
        }
      
      if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && round(DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT"),0) == 0){
            if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && i < 23){
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT") = getRoundDec("1",orgProfTAmt,0);
            }
            else{
                DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT") = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0) - getRoundDec("1",orgProfTAmt,0)*11;
            }
        }
        else{
            if(DS_IO_DETAIL.NameValue(i-1,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT") != 0){
                if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표" && DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT") == 0){
                  DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT") = getRoundDec("1",getRoundDec("1",DS_IO_DETAIL.NameValue(i-1,"ORIGIN_PROF_TAMT"),0)/getRoundDec("1",bfyyProfTAmt,0)*getRoundDec("1",orginSaleTAmt,0),0) ;
                }
            }
        }
    }
   
   
    
    //당초
    var originNormSAmt    = 0;    //정상매출합계
    var originEvtSAmt     = 0;    //행사매출합계
    var originSaleTAmt    = 0;    //총매출합계
    var originProfTAmt    = 0;    //이익합계

   
    
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "당초목표"){
            originNormSAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            originEvtSAmt    += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            originSaleTAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            originProfTAmt   += getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
        }
    }
    

    var orgNormSAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0);   //당초년정상
    var orgEvtSAmt     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0);    //당초년행사
    var orgProfTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0);   //당초년이익
    var orgSaleTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT"),0);   //당초년총매출
    
    
    DS_IO_DETAIL.NameValue(24,"ORIGIN_NORM_SAMT") = getRoundDec("1",DS_IO_DETAIL.NameValue(24,"ORIGIN_NORM_SAMT"),0) + getRoundDec("1",orgNormSAmt,0) - getRoundDec("1",originNormSAmt,0)  ;
    DS_IO_DETAIL.NameValue(24,"ORIGIN_EVT_SAMT")  = getRoundDec("1",DS_IO_DETAIL.NameValue(24,"ORIGIN_EVT_SAMT"),0) + getRoundDec("1",orgEvtSAmt,0) - getRoundDec("1",originEvtSAmt,0);
    DS_IO_DETAIL.NameValue(24,"ORIGIN_SALE_TAMT") = getRoundDec("1",DS_IO_DETAIL.NameValue(24,"ORIGIN_SALE_TAMT"),0) + getRoundDec("1",orgSaleTAmt,0) - getRoundDec("1",originSaleTAmt,0);
    DS_IO_DETAIL.NameValue(24,"ORIGIN_PROF_TAMT") = getRoundDec("1",DS_IO_DETAIL.NameValue(24,"ORIGIN_PROF_TAMT"),0) + getRoundDec("1",orgProfTAmt,0) - getRoundDec("1",originProfTAmt,0);

   
}

/**
* comparecheck()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-04
* 개    요 :  당초년매출계획과 당초월매출계획 합계 비교
* return값 : 
*/
function comparecheck(){
   //당초
    var originNormSAmt    = 0;    //정상매출합계
    var originEvtSAmt     = 0;    //행사매출합계
    var originSaleTAmt    = 0;    //총매출합계
    var originProfTAmt    = 0;    //이익합계
    
    var orgNormSAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_NORM_SAMT"),0);   //당초년정상
    var orgEvtSAmt     = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_EVT_SAMT"),0);    //당초년행사
    var orgProfTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_PROF_TAMT"),0);   //당초년이익
    var orgSaleTAmt    = getRoundDec("1",DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORIGIN_SALE_TAMT"),0);   //당초년총매출
    
    for(i=1; i <= 24; i++){
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") != "전년매출"){
            originNormSAmt     =getRoundDec("1",originNormSAmt,0)+ getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_NORM_SAMT"),0);
            originEvtSAmt      =getRoundDec("1",originEvtSAmt,0)+  getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_EVT_SAMT"),0);
            originSaleTAmt     =getRoundDec("1",originSaleTAmt,0)+  getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT"),0);
            originProfTAmt     =getRoundDec("1",originProfTAmt,0)+  getRoundDec("1",DS_IO_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT"),0);
            
        }
    }
    
    if(getRoundDec("1",orgNormSAmt,0) != getRoundDec("1",originNormSAmt,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초년매출목표 정상매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgEvtSAmt,0) != getRoundDec("1",originEvtSAmt,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초년매출목표 행사매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgProfTAmt,0) != getRoundDec("1",originProfTAmt,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초년매출목표 이익과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    if(getRoundDec("1",orgSaleTAmt,0) != getRoundDec("1",originSaleTAmt,0) ){
        showMessage(INFORMATION, OK, "USER-1000", "당초년매출목표 총매출과 일치하지 않습니다. 확인하여 주십시오.");
        return false;
    }
    return true;
}

/**
* checkChange()
* 작 성 자 : 박종은
* 작 성 일 : 2010-03-07
* 개    요 :  마스터의 팀, 파트 코드와 디테일 내역의 팀, 파트 비교하여 틀리면 마스터의 팀, 파트코드로 변경
* return값 : 
*/
function checkChange(){
    var strDeptCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "DEPT_CD");          //팀
    var strTeamCd      = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "TEAM_CD");          //파트
    var strOrgName     = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition, "ORG_NAME");         //파트명
    
    for(i=1; i<= 24;i++){
    	/*
        DS_IO_DETAIL.NameValue(i, "DEPT_CD")  = strDeptCd;
        DS_IO_DETAIL.NameValue(i, "TEAM_CD")  = strTeamCd;
        DS_IO_DETAIL.NameValue(i, "ORG_NAME") = strOrgName;
        */
        if(DS_IO_DETAIL.NameValue(i, "DEPT_CD")  != strDeptCd 
           || DS_IO_DETAIL.NameValue(i, "TEAM_CD")  != strTeamCd
           || DS_IO_DETAIL.NameValue(i, "ORG_NAME") != strOrgName){
    	       DS_IO_DETAIL.NameValue(i, "ERROR_CHECK")  = "true";
        }
    }
}


/**
* searchBFYY()
* 작 성 자 : 박종은
* 작 성 일 : 2010.03.21
* 개     요 : 전년실적 조회
* return값 :
*/
function searchBFYY(){
    var j = 0;
  
    for(i=1; i <= DS_IO_DETAIL.CountRow; i++){
        j = i;
        if(DS_IO_DETAIL.NameValue(i,"GUBUN") == "전년매출" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "합계" && 
        		DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "" && DS_IO_DETAIL.NameValue(i,"ORG_NAME") != "오차" ){
        	
	        var strStrCd        = DS_O_MASTER.NameValue(DS_O_MASTER.RowPosition,"STR_CD");         //점
	        var strDeptCd       = DS_IO_DETAIL.NameValue(i,"DEPT_CD");        //팀
	        var strTeamCd       = DS_IO_DETAIL.NameValue(i,"TEAM_CD");        //파트
	        var strPlanYm       = DS_IO_DETAIL.NameValue(i,"PLAN_YM");        //년도
	        

	        if(strStrCd == "" || strDeptCd == "" || strTeamCd == "" || strPlanYm == "" ) {
	            showMessage(INFORMATION, OK, "USER-1000", "데이터 중 공백인 데이터가 있습니다. 확인하여 주십시오.");
	            //DS_IO_DETAIL_ORG.DeleteRow(i);
	            break;
	        }
	        var goTo       = "searchBFYY" ;    
	        var action     = "O";     
	        var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
	                       + "&strDeptCd="          +encodeURIComponent(strDeptCd)
	                       + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                           + "&strPlanYm="          +encodeURIComponent(strPlanYm);
	        
	        TR_MAIN.Action="/dps/psal103.ps?goTo="+goTo+parameters;  
	        TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_BFYY=DS_IO_BFYY)"; 
	        TR_MAIN.Post();
	        
	        i = j;
	        
	        if(DS_IO_BFYY.CountRow > 0){
	        	DS_IO_DETAIL.NameValue(i, "BFYY_NORM_SAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_NORM_SAMT");
	        	DS_IO_DETAIL.NameValue(i, "BFYY_EVT_SAMT")   = DS_IO_BFYY.NameValue(0,"BFYY_EVT_SAMT");
	        	DS_IO_DETAIL.NameValue(i, "BFYY_SALE_TAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_SALE_TAMT");
	        	DS_IO_DETAIL.NameValue(i, "BFYY_PROF_TAMT")  = DS_IO_BFYY.NameValue(0,"BFYY_PROF_TAMT");
	        	DS_IO_DETAIL.NameValue(i, "BFYY_SALE_CRATE") = DS_IO_BFYY.NameValue(0,"BFYY_SALE_CRATE");
	        	DS_IO_DETAIL.NameValue(i, "BFYY_PROF_CRATE") = DS_IO_BFYY.NameValue(0,"BFYY_PROF_CRATE");
	        }
	        else{
	        	DS_IO_DETAIL.NameValue(i, "BFYY_NORM_SAMT")  = 0;
	        	DS_IO_DETAIL.NameValue(i, "BFYY_EVT_SAMT")   = 0;
	        	DS_IO_DETAIL.NameValue(i, "BFYY_SALE_TAMT")  = 0;
	        	DS_IO_DETAIL.NameValue(i, "BFYY_PROF_TAMT")  = 0;
	        	DS_IO_DETAIL.NameValue(i, "BFYY_SALE_CRATE") = 0;
	        	DS_IO_DETAIL.NameValue(i, "BFYY_PROF_CRATE") = 0;
	        }
        }
    }
  
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
<!--------------------- 1. TR Success 메세지 처리  ---------------------------->
<script language=JavaScript for=TR_DETAIL event=onSuccess>
    for(i=0;i<TR_DETAIL.SrvErrCount('UserMsg');i++) {
        showMessage(INFORMATION, OK, "USER-1000", TR_DETAIL.SrvErrMsg('UserMsg',i));
    }
</script>

<!--------------------- 2. TR Fail 메세지 처리  ------------------------------->
<script language=JavaScript for=TR_DETAIL event=onFail>
    trFailed(TR_DETAIL.ErrorMsg);
</script>
<!--------------------- 3. Excelupload  --------------------------------------->
<comment id="_NSID_">
<object id=INF_EXCELUPLOAD classid=<%=Util.CLSID_INPUTFILE%>
   style="position: absolute; left: 355px; top: 55px; width: 110px; height: 23px; visibility: hidden;">
   <param name="Text" value='FileOpen'>
   <param name="Enable" value="true">
</object>
</comment>
<script>_ws_(_NSID_);</script>

<!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
<!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
<!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
<!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>
<!-- Grid GD_DETAIL OnExit event 처리 -->
<script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>

if(row <= 0 ){
    setFocusGrid(GD_MASTER, DS_O_MASTER,row,colid);
    sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
}
  
</script>

<script language=JavaScript for=DS_O_MASTER event=OnRowPosChanged(row)>

    if(row > 0 && old_Row != row){
    	//저장되지 않은 내용이 있을경우 경고
    	
        if (DS_IO_DETAIL.IsUpdated ){
        	ret = showMessage(QUESTION, YESNO, "USER-1074");
            if (ret != "1") {
            	DS_O_MASTER.RowPosition = old_Row;
                return false;
            } 
        }
    	
        searchDetail();
    }
    old_Row = row;
    
</script>

<script language="javascript">
    var lOption = 0;
    var szTitle, szTitle2, szTitle3;
    var szName = "Sheet Name";
    var szPath = "C:\\Test\\Test";
    var today    = new Date();
    var chk_grid1 = 0;
    var errchk_flag = 0;
    var errcnt = 0;
    var errorRow = "";
    var errorRowS = "";
    var old_Row = 0;
     
</script>
<!-- 점(조회)  변경시  -->
<script language=JavaScript for=LC_STR_CD event=OnSelChange()>
    getDept("DS_DEPT_CD", "Y", LC_STR_CD.BindColVal, "N");                                              // 팀 
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트  
    LC_DEPT_CD.Index = 0;
    LC_TEAM_CD.Index = 0;
</script>

<!-- 팀(조회)  변경시  -->
<script language=JavaScript for=LC_DEPT_CD event=OnSelChange()>
    getTeam("DS_TEAM_CD", "Y", LC_STR_CD.BindColVal, LC_DEPT_CD.BindColVal, "Y");                       // 파트   
    LC_TEAM_CD.Index = 0;
</script>

<script language=JavaScript for=DS_O_MASTER
   event=onColumnChanged(Row,Colid)>
old_Row = Row
</script>

<script language=Javascript for=GD_DETAIL
   event=OnExit(row,colid,olddata)>

   switch (colid) {
   case "TEAM_CD" :
      if(olddata != DS_O_MASTER.NameValue(row,"TEAM_CD")){
           for(i=1; i <= DS_STR_CD_I.CountRow; i++){
            if(DS_IO_DETAIL.NameValue(row,"TEAM_CD") == DS_STR_CD_I.ColumnValue(i,1) ){
               DS_IO_DETAIL.NameValue(row,"ORG_NAME") = DS_STR_CD_I.ColumnValue(i,2);
            }
           }
      }
        break;
   case "ORIGIN_NORM_SAMT" :
       if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_NORM_SAMT") ){
           changecolumn();
           change_ln_sum();
       }
       
       break;
   case "ORIGIN_EVT_SAMT" :
      if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_EVT_SAMT") ){
            changecolumn();
            change_ln_sum();
        }
       break;
   case "ORIGIN_PROF_TAMT" :
      if(olddata != DS_IO_DETAIL.NameValue(row,"ORIGIN_PROF_TAMT") ){
            changecolumn();
            change_ln_sum();
        }
       break;
   default:
       break;
   
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
<object id="DS_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
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

<!-- ===============- Output용 -->
<comment id="_NSID_">
<object id="DS_O_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_IO_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_DETAIL_ORG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_IO_BFYY" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKORGMST" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_CHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_MCHKCONFFLAG" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_STR_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_DEPT_CD" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>
<comment id="_NSID_">
<object id="DS_O_TEAM_CD" classid=<%=Util.CLSID_DATASET%>></object>
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
<!--*************************************************************************-->
<!--* D. 가우스 DataSet & Transaction 정의 끝                                                                                        *-->
<!--*************************************************************************-->
<!-- Master 그리드 세로크기자동조정  2013-07-17 -->
<script language='javascript'>
window.onresize = function(){
	
    var obj   = document.getElementById("GD_DETAIL");
    
    var grd_height = 0;
    
    
    if((parseInt(window.document.body.clientHeight)-top) <= top) {
    	grd_height = top+300;    	
    } else {
    	grd_height = (parseInt(window.document.body.clientHeight)-top);
    }
    obj.style.height  = grd_height + "px";
}
</script>

<!--*************************************************************************-->
<!--* E. 본문시작                                                                                                                                                               *-->
<!--*************************************************************************-->
<body onLoad="doInit();" class="PL10 PT15 ">

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
            <table width="100%" border="0" cellpadding="0" cellspacing="0"
               class="s_table">
               <tr>
                  <th width="80" class="point">점</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_STR_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" class="point">팀</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_DEPT_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80">파트</th>
                  <td width="110"><comment id="_NSID_"> <object
                     id=LC_TEAM_CD classid=<%=Util.CLSID_LUXECOMBO%> width=100 tabindex=1 
                     align="absmiddle"> </object> </comment><script>_ws_(_NSID_);</script></td>
                  <th width="80" class="point">목표년도</th>
                  <td><comment id="_NSID_"> <object
                     id=EM_PLAN_YEAR classid=<%=Util.CLSID_EMEDIT%> width=80
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
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%"><comment id="_NSID_"> <object
                     id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_O_MASTER">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
               </tr>
            </table>
            </td>
         </tr>
      </table>
      </td>
   </tr>

   <tr>
      <td class="right PB03 PT03">
      <table width="160" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <th><img src="/<%=dir%>/imgs/btn/excel_s.gif"
               onclick="loadExcelData();" align="absmiddle" /></th>
            <th><img src="/<%=dir%>/imgs/btn/excel_down.gif"
               onclick="ExcelDownData();" align="absmiddle" /></th>
         </tr>
      </table>
      </td>
   </tr>
   <tr valign="top" >
      <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
         <tr valign="top">
            <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0"
               class="BD4A">
               <tr>
                  <td width="100%">
                  <div style="display:none;">
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL_ORG width=100% height=230 classid=<%=Util.CLSID_GRID%>> 
                     <param name="DataID" value="DS_IO_DETAIL_ORG">
                  </object> </comment><script>_ws_(_NSID_);</script>
                  </div>
                  <comment id="_NSID_"> <object
                     id=GD_DETAIL width=100% height=293 classid=<%=Util.CLSID_GRID%>>
                     <param name="DataID" value="DS_IO_DETAIL">
                  </object> </comment><script>_ws_(_NSID_);</script></td>
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
