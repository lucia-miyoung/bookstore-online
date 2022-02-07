<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>    
    <link href="https://fonts.googleapis.com/css?family=Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../../resources/css/service.css">
    <script src="https://kit.fontawesome.com/3fb56dfe63.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../../../resources/css/reset.css">
    <link rel="stylesheet" href="../../../resources/css/common.css">
</head>
<body>
   <header class="topbar">
		<nav>
			<div class="container">
				 <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
				<h2>고객 센터</h2>

				<div class="login-out">
					<c:choose>
						<c:when test= "${sessionScope.userId != null }">
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
<div class="bigBox">
      <div class="tabBox">
          <ul class="tabs">
                <li class="qstStay active" data-id="two" >           
                      문의내역
                </li>
                 <li class="qstAdd" data-id="one">
                      문의하기
                </li>
          </ul>
      </div>
      <form method="post" id="postform" enctype="multipart/form-data">
      <input type="hidden" id="member_name" name="member_name" value="${sessionScope.userId }"/>
      <input type="hidden" id="qst_idx" name="qst_idx" value=""/>  
      <input type="hidden" id="status" name="status" value=""/>
         <div class="contentBox" data-id="one">
            <div class="goQuestion">
              <div id="msg-wrap">
                        <div class="selectWrap">
                            <input type="text" name="qst_type" class="default" value="" readonly/>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="selectResult invisible">
                            <ul>
                            	<li>회원 정보 문의</li>
                    			<li>결제/취소/환불 문의</li>
								<li>배송 문의</li>
                    			<li>도서관련 문의</li>
                    			<li>기타 문의</li>
                            </ul>
                        </div>
                    </div>
              <div class="question_service">
                  <input type="text" id="qst_title" name="qst_title" placeholder="제목을 입력하세요.">
                  <textarea id="qst_content" name ="qst_content"></textarea>
                  <span class="limitText"><span></span>/500</span>
               </div>
            </div>
            <div class="addNotice">
                <ul>
                	<li> 문의 내용은 500자까지 가능합니다.</li>
                    <li> 문의 [제목]과 [내용]란에는 절대 개인정보를 입력하지 마세요.</li>
                    <li> 문의에 개인정보가 포함되어 있거나, 중복 문의인 경우에는 삭제될 수 있습니다.</li>
                    <li> 문의에 욕설, 인격침해, 성희롱 등 수치심을 유발하는 표현이 있다면 상담이 중단될 수 있습니다. </li>
                </ul>
            </div>
            <label for="qst_image">첨부파일</label>
            <div class="addFile">
                <!-- <input type="text" name="fileTxt" id="fileTxt"> -->
                <input type="file" name="qst_image" id="qst_image">
            </div>
            <p class="fileadd"> * 문제가 발생하는 화면 캡쳐 이미지를(타입: jpg, jpeg, png, svg)첨부해주세요.(최대 50GB까지 가능)</p>
        
            <label for="mailInput">
                이메일
            </label>
            <div class="email">
                <input type="text" name="email" id="email">
            </div>
        <div class="agreeChk">
            <label for="chkbox">
            <input type="checkbox" name="chkbox" id="chkbox">
                개인정보 수집 및 이용 동의
            </label>
            <ul>
                <li> 1. 개인정보의 수집ㆍ이용 목적
                    밀리의 서재에서는 문의하신 내용에 대한 원인파악 및 원활한 상담을 위해 개인정보를 수집하고 있습니다. 수집된 개인정보는 상담 외 다른 용도로 사용되지 않습니다.
                </li>
                <li>
                    2. 수집하는 개인정보의 항목
                이메일, 연락처(휴대폰 번호), 단말 기기의 OS버전 정보, 앱 버전, 인터넷 환경에 대해, 고객님이 제공하시는 정보에 한해 수집합니다.

                </li>
                <li>
                    3. 개인정보의 보유ㆍ이용 기간
                    수집된 개인정보는 회원탈퇴 시점 또는 관련 법령(소비자의 불만 또는 분쟁처리에 관한 기록 3년)에 근거한 기간 동안 보관 후 삭제됩니다.
    
                </li>
            </ul>
        </div>
        <div class="btn">
            <button type="button" id="preBtn" onclick="history.back()">이전</button>
            <button type="button" id="finishBtn">문의하기</button>
        </div>
        </div>
        </form>
         <!--one end  -->

         <div class="contentBox invisible" data-id="two">
            <div class="questionTable">
                <table class="tables">
                <thead>
                    <tr>
                    	<th>답변상태</th>
                        <th>문의 유형</th>                    
                        <th>제목</th>
                        <th>문의자</th>
                        <th>문의날짜</th>
                        <th>삭제</th>
                    </tr>
                    </thead>
                   <!-- foreach 시작 -->
                   <c:choose>
				<c:when test="${myqstList.size() > 0}">
                <c:forEach var="list" items="${myqstList}" varStatus="index">
              		<tbody data-var="${list.qst_index }">
              		<tr class="qst_preview">
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
                        <td>${list.qst_type}</td>
                        <td><a href="#" id="qst_title" data-id="${list.qst_index}">${list.qst_title}</a></td>
                        <td>${list.member_name}</td>
                        <td style="font-size:11px;">${list.qst_date}</td>
                        <td><button type="button" id=deleteBtn onclick="godeletequestion(this,'${list.qst_index}')" data-var="${list.qst_index }"><i class="fas fa-trash-alt"></i></button></td>
                    </tr>
                    <tr class="qst_detail invisible" data-index="${list.qst_index}">
                        <td colspan="6"> 
                        <div class="detailQuestion">
                            <div class="question">
                                <strong><i class="fab fa-quora"></i></strong> 
                                <div class="question-detail"> 
                                	<p>${list.qst_content}</p>
                                	<c:if test="${list.qst_image !=null }">
                                	<div class="divider"></div>
                                	<div class="question-img"><img src="/svcImg${list.qst_image }"/></div>
                                	</c:if>
                                </div>
                               
                            </div>
									<div class="answer">
									<c:choose>
								<c:when test="${list.qst_answer == null || list.qst_answer == ''}">
               							<span style="margin: auto; color: lightgray; margin-top: 20px; margin-bottom: 20px;">답변 대기중</span>
              					</c:when>
								<c:otherwise>
                               			 <strong><i class="fas fa-font"></i></strong> 
                               				 <p>
                                   				 ${list.qst_answer}
                                			</p>
                               	</c:otherwise>
								</c:choose>
                            </div>
                        </div>    
                        </td>
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
/* 질문 타이틀 클릭시 질문 상세 보이기 */

const qstname = document.querySelectorAll('#qst_title');
const qstdetail = document.querySelectorAll('.qst_detail');

  	qstname.forEach(name => {
       name.addEventListener('click', () => {
       	const dataid = name.getAttribute('data-id');
          qstdetail.forEach(detail=>{
             const dataidx = detail.getAttribute('data-index');
               if(dataid == dataidx) {
                 detail.classList.toggle('invisible');
               }
          });
        });
    });
  	
/* 해당 질문 삭제 */  	
function godeletequestion(event,number) {
	const conf = confirm('해당 질문을 삭제하시겠습니까?');
	if(!conf) {
		return;
	}
	ondeleteQst(event, number);
}
  	
function ondeleteQst(event, num) {
	const data = event.getAttribute('data-var');
	if(!data) {
		return;
	}   	
	const qsttbody = document.querySelectorAll(".questionTable table tbody");
	const deletedrow = document.querySelector(".questionTable table tbody[data-var='"+data+"']");
    const usernm = document.querySelector('#member_name').value;
        	
      $.ajax({
        url: "/member/deletemyqstService",
        data: {
        	"status" : "D",
        	"member_name" : usernm, 
        	"qst_index": num
        },
        async: true,
        success: function(rs) {
        	if(rs > 0) {
        	 	if(qsttbody.length > 1) {
        	 		deletedrow.remove();	
        	 	} else {
        	 		location.reload();
        	 	}
        	}
        },
        error: function(xhr,status,error) {
        		alert('오류가 발생했습니다.');
        }
      });     	
 }   
</script>
<script>
/* 질문 등록 글자수 제한 등 validation 체크 */
const qstConts = document.querySelector('.question_service #qst_content');
const limit = document.querySelector('.question_service .limitText');
const limitText = document.querySelector('.question_service .limitText > span');
const text = limitText.textContent;
let maxleg = 500;
	qstConts.addEventListener('keyup', () => {
		const leng = qstConts.value.length;
		limitText.textContent = leng;
		if(limitText.textContent > maxleg) {
			alert('500자까지 입력가능합니다.');
			return;
		}
	});

const qstBtn = document.querySelector('#finishBtn');
const agreeChk = document.querySelector('.agreeChk #chkbox');
const qstInput = document.querySelector('.question_service > input');
const qstText = document.querySelector('.question_service > textarea');
const litabs = document.querySelectorAll('ul.tabs li');

	qstBtn.addEventListener('click', () => {
		if(!agreeChk.checked){
			alert('개인 정보 수집에 동의해주세요.');
			return;
		}
		if(qstInput.value == '' || qstInput.value == null) {
			alert('제목을 입력해주세요.');
			qstInput.focus();
			return;
		}
		if(qstText.value == '' || qstText.value == null) {
			alert('문의 내용을 입력해주세요.');
			qstText.focus();
			return;
		}
		if(qstText.value.length < 10 || qstText.value.length > 500) {
			alert('문의 내용은 10자 이상 500자 이하로 입력 가능합니다.');
			qstText.focus();
			return;
		}
		if(!confirm('문의 등록을 하시겠습니까?')) {
			return;
		}
		oninsertQst();
	});
	
function oninsertQst() {
	
	$('#status').val('I');
	const formvalue = $('#postform')[0];
	let formdata = new FormData(formvalue);
	
	$.ajax({
		url: "/member/setQuestionService",
		data: formdata,
		enctype:'multipart/form-data',
		async:true,
		processData: false,
		contentType:false,
		type: 'POST',
		success: function(rs) {
			if(rs > 0) {
				alert('문의사항 등록이 완료되었습니다.');
				location.reload();
			}
		},
		error: function(xhr,status,error) {
			alert("오류");
		}
	});
}
</script>
<script>
/* 문의 등록 & 문의 내역 확인하기 */
 const tabs = document.querySelectorAll('ul.tabs li');
 const conts = document.querySelectorAll('.contentBox');

    tabs.forEach((tab, index) => {
        tab.addEventListener('click', (event) => {
                tabs.forEach(tab => {
                    tab.classList.remove('active');
                });
                tab.classList.add('active');
                onclicktab(tab, index);
            });
            onclicktab(tab, index);
        });

    function onclicktab(tab, index) {
        if (tab.classList.contains('active')) {
            const tabid = tab.dataset.id;
            const conid = conts[index].dataset.id;
              conts.forEach(cont => {
                   if (tabid == cont.dataset.id) {
                       cont.classList.remove('invisible');
                   } else {
                       cont.classList.add('invisible');
                   }
           	  });
         }
    }
</script>
<script>
/* 문의 유형 select 박스 커스터마이징 */
const selectWrap = document.querySelector('.selectWrap');
const selectIcon = document.querySelector('.selectWrap > i');
const selectResult = document.querySelector('.selectResult');
const selectList = document.querySelector('.selectResult > ul');
const def = document.querySelector('.default');
const wrap = document.querySelector('#wrap');

def.value = selectList.querySelectorAll('li')[0].textContent;

selectWrap.addEventListener('click', () => {
    selectIcon.classList.toggle('open');
    selectResult.classList.toggle('invisible');
});

selectList.addEventListener('click', (event) => {
    if (event.target.nodeName == 'LI') {
        const val = event.target.textContent;
        def.value = val;
        selectResult.classList.add('invisible');
        selectIcon.classList.toggle('open');
    }
});
</script>
<script>
/* 파일 첨부 validation */
const qstImg = document.querySelector('#qst_image');
let imgtype= ['jpg', 'jpeg', 'png', 'svg'];

qstImg.addEventListener('change', (event) => {
	let file = event.target.files[0];
 	let filetype = file.type.split('/')[1];
 	if(imgtype.indexOf(filetype) == -1) {
 		alert('jpg, jpeg, png, svg 등 \n이미지 파일만 업로드 가능합니다.');
 		return;
 	}
});
</script>

</body>
</html>