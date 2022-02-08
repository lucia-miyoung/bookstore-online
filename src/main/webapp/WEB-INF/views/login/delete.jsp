<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="../../../resources/css/delete.css">
    <link href="https://fonts.googleapis.com/css?family=Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap" rel="stylesheet">
    <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
   <script src="https://kit.fontawesome.com/3fb56dfe63.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="../../../resources/css/reset.css">
    <link rel="stylesheet" href="../../../resources/css/common.css">
    <script src="../../../resources/js/common.js"></script>
</head>
<body>
<!-- <sec:authentication property="principal" var="member"/> -->
<header class="topbar">
		<nav>
			<div class="container">
				 <a href="javascript: history.back();"><i class="fas fa-arrow-left"></i><span>이전</span></a>
                 <a href="/book/main"><i class="fas fa-home"></i><span>홈</span></a>
				<h2>회원 탈퇴</h2>	
			</div>
		</nav>
	</header>
    <div class="wrapper">
        <h3> 서재 이용 현황 </h3>
        <form id="frm" onsubmit="return false">
        <input type="hidden" id="member_name" name="member_name" value="${sessionScope.userId }"/>
        <input type="hidden" id="member_id" name="member_id" value="${memInfo.member_id }"/>
        <input type="hidden" id="status" name="status" value="D"/>
        <div class="useInfo">
            <p>${sessionScope.userId } 님의 서재</p>
            <ul>
                <li><strong>찜하기</strong> <span>${zzimCnt} 개</span></li>
                <li><strong>서재에 기록된 포스트</strong><span>${reviewCnt} 개</span></li>
                <li><strong>마일</strong><span>${mileCal.mile} 마일</span></li>
                <li><strong>종이책 결제 건수</strong><span>${orderCnt} 권</span></li>
            </ul>
        </div>
         <!-- useInfo end -->
        
        <hr class="line"> 
        <div class="inner">
        <p class="chkDelete">◎ 탈퇴 회원 유의 사항 </p>
        <ul>
            <li> 탈퇴를 하면 고객님의 직접 작성하신 포스트와 댓글은 자동 삭제됩니다. 
                노출을 원치 않으실 경우 탈퇴 전 삭제 하시기 바랍니다.
            </li>
            <li>
                탈퇴를 하실 경우, 어떤 경우에도 기존 서재의 대한 복구는 불가능하며, 로그인이 필요한 모든 서비스를 이용하실 수 없습니다.
            </li>
            <li>
                탈퇴를 하실 경우 계정과 함께 마일리지가 소멸됩니다. 원치 않으실 경우, 마일리지 이용 후 탈퇴해 주시기 바랍니다.
            </li>
            
        </ul>
    </div>

    <div class="lastChkBtn">
    <label for="agreeBtn"><input type="checkbox" name="agreeBtn" id="agreeBtn">
        <span> 회원 탈퇴에 관한 모든 내용을 숙지하였고, 회원 탈퇴를 신청합니다. </span>
    </label>

    </div>
    <div class="finishBtn">
        <button type="button" id="golaterbtn">나중에 하기</button>
        <button type="button" id="godeletecheck">탈퇴 하기</button>

    </div>

	<div class="pop_wrap invisible" >
        <div class="pop_container">
            <div class="pop_up">
                <span class="recheck_msg">정보 보호를 위해 비밀번호를 다시 입력해주세요.</span>
                <input type="password" id="recheck_pw" name="recheck_pw"/>
                <div class="recheck_button">
                    <button type="button" class="cancel_btn">취소</button>
                    <button type="button" class="check_btn">확인</button>
                </div>
            </div>
        </div>
    </div> 


    </form>

    </div>
    <!-- wrapper end -->

<script>
	/*  탈퇴 전, 비밀번호 재확인 팝업창 */
	const deletebtn = document.querySelector('#godeletecheck');
	const popwrap = document.querySelector('.pop_wrap');
	const canbtn = document.querySelector('.cancel_btn');
	const agreebtn = document.querySelector('#agreeBtn');
	const chkbtn = document.querySelector('.check_btn');
	const pwchkinput = document.querySelector('#recheck_pw');
	const laterBtn = document.querySelector('#golaterbtn');
	
	laterBtn.addEventListener('click', () => {
		if(!confirm('탈퇴를 취소하시겠습니까?')) {
			return;
		}
		
		location.href="/member/myaccount";
	});
	
	deletebtn.addEventListener('click', () => {
		if(!agreebtn.checked) {
			alert('체크 박스에 동의해주세요.');
			agreebtn.focus();
			return;
		}
		popwrap.classList.remove('invisible');	
	});
	
	if(canbtn) {
		canbtn.addEventListener('click', () => {
			popwrap.classList.add('invisible');
		});
	}
	
	if(chkbtn) {
		chkbtn.addEventListener('click', () => {
			 ondeleteInfo(); 
		});
	}
	
	if(pwchkinput) {
		pwchkinput.addEventListener('keypress', (event) => {
			if(event.keyCode==13) {
				ondeleteInfo();
			}
		});
	}
	
	function ondeleteInfo() {
		const pwinput = document.querySelector('#recheck_pw');
		if(pwinput.value == '') {
			alert('비밀번호를 입력해주세요.');
			pwinput.focus();
			return;
		}
			$.ajax({
				url: "/member/deletemyaccount",
				data: $('#frm').serialize(),
				type: 'POST',
				success: function(rs) {
					if(rs == 0) {
						alert('비밀번호가 틀렸습니다. 다시 확인해주세요.');
						pwinput.value='';
						pwinput.focus();
					} else {
						alert('회원탈퇴가 완료되었습니다.');
						location.href="/login";
					}
				}, 
				error: function(xhr, status, error) {
					alert('오류 발생');
				}
			});
	}

</script>

</body>
</html>