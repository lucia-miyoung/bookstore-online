<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>내 서재</title>
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Nanum+Gothic|Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap"
	rel="stylesheet" />
<!-- Fontawesome API-->
<script src="https://kit.fontawesome.com/3fb56dfe63.js"
	crossorigin="anonymous"></script>
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
<link rel="stylesheet" href="../../../resources/css/myaccount.css">
<link rel="stylesheet" href="../../../resources/css/common.css" />
<script type="text/javascript" src="/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript"
	src="/resources/js/jquery-ui-1.10.3.custom.js"></script>
<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<!-- slidify sliders and fadeInUp reveal -->
<script src="../../../resources/js/common.js"></script>
</head>
<body>
	<!-- <sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal" var="member" />
	</sec:authorize> -->
	<header class="topbar">
		<nav>
			<div class="container">
				 <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
				<h2>내 정보 관리</h2>
				<div class="login-out">
					<c:choose>
						<c:when test="${sessionScope.userId != null }">
							<span>${ sessionScope.userId }</span>님 환영합니다.
                		<button type="button" id="logoutBtn"
								onclick="gologinout(0)">로그아웃</button>
						</c:when>
						<c:otherwise>
							<button type="button" id="loginBtn" onclick="gologinout(1)">로그인</button>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</nav>
	</header>

	<div class="wrapper">
	<form id="frm" method="post">
		<input type="hidden" name="member_id" id="member_id" value="${paramMap.member_id }" />
		<input type="hidden" name="member_name" id="member_name" value="${sessionScope.userId}" />
	</form>
    <div class="title">
        <h2> <i class="fas fa-bell-on"></i>  <p> ${sessionScope.userId} </p>님</h2>
    </div>       
    <div class="summary">
        <div class="goSub">  
            <div id="gogoSub">
            <div>
                <p>
                    이번 달 마지막 찬스!! 
                </p>
                <p>
                    독서 습관을 길러서 지식인이 되어보아요.
                </p>
                <p>
                    한달 동안 종이책 3권 이상 구입시 마일리지 +3% 추가 적립!!
                </p>
                <div class="image">
                    <img src="../../../resources/images/photoImg.png" >
                </div>
            </div>
            </div>
        </div>
    </div>
    <div class="listChoice">
        <p> 정보 관리 </p>
        <ul>
            <li><a href="javascript:goview('/member/updatemypage');">회원정보수정 <i class="far fa-chevron-right"></i></a></li>
            <li><a href="javascript:goview('/member/godeletepage');">회원탈퇴<i class="far fa-chevron-right"></i></a> </li>
        	<li><a href="javascript:goview('/member/mypage');">마이 페이지<i class="far fa-chevron-right"></i></a></li>
        </ul>
    </div>

    <div class="listChoice">
        <p> 서비스 안내 </p>
        <ul>
            <li><a href="/member/notice">공지사항<i class="far fa-chevron-right"></i></a></li>
            <li><a href="javascript:goview('/common/servicecenter');">고객센터<i class="far fa-chevron-right"></i></a></li>
        </ul>
    </div>
    <div class="lastColumn">
      <button type="button" onclick="gologinout(0)">로그아웃</button>
    </div>
  </div>
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

function goview(url) {
	const userid = document.querySelector('#member_name').value;
	if(userid == '' || userid == null) {
		alert('로그인 후 이용 가능합니다.');
		return;
	}
	$('#frm').attr('action', url);
	$('#frm').submit();
}

</script>
</body>

</html>