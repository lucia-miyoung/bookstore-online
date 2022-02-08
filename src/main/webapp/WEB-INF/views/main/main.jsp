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
  <link rel="stylesheet" href="../../../resources/css/main.css" />
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
  <div class="container">
          <form id="frm" method="post">
           	<input type="hidden" id="member_name" name="member_name" value="${sessionScope.userId }"/>
			<input type="hidden" id="book_id" name="book_id" value="" />
          </form>
    <div class="head">
      <div class="head-upper">
        <div class="logo">
          <a href="#">
            <h2>NATIONAL BOOKSTORE</h2>
          </a>
        </div>
        <div class="search-wrapper">
          <div class="filter">
            <ul>
              <li class="selected">제목</li>
            </ul>
          </div>
          <form  method="GET" id="cfrm"> 
            <button id="search-button"><span class="far fa-search"></span></button>
            <input id="search-input" name="keyword" type="text" placeholder="제목, 저자, 해쉬태그 검색" autocomplete="off" spellcheck="false"
            onkeydown="javascript:if (event.keyCode == 13){ goSearch();}"
            value=""/>        
            <input id="search-type" type="hidden" name="type" value="title">
          	<div class="search-result" style="display:none;">
              <ul style="padding: 15px; color: gray;">
              <c:choose>
				<c:when test="${bookList.size() > 0}">
                <c:forEach var="book" items="${bookList}">
              		<li class="invisible"><a href="javascript:ongoSearch('${book.book_name }');">${book.book_name }</a></li>
              	</c:forEach>
              	</c:when>
				<c:otherwise>
					<span> 검색한 내용이 없습니다. </span>
				</c:otherwise>
				</c:choose>
              </ul>
            </div>
	 	 </form> 
        </div> 
      </div>
      <div class="head-lower">
        <nav class="lnb">
          <ul>
            <li>
              <a href="javascript:goview();">
                <span>내 서재</span>
              </a>
            </li>
            <li>
              <a href="javascript:notopenyet();">
                <span>베스트 셀러</span>
              </a>
            </li>
            <li>
              <a href="javascript:notopenyet();">
                <span>도서 구매</span>
              </a>
            </li>
            <li>
              <a href="javascript:notopenyet();">
                <span>이벤트</span>
              </a>
            </li>
          </ul>
          <div class="accent-slider"></div>
        </nav>
      </div>
       
    </div>
    <div class="body-wrapper">
      <section class="recommendation">
        <div class="left-section">
          <h2>오늘의 추천도서</h2>
          <div class="slider-wrapper slider-window infinite-slider-window">
            <div class="prev button-wrapper">
              <svg fill="#ffffff" height="2em" width="1em" viewBox="0 0 40 40">
                <g>
                  <path d="m28.5 12.5l-5-5-12.5 12.5 12.5 12.5 5-5-7.5-7.5 7.5-7.5z"></path>
                </g>
              </svg>
            </div>
            <div class="next button-wrapper">
              <svg fill="#ffffff" height="2em" width="1em" viewBox="0 0 40 40">
                <g>
                  <path d="m16 7.5l-5 5 7.5 7.5-7.5 7.5 5 5 12.5-12.5-12.5-12.5z"></path>
                </g>
              </svg>
            </div>
            <div class="slider-indicator">
              <ul>
              	<c:forEach begin="1" end="${todayBook.size()}" step="1" var="todayCount">
              		<c:choose>
              			<c:when test="${todayCount == 1 }">
              				<li class="active"><label for=""><input type="radio"></label></li>
              			</c:when>
              			<c:otherwise>
              				<li><label for=""><input type="radio"></label></li>
              			</c:otherwise>
              		</c:choose>
              	</c:forEach>
              </ul>
            </div>
            <div class="slider infinite-slider">
            	<c:forEach items="${bookList}" var="list" varStatus="status"
			 	begin="6" end="12">
            		<div class="slide infinite-slide">
            		<a href="#"><img src="/bookImg/book${list.book_id}.jpg" alt=""></a></div>
            	</c:forEach>
            </div>
          </div>
        </div>
        <div class="right-section">
          <h2>
            <c:choose>
            	<c:when test="${sessionScope.userId != null }">
            		<a href="#">${sessionScope.userId } 님에게 추천 해드리는 도서</a>
            	</c:when>
            	<c:otherwise>
            		<a href="javascript:void(0)"><span></span> 회원님에게 추천해드리는 추천도서~!</a>
            	</c:otherwise>
            </c:choose>
          </h2>
 
          <div class="bookshelf-wrapper">
            <div class="shelf">
              <div class="bookend-left"></div>
              <div class="bookend-right"></div>
              <div class="reflection"></div>
              <ul>
              	<c:forEach var="list" items="${bookList}" varStatus="status" begin="16" end="19">
              		<li>
                  		<a href="javascript:goView('${list.book_id}');">
                    	<img src="/bookImg/book${list.book_id}.jpg" width="65px" height="85px" alt="">
                  		</a>
                	</li>
              	</c:forEach>
              </ul>
            </div>
            <div class="shelf">
              <div class="bookend-left"></div>
              <div class="bookend-right"></div>
              <div class="reflection"></div>
              <ul>
              <c:choose>
				<c:when test="${bookList.size() > 0}">
			 	<c:forEach items="${bookList}" var="list" varStatus="status" begin="5" end="9">
                <li>
                  <a href="javascript:goView('${list.book_id}');">
                    <img src="/bookImg/book${list.book_id}.jpg" alt="">
                  </a>
                </li>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<span> 책이 없습니다. </span>
				</c:otherwise>
				</c:choose>
              </ul>
            </div>
            <div class="shelf">
              <div class="bookend-left"></div>
              <div class="bookend-right"></div>
              <div class="reflection"></div>
              <ul>
                 <c:choose>
				<c:when test="${bookList.size() > 0}">
			 	<c:forEach items="${bookList}" var="list" varStatus="status" begin="10" end="14">
                <li>
                  <a href="javascript:goView('${list.book_id}');">
                    <img src="/bookImg/book${list.book_id}.jpg" alt="">
                  </a>
                </li>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<span> 책이 없습니다. </span>
				</c:otherwise>
				</c:choose>
              </ul>
            </div>
          </div>
        
        </div>
      </section>
      <section class="trending">
        <h2 class="section-heading">
          <div class="clock">
            <i class="fas fa-clock"></i>
            <span></span>
          </div>
          <!-- 사람들이 많이 읽은 책 -->
        </h2>
          
        <div class="list-container">
          <ul>
          	<c:set var="count" value="${1}"/>
          	<c:forEach var="read" items="${bestReadBook }">
          		<li>
              	<a href="${pageContext.request.contextPath}/book/bookdetail?booknumber=${read.bookNum}">
                	<div class="img-wrapper">
                  		<img src="${pageContext.request.contextPath}${read.bookThumbnail}" alt="">
                	</div>
                	<div class="text-wrapper">
                  	<div class="ranking">
                    	<h3><c:out value="${count }"/> </h3>
                  	</div>
                  	<div class="meta-data">
                    	<span class="title">${read.bookTitle }</span>
                    	<span class="author">author</span>
                  	</div>
                	</div>
              	</a>
            </li>
            <c:set var="count" value="${count + 1 }"/>
          	</c:forEach>
          </ul>
        </div>
      </section>
      <section class="paperbook-sale content-area fadeInUp">
        <h2 class="section-heading">빈 책장을 채우는 기회</h2>
        <div class="content-wrapper">
          <h3><span class="fal fa-file-check"></span>이달의 할인</h3>
          <div class="list-container flexible-slider-window">
            <ul class="flexible-slider"> 
              <c:forEach var="sale" items="${saleList}">
              			<li class="flexible-slide">
                			<a href="javascript:goView('${sale.book_id}');">
                  		<div class="thumbnail-wrapper">
                    		<span class="discount-rate">${sale.sale }<span>%</span></span>
                    		<img src="/bookImg/book${sale.book_id}.jpg" alt="">
                  		</div>
                  		<div class="text-wrapper">
                    		<strong>${sale.book_name }</strong>
                    		<span>${sale.book_author }</span>
                    		<span class="org_price" style="font-size:13px;">${sale.book_price }</span>
                    		<span class="sale_price" style="color:red; font-weight:bold;">${sale.sale_price }</span>
                  		</div>
                		</a>
              		</li>
              </c:forEach>
            </ul>
          </div>
        </div>
      </section>
      <section class="recent-posts content-area fadeInUp">
        <h2 class="section-heading">최신 리뷰엉이</h2>
        <div class="content-wrapper">
          <ul>
          	<c:forEach var="review" items="${reviewList}">
          		 <li>
              <div class="profile-thumbnail-wrapper">
                <a href="javascript:goView('${review.book_id }')">
                  <img src="/bookImg/book${review.book_id}.jpg" width="42px" height="42px" alt="">
                </a>
              </div>
              <div class="message-bubble">
                <a href="javascript:goView('${review.book_id }')" class="user-nickname">${review.member_name }</a>
                <div class="message-wrapper">
                  <span class="message">
                    <pre>${review.review_content }</pre>
                  </span>
                  <small class="date">${review.review_date }</small>
                </div>
              </div>
            </li>
          	</c:forEach>
          </ul>
        </div>
      </section>
    </div>
  </div>        
  <footer class="main-footer">
    <div class="footer-above">
      <div class="container">
        <ul>
          <li><a href="/member/notice">공지사항</a></li>
          <li><a href="javascript:gopage('/common/servicecenter');">1:1 문의</a></li>
          <li><a href="/common/showqstlist/">FAQ</a></li>
          <li><a href="#">회사소개</a></li>
          <li><a href="/member/notice">이용약관</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-below">
      <div class="container">
        <div class="customer-service">
          <h3>고객센터 070 - 2745 - 4257</h3>
          <p>영업시간 평일 09:00 ~ 17:00</p>
        </div>  
        <hr />
        <div class="company-information">
          <p><span>상호</span> National Bookstore</p>
          <p>서울시 종로구 묘동 돈화문로 26</p>
          <p><span>사업자등록번호</span> 623-25-72312 / 통신판매번호: 제 2008-서울종로 26-03128호</p>
          <p><span>광고/제휴문의</span> 070 - 2745 - 7524 / marketing@nationalbookstore.com</p>
        </div>
        <div class="copy-right">
          <p><span>© 2020. (주)National Bookstore. All Rights Reserved</span></p>
        </div>
      </div>
    </div>
  </footer>
  <!-- activate 'home' tab -->
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
        <!-- search preview ajax request -->
        <script>
        /* 검색 미리보기 */
        	const searchInput = document.querySelector('#search-input');
        	const searchResult = document.querySelector('.search-result');
        	const searchList = document.querySelectorAll('.search-result > ul > li');	
        		searchInput.addEventListener('keyup', () => {
        			
        			const searchVal = searchInput.value.trim().replace(/ /g, '');
        			if(searchVal.length > 0) {
        				searchResult.style.display = "block";
        				goPreview(searchVal);
        			}
        			else {
        				searchResult.style.display = "none";
        			}
        		});
        		
        	 /* searchInput.addEventListener('blur', () => {
        			searchResult.style.display = "none";
        		});  */
        		
        	const searchBtn = document.querySelector('#search-button');
        	searchBtn.addEventListener('click', (event) => {
        		
        		 const searchVal = searchInput.value.trim().replace(/ /g, '');;
        		if(searchVal.length == 0) {
        			alert('검색어를 입력해주세요.');
        			return;
        		}  
        		goSearch();
        	});
        	function goPreview(value) {
        		
        		searchList.forEach(list => {
        			const text = list.textContent;
    				const textVal = text.trim().replace(/ /g, '');
    				if(text.indexOf(value) > -1 || textVal.indexOf(value) > -1) {
    					list.classList.remove('invisible');
    				} else {
    					list.classList.add('invisible');
    				}
    			});
        	}
        	
        function goSearch() {
        	$('#cfrm').attr('action', '/book/search');
        	$('#cfrm').submit();
        }	
        
        function ongoSearch(name) {
        	$('#search-input[name=keyword]').val(name);
        	$('#cfrm').attr('action', '/book/search');
         	$('#cfrm').submit(); 
        }	
        		
        </script>
        <script>
        /* 검색 카테고리 필터 */
          $(document).ready(function() {
            const filterList = document.querySelector('.head .search-wrapper .filter ul');
            const filterMenus = ['제목', '저자'];
            const filterItems = {
              '제목': 'title',
              '저자': 'author'
            };
            const filterHiddenInput = document.querySelector('.search-wrapper input[name="type"]');

            filterList.addEventListener('click', event => {
              filterList.classList.toggle('active');
              // append other menu lists on click
              if (filterList.classList.contains('active')) {
                filterMenus.forEach(menu => {
                  if (menu === event.target.textContent) return;
                  const list = document.createElement('li');
                  list.textContent = menu;
                  filterList.appendChild(list);
                });
              }
              // switch to selected menu list
              else {
                filterList.innerHTML = '';
                event.target.classList.add('selected');
                filterHiddenInput.value = filterItems[event.target.textContent];
                filterList.appendChild(event.target);
              }
            });
          });
        </script>
      <script>
      /* 내 서재가기 */
      function goview() {
    	  const memNm = document.querySelector('#member_name').value;
    	  if(memNm == '') {
    		  if(!confirm('로그인이 필요합니다. 로그인하시겠습니까?')) {
    			  return;
    		  }
    		  $('#frm').attr('action', '/login');
    		  $('#frm').submit();
    		  return;
    	  }
    	  $('#frm').attr('action', '/member/myaccount');
    	  $('#frm').submit();
      }
      /* 오픈 전 페이지 */
      function notopenyet() {
    	  alert('아직 오픈 준비 중입니다.');
      }
      
      </script>
      <!-- make it sticky on scroll -->
      <script>
      /* 헤더 sticky */
        $(document).ready(function() {
          const headLower = document.querySelector('.head .head-lower');
          window.addEventListener('scroll', () => {
            if (headLower.getBoundingClientRect().top < 0)
              headLower.classList.add('sticky');
            else
              headLower.classList.remove('sticky');
          });
        });
      </script>
      <!-- move accent slider on hover -->
      <script>
        $(document).ready(function() {
          const accentSlider = document.querySelector('.lnb .accent-slider');
          const lnbMenus = [...(document.querySelectorAll('.lnb li'))];
          const lnb = document.querySelector('.lnb');

          lnbMenus.forEach((menu, index) => {
            menu.addEventListener('mouseover', () => {
              accentSlider.classList.add('isBeingHovered');
              menu.classList.add('isBeingHovered');
              accentSlider.style.transform = 'translateX(' + 100 * index + '%)';
            });
            menu.addEventListener('mouseout', () => {
              menu.classList.remove('isBeingHovered');
            });
          });

          lnb.addEventListener('mouseout', () => {
            accentSlider.classList.remove('isBeingHovered');
          });
        });
      </script>
	<script>
        /* 해당 책 상세페이지로 가기 */  	
         function goView(num) {
          	$("#book_id").val(num);
            $("#frm").attr("action","/member/detail");
            $("#frm").submit();
          }        
          		
         const prices = document.querySelectorAll('.sale_price');
           prices.forEach(price => {
           let newprice = price.textContent.split('.')[0];
           price.textContent = newprice + "원";
         });
          		
         function gopage(url) {
        	 const userid = document.querySelector('#member_name').value;
        		if(userid == '' || userid == null) {
        		 alert('1:1 문의는 로그인 후 가능합니다.');
        		 return;
        	 }
        	 $("#frm").attr("action", url);
             $("#frm").submit();
         }
     </script>
     <!-- emphasize shelf on hover -->
         <script>
            $(document).ready(function() {
              const bookshelfWrapper = document.querySelector('.recommendation .bookshelf-wrapper');
              const bookshelfList = [...(bookshelfWrapper.querySelectorAll('.shelf'))];
              let previousShelf = undefined;
              bookshelfWrapper.addEventListener('mouseover', event => {
                const bookshelf = bookshelfList.filter(bookshelf => bookshelf.contains(event.target))[0];

                // if bookshelf to be emphasized is the same bookshelf as previously selected then ignore
                if (!bookshelf || previousShelf === bookshelf) return;
               
                bookshelfList.forEach(bookshelf => bookshelf.classList.remove('emphasized'));
                bookshelf.classList.add('emphasized');

                previousShelf = bookshelf;
              });
            });
          </script> 
        <!-- initialize clock -->
        <script>
          $(document).ready(function() {
            const clock = document.querySelector('div.clock span');
            function updateClock() {
              const date = new Date();
              const hour = date.getHours();
              const minutes = String(date.getMinutes()).length === 1 ? '0' + date.getMinutes() : date.getMinutes();
              const timeString = hour + '시 ' + minutes + '분';
              clock.textContent = timeString;
            }
            // initialize clock
            updateClock();

            // renew clock every second
            setInterval(function() {
              updateClock();
            }, 1000);
          });
        </script>
</body>
</html>