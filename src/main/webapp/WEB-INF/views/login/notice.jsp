<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>National Bookstore</title>
  <!-- Google Fonts -->
  <link
    href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Nanum+Gothic|Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap"
    rel="stylesheet" />
  <!-- Fontawesome API-->
 <script src="https://kit.fontawesome.com/3fb56dfe63.js" crossorigin="anonymous"></script>
  <!--
    Available Fonts
    Main Font:
    font-family: 'Kaushan Script', cursive;

    Article Choices:
    font-family: 'Roboto', sans-serif;
    font-family: 'Open Sans', sans-serif;
    font-family: 'Montserrat', sans-serif;

    Korean Font:
    font-family: '맑은 고딕', sans-serif;
    font-family: 'Noto Sans KR', sans-serif;
    font-family: 'Black Han Sans', sans-serif;
    font-family: 'Nanum Gothic', sans-serif;
    -->

  <!-- css reset -->
  <link rel="stylesheet" href="../../../resources/css/reset.css" />
  <!-- individual page stylesheet -->
  <link rel="stylesheet" href="../../../resources/css/notice.css" />
  <link rel="stylesheet" href="../../../resources/css/common.css" />

  <!-- jQuery CDN -->
  <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
  <!-- slidify sliders and fadeInUp reveal -->
  <script src="../../../resources/js/common.js"></script>
</head>
<body>
<!-- <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="member"/>
</sec:authorize> -->
<header class="topbar">
        <nav>
            <div class="container">
                <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
                <h2>메인 페이지</h2>

                <div class="login-out">
                 <c:choose>
            		<c:when test="${sessionScope.userId != null }">
                		<span>${ sessionScope.userId }</span>님 환영합니다.
                		<button type="button" id="logoutBtn" onclick="gologinout(0)">로그아웃</button>
                	</c:when>
            		<c:otherwise>
            			<button type="button" id="loginBtn" onclick="gologinout(1)">로그인</button>
            		</c:otherwise>
            	</c:choose>
                </div>
            </div>
        </nav>
</header>
   <div class="biggestBox">
      <div class="noticeforUsing">
        <div class="smallNotice">
          <div class="smaller">
            <b>이용약관</b>
            <p>
              제1조 [목적] 본 약관은 주식회사 National Bookstore(이하 “회사”라고
              합니다)와 “이용자” 간에 “회사”가 제공하는 콘텐츠 서비스인 밀리의
              서재 서비스 및 제반 서비스를 이용함에 있어 “회사”와 “이용자” 간의
              권리, 의무에 관한 사항과 기타 필요한 사항을 규정하는 것을 목적으로
              합니다.
            </p>
          </div>
          <b>* 개인정보처리방침</b>
          <p>
            개인정보보호법, 정보통신망 이용촉진 및 정보보호 등에 관한 법률,
            통신비밀보호법, 전기통신사업법 등 정보통신서비스제공자가 준수하여야
            할 관련 법규상의 개인정보보호 규정을 준수하며, 관련 법령에 의거한
            개인정보처리방침을 정하여 이용자 권익 보호에 최선을 다하고 있습니다.
          </p>

          <ul>
            <li>1. 처리하는 개인정보 항목</li>
            <li>2. 개인정보의 처리목적</li>
            <li>3. 개인정보의 제3자 제공</li>
            <li>4. 개인정보 파기절차 및 방법</li>
            <li>5. 정보주체의 권리·의무 및 그 행사방법</li>
            <li>6. 개인정보보호 책임자 및 연락처</li>
          </ul>
        </div>
      </div>
      <div class="biggerBox">
        <ul>
          <li>
            <a href="#content" id="noticeHere">
              <strong
                >[공지] 종이책 배송 지연 안내
                <i class="fas fa-truck-container"></i>
                <span><i class="fas fa-chevron-down"></i></span
              ></strong>
              <span> 2022.01.25</span>
            </a>
            <div id="content">
              <p>
                설 연휴로 인하여 종이책 배송 일정이 변경되어 안내드립니다. 배송
                물량 증가로 부득이하게 지연되는 점 양해부탁드립니다. [배송 지연
                기간] - 2022년 1월 27일 ~ 2022년 02월 03일 평소보다 최소 3일 ~
                최대 7일 지연됩니다. 연휴 이후 안전하고 빠르게 배송하겠습니다.
                즐겁고 편안한 연휴 보내시길 바랍니다. 감사합니다.
              </p>
            </div>
          </li>
          <li>
            <a href="#content" id="noticeHere">
              <strong
                >[공지] 개인정보처리방침 일부 개정 안내
                <span><i class="fas fa-chevron-down"></i></span
              ></strong>
              <span> 2022.12.12</span>
            </a>
            <div id="content" class="active">
              <p>
                개인정보처리방침 약관이 일부 개정 예정되어 사전 안내드립니다.
                [변경 사유] 서비스 개편 사유로 개인정보 수집/이용 항목 추가 기타
                오탈자 수정 [변경 조항] 개인정보처리방침 제 1조 1항 가호 [변경
                내용] 변경 전 ① National Bookstore 서재는 회원가입, 고객상담,
                서비스 제공 및 이용과정에서 아래와 같이 필요한 최소한의
                개인정보를 수집하고 있습니다. 가. 필수정보 -SNS(카카오톡,
                네이버, 페이스북) 가입 : 로그인 정보 식별값, SNS 프로필 사진,
                필명, 휴대전화번호 -휴대폰 가입 : 생년월일, 성별정보, 필명,
                휴대전화번호 변경 후 ① National Bookstore 서재는 회원가입,
                고객상담, 서비스 제공 및 이용과정에서 아래와 같이 필요한
                최소한의 개인정보를 수집하고 있습니다. 가. 필수정보
                -SNS(카카오톡, 네이버, 페이스북, Apple) 가입 : 로그인 정보
                식별값, SNS 프로필 사진, 필명, 휴대전화번호 -휴대폰 가입 :
                생년월일, 성별정보, 필명, 휴대전화번호 -성인인증 처리 및
                연령제한 구독권 사용 시 : 생년월일 성인인증 처리 및 연령제한
                구독권을 사용하지 않는 경우 해당 정보는 수집/이용하지 않으며
                수집 후 회원탈퇴 시 지체없이 파기합니다. 위 내용은 2020년 05월
                21일자부터 시행되며, 변경되는 내용에 동의하지 않으시는 경우
                '회원탈퇴'를 통해 거부 의사를 표시하실 수 있습니다. 관련하여
                궁금하신 부분은 고객센터로 문의 부탁드립니다. 앞으로도 더 나은
                서비스 제공을 위해 최선을 다하겠습니다. 감사합니다.
              </p>
            </div>
          </li>
          <li>
            <a href="#content" id="noticeHere">
              <strong>
                내서재 후기 이벤트 당첨자 발표
                <i class="fas fa-leaf-heart"></i>
                <span><i class="fas fa-chevron-down"></i></span
              ></strong>
              <span> 2021.11.17</span>
            </a>
            <div id="content">
              <p>
                내서재 후기 이벤트에 참여해주신 모든 주민님들께 감사드립니다.
                당첨자 발표합니다. 까사미아 밀리 책상 풀세트 (1명) 미니민지 유티
                스탠딩 시계 (20명) 남독 니리 축하 드립니다! 당첨된 주민님들께
                별도 문자 안내가 진행될 예정입니다. 안내된 일정 내에 상품 배송을
                위한 정보를 입력해주세요! 앞으로도 National Bookstore 서재에
                많은 관심과 사랑 부탁 드립니다.
              </p>
            </div>
          </li>
          <li>
            <a href="#content" id="noticeHere">
              <strong>
                <i class="fad fa-lightbulb-exclamation bell"></i> 서버 점검 안내
                <span><i class="fas fa-chevron-down"></i></span
              ></strong>
              <span> 2021.11.04</span>
            </a>
            <div id="content">
              <p>
                최근 아마존 웹 서비스 장애로 밀리의
                서재 서비스가 다소 불안정했었습니다. 이와 같은 서비스 영향을
                최소화하기 위하여 아래와 같이 서버 이전 및 점검 작업을 진행할
                예정입니다. 점검 기간에는 서비스 이용이 원활하지 않을 수
                있습니다. 조금 불편하시더라도 너그러운 마음으로 이해
                부탁드립니다.  - 작업 내용 : DB 서버 이전 및 점검
                - 점검 시간 : 11월 10일(수) 새벽 2시에서 아침 8시까지 최선을
                다해 점검하고 좀 더 안정적인 서비스로 찾아뵙겠습니다.
                고맙습니다.
              </p>
            </div>
          </li>
        </ul>
      </div>
      <!-- biggerBox end -->
    </div>
    <!-- biggestBox end -->
    <script>
    function gologinout(num) {
    	/* 로그아웃하기 */
    	if(num == 0) {
    		if(!confirm('로그아웃 하시겠습니까?')) {
    			return;
    		}	
    		$.ajax({
    			url: '/logout',
    			data: {
    				"member_name" : ''
    			},
    			success: function(rs) {
    					alert('로그아웃이 완료되었습니다.');
    					location.reload();
    					$('#member_name').val('');
    			}, error : function(xhr, status, error) {
    				alert('오류');
    			}
    		});	
    	} else {
    		alert('로그인 페이지로 이동합니다.');
    		location.href='/login';
    	}
    }
	</script>
    <script>
    /* 공지사항 클릭시 해당 공지만 보여주기 */
      const container = document.querySelector(".biggerBox");
      const items = document.querySelectorAll(".biggerBox ul>li");
      const content = document.querySelectorAll(".biggerBox #content");

      items.forEach((item) => {
        item.addEventListener("click", (e) => {
          items.forEach((it) => {
            it.querySelector("#content").classList.remove("active");
            item.querySelector("#content").classList.add("active");
          });
        });
      });

    </script>
</body>
</html>