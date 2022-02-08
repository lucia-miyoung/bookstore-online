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
<title>도서 상세 </title>
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
<link rel="stylesheet" href="../../../resources/css/detail.css">
<link rel="stylesheet" href="../../../resources/css/common.css" />
<script type="text/javascript" src="/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-ui-1.10.3.custom.js"></script>
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
				<h2>도서 상세</h2>
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
			<input type="hidden" name="member_name" id="member_name" value="${ sessionScope.userId }" /> 
			<input type="hidden" name="status" id="status" value="${status}" /> 
			<input type="hidden" name="heart_yn" id="heart_yn" value="${heartChk.heartChk}" /> 
			<input type="hidden" name="book_id" id="book_id" value="${paramMap.book_id}" /> 
			<input type="hidden" name="zzim_chk" id="zzim_chk" value="${zzimCnt}" />
		</form>
		<!-- form 끝 -->
		<div class="top-container">
			<c:if test="${sessionScope.userId != null}">
				<a href="javascript:goMypage('${ sessionScope.userId }');" class="mypageBtn">MY</a>
			</c:if>
			<div class="leftBox">
				<div class="imageBox">
					<img src="/bookImg/book${paramMap.book_id}.jpg"	alt="없음" />
				</div>
			</div>
			<!-- leftbox 끝 -->
			
			<div class="introWrite">
				<h3>${bookInfo.book_name}</h3>
				<ul>
					<li>${bookInfo.book_author} (<span style="color: gray;">${bookInfo.book_date}</span>)</li>
					<li style="color: gray;">${bookInfo.book_type}</li>
				</ul>
				<div class="bookStarScore">
					<div id="default">
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
					</div>
					<div id="full">
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
						<i class="fas fa-star"></i>
					</div>
					<div class="bookScoreWrap">
					 	<span class="bookScore">
					 		<c:if test="${bookScore.avg == null || bookScore.avg == '' }">
					 			0
					 		</c:if>
					 		<c:if test="${bookScore.avg != null || bookScore.avg != '' }">
					 			${bookScore.avg }
					 		</c:if>
					 	</span><span>점</span>
					 	<span class="add">
					 	(${bookScore.cnt}명 참여중)
					 	</span>
					</div>
				</div>
				<!-- bookStarScore 끝 -->
					<div class="choiceBtn">
						<input type="button" value="바로읽기" class="goRead" id="choose"
						onclick="goViewer();" />
						<button type="button" class="zzimBtn" id="choose">
							<i class="fas fa-plus-circle"></i> 찜하기
						</button>
						<input type="button" value="바로 구매" class="goOrder" id="choose" 
						onclick="goOrder();"/>
					</div>
				<div class="likeChk">
					<a id="modalOpen">
						<div class="likelists">
							<div class="likePeople">
								<img src="/image/default.png"/>
								<img src="/image/default.png"/>
								<img src="/image/default.png"/>
							</div>
						</div> 
						<span id="people"> 좋아하는 사람들</span>
					</a>
					<div class="likeBtn">
						<span class="countLike">${heartCnt}</span>
						<div class="heartClick">
							<c:choose>
								<c:when test="${sessionScope.userId != null}">
									<c:if
										test="${heartChk.heartChk == 'N' || heartChk.heartChk == null }">
										<i class="far fa-heart"></i>
									</c:if>
									<c:if test="${heartChk.heartChk eq 'Y' }">
										<i class="fas fa-heart"></i>
									</c:if>
								</c:when>
								<c:otherwise>
									<span class="far fa-heart" id="heartD"></span>
								</c:otherwise>
							</c:choose>
						 </div>
					</div>
					<!--likeBtn 끝  -->
				</div>
				<!-- likeChk end -->
				<div class="likemodal invisible">
					<div class="modal_content">
						<p><i class="fab fa-gratipay"></i> 좋아요한 사람들</p>
						<div class="likeList">
							<ul>
							<c:choose>
							<c:when test="${likedlist.size() > 0}">
							<c:forEach items="${likedlist}" var="list">
								<li>
									<div id="likedUsersList">
										<img id="myFaceImage"
											src="/image${list.member_image}" /> 
										<a href="javascript:showUserpage('${list.member_name}')" class="likedUser">
											<span>${list.member_name }</span>
										</a>
									</div>
								</li>
							</c:forEach>
							</c:when>
							<c:otherwise>
								<li> 
									<span class="noliked"> 좋아요한 사람이 없습니다. </span> 
								</li>
							</c:otherwise>
							</c:choose>
							</ul>
						</div>
						<span id="modalCloseBtn">
							<button type="button" id="peopleChkBtn">확인</button>
						</span>
					</div>
				</div>
			</div>
			<!-- introWrite 끝 -->
		</div>
		<!-- top-container 끝-->	
		<div class="body-container">
			<div class="firstBox">
				<h2># 감성태그</h2>
				<div class="hashtagDetail">
					<div class="hashTag">
						<c:choose>
							<c:when test="${emotag.size() > 0}">
								<c:forEach items="${emotag}" var="tag" varStatus="idx" begin="0" end="4">
									<div class="hash_tag_wrap" style="display:inline-block;" id="${idx.index}">
										<input type="checkbox" class="hash_emo_tag" id="${idx.index}">
										<label for="${idx.index}">#${tag.emo_tag} 
										<c:if test="${sessionScope.userId == tag.member_name }">
											<i class="far fa-times-circle"></i>
										</c:if>
										</label>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<span> 등록된 감성 태그가 없습니다. </span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="emo_tag_wrap">
						<input type="text" name="emo_tag" class="emo_tag"
							placeholder="이 책에 대한 나만의 #감성태그를 달아주세요">
							<input type="button" value="등록" class="inputBtn">
					</div>
				</div>
			</div>
			<!-- firstBox end -->
			<div class="wrapperBox">
				<div class="secondBox box">
					<h2>책소개</h2>
					<div class="bookDetail detail">책소개하는 칸입니다. ‘이 소설 자체가 순수한
						마법’이라는 최고의 극찬을 받으며 2017년 뉴베리 수상의 영광을 차지한 작품이다. 고요하지만 위험한 숲속에 해마다
						아기가 버려진다. 또한 매년 그런 아기를 구하러 오는 마녀가 있다. 그런데 이상하다. 마녀 잰은 유독 이번 아기에게
						눈길을 빼앗긴다. 그러다가 그만 실수로 아기에게 달빛을 먹이고 만다. 사실 달빛에는 어마어마한 마법이 깃들어 있다.

						잰은 어쩔 수 없이 분화구 가장자리 늪에 있는 자신의 집으로 아기를 데려간다. 그렇게 마법 아기 루나는 기억을 꽁꽁
						감추고 사는 마녀 잰, 시를 사랑하는 늪 괴물 글럭, 망상 속에 사는 용 피리언과 함께 이상한 가족의 일원이 된다.
						마법이 무엇인지도 모른 채 온갖 말썽을 부리며 자라는 루나와 그런 루나에게 무한한 사랑과 우정을 보여주는 가족들.

						하지만 루나는 점차 자신의 정체성에 혼란을 느끼고 이런저런 의문에 시달린다. 또한 미쳐서 탑에 갇힌 한 여자의 환영에
						아련한 향수마저 느끼는데…. 사실 가족 모두에겐 저마다 묻어둔 아픔이 있고 그것은 ‘보호령’이라는 도시와 깊은 연관이
						있다. 해마다 숲속 마녀에게 아기를 갖다 바쳐야 한 해가 무사하다고 믿는 슬픔의 도시 보호령의 진짜 비밀은 무엇일까?

						과연 달빛 마신 소녀 루나와 이상한 가족들은 보호령의 검은 장막을 걷어내고 사람들을 무겁게 휘감은 슬픔과 두려움을
						사라지게 할 수 있을까? 이들이 펼치는 사랑과 모험의 환상적인 달빛 마법이 시작된다.</div>
					<input type="button" value="더보기" class="clickBtn">

				</div>
				<div class="thirdBox box">
					<h2>목차</h2>
					<div class="listDetail detail">목차 칸입니다. 1장 이야기를 하다∥2장 불행한 여자가
						미쳐 버리다 ∥ 3장 마녀가 실수로 아기에게 마법을 걸다 ∥ 4장 그냥 꿈일 뿐인 이야기 ∥ 5장 늪 괴물도 결국
						사랑에 빠지다 ∥ 6장 앤테인이 곤경에 처하다 ∥ 7장 마법의 아이가 좀 지나치게 골칫거리다 ∥ 8장 이야기에 일말의
						진실이 있다 ∥ 9장 여러 가지 문제가 발생하다 ∥ 10장 마녀가 문을 찾고 기억도 찾다 ∥ 11장 마녀가 결단을
						내리다 ∥ 12장 아이가 습지에 관해 배우다 ∥ 13장 앤테인이 미친 여자를 만나러 가다 ∥ 14장 행동에 결과가
						따르다 ∥ 15장 앤테인이 거짓말을 하다 ∥ 16장 종이가 너무나 많다 ∥ 17장 호두알에 갈라진 틈이 있다 ∥ 18장
						마녀가 발각되다 ∥ 19장 자유도시에 다녀오다 ∥ 20장 루나가 이야기하다 ∥ 21장 피리언이 장화를 발견하다 ∥
						22장 다른 이야기가 있다 ∥ 23장 루나가 지도를 그리다 ∥ 24장 앤테인이 해결책을 내놓다 ∥ 25장 루나가 새로운
						세상을 배우다 ∥ 26장 미친 여자가 종이를 만들다 ∥ 27장 루나가 원하는 것보다 더 많이 배우다 ∥ 28장 여러
						사람이 숲으로 가다 ∥ 29장 화산이 나오는 이야기 ∥30장 계획보다 일이 더 꼬이다 ∥ 31장 미친 여자가 나무 집을
						발견하다 ∥ 32장 루나가 종이 새를 아주 많이 발견하다 ∥ 33장 마녀가 오래전에 알던 이를 만나다 ∥ 34장 루나가
						숲에서 한 여자를 만나다 ∥ 35장 글럭이 불쾌한 냄새를 맡다 ∥ 36장 지도가 별 쓸모가 없다 ∥ 37장 마녀가
						충격적인 사실을 알게 되다 ∥ 38장 안개가 서서히 걷히다 ∥ 39장 글럭이 피리언에게 진실을 말하다 ∥ 40장 장화를
						두고 다툼이 벌어지다 ∥ 41장 몇 개의 길이 만나다 ∥ 42장 세상이 파랗고 은빛이고 은빛이고 파랗다 ∥ 43장
						루나가 처음으로 의도를 갖고 마법을 걸다 ∥ 44장 마음이 움직이다 ∥ 45장 거대한 용이 거대한 결단을 내리다 ∥
						46장 몇 가족이 다시 만나다 ∥ 47장 글럭이 여행을 떠나며 시를 남기다 ∥ 48장 마지막 이야기를 하다</div>
					<input type="button" value="더보기" class="clickBtn">
				</div>
				<div class="fourthBox box">
					<h2>리뷰 (${bookScore.cnt})</h2>
					<div class="reviewDetail detail">
						<table>
						 <c:choose>
							<c:when test="${reviewallList.size() > 0}">
                				<c:forEach var="rev" items="${reviewallList}">
              						<tbody>
										<tr style="background-color: #E8DCDC;">
											<td>
												<div class="review_star_wrap">
													<div class="review_user_image">
														<img src="/image${rev.member_image }"/>
													</div>
													<div class="review_user_wrap">
														<span class="review_user_name">${rev.member_name }</span>
														<div class="review_user_star">
															<div id="default">
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
														</div>
														<div id="full">
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
															<i class="fas fa-star"></i>
														</div>
													<input type="hidden" class="review_user_score" value="${rev.review_score }"/>
													</div>
												</div>
											</div>
											</td>
											<td><span class="review_date">${rev.review_date }</span></td>
										</tr>
									<tr>
									<td colspan="2" style="background-color: #FFF7F6;">
										<div class="review_wrap">
											<span class="review_title">${rev.review_title }</span>
											<input type="text" name="review_content" class="review_content" value="${rev.review_content}" readonly />
										</div>
									</td>
								</tr>
								</tbody>
              					</c:forEach>
              				</c:when>
						<c:otherwise>
								<span class="noUserReview"> 등록된 리뷰가 없습니다. </span>
						</c:otherwise>
						</c:choose>
						</table>
					</div>
					<input type="button" value="더보기" class="clickBtn">
				</div>
				<div class="fifthBox">
					<h2>관련 도서</h2>
					<div class="similarBook">
					<c:choose>
						<c:when test="${relbookList.size() > 0 }">
							<c:forEach items="${relbookList}" var="list" begin='0' end='4'>
								<a href="javascript: goView('${list.book_id}');">
									<img src="/bookImg/book${list.book_id}.jpg" alt="">
								</a>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<span class="noBook"> 관련 도서가 없습니다. </span>
						</c:otherwise>
					</c:choose>	
					</div>
				</div>
			</div>
			<!-- 관련 도서 end -->
		</div>
		<!-- body-container -->
	</div>
	<!-- wrapper end -->

	
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
	/* 책 별점 구현 */
	const starWrap = document.querySelector('.bookStarScore');
	const starWidth = starWrap.offsetWidth;
	const starCnt = document.querySelectorAll('.bookStarScore #default i').length;
	let bookstarScore = document.querySelector('.bookScoreWrap > .bookScore').textContent.trim();
	let bookScore = Number(bookstarScore);
	const fullStar = document.querySelector('.bookStarScore #full');
	
	if(starWrap) {
		let score = (starWidth/starCnt) * bookScore;
		fullStar.style.width = score+"px";	
		if(bookstarScore.split('.')[1] == '') {
			document.querySelector('.bookScoreWrap > .bookScore').textContent = bookstarScore.split('.')[0];
		}
	}

	/* 유저의 개별 별점 구현 */
	const userstarWrap = document.querySelectorAll('.review_user_star');
	const userStarWidth = $('.review_user_star').width();
	const userStars = document.querySelectorAll('.review_user_score');
	const userFullStar = document.querySelectorAll('.review_user_star #full');
	let userstarCnt = document.querySelectorAll('.review_user_star #default')[0];
		
		if(userstarCnt) {
			userstarCnt = userstarCnt.querySelectorAll('i').length;
		}
	
		userStars.forEach((star, index) => {
			let num = Number(star.value);
				let userScore = (userStarWidth/userstarCnt) * num;
				userFullStar[index].style.width = userScore+"px";
		});
</script>

<script>
	/* 탭 클릭시 해당 상세 정보 보이기  */
	const wrapboxes = document.querySelectorAll('.wrapperBox .detail');
	wrapboxes.forEach(box => {
		const boxButton = box.parentNode.querySelector('input[type="button"]');
		boxButton.addEventListener('click', () => {
				box.classList.toggle('open');
		});
	});

	/* 해시태그 */
    const hashTagBox = document.querySelector(".hashTag");
    const hashtagspan = document.querySelector(".hashTag > span");
    const inputTag = document.querySelector(".emo_tag");
    const addBtn = document.querySelector(".inputBtn");
    const tagwrap = document.querySelectorAll('.hashTag .hash_tag_wrap');
	let tagindex = 0;
	
	if(tagwrap.length > 0) {
		tagindex = Number(tagwrap[tagwrap.length-1].getAttribute('id'))+1;
	}
	
    addBtn.addEventListener("click", () => {
      	addItem();
    });

    inputTag.addEventListener("keypress", (event) => {
      	if (event.key === "Enter") {
        	addItem();
      	}
    });

      function addItem() {  
    	if(inputTag.value == '' || inputTag.value == null) {
    		alert('빈칸을 입력해주세요.');
    		inputTag.focus();
    		return;
    	}
    	
    	if(tagwrap.length == 5) {
    		alert('해시태그는 5개까지 가능합니다.');
    		return;
    	}
    	
        const usernm = document.querySelector('#member_name').value;
        const bookid = document.querySelector('#book_id').value;
        const emoInput = document.querySelector('.emo_tag').value;
		
	 $.ajax({
        	url:"/member/setdetailInfo",
        	data: {
        		 "status" : "I",
        		 "member_name" : usernm, 
        		 "book_id": bookid, 
        		 "emo_tag": emoInput
        	},
        	success:function(rs) {
        		if(rs > 0) { 
        			if(hashtagspan) {
        				hashtagspan.remove();
        			}
        			hashTagBox.innerHTML += 
        			'<div class="hash_tag_wrap" style="display:inline-block;" id="'
        			+tagindex+'"><input type="checkbox" class="hash_emo_tag" id="'
        			+tagindex+'"><label for="'+tagindex+'">#'+emoInput+'<i class="far fa-times-circle"></i></label></div>';
        			inputTag.value='';
        			inputTag.focus();
        		} else {
        			alert('동일한 아이디로 책 한권당 1개의 태그만 가능합니다.');
        			inputTag.value='';
        			inputTag.focus();
        		}
        	},
        	error: function(xhr,status,error) {
        		alert("오류");
        	}
        });
      }

      /* 내 해시태그 삭제하기 */
      hashTagBox.addEventListener('click', (event) => {
    		if(event.target.localName == "i") {
    			const parevent = event.target.parentNode.parentNode;
    			delItem(parevent);
    		}  
      });
      
      function delItem(parent) {
    	  const tagwrap = document.querySelectorAll('.hashTag .hash_tag_wrap');
    	  const usernm = document.querySelector('#member_name').value;
          const bookid = document.querySelector('#book_id').value;
          
          $.ajax({
          	url:"/member/setdetailInfo",
          	data: {
          		 "status" : "D",
          		 "member_name" : usernm, 
          		 "book_id": bookid
          	},
          	success:function(rs) {
          		console.log(rs);
          		if(rs > 0) {
          			parent.remove();
          			if(tagwrap.length == 1) {
          				location.reload();
          			} 
          		}
          	},
          	error: function(xhr,status,error) {
          		alert("오류");
          	}
          });
      }
      
    </script>
    <script>
    /* 하트 클릭 */
    const heart = document.querySelector('.heartClick i');
    let countLike = document.querySelector('.countLike');
    let loveCnt = Number(countLike.innerHTML);
    const memId = document.querySelector('#member_name');
    const heartDefault = document.querySelector('.heartClick span');

	if(heartDefault) {
		heartDefault.addEventListener('click', () => {
			if(!confirm('로그인 후 가능합니다. 로그인하시겠습니까?')) {
				return;
			}
			alert('로그인 페이지로 이동합니다.');
			location.href="/login";	
		});
	}	
	
	if(heart) {
		heart.addEventListener('click', (event) => {
		       const target = event.target;
		       	if(target.getAttribute('class') == "fas fa-heart") {
		           	target.setAttribute('class', "far fa-heart" );
		                changeHeart("N");
		       	} else {
		            target.setAttribute('class', "fas fa-heart" );
		                changeHeart("Y");
		        }
		});	
    }

function changeHeart(yn) {                		    	
    const status = document.querySelector('#status');
    const dupCheck = document.querySelector('#dup_chk');
    const memName = $('#member_name').val();
    const bookId = $('#book_id').val();
    const dupChk = status.value == '0' ? 'I' : 'U';
                    
    $.ajax({
     	url : "/member/heartCheck.do",
        data : {
           "dup_chk" : dupChk,
           "member_name" : memName,
           "book_id" : bookId,
           "heart_yn" : yn
        },
        success : function(rs) {
        	status.value = '1';
        	countLike.innerHTML = rs.loveChk;
        	$('#heart_yn').val(yn);

        },
        error : function(xhr, error) {
             alert('오류');
        }
      });                    
    }

    </script>
	<script>
	/* 찜하기 버튼 */
    const zzim = document.querySelector('#zzim_chk')
    const status = document.querySelector('#status');
    const zzimBtn = document.querySelector('.zzimBtn');
    const bookId = document.querySelector('#book_id').value;
    const memName = document.querySelector('#member_name').value;
    
    zzimBtn.addEventListener('click', () => {
    	if(!memName) {
    		if(!confirm('로그인 후 가능합니다. 로그인하시겠습니까?')) {
				return;
			}
			alert('로그인 페이지로 이동합니다.');
			location.href="/login";
			return;
    	}
    		if(!confirm('찜하시겠습니까?')) {
    			return;
    		}
    		if(zzim.value == '1' && status.value == '1') {
    			alert('이미 찜하기 목록에 존재합니다.');
    			return;
    		}
    		gozzim();
    });
    
    function gozzim() {
    	 const status = document.querySelector('#status');
    	 const dupChk = status.value > 0 ? 'U' : 'I';
    	 
    	$.ajax({
    		url: "/member/mypageInfo",
    		type : 'POST',
    		data: {
    			"dup_chk" : dupChk,
    			"zzim_yn" : "Y",
    			"book_id" : bookId, 
    			"member_name" : memName
    		}, 
    		success: function(rs) {
    			const zzim = document.querySelector('#zzim_chk');
    			if(zzim.value > 0) {
    				alert('이미 찜하기 목록에 존재합니다.');
    			} else {
    				 alert('찜하기가 완료되었습니다.');
    				 $('#status').val('1');
    				 $('#zzim_chk').val('1');
    			 }
    		},
    		error: function(xhr, error) {
    			alert('오류' + error);
    		}
    	});
    }
    
    /* 좋아요한 사람들 팝업창 */ 
    const likemodalBtn = document.querySelector('#peopleChkBtn');
    const likemodal = document.querySelector('.likemodal');
    
    if(peopleChkBtn) {
    	likemodalBtn.addEventListener('click', () => {
    		likemodal.classList.add('invisible');
    	});
    }
    const modalOpen = document.querySelector('#modalOpen');
    modalOpen.addEventListener('click', () => {
    	likemodal.classList.remove('invisible');
    });

    function showUserpage(nm) {
    	const memId = document.querySelector('#member_name').value=nm;
    	$('#frm').attr('action', '/member/mypage');
    	$('#frm').submit();
    }
    </script>
    <script> 
    /* viewer 페이지로 이동 */
    function goViewer() {
    	if(${orderchk} == 0 && ${sessionScope.userId == null}) {
    		if(!confirm('구매 후 이용 가능합니다. 로그인하시겠습니까?')) {
    			return;
    		}
    		alert('로그인 페이지로 이동합니다.');
    		location.href = '/login';
    		return;
    	} 
    	
    	if(${orderchk} == 0 && ${sessionScope.userId != null}) {
    		alert('구매 후 이용 가능합니다. 구매 버튼을 눌러주세요.');
    		return;
    	}
    	
    	$('#frm').attr('action', '/book/showViewer');
    	$('#frm').submit();
    }
    
    /* 마이페이지가기 */
    function goMypage(num) {
    	$('#frm').attr("action", "/member/mypage");
    	$('#frm').submit();
    }
    
    /* 해당 책 상세페이지로 가기 */  	
    function goView(num) {
     	$("#book_id").val(num);
       $("#frm").attr("action","/member/detail");
       $("#frm").submit();
     }  
    
    /* 바로구매 버튼 */
    function goOrder() {
    	const memNm = document.querySelector('#member_name').value;
    	if(memNm == '' || memNm == null) {
    		if(!confirm('로그인 후 구매 가능합니다. 로그인하시겠습니까?')) {
				return;
			}
			alert('로그인 페이지로 이동합니다.');
			location.href="/login";
			return;
    	}
    	if(${orderchk} > 0) {
    		alert('이미 구매한 도서입니다. ID당 도서 1개씩만 구매 가능합니다.');
    		return;
    	}
    	$('#frm').attr("action", "/member/paycheck.do");
    	$('#frm').submit();
    }
	</script>
</body>
</html>