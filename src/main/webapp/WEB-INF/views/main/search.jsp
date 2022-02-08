<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>전체 도서</title>
  <!-- Google Fonts -->

  <!-- Fontawesome API -->
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
    font-family: 'Noto Sans KR', sans-serif;
    font-family: 'Black Han Sans', sans-serif;
    font-family: 'Nanum Gothic', sans-serif;
    -->
  <!-- css reset -->
  <link rel="stylesheet" href="../../../resources/css/reset.css" />
  <!-- individual page stylesheet -->
  <link rel="stylesheet" href="../../../resources/css/common.css" />
  <link rel="stylesheet" href="../../../resources/css/search.css" />
<script src="https://code.jquery.com/jquery-3.5.0.js" integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc=" crossorigin="anonymous"></script>
<script src="../../../resources/js/common.js"></script>
<%
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	String category = request.getParameter("category");
	String pageNum = request.getParameter("page");
	
	if(type == null)
		type = "title";
	if(keyword == null)
		keyword = "";
	if(category == null)
		category = "all";
	if(pageNum == null)
		pageNum = "1";
%>
<!-- <sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="member"/>
</sec:authorize> -->
</head>
<body>
	<header class="topbar">
        <nav>
            <div class="container">
                <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
                <h2>검색 결과</h2>

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
	<div class="main-container" >
	<div class="popup-wrap invisible">
	 <div class="popup-dim"></div>
	 <div class="popup-container">
            <span class="fas fa-times" id="close-icon"></span>
            <div class="popup-content">
                <a href="#" class="stay"><i class="fab fa-staylinked"></i>현재 유지</a>
                <a href="/member/mypage?member_name=${sessionScope.userId}" class="gocart"><i class="fas fa-shopping-cart"></i>장바구니 이동</a>
            </div>
        </div>
        </div>
	<!-- 검색바 -->
	<!-- <form action="/search/searchtest" method="GET" > -->
	<form class="search-form" action="/book/search" method="GET" >
		<div class="search-bar" >
			<select class="type" name="type" >
				<option value="title" ${paramMap.type == 'title' ? 'selected="selected"' : ''}>제목</option>
				<option value="author" ${paramMap.type == 'author' ? 'selected="selected"' : ''}>저자</option>
				<option value="publisher" ${paramMap.type == 'publisher' ? 'selected="selected"' : ''}>장르</option>
			</select>
			<input class="keyword" type="text" name="keyword" placeholder="검색어를 입력해주세요" autocomplete="off" spellcheck="false"/>
			<button class="btn-search fas fa-search" name="category" value="all" ></button>
		</div>
	</form>
	<%-- 빈 화면에 내보낼 것들 --%>
	<c:if test="${empty paramMap.keyword }" >
		<div class="empty-spot" >
			<h3>검색 결과가 없습니다. </h3>
		</div>
	</c:if>
	<!-- 검색 결과 요약 -->
	<c:if test="${not empty paramMap.keyword }" >
		<!-- 카테고리 선택 -->
		<form action="/book/search" method="GET" >
			<div class="category-list" >
				<input class="type" type="hidden" name="type" />
				<input class="keyword" type="hidden" name="keyword" value="${paramMap.keyword}"/>
				<input type="hidden" name="page" value="1" />
				<button name="category" value="all" class="btn-category selected">통합검색</button>
				<button name="category" value="paper" class="btn-category">종이책</button>
			</div>
		</form>
		<div class="search-summary" >
			<div>
				'<span class="skeyword" >${paramMap.keyword }</span><span>'에 대한</span>
			</div>
			<span class="scount" >총 
			<span class="result-count" >${bookCount }</span> 개의 검색결과</span>
			<div class="layout" >
					<button class="btn-layout btn-list list fas fa-list"></button>
					<button class="btn-layout btn-grid fas grid fa-th-large"></button>
			</div>
		</div>
	</c:if>
	<!-- paper -->
			<div class="search-list fadeInUp">
				<div class="category-belt" >
						<span class="category-title" >도서<span class="category-count" >${bookList.size() }</span></span>
						<c:if test="${sessionScope.userId != null }"> 
						<div class="cart-select-wrap">
						<button type="button" class="cart-insert">장바구니 추가</button>
							<label for ="all-check">
								<input type="checkbox" name="all-check" id="all-check"/>
								<span class="btn-cart">전체 선택</span>
							</label>
						</div>
						</c:if>
				</div>
				<c:choose>
					<c:when test="${bookList.size() == 0 }" >
						<div class="empty-spot" >
							<h3>검색 결과가 없습니다. </h3>
						</div>
					</c:when>
					<c:otherwise>
						<div class="search-result" >
							<c:forEach var="book" items="${bookList}">
								<div class="search ${book.book_id}" >
									<div class="book" >
										<!-- 책 커버 -->
										<a href="/member/detail?book_id=${book.book_id }&member_name=${sessionScope.userId}">
										<img class="cover" src="/bookImg/book${book.book_id}.jpg" />
										</a>
										<!-- 책 정보 -->
										<div class="info" >
											<a href="/member/detail?book_id=${book.book_id }&member_name=${sessionScope.userId}">
												<span class="title" >${book.book_name }</span>
											</a>
											<div>
												<span class="author" >${book.book_author }</span>
												<span class="publisher" >${book.book_type }</span>
											</div>
										</div>
									</div>
									<div class="interact" >
										<button class="btn-purchase" onclick="location.href='/member/paycheck.do?book_id=${book.book_id }&member_name=${sessionScope.userId}'">구매</button>
											<c:if test="${sessionScope.userId !=null }" > 
											<input class="checkbox-cart btn-list-cart" id="cart" type="checkbox" name="cart" value="${book.book_id }" />
											</c:if> 
									</div>
								</div>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
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
</script>

<script>
/* 장바구니 추가 했을때 팝업창 생성 */
const popContainer = document.querySelector('.popup-container');
const popWrap =document.querySelector('.popup-wrap');
const stayBtn = document.querySelector('.popup-container .stay');
const closeBtn = document.querySelector('#close-icon');
	closeBtn.addEventListener('click', () => {
		popWrap.classList.add('invisible');
	});
	stayBtn.addEventListener('click', () => {
		popWrap.classList.add('invisible');
	});

/* 체크박스 */
const allChk = document.querySelector('#all-check');
const cartInsert = document.querySelector('.cart-insert');
const carts = document.querySelectorAll('#cart');

allChk.addEventListener('change', () => {
	const isChecked = allChk.checked ? true : false;
	carts.forEach(cart => {
		cart.checked = isChecked;
	});
});


if(cartInsert) {
	cartInsert.addEventListener('click', () => {
		let chkArray = [];
		carts.forEach(cart => {
			if(cart.checked) {
			const chkVal = cart.value;
				chkArray.push(chkVal);
			}
		});
		if(chkArray == null || chkArray == '') {
			alert('장바구니에 담고 싶은 도서를 선택해주세요.');
			return;
		}
		if(!confirm('선택한 도서를 장바구니에 담으시겠습니까?')) {
			return;
		}
		oninsertcart(chkArray);
	});
}

function oninsertcart(array) {
	
	$.ajax({
		url : "/member/setmypageInfo",
		type : 'POST',
		async: true,
		data : {
			"status" : 'I',
			"member_name" : "${sessionScope.userId}",
			"chk_array" : array
		},
		success: function(rs) {	
			if(rs.zzimdupChk > 0) {
				alert('이미 장바구니에 담긴 책이 있습니다. 다시 확인해주세요.');
				return;
			} 
			if(rs.result > 0) {
				alert('장바구니에 담기가 완료되었습니다.');
				popWrap.classList.remove('invisible');
			}else {
				alert('오류가 발생했습니다. 확인해주세요.');
			}
		},
		error: function(xhr, error) {
			alert('오류');
		}	
	});
}
</script>

</body>
</html>