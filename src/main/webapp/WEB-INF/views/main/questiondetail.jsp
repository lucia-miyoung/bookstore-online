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
	<link rel="stylesheet" href="../../../resources/css/questiondetail.css" />
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
	  <div class="main-container">
        <div class="container">
            <div class="question_container">
                <span class="question_date">작성날짜: ${qstdetail.qst_date }</span>
                <input type="text" class="question_title" name="question_title" value="${qstdetail.qst_title }" readonly />
                <div class="question_info">
                    <ul class="upper">
                        <li>문의자</li>
                        <li>문의 유형</li>
                    </ul>
                    <ul class="info">
                        <li><span class="name">${qstdetail.member_name }</span></li>
                        <li><span class="type">${qstdetail.qst_type }</span></li>
                    </ul>
                </div>
                <div class="question_content" readonly> 
                ${qstdetail.qst_content} 
                	<c:if test="${qstdetail.qst_image}">
                 		<div class="question_image">
                        	<img src="/svgImg${qstdetail.qst_image}" alt="">
                    	</div>
                 	</c:if>
                 </div>
            </div>
            
            <div class="answer_wrap">   
            <c:if test="${qstdetail.answer_status == 'Y'}">
                <div class="answer_comment">
                	<p><span class="name">관리자</span>
                		<span class="date">${qstdetail.answer_date }</span>
                		<span class="new_icon">N</span>
                		<c:if test="${sessionScope.userId == '관리자'}">
                			<i class="fas fa-edit"></i>
                		</c:if>
                		</p>
                	<div class="comment">
                		${qstdetail.qst_answer }
                	</div>
                </div>    
            </c:if>      
            </div>
            <form id="ansForm" name="ansForm" method="get">
            	<input type="hidden" name="member_name" id="member_name" value="${sessionScope.userId }"/>
            	<input type="hidden" name="qst_index" id="qst_index" value="${qstdetail.qst_index}"/>
            	<input type="hidden" name="status" id="status" value=""/>
            	<c:if test="${sessionScope.userId == '관리자' }">
            		<div class="answer_container">
                		<textarea class="answer_content" name="answer_content">${qstdetail.qst_answer }</textarea>
                		<button type="button" class="answer_add_btn"><i class="fas fa-arrow-alt-circle-right"></i>답변 등록</button>
            		</div>
            	</c:if>
            </form>
            <div class="list_btn">
            	<a href="javascript:golist('/common/showqstlist');">목록으로</a>
            </div>
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

	function golist(url) {
		if(!confirm('목록으로 이동하시겠습니까?')) {
			return;
		}
		
		location.href=url;
	}
		
	</script>
    <script>
    	const newIcon = document.querySelector('.answer_comment p .new_icon');
    	let ansdatewrap = document.querySelector('.answer_comment .date');
    	let ansdate = undefined;
    	if(ansdatewrap) {
    		ansdate = ansdatewrap.textContent;
    	}
    	const qstContent = document.querySelector('.question_content');
    	const ansContan = document.querySelector('.answer_container');
    	const ansComment = document.querySelector('.answer_comment');
        const ansBtn = document.querySelector('.answer_add_btn');
        const ansWrap = document.querySelector('.answer_wrap');
        const ansContent = document.querySelector('.answer_content');
		let maxWidth = 250;
        
        let today = new Date();
        let year = today.getFullYear();
        let month = ('0'+(today.getMonth()+1)).slice(-2);
        let day = ('0'+today.getDate()).slice(-2);
        let hours = ('0'+today.getHours()).slice(-2);
        let minutes = ('0'+today.getMinutes()).slice(-2);
        let dateString = year + '-' + month + '-' + day + ' '
        + hours + ':' + minutes;
        let laterday = new Date(ansdate);
		let updatetime = new Date(laterday.setDate(laterday.getDate() + 2));    
        
		if(newIcon) {
			if(today < updatetime) {
				newIcon.classList.remove('invisible');
	        } else {
	        	newIcon.classList.add('invisible');
	        }	
		}

        if(ansContan) {
        	 if(ansComment) {
             	ansContan.classList.add('invisible');
             }else {
             	ansContan.classList.remove('invisible');
             }		
        }
       
        if(qstContent.clientHeight < maxWidth) {
            qstContent.style.height = maxWidth+'px';
        }else {
            qstContent.style.height = 'auto';
        }

        
        if(ansBtn) {
        	ansBtn.addEventListener('click', () => {
            	if(ansContent.value == '' || ansContent.value == null) {
                    alert('답변 내용을 입력해주세요.');
                    ansContent.focus();
                    return;
                } 
            	if(!confirm('답변을 등록하시겠습니까?')) {
            		return;
            	}
                oninsertcomment();
            });
        }
                 
        function oninsertcomment(status) {
        const ansContainer = document.querySelector('.answer_container');
        const ansConts = document.querySelector('.answer_content');
        const statusVal = document.querySelector('#status');
        const ansWrap = document.querySelector('.answer_wrap');
        	
        	statusVal.value="I";
        
            $.ajax({
            	url: "/common/setcommentdetail",
            	data: $("#ansForm").serialize(),
            	success: function(rs) {
            		if(rs > 0) {
            			ansWrap.innerHTML = 
            				'<div class="answer_comment"><p><span class="name">'
                            +'${sessionScope.userId}'+'</span><span class="date">'
                            + dateString +'</span><span class="new_icon">N</span><i class="fas fa-edit"></i></p><div class="comment">'
                            +ansConts.value+'</div></div>';
                        	alert('답변 등록이 완료되었습니다.');
            			ansContainer.classList.add('invisible');
            		}else {
            			ansContainer.classList.remove('invisible');
            		}
            	},
            	error: function(xhr, status, error) {
            		alert('오류');
            	}
            });
        } 
        
        ansWrap.addEventListener('click', (event) => {
        	if(event.target.localName == "i") {
        		if(!confirm('답변을 수정하시겠습니까?')) {
            		return;
            	}
        		ansContan.classList.remove('invisible');	
        	}
        });

    </script>
</body>
</html>