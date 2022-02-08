<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%--  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
   <script src="https://kit.fontawesome.com/3fb56dfe63.js" crossorigin="anonymous"></script>
	<link href="https://fonts.googleapis.com/css?family=Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="../../../resources/css/reset.css" />
    <!-- individual page stylesheet -->
    <link rel="stylesheet" href="../../../resources/css/mypage.css">
    <link rel="stylesheet" href="../../../resources/css/common.css" />
    <script src="../../../resources/js/common.js"></script>
    <script type="text/javascript" src="/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-ui-1.10.3.custom.js"></script>
  
</head>
<body>
<!-- 
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="member"/>
</sec:authorize> -->
<header class="topbar">
        <nav>
            <div class="container">
                 <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
                <h2>${ paramMap.member_name } 님의 서재</h2>

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

<div class="wrapper">
	<form id="frm" method="post">
	 <c:forEach items="${paramMap}" var="map">
		<input type="hidden" name="${map.key }" id="${map.key }" value="${map.value }" >
		<input type="hidden" name="reviewdupChk" id="reviewdupChk" value="${reviewdupChk }"/>
	</c:forEach>
	</form>

<div class="firstColumn">
<!-- 배경화면 넣는곳 -->
<div class="follow">

<%--    	<c:if test="${showdata.mile}"> --%>
   <%-- 		<c:if test="${showdata.follow1 eq null}"> --%>
   <c:if test="${paramMap.member_name != sessionScope.userId }">
   			<button type="button" id="followBtn"> <i class="fas fa-plus-circle"></i> 팔로우 </button>
  </c:if>
    <%--  	</c:if>  --%>
     	<%-- <c:if test="${showdata.follow1}">
     		<button type="button" id="followBtn2"><i class="fas fa-minus-circle"></i>팔로우</button>
     	</c:if>
     </c:if>    --%> 
   
  </div>
<div class="bigbox">
<div class="myImage"> 
    <a href="/image${userdata.member_image}"><img id="myFaceImage" src="/image${userdata.member_image}" ></a>   
	<c:if test="${paramMap.member_name == sessionScope.userId }">
		<span id="point"><span>${showdata.mile}</span>miles</span>
	</c:if>
</div>
<div class="myNickname">
		<a> ${ paramMap.member_name }  </a> 님의 서재 
</div>
</div>
<div class = "manyBtn">
    <ul>
        <li><a href="#"> 찜한 책 <b>( ${paramMap.member_name != null ? zzimbookcount : '-' } )</b> </a></li>
        <li><a href="#"> 좋아요 <b>( ${paramMap.member_name != null ? likebookcount : '-' } )</b> </a></li>
   	    <li><a href="#" id="modalOpen"> 팔로우 <b>( 0 )</b> </a></li>
    </ul>
</div>
<div class="goSubscribe">
<c:if test="${checkId eq false}">
<a href="goSubscribe.jsp"> 
  <b> 정기구독 시작 </b><br>
  <em> 바로가기 </em> 
  <i class="fas fa-arrow-circle-right"></i>
</a>
</c:if>
</div>
</div>
<!-- firstColumn end -->

<div class="secondColumn">
    <div class="consBtn">
    <input type="radio" name="myPage" id="mybookcart" value="mybookcart" data-name="cart" checked><label for="mybookcart">카트</label>
   	<c:if test="${sessionScope.userId == paramMap.member_name}">
   	 	<input type="radio" name="myPage" id="mybook" value="mybook" data-name="post"><label for="mybook"> 포스트</label>
   	</c:if>
  	<input type="radio" name="myPage" id="myorder" data-name="order"><label for="myorder">책장</label>
    </div>
     <div class="content one invisible" data-name="order">
        <div class="mybookTitle">
            <a> ${orderList.size()} </a> 권의 도서
        </div>
         <c:choose>
          <c:when test="${paramMap.member_name != null && orderList.size() >0 }">
        <div class="myBookbook">
          <ul>
            <c:forEach var="list" items ="${orderList}">
						<li><a href="javascript:goView('${list.book_id}');">
							<div class="books">
								<div class="mybookimage">
										<img src="/bookImg/book${list.book_id}.jpg" alt="없음">
								</div>
								<div class="names">
									<strong>${list.book_name}</strong> <br> <span>${list.book_author}</span>
								</div>
							</div> <!-- books end -->
						</a></li>
			</c:forEach>
          </ul>
   		 </div> <!-- myBookbook end -->  
   		 </c:when>     
           	<c:otherwise>
           		 <div class="mybook_Content">
        	   	<i class="fas fa-book"></i>
        	    	<span> 구매한 도서가 없습니다.</span>
      		     </div>
           	</c:otherwise>
          </c:choose>  	
    </div>
     <div class="content two" data-name="cart">
        <div class="mybookTitle">
            <a>${paramMap.member_name != null ? zzimbookcount : '-' }</a> 개의 책장
        </div>
    
        <div class="ebooks">
            <div class="listTitle">
              <span> 찜 목록 </span>
            </div>
            
            <c:if test="${sessionScope.userId == paramMap.member_name}">
            <div class="totalBtn">
              <label for="allChk">
              <input type="checkbox" name="allChk" id="allChk"> 전체선택
              </label>    
              <button type="button" id="deleteBtn"> 선택삭제 </button>   
            </div>
           	<button type="button" class="buyBtn">구매하기</button>
            </c:if>

            <div class="ebookList" id="ebooklist" > 
            <form id="chkform" >
               <c:choose>
               	
                  <c:when test="${paramMap.member_name != null && zzimList.size() >0 }">
                   <table>
                    <c:forEach items="${zzimList}" var="book" >
                     <tr>
                     	<c:if test="${sessionScope.userId == paramMap.member_name}">
                        <td>
                        <input type="hidden" name="member_name" value="${sessionScope.userId}"/>
                        <input type="checkbox" name="chkbox" id="chkbox" value="${book.book_id}"></td>
                        </c:if>
                        <td>
                          <a href="javascript:goView('${book.book_id}');"> 
                  			<img src="/bookImg/book${book.book_id}.jpg" alt="없음">
                  		  </a>
                  		</td>
                  		<td>
                    		<ul>
                      			<li> <strong>${book.book_name}</strong> </li>
                      			<li> <a>${book.book_author} 지음</a>  </li>
                      			<li> <span>${book.book_type}</span></li>
                    		</ul>
                  		</td>
                <c:if test="${checkId eq false}">
                  <td><button type="button" id="goRead">바로보기</button>
                  <a href="/booklist/deleteLibList?booknum=${book.bookNum }" id=eachDelete>삭제</a></td>
                  </c:if>
                </tr>
                       </c:forEach>   	
                       </table>		
                     </c:when>        
                     <c:otherwise>
                         <span style="display:block; text-align: center; padding: 100px 0;"> <i class="fas fa-books"></i>
                         찜한 도서가 없습니다. </span>    
                     </c:otherwise>
             </c:choose>     
             </form>        
          </div>
    </div>
    </div>

     <div class="content four invisible" data-name="post" style="background-color:#fff;">
        <div class="mybookTitle">
        	   나의 포스트 <a>${reviewList.size()}</a> 개
        </div>
        <c:if test="${orderCnt > 0}">
        	<div class ="postInputBtn">
        		<button type= "button" id = postInput onclick="onOpenpost();"> <i class="fas fa-pencil-alt"></i> 포스트 작성</button>
        	</div> 
         </c:if>
        <div class="myPostCheck" id="myPostCheck">
         <c:choose>
          <c:when test="${reviewList.size() > 0}">
          <table>
          <c:forEach var="list" items="${reviewList}">
                <tr>
                    <th> 도서명 </th>	
                    <th> 점수 </th>
                    <th> 등록날짜 </th>
                    <th> 삭제 </th>
                </tr>
                <tr>
                	<td>${list.book_name}</td>
                	<td>
			<div class="mystarScore">
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
					 	<span class="bookScore" style="display:none;">
					 		${(list.review_score != null || list.review_score != '') ?  list.review_score : 0}
					 	</span>
				</div>

					</td>
                  <td>${list.review_date}</td>
                  	<td> <a href="javascript:ondeletereview('${list.book_name}', '${list.book_id}');"><i class="fas fa-trash-alt"></i></a></td>
                </tr>   
                <tr> 
                    <td colspan="4" style="border-bottom: 2px solid gray; padding-bottom:10px;">
                      <div class="inputs" style="border: 1px solid lightgray; border-radius: 4px;">
                      	<input type="text" name="postTitleChk" id="postTitleChk" 
                      value="${list.review_title}" readonly/> 
                      <input type="text" name="postText" id="postText" readonly 
                      value="${list.review_content}" /> 
                      </div>                      
                    </td>
                	</tr>
           </c:forEach>
           </table>
         </c:when>
         <c:otherwise>
         	<h3> 작성된 포스트가 없습니다. </h3>
         </c:otherwise>
	   </c:choose> 
    </div>
  <form id="postRegister" method="post">  
     <div class="postInsert invisible" id="postInsert">
       <div id="selWrap">
        <div class="selectInput">
            <span class="default">${orderList[0].book_name}</span><span class="defaultId" style="visibility:hidden;">${orderList[0].book_id}</span>
            <i class="fas fa-chevron-down"></i>
        </div>
        <div class="selectResult invisible" style="z-index:2;">
            <ul>
            	<c:forEach var="list" items ="${orderList}">
               	 	<li data-id="${list.book_id}">${list.book_name}</li>
                </c:forEach>
            </ul>
        </div>
    </div>    
     
      <div class="starWrap">
        <div class="starLabel" style="z-index:1;">
            <label for="start1">
                <input type="radio" name="star" id="start1" value="0.5"/>
            </label>
            <label for="start2">
                <input type="radio" name="star" id="start2" value="1"/>
            </label>
            <label for="start3">
                <input type="radio" name="star" id="start3" value="1.5"/>
            </label>
            <label for="start4">
                <input type="radio" name="star" id="start4" value="2"/>
            </label>
            <label for="start5">
                <input type="radio" name="star" id="start5" value="2.5"/>
            </label>
            <label for="start6">
                <input type="radio" name="star" id="start6" value="3"/>
            </label>
            <label for="start7">
                <input type="radio" name="star" id="start7" value="3.5"/>
            </label>
            <label for="start8">
                <input type="radio" name="star" id="start8" value="4"/>
            </label>
            <label for="start9">
                <input type="radio" name="star" id="start9" value="4.5"/>
            </label>
            <label for="start10">
                <input type="radio" name="star" id="start10" value="5"/>
            </label>
        </div>
        <div class="starDefault" style="z-index:1;">
           <i class="far fa-star"></i>
           <i class="far fa-star"></i>
           <i class="far fa-star"></i>
           <i class="far fa-star"></i>
           <i class="far fa-star"></i>
        </div>
        <div class="starFull" style="z-index:0;">
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
            <i class="fas fa-star"></i>
        </div>
    </div>
	     <span class="starScore"> <span>0</span> 점</span>
            <input type="text" name="review_title" id="postTitle" placeholder="제목을 입력하세요"/>
            <input type="text" name="review_content" id="post_Content" placeholder="한줄 리뷰를 남겨주세요."/>
            <div class="postEndBtn">
                <button type="button" id="postSave"> 저장 </button>
                <button type="button" id="postCancel" onclick="onClickSubmit('취소')"> 취소 </button>
            </div>
             </div> 
          </form>
     </div>
</div>
</div>
</div>
<!-- 팔로우 모달창 -->
<div id ="modalGo" class="modal">  
  <div class="modal_content">
    <span id="modalCloseBtn">
      <button type="button" > <i class="fas fa-times-circle"></i> </button>
  </span>

  <span class="followNum">
    <i class="fas fa-user-plus"></i> 팔로우한 사람들
  </span>

  <div class = "likeList"> 
  <ul>
    <c:choose>
    <c:when test="${followerList.size() > 0 }">
	<c:forEach var="foll" items="${followerList }">
          <li><img id="myFace" src="${pageContext.request.contextPath }/resources/images/default.png" ></li>
          <li><a href="/booklist/myLibList?clickId=${foll.fkMemberFollow2 }"> ${foll.memberNickName} </a>님</li>
     </c:forEach>
     </c:when>
     <c:otherwise>
     	<li><img id="myFace" src="${pageContext.request.contextPath }/resources/images/default.png" ></li>
     	<li>친애하는 셀럽님이 없습니다</li>
     </c:otherwise>
</c:choose>
          </ul>
    </div>
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
	/* 상세페이지 가기 */
    function goView(num) {
    	const id = $('#member_id').val();
    	const load = "/member/detail?member_id="+ id + "&book_id=" + num;
    	$('#frm').attr('method', 'post'); 
    	$('#frm').attr('action', load);
    	$('#frm').submit();
    }
	
	/* 찜한 책 삭제하기 */
	const deleteBtn = document.querySelector('#deleteBtn');
	const chkboxs = document.querySelectorAll('#chkbox');
	if(deleteBtn) {
		deleteBtn.addEventListener('click', () => {
			let chkArray = [];
				chkboxs.forEach(box => {
					if(box.checked) {
					const chkVal = box.value;
						chkArray.push(chkVal);
					}
				});			
				if(chkArray == null || chkArray == '') {
					alert('선택된 도서가 없습니다.');
					return;
				}
				ondeletezzim(chkArray); 
		});
	}

    function ondeletezzim(array) {
    	const memName = document.querySelector('#member_name').value;
    	
    	$.ajax({
    		url : "/member/setmypageInfo",
    		type : 'POST',
    		async: true,
    		data : {
    			"status" : 'D',
    			"member_name" : memName,
    			"chk_array" : array
    		},
    		success: function(rs) {
    			if(!confirm("선택하신 책을 삭제하시겠습니까?")){
    				return;
    			}
    			
    			alert('삭제가 완료되었습니다.');
				$('#frm').attr('action', '/member/mypage');
    			$('#frm').submit();
    			$("input:radio[name='myPage']:radio[value='mybookcart']").prop('checked', true); 
    		},
    		error: function(xhr, error) {
    			alert('오류');
    		}	
    	});
    }
	</script>
    <!-- 도서 구매 -->
<script>
	/* 찜한 책 구매하기 */
	const buyBtn = document.querySelector('.ebooks .buyBtn');
	const checks = document.querySelectorAll('#chkbox');
	
	if(buyBtn) {
		buyBtn.addEventListener('click', () => {
			let chkArray = [];
			checks.forEach(box => {
				if(box.checked) {
				const chkVal = box.value;
					chkArray.push(chkVal);
				}
			});
			if(chkArray == null || chkArray == '') {
				alert('구매할 도서를 선택해주세요.');
				return;
			}
			onchkOrderdup(chkArray);
		});
	}
	
	/* 찜한책 중에서 구매한 책인지 확인(ID당 각 도서 1개 구매가능) */
	function onchkOrderdup(array) {
		const memName = document.querySelector('#member_name').value;
		
    	$.ajax({
    		url : "/member/setmypageInfo",
    		type : 'POST',
    		async: true,
    		data : {
    			"status" : 'R',
    			"member_name" : memName,
    			"chk_array" : array
    		},
    		success: function(rs) {
    			let num = rs.ordernumchk;
    			if(num > 0) {
    				alert("이미 구매한 도서 "+ num+"권이 있습니다. \nID당 각 도서 1권씩만 구매 가능합니다.\n재확인해주세요.");
    				return;
    			}
    			$("#chkform").attr('action', '/member/paycheck.do');
    			$("#chkform").submit();
    		},
    		error: function(xhr, error) {
    			alert('오류');
    		}
    		
    	});
    }
</script>
<script>
	/* 리뷰 글 삭제하기 */
 function ondeletereview(name, id) {
	 if(!confirm("'"+ name +"'의 리뷰를 삭제하시겠습니까?")) {
		 return;
	 }
	 
	 $.ajax({
		type:'post',
		url : "/member/review",
		data : { 
			"status" : 'D',
			"member_name" : '${sessionScope.userId}',
			"book_id": id
		},
		success: function(rs){
			alert('삭제되었습니다.');
			location.reload();
		},
		error: function(xhr, status, error) {
			console.log("error: " + error);
		}	
	 });
 }
</script>

<script>
	/* 마이페이지 탭 누르기 */
	const postChkCont = document.querySelector('.myPostCheck');
	const postInsCont = document.querySelector('.postInsert');
	const postCanCel = document.querySelector('.postCancel');
	const postInputBtn = document.querySelector('.postInputBtn');
	const cons = document.querySelectorAll('.content');
	const radioBtns = document.querySelectorAll('.secondColumn .consBtn input[type="radio"]');
	
 	 radioBtns.forEach((radio,index) => {
		 radio.addEventListener('click', (event) => {
			 const datanm = event.target.dataset.name;
			 const consnm = cons[index].dataset.name;
				cons.forEach(con=> {
					if(datanm == con.dataset.name) {
						con.classList.remove('invisible');
					} else {
						con.classList.add('invisible');
					}
				});
		 });
	 }); 
	 
 	 /* 주문한 책 리뷰 작성하러 가기 */
 	function onOpenpost() {		
		const conf = confirm('포스트를 작성하시겠습니까?');
		if(!conf) {
			return;
		}
		
		postChkCont.classList.add('invisible');
		postInsCont.classList.remove('invisible');
		postInputBtn.style.display='none';
	}
 
	function onClickSubmit(text) {
		if(text) {
			const conf = confirm(text + '하시겠습니까?');
			if(!conf) {
			return;		
			}
			postChkCont.classList.remove('invisible');
			postInsCont.classList.add('invisible');
		}
		
		postInputBtn.style.display='block';
	}
	 	
	/* 리뷰 등록할때, 별점 구현하기 */
	const reviewTitle = document.querySelector('#postTitle');
    const reviewCont = document.querySelector('#post_Content'); 
    const array  = [reviewTitle, reviewCont];	
	const saveBtn = document.querySelector('#postSave');
	saveBtn.addEventListener('click', () => {
	const starText = Number(document.querySelector('.starScore span').textContent);
	 
		for(let i=0; i<array.length; i++) {
	    	if(array[i].value.length == 0) {
	    		alert(array[i].placeholder);
	    		array[i].focus();
	    		return;
	    	}
	    }
	    if(starText == 0 ) {
			alert('별점을 등록해주세요.');
			return;
		}
		oninsertreview(); 
	});
	
    const memName = document.querySelector('#member_name').value;
   
	function oninsertreview() {	
		const starCnt = document.querySelector('input[name="star"]:checked').value;
		const bookNm = document.querySelector('.default').textContent;
		const bookId = document.querySelector('.defaultId').textContent;
		const postTitle = document.querySelector('#postTitle').value;
	    const postCont = document.querySelector('#post_Content').value;

    	$.ajax({
    		url : "/member/review",
    		type : 'POST',
    		data : {
    			"status" : 'I',
    			"member_name" : memName,
    			"book_name": bookNm,
    			"book_id" : bookId,
    		 	"star": starCnt,
    			"review_title" : postTitle,
    			"review_content" : postCont	
    		},
    		success: function(rs) {
    			if(rs.reviewdupChk > 0) {
    				alert('이미 리뷰 등록된 도서입니다.');
    				return;
    			}
    				alert('저장이 완료되었습니다.');
        			location.reload();
    		},
    		error: function(xhr, error) {
    			alert('오류');
    		}
    	});
	}
</script>

 <script>
 /* 체크박스 */
  var $allChk = $('#allChk');
  $allChk.change(function () {
      var $this = $(this);
      var checked = $this.prop('checked');
      $('input[name="chkbox"]').prop('checked', checked);
  });
</script> 

<script>

  var modal = document.getElementById('modalGo');
  var openBtn = document.getElementById('modalOpen');
  var closeBtn = document.getElementById('modalCloseBtn'); 

  openBtn.onclick = function() {
     modal.style.display = "block";
  }
  closeBtn.onclick = function() {
    modal.style.display = "none";
  }
 window.onclick = function(event){
     if(event.target==modal) {
         modal.style.display = "none";
 
     }
 }
 </script>
 
 
<!-- 주문 목록 select 기능 -->
<script>
        const selectInput = document.querySelector('.selectInput');
        const selectIcon = document.querySelector('.selectInput > i');
        const selectResult = document.querySelector('.selectResult');
        const selectList = document.querySelector('.selectResult > ul');
        const def = document.querySelector('.default');
        const defspan = document.querySelector('.defaultId');
        
        selectInput.addEventListener('click', () => {
            selectIcon.classList.toggle('open');
            selectResult.classList.toggle('invisible');
        });

        selectList.addEventListener('click', (event) => {
            if(event.target.nodeName == 'LI') {
                const value = event.target.textContent;
                def.textContent = value;
         		defspan.textContent = event.target.getAttribute('data-id');
                selectResult.classList.add('invisible');
                selectIcon.classList.toggle('open');
            }
        });

</script>

<!-- 별점 구현 (read) -->
<script>
	let starWidth = $('.mystarScore').width();
	/* const bookScore = Number(document.querySelectorAll('.mystarScore .bookScore').textContent.trim()); */
	const bookScore = document.querySelectorAll('.mystarScore .bookScore');
	const fullStar = document.querySelectorAll('.mystarScore #full');
	let starCnt = document.querySelectorAll('.mystarScore #default')[0];
		
	if(starCnt) {
		starCnt = starCnt.querySelectorAll('i').length;
	}
	bookScore.forEach((star, index) => {
		let num = Number(star.textContent.trim());
		let score = (starWidth/starCnt) * num;
		fullStar[index].style.width = score+"px";
	});

</script>

<!-- 별점 구현 (insert) -->
<script>
	const stars = document.querySelectorAll('.starWrap input[type="radio"]');
	const starFull = document.querySelector('.starFull');
	const starScore = document.querySelector('.starScore span');
	
	stars.forEach((star,index) => {
    	star.addEventListener('click', (event) => {
        	let starWidth = Number(16.88);
        	let inx = index + 1;
        	starFull.style.width = (starWidth * inx) +"px";
        	starScore.textContent = star.value;
    	});
	});
		
</script>
<script>
	let point = document.querySelector('#point > span');
	if(point) {
		point.textContent = Number(point.textContent).toLocaleString(); 
	}

</script>


</body>
</html>