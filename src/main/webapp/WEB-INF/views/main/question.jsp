<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <!-- Google Fonts -->
  <link
    href="https://fonts.googleapis.com/css?family=Black+Han+Sans|Nanum+Gothic|Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap"
    rel="stylesheet" />
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
	<link rel="stylesheet" href="../../../resources/css/question.css" />
  <link rel="stylesheet" href="../../../resources/css/common.css" />
  <script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
  
<title>자주 묻는 질문</title>
</head>
<body>

	<header class="topbar">
        <nav>
            <div class="container">
                <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
                <h2>자주 묻는 질문</h2>

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
	<div class="container" >
		<form name="qstForm" id="qstForm">
		<input type="hidden" id="currPage" name="currPage" value="${currPage }"/> 
		<div class="searchContainer">
				<div class="search_wrap">
					<input type="text" id="search_name" name="search_name"/>
					<button type="button" id="search_btn" name="search_btn">검색</button>
				</div>
		</div>
		<div class="questionTable">
                <table class="tables">
                <thead>
                    <tr>
                    	<th>순번</th>
                        <th>답변상태</th>
                        <th>문의 유형</th>                    
                        <th>제목</th>
                        <th style="width:17%;">문의자</th>
                        <th>문의날짜</th>
                    </tr>
                    </thead>
                   <!-- foreach 시작 -->
                   <c:choose>
				<c:when test="${qstallList.size() > 0}">
                <c:forEach var="list" items="${qstallList}" varStatus="index">
              		<tbody>
              		<tr class="qst_preview">
              			 <td>
              			 	${paging.rowNum - index.index}
              			 </td>
              			 <td>
              				<c:choose>
								<c:when test="${list.answer_status == 'N'}">
               						<span id="ansStatus" style="color:#ccc;">답변 대기</span>
              					</c:when>
								<c:otherwise>
									<span id="ansStatus" style="color:red; font-weight:bold;">답변 완료</span>
								</c:otherwise>
							</c:choose>
              			</td>
                        <td><span class="qstType">${list.qst_type}</span></td>
                        <td><a href="/common/showqstdetail?qstIdx=${list.qst_index}" id="qst_title" data-id="${list.qst_index}">${list.qst_title}</a></td>
                        <td>${list.member_name}</td>
                        <td style="font-size:11px;">${list.qst_date}</td>
                    </tr>
              	</c:forEach>
              	</c:when>
				<c:otherwise>
					<tr> 
						<td colspan="6"><span class="no_question">등록된 문의 사항이 없습니다. </span> </td> 
					</tr>
				</c:otherwise>
				</c:choose>
				</tbody>
                </table>            
              </div>
        </form> 
        <c:if test="${paging.pageCnt > 0}">
		<div class="pagination" >
			<div class="page">
						<button type="button" class="btn page before" name="page" <c:if test="${paging.preBtn==false}">disabled
						</c:if> onclick="onmovepage('${paging.startPage-1}');"><i class="fas fa-chevron-left"></i></button>
				
    				<div id="pageCnt">
    				<c:forEach var="page" begin="${paging.startPage }" end="${paging.endPage}">
        				<a href="/common/showqstlist?currPage=${page}&search_name=${paramMap.search_name }" data-id="${page}">${page}</a>
    				</c:forEach>
    				</div>
						<button type="button" class="btn page after" name="page" <c:if test="${paging.nextBtn == false}">disabled
						</c:if> onclick="onmovepage('${paging.endPage+1}');"><i class="fas fa-chevron-right"></i></button>
			</div>
		</div>
		</c:if>
	</div>
	</div>
<style>
.questionTable a#qst_title {
	display: block; /* 중요!! */
	overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    width: 170px;
}
.questionTable table td span.qstType {
	display: block; /* 중요!! */
	overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    width: 80px;
}
</style>
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
	
	const currVal = document.querySelector('#currPage').value;
	const pagenum = document.querySelector('div.pagination div.page a[data-id="'+currVal+'"]');
	if(pagenum) {
		pagenum.classList.add('active');
	}
	
	function onmovepage(pageNum) {
		location.href="/common/showqstlist?currPage="+pageNum+"&search_name="+"${paramMap.search_name }";
	}
	
</script>
<script>
	
	const searchBtn = document.querySelector('#search_btn');
	searchBtn.addEventListener('click', () => {
			goSearch();
	});
	
	const searchVal = document.querySelector('#search_name');
	searchVal.addEventListener('keydown', (event) => {
		if(event.keyCode == 13) {
			goSearch();
		}
	});
	 function goSearch() {
		$('#currPage').val('1');
     	$('#qstForm').attr('action', '/common/showqstlist');
     	$('#qstForm').submit();
     }
	
</script>
</body>
</html>