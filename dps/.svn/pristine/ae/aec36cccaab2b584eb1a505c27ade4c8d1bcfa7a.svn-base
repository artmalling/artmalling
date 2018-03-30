<!-- 
/*******************************************************************************
 * 시스템명 : 백화점 영업 > 매출관리 > 당초계획
 * 작 성 일 : 2010.03.07
 * 작 성 자 : 박종은
 * 수 정 자 : 
 * 파 일 명 : psal1060.jsp
 * 버    전 : 1.0 (버전은 1.0부터 시작하며 0.1씩 증가)
 * 개    요 : 당초파트별년매출계획확정
 * 이    력 :2010.03.07 박종은
 * 
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
<script language="javascript"  src="/<%=dir%>/js/popup_mss.js" type="text/javascript"></script>
<script language="javascript"  src="/<%=dir%>/js/popup_dcs.js" type="text/javascript"></script>

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
    DS_IO_MASTER.setDataHeader('<gauce:dataset name="H_SEL_MASTER"/>');
    DS_O_DETAIL.setDataHeader('<gauce:dataset name="H_SEL_DETAIL"/>');

    //그리드 초기화
    gridCreate1(); //마스터
    gridCreate2(); //디테일
    

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

    //현재년도 셋팅
    EM_PLAN_YEAR.text = today.getYear();
    GD_MASTER.Focus();
    LC_STR_CD.Focus();

    registerUsingDataset("psal106","DS_IO_MASTER,DS_O_DETAIL" );

}

function gridCreate1(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30     align=center     </FC>'
			    	 + '<FC>id=CONF_FLAG               name="선택"              width=50     align=center   EditStyle=CheckBox HeadCheck=false HeadCheckShow=true</FC>'
			         + '<FC>id=STR_CD                  name="점"           width=40     align=center     Edit=none    show=true</FC>'
			    	 + '<FC>id=STR_NAME                name="점명"               width=70     align=left      Edit=none   </FC>'
                     + '<FC>id=DEPT_CD                 name="팀"         width=40     align=center     Edit=none    show=false</FC>'
			         + '<FC>id=TEAM_CD                 name="파트"           width=40     align=center     Edit=none    show=true</FC>'
			         + '<FC>id=ORG_NAME                name="파트명"         width=90     align=left       Edit=none    SumText="합계"</FC>'
			         + '<FC>id=PLAN_YEAR               name="목표년도"           width=100    align=left      Edit=none   show=false</FC>'
                     + '<FC>id=CONF_DT                 name="확정일자"           width=80    align=center   Edit=Numeric Mask="XXXX/XX/XX"   EditStyle=Popup  </FC>'
                     + '<FG>                            name="파트별월매출목표합계"'
                     + '<C>id=ORIGIN_NORM_SAMT_TOT     name="정상매출"     width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_NORM_SAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_EVT_SAMT_TOT      name="행사매출"     width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_EVT_SAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_SALE_TAMT_TOT     name="총매출"       width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_SALE_TAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_PROF_TAMT_TOT     name="이익"         width=100     align=right      Edit=none      SumText={SubSum(ORIGIN_PROF_TAMT_TOT)}</C>'
                     + '<C>id=ORIGIN_SALE_CRATE_TOT    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_TOT    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</FG>'                          
                     + '<FG>                            name="1월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JAN     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JAN      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JAN     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JAN)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JAN     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JAN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JAN    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JAN    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JAN    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JAN    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="2월"'
                     + '<C>id=ORIGIN_NORM_SAMT_FEB     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_FEB      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_FEB     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_FEB)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_FEB     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_FEB)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_FEB    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_FEB    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_FEB    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_FEB    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="3월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAR     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAR      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAR     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_MAR)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAR     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_MAR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAR    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAR    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_MAR    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_MAR    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="4월"'
                     + '<C>id=ORIGIN_NORM_SAMT_APR     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_APR      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_APR     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_APR)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_APR     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_APR)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_APR    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_APR    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_APR    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_APR    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="5월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAY     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAY      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAY     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_MAY)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAY     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_MAY)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAY    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAY    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_MAY    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_MAY    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="6월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUN     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUN      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUN     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JUN)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUN     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JUN)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUN    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUN    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JUN    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JUN    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="7월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUL     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUL      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUL     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_JUL)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUL     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_JUL)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUL    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUL    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_JUL    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_JUL    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="8월"'
                     + '<C>id=ORIGIN_NORM_SAMT_AUG     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_AUG      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_AUG     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_AUG)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_AUG     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_AUG)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_AUG    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_AUG    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_AUG    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_AUG    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="9월"'
                     + '<C>id=ORIGIN_NORM_SAMT_SEP     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_SEP      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_SEP     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_SEP)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_SEP     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_SEP)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_SEP    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_SEP    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_SEP    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_SEP    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="10월"'
                     + '<C>id=ORIGIN_NORM_SAMT_OCT     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_OCT)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_OCT      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_OCT)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_OCT     name="총매출"       width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT_OCT)}     Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_OCT     name="이익"         width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT_OCT)}     Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_OCT    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_OCT    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_OCT    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_OCT    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                                  
                     + '<FG>                            name="11월"'
                     + '<C>id=ORIGIN_NORM_SAMT_NOV     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_NOV)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_NOV      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_NOV)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_NOV     name="총매출"       width=100     align=right     SumText={SubSum(ORIGIN_SALE_TAMT_NOV)}     Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_NOV     name="이익"         width=100     align=right     SumText={SubSum(ORIGIN_PROF_TAMT_NOV)}     Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_NOV    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_NOV    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_NOV    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_NOV    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                          
                     + '<FG>                            name="12월"'
                     + '<C>id=ORIGIN_NORM_SAMT_DEC     name="정상매출"     width=100     align=right      SumText={SubSum(ORIGIN_NORM_SAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_DEC      name="행사매출"     width=100     align=right      SumText={SubSum(ORIGIN_EVT_SAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_DEC     name="총매출"       width=100     align=right      SumText={SubSum(ORIGIN_SALE_TAMT_DEC)}    Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_DEC     name="이익"         width=100     align=right      SumText={SubSum(ORIGIN_PROF_TAMT_DEC)}    Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_DEC    name="매출구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_DEC    name="이익구성비"   width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_SALE_IRATE_DEC    name="매출신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '<C>id=ORIGIN_PROF_IRATE_DEC    name="이익신장율"   width=80     align=right      Dec=2        Edit=none    show=false </C>'
                     + '</FG>'                                                           
                     ;
                    

    initGridStyle(GD_MASTER, "common", hdrProperies, true);
    GD_MASTER.ViewSummary = "1";
    GD_MASTER.DecRealData = true;
}

function gridCreate2(){
    var hdrProperies = '<FC>id={currow}                name="NO"           width=30     align=center     BgColor={decode(ERROR_CHECK,"","white","yellow")} </FC>'
                     + '<FC>id=PC_CD                   name="PC"           width=40     align=center     Edit=none    Suppress="1" </FC>'
                     + '<FC>id=ORG_NAME                name="PC명"         width=90     align=left       Edit=none    Suppress="1" </FC>'
                     + '<FC>id=GUBUN                   name="구분"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=70     align=center     Edit=none    </FC>'
                     + '<G>                            name="PC별월매출목표합계"'
                     + '<C>id=ORIGIN_NORM_SAMT_TOT     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_TOT      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_TOT     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_TOT     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_TOT    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_TOT    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="1월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JAN     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JAN      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JAN     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JAN     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JAN    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JAN    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="2월"'
                     + '<C>id=ORIGIN_NORM_SAMT_FEB     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_FEB      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_FEB     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_FEB     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_FEB    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_FEB    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="3월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAR     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAR      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAR     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAR     name="이익"        textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAR    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAR    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="4월"'
                     + '<C>id=ORIGIN_NORM_SAMT_APR     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_APR      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_APR     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_APR     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_APR    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_APR    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="5월"'
                     + '<C>id=ORIGIN_NORM_SAMT_MAY     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_MAY      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_MAY     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_MAY     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_MAY    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_MAY    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="6월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUN     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUN      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUN     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUN     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUN    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUN    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="7월"'
                     + '<C>id=ORIGIN_NORM_SAMT_JUL     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_JUL      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_JUL     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_JUL     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_JUL    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_JUL    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="8월"'
                     + '<C>id=ORIGIN_NORM_SAMT_AUG     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_AUG      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_AUG     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_AUG     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_AUG    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_AUG    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="9월"'
                     + '<C>id=ORIGIN_NORM_SAMT_SEP     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_SEP      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_SEP     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_SEP     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_SEP    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_SEP    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="10월"'
                     + '<C>id=ORIGIN_NORM_SAMT_OCT     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_OCT      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_OCT     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_OCT     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_OCT    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_OCT    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                                  
                     + '<G>                            name="11월"'
                     + '<C>id=ORIGIN_NORM_SAMT_NOV     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_NOV      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_NOV     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_NOV     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_NOV    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_NOV    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                          
                     + '<G>                            name="12월"'
                     + '<C>id=ORIGIN_NORM_SAMT_DEC     name="정상매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_EVT_SAMT_DEC      name="행사매출"     textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_TAMT_DEC     name="총매출"       textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_TAMT_DEC     name="이익"         textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=100     align=right      Edit=none      </C>'
                     + '<C>id=ORIGIN_SALE_CRATE_DEC    name="매출구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '<C>id=ORIGIN_PROF_CRATE_DEC    name="이익구성비"   textcolor={if(GUBUN="전년매출" AND PC_CD <> "","lightblue","#3a3a3a")}    width=80     align=right      Dec=2        Edit=none    </C>'
                     + '</G>'                                                           
                     ;
                    

    initGridStyle(GD_DETAIL, "common", hdrProperies, false);
   
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
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-02
 * 개    요 : 조회시 호출
 * return값 : void
 */
function btn_Search() {

    //저장되지 않은 내용이 있을경우 경고
    if (DS_IO_MASTER.IsUpdated) {
        ret = showMessage(QUESTION, YESNO, "USER-1084");
        if (ret != "1") {
            return false;
        } 
    }
        
    searchChk = "S";
    
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
    DS_IO_MASTER.ClearData();
    DS_O_DETAIL.ClearData();
    

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
     
    TR_MAIN.Action="/dps/psal106.ps?goTo="+goTo+parameters;  
    TR_MAIN.KeyValue="SERVLET("+action+":DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
    TR_MAIN.Post();

    //확정된 내역은 확정일자 수정 불가능
    if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
        GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
    }
    else{
        GD_MASTER.ColumnProp("CONF_DT","Edit")="";
    }
    
    GD_MASTER.ColumnProp('CONF_FLAG','HeadCheck')= "false";

    // 조회결과 Return
    setPorcCount("SELECT", DS_IO_MASTER.CountRow);
    
    //스크롤바 위치 조정
    GD_MASTER.SETVSCROLLING(0);
    GD_MASTER.SETHSCROLLING(0);
    GD_MASTER.Focus();
}

/**
 * btn_New()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_New() {
	
	
}

/**
 * btn_Delete()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Delete() {

}

/**
 * btn_Save()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개    요 : DB에 저장 / 수정 / 삭제 처리
 * return값 : void
 */
function btn_Save() {
    
}

/**
 * btn_Excel()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Excel() {

}

/**
 * btn_Print()
 * 작 성 자 : 
 * 작 성 일 : 
 * 개     요 : 
 * return값 : void
 */
function btn_Print() {
     
}

/**
 * btn_Conf()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-02
 * 개    요 : 확정, 확정취소 처리
 * return값 : void
 */

 function btn_Conf() {
     if (!DS_IO_MASTER.IsUpdated ){
         //저장할 내용이 없습니다
         showMessage(INFORMATION, OK, "USER-1000","확정할 데이터가 없습니다.");
         return;
     }
     //체크
     if(!chkValidation()) return;
     
     
     if( showMessage(QUESTION, YESNO, "USER-1000", "확정 또는 확정취소 하시겠습니까?") != 1 )
         return;
     
     TR_MAIN.Action="/dps/psal106.ps?goTo=save";
     TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
     TR_MAIN.Post();

     // 정상 처리일 경우 조회
     if( TR_MAIN.ErrorCode == 0){
         btn_Search();
     }
 }

 /**
 * searchDetail()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-02
 * 개    요 :  상세내역 조회
 * return값 : void
 */
 function searchDetail(){
     
     DS_O_DETAIL.ClearData();

     var strStrCd        = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "STR_CD");           //점
     var strDeptCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "DEPT_CD");          //팀
     var strTeamCd       = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "TEAM_CD");          //파트
     var strPlanYear     = DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition, "PLAN_YEAR");        //계획년도
 
     var goTo       = "searchDetail" ;    
     var action     = "O";     
     var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
		            + "&strDeptCd="            +encodeURIComponent(strDeptCd)
		            + "&strTeamCd="            +encodeURIComponent(strTeamCd)
		            + "&strPlanYear="          +encodeURIComponent(strPlanYear);
     
     TR_DETAIL.Action="/dps/psal106.ps?goTo="+goTo+parameters;  
     TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL=DS_O_DETAIL)"; //조회는 O
     TR_DETAIL.Post();
     

     var bfyySaleTamt = 0;
     var originSaleTamt = 0;
     var bfyyProfTamt = 0;
     var originProfTamt = 0;
     
     for(i=1; i <= DS_O_DETAIL.CountRow;i++){
    	 if(DS_O_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
    	     bfyySaleTamt   += getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
    	     bfyyProfTamt   += getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
    	 }
    	 else{
    	     originSaleTamt += getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT"),0);
    	     originProfTamt += getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT"),0);
    	 }
     }

     for(i=1; i <= DS_O_DETAIL.CountRow;i++){
         if(DS_O_DETAIL.NameValue(i,"GUBUN") == "전년매출"){
        	 DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT")  = getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT")/bfyySaleTamt*100,2);
        	 DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT")  = getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT")/bfyyProfTamt*100,2);
         }
         else{
        	 DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_CRATE_TOT")  = getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_SALE_TAMT_TOT")/originSaleTamt*100,2);
        	 DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_CRATE_TOT")  = getRoundDec("1",DS_O_DETAIL.NameValue(i,"ORIGIN_PROF_TAMT_TOT")/originProfTamt*100,2);
         }
     }
     DS_O_DETAIL.ResetStatus();
     
     GD_MASTER.Editable = true;
     if(DS_O_DETAIL.CountRow == 0){
         GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         GD_MASTER.Editable = false;
         
     }
     else{
         if(DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
             GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         }
         else{
           if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
                 GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
             }
             else{
                 GD_MASTER.ColumnProp("CONF_DT","Edit")="";
             }
         }
         GD_MASTER.Editable = true;
     } 
     
     
     if(DS_IO_MASTER.RowStatus(DS_IO_MASTER.RowPosition) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
         GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         searchChk = "A";
     }
     else{
    	 if(searchChk == "S" && DS_O_DETAIL.CountRow != 0 ){
             GD_MASTER.ColumnProp("CONF_DT","Edit")="";
             searchChk = "A";
    	 }
    	 else{
    		 searchChk = "A";
    	 }
     }
     //스크롤바 위치 조정
     GD_DETAIL.SETVSCROLLING(0);
     GD_DETAIL.SETHSCROLLING(0);
     GD_DETAIL.Focus();

     // 조회결과 Return
     setPorcCount("SELECT", DS_O_DETAIL.CountRow);
 }

 /*************************************************************************
  * 3. 함수
  *************************************************************************/

/**
 * chkValidation()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkValidation(){

    //상,하위 데이터 있을시 확정취소 안됨
    for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){
        if(DS_IO_MASTER.RowStatus(j) != 0) {
        	var strStrCd        = DS_IO_MASTER.NameValue(j, "STR_CD");           //점
            var strDeptCd       = DS_IO_MASTER.NameValue(j, "DEPT_CD");          //팀
            var strTeamCd       = DS_IO_MASTER.NameValue(j, "TEAM_CD");          //파트
            var strPlanYear     = DS_IO_MASTER.NameValue(j, "PLAN_YEAR");        //계획년도
            

            //상위데이터 체크
            var goTo       = "searchTeam" ;    
            var action     = "O";     
            var parameters = "&strStrCd="           +encodeURIComponent(strStrCd)
                           + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                           + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                           + "&strPlanYear="        +encodeURIComponent(strPlanYear);
            
            TR_MAIN.Action="/dps/psal106.ps?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_TEAM=DS_O_TEAM)"; //조회는 O
            TR_MAIN.Post();
            
            if(DS_O_TEAM.CountRow == 0){
                    showMessage(INFORMATION, OK, "USER-1000","당초파트별월매출목표가  미확정되있습니다. 확정 후 등록하십시오.");
                    //변경된 데이터 원상복귀
                    var ColCnt = DS_IO_MASTER.CountColumn;
                    for(m=1; m <= DS_IO_MASTER.CountRow; m++ ){
                        for( var k=1; k<=ColCnt;k++){
                            if(DS_IO_MASTER.RWStatus(m,k) != 0)
                                DS_IO_MASTER.NameValue( m, DS_IO_MASTER.ColumnID(k)) = DS_IO_MASTER.OrgNameValue(m,DS_IO_MASTER.ColumnID(k));
                        }
                    }
                    return false;
            }
            
            goTo           = "searchPumbun" ;    
            action         = "O";     
            parameters     = "&strStrCd="           +encodeURIComponent(strStrCd)
                           + "&strDeptCd="          +encodeURIComponent(strDeptCd)
                           + "&strTeamCd="          +encodeURIComponent(strTeamCd)
                           + "&strPlanYear="        +encodeURIComponent(strPlanYear);
            
            TR_MAIN.Action="/dps/psal106.ps?goTo="+goTo+parameters;  
            TR_MAIN.KeyValue="SERVLET("+action+":DS_O_PUMBUN=DS_O_PUMBUN)"; //조회는 O
            TR_MAIN.Post();
            
            var confFlagCnt = 0;
            
            if(DS_O_PUMBUN.CountRow != 0){
                for(i=1; i <= DS_O_PUMBUN.CountRow;i++){
                    if(DS_O_PUMBUN.NameValue(i,"CONF_FLAG") == "Y"){
                        confFlagCnt++;
                    }
                }
                if(confFlagCnt > 0){
                    showMessage(INFORMATION, OK, "USER-1000","하위데이터가 확정되있습니다. 하위데이터 확정 취소 후 등록하십시오.");
                    //변경된 데이터 원상복귀
                    var ColCnt = DS_IO_MASTER.CountColumn;
                    for(m=1; m <= DS_IO_MASTER.CountRow; m++ ){
                        for( var k=1; k<=ColCnt;k++){
                            if(DS_IO_MASTER.RWStatus(m,k) != 0)
                                DS_IO_MASTER.NameValue( m, DS_IO_MASTER.ColumnID(k)) = DS_IO_MASTER.OrgNameValue(m,DS_IO_MASTER.ColumnID(k));
                        }
                    }
                    return false;
                }
                
            }
            
            //확정체크 체크
            if(DS_IO_MASTER.OrgNameValue(j,"CONF_DT") != DS_IO_MASTER.NameValue(j,"CONF_DT") && DS_IO_MASTER.OrgNamevalue(j,"CHK_FLAG") =="F" && DS_IO_MASTER.Namevalue(j,"CHK_FLAG") =="F"   ){
                showMessage(INFORMATION, OK, "USER-1000","확정 체크하셔야 합니다.");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"STR_CD");
                return false;
            }
        }
    }
    
    

    //데이터 길이 체크
    for(j=1; j <= DS_IO_MASTER.CountRow; j++ ){
        if(DS_IO_MASTER.NameValue(j, "CONF_FLAG") == "T" && DS_IO_MASTER.RowStatus(j) != 0){
            if(DS_IO_MASTER.NameValue(j, "CONF_DT") == ""){
                showMessage(INFORMATION, OK, "USER-1003","확정일자");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
            if(DS_IO_MASTER.NameValue(j, "CONF_DT").replace(" ","").length != 8){
                showMessage(INFORMATION, OK, "USER-1027","확정일자","8");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
            if(DS_IO_MASTER.NameValue(j, "CONF_DT") < varToday  && DS_IO_MASTER.RowStatus(i) != 0){
                showMessage(INFORMATION, OK, "USER-1020","확정일자", "당일");
                setFocusGrid(GD_MASTER, DS_IO_MASTER,j,"CONF_DT");
                return false;
            }
        }
    }
    return true;
}
 
/**
 * chkSave()
 * 작 성 자 : 박종은
 * 작 성 일 : 2010-03-14
 * 개    요 :  저장
 * return값 : void
 */
function chkSave(){
	if(!chkValidation()) return;
	   
	TR_MAIN.Action="/dps/psal106.ps?goTo=save";
	TR_MAIN.KeyValue="SERVLET(I:DS_IO_MASTER=DS_IO_MASTER)"; //조회는 O
	TR_MAIN.Post();
	     
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

 <!--------------------- 3. DataSet Success 메세지 처리  ----------------------->
 <!--------------------- 4. DataSet Fail 메세지 처리  -------------------------->
 <!--------------------- 5. DataSet 이벤트 처리  ------------------------------->
 <!--------------------- 6. 컴포넌트 이벤트 처리  ------------------------------>

 <!-- Grid GD_MASTER OnPopup event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnPopup(row,colid,data)>
    switch (colid) {
    case "CONF_DT" :
        openCal(GD_MASTER, row, colid);   //그리드 달력 
        break;
    }
     
 </script>

 <!-- Grid GD_MASTER OnClick event 처리 -->
 <script language=JavaScript for=GD_MASTER event=OnClick(row,colid)>
 if(row > 0){  
     if(DS_O_DETAIL.CountRow == 0){
    	 GD_MASTER.ReDraw = "false";
         GD_MASTER.Editable = false;
         GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F"
         DS_IO_MASTER.NameValue(row,"CONF_DT") = "";
         GD_MASTER.ReDraw = "true";
     }
     else{
         if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
             GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         }
         else{
             GD_MASTER.ColumnProp("CONF_DT","Edit")="";
         }
         
     } 
 } 
 else{
	 setFocusGrid(GD_MASTER, DS_IO_MASTER,0,colid);
	 sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
 }

 GD_MASTER.Editable = true;


 </script>

<script language=JavaScript for=GD_MASTER event=OnExit(row,colid)>
		
    if(colid == "CONF_DT") {
    	if(DS_IO_MASTER.Namevalue(row,"CONF_FLAG") == "T" ){
	    	if(!checkDateTypeYMD(this,colid,'')){
	        	setTimeout("setFocusGrid(GD_MASTER,DS_IO_MASTER,"+row+",'"+colid+"');",50);
	            return false;
	        }
    	}
	}
</script>

<script language=JavaScript for=GD_DETAIL event=OnClick(row,colid)>
    //sortColId( eval(this.DataID), row, colid); //헤더 클릭시 정렬
</script>
 <script language=JavaScript for=DS_IO_MASTER event=OnRowPosChanged(row)>

 if(row > 0  && old_Row >0 ){
     searchDetail();
 }

 if(DS_IO_MASTER.NameValue(row, "CHK_FLAG") == "F" && DS_IO_MASTER.RowStatus(row) == 0){
     setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
 }
 else{
     setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
 }
 if(row > 0 && old_Row >0){  
     if(DS_O_DETAIL.CountRow == 0 && DS_IO_MASTER.RowStatus(row) == 0){
    	 GD_MASTER.ReDraw = "false";
         GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
         DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") = "F"
         DS_IO_MASTER.NameValue(row,"CONF_DT") = "";
         setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
         GD_MASTER.ReDraw = "true";
     }
     else{
         if(DS_IO_MASTER.RowStatus(row) == 0 && DS_IO_MASTER.NameValue(DS_IO_MASTER.RowPosition,"CONF_FLAG") == "T"){
             GD_MASTER.ColumnProp("CONF_DT","Edit")="None";
             setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
         }
         else{
             GD_MASTER.ColumnProp("CONF_DT","Edit")="";
             setFocusGrid(GD_MASTER, DS_IO_MASTER,row,"STR_CD");
         }
         
     } 
 } 
 old_Row = row;

 </script>


 <script language="javascript">
 var today    = new Date();
 var old_Row = 0;
 var searchChk = "";

//오늘 일자 셋팅 
var now = new Date();
var mon = now.getMonth()+1;
if(mon < 10)mon = "0" + mon;
var day = now.getDate();
if(day < 10)day = "0" + day;
var varToday = now.getYear().toString()+ mon + day;
 </script>

 <script language=JavaScript for=DS_IO_MASTER
     event=onColumnChanged(Row,Colid)>
 old_Row = Row

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
 

<script language="javascript"  for=GD_MASTER event=OnHeadCheckClick(Col,Colid,bCheck)>

    var j = 0;

    if(bCheck == "1"){
        for(i=1; i <= DS_IO_MASTER.CountRow; i++){
        	
        	j = i;

            var strStrCd        = DS_IO_MASTER.NameValue(i, "STR_CD");           //점
            var strDeptCd       = DS_IO_MASTER.NameValue(i, "DEPT_CD");          //팀
            var strTeamCd       = DS_IO_MASTER.NameValue(i, "TEAM_CD");          //파트
            var strPlanYear     = DS_IO_MASTER.NameValue(i, "PLAN_YEAR");        //계획년도
        
            var goTo       = "searchDetailCheck" ;    
            var action     = "O";     
            var parameters = "&strStrCd="             +encodeURIComponent(strStrCd)
                           + "&strDeptCd="            +encodeURIComponent(strDeptCd)
                           + "&strTeamCd="            +encodeURIComponent(strTeamCd)
                           + "&strPlanYear="          +encodeURIComponent(strPlanYear);
            
            TR_DETAIL.Action="/dps/psal106.ps?goTo="+goTo+parameters;  
            TR_DETAIL.KeyValue="SERVLET("+action+":DS_O_DETAIL_CHK=DS_O_DETAIL_CHK)"; //조회는 O
            TR_DETAIL.Post();           
            
            i = j;
            if(DS_O_DETAIL_CHK.CountRow == 0){
            	DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "F";
            }
            else{
            	DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "T";	
            }
            
        }
    }
    else{
        for(i=1; i <= DS_IO_MASTER.CountRow; i++){
            DS_IO_MASTER.NameValue(i,"CONF_FLAG") = "F";
        }
    }
    GD_MASTER.Editable = false;
    old_Row = 1;
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
<comment id="_NSID_">
<object id="DS_O_PUMBUN" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_TEAM" classid=<%=Util.CLSID_DATASET%>></object>
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
<object id="DS_IO_MASTER" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_O_DETAIL_CHK" classid=<%=Util.CLSID_DATASET%>></object>
</comment>
<script>_ws_(_NSID_);</script>

<comment id="_NSID_">
<object id="DS_CHKORGMST" classid=<%=Util.CLSID_DATASET%>></object>
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
                         <td width="100%">
                         <comment id="_NSID_"> <object
                             id=GD_MASTER width=100% height=186 classid=<%=Util.CLSID_GRID%>>
                             <param name="DataID" value="DS_IO_MASTER">
                             <param name="UsingOneClick" value="1">
                         </object> </comment><script>_ws_(_NSID_);</script></td>
                     </tr>
                 </table>
                 </td>
             </tr>
         </table>
         </td>
     </tr>

     <tr valign="top" class="PT10">
         <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr valign="top">
                 <td>
                 <table width="100%" border="0" cellspacing="0" cellpadding="0"
                     class="BD4A">
                     <tr>
                         <td width="100%">
                          <comment id="_NSID_"> <object
                             id=GD_DETAIL width=100% height=307 classid=<%=Util.CLSID_GRID%>>
                             <param name="DataID" value="DS_O_DETAIL">
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
