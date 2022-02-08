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
    <link rel="stylesheet" href="../../../resources/css/update.css">
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
                <h2>개인 정보 수정</h2>

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
 <div class="newMyInfo">
 	<form id="frm" method="post" action="" enctype="multipart/form-data">
 	<input type="hidden" name="loginName" id="loginName" value="${sessionScope.userId }"/>
 	<input type="hidden" name="status" id="status" value=""/>
 	<input type="hidden" name="member_id" id="member_id" value="${memData.member_id }"/>
      <div class="imageBox">
        <img id="myFaceImage" src="/image${memData.member_image}"/>
        <!-- 사진 넣을거임 -->
        <label for="camera">
          <i class="fas fa-camera-retro"></i>
          <input type="file" name="camera" id="camera" />
        </label>
        <button type="button" id="deleteBtn">
          <i class="fas fa-times"></i>
        </button>
      </div>
      <!-- imageBox end -->
      <div class="wrapperOne">
        <p>필명</p>
        <div class="updateLists">
          <input type="text" name="member_name" id="nickName" placeholder="이름" value="${memData.member_name}"/>
          <button type="button" id="nickNameChk">중복확인</button>
        </div>
        <span class="data-chk" style="color: rgb(194, 16, 16);">
          <i class="fas fa-exclamation-circle"></i> 욕설, 비속어 사용 시 서비스
          이용이 제한될 수 있습니다.
        </span>
      </div>
      <!-- wrapperOne end -->
      <div class="wrapperOne_half">
        <p>비밀번호</p>
        <input
          type="password"
          id="inputPw"
          maxlength="16"
          placeholder="비밀번호" value="${memData.member_pw }"/>
        <span id="hereText">8자 이상, 16자 이하로 입력해주세요.</span>
        <input
          type="password"
          id="inputPwAgain" 
          name="member_pw"
          placeholder="비밀번호 확인" value="${memData.member_pw }"/>
        <span class="data-chk" id="rechkPW"></span>
      </div>
      <hr class="firstLine" />
      <!-- updateLists end -->
      <div class="wrapperTwo">
        <p>핸드폰 번호</p>
        <div class="phoneUpdate">
          <input type="text" name="member_phone" id="phoneNum" placeholder="핸드폰 번호" value="${memData.member_phone}"/>
          <span class="data-chk"> ※ ' - ' 없이 숫자로만 입력해주세요. </span>
        </div>

        <!-- mailChoice end -->
        <hr class="secondLine" />
      </div>
      <!-- wrapperTwo end -->
      <div class="wrapperFour">
        <p>주소</p>
        <div class="address1">
          <button type="button" id="zipCodeSearch" onclick="zipCodeClick()">
            검색
          </button>
          <input type="text" name="member_home1" id="homeZipcode" value="${memData.member_home1}" readonly />
          <input type="text" name="member_home2" id="homeAdrs" value="${memData.member_home2}" readonly />
        </div>
        <div class="address2">
          <input
            type="text"
            name="member_home3"
            id="homeDetail"
            placeholder="상세 주소"
            value="${memData.member_home3}"
          />
        </div>
      </div>
      <div class="wrapperThree">
        <div class="infoAgree">
          <label for="infoChk"
            ><input type="checkbox" name="infoChk" id="infoChk" />
            <span>개인정보 수집 및 이용 동의</span>
          </label>
        </div>
        <div class="infoChkList">
          <ul>
            <li>
              개인정보 수집 목적: 원활한 서비스 이용을 위해 정보를 수집합니다.
            </li>
            <li>
              개인정보 수집항목: 프로필 이미지, 필명, 아이디, 비밀번호, 이메일,
              주소
            </li>
            <li>
              개인정보 이용기간: 회원 탈퇴 시 또는 개인정보처리방침에 따라 보유
              및 파기 됩니다.
            </li>
          </ul>
        </div>
        <div class="finishBtn">
          <div class="btn1">
            <button
              type="button"
              class="resetBtn">
              취소
            </button>
          </div>
          <div class="btn2">
            <button type="button" class="chkBtn">
              확인
            </button>
          </div>
        </div>
      </div>
      </form>
    </div>
    <!-- 제일 큰 박스 end -->
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

 alert("닉네임을 변경할 경우, 회원님의 정보 보호를 위해 \n다시 로그인하셔야 합니다. 이용시 참고 바랍니다.");

/* 정보 수정 취소 */
const resetBtn = document.querySelector(".resetBtn");
resetBtn.addEventListener('click', () => {
	if(!confirm("정보 수정을 취소하시겠습니까?")) {
		return;
	}
	location.href="/member/myaccount";
});

/* 프로필 사진, 기본이미지로 설정 */
const deleteBtn = document.querySelector('#deleteBtn');
deleteBtn.addEventListener('click', () => {
	if(!confirm("기본 이미지로 수정하시겠습니까?")) {
		return;
	}
	const imgthumb = document.querySelector('.imageBox > img');
	imgthumb.setAttribute('src', "/image/default.png");
});
</script>

<script>
/* 파일 첨부 & 썸네일 */
const userimg = document.querySelector('#camera');
userimg.addEventListener('change', (event) => {
	onsetimage(event); 
}); 

function onsetimage(e) {
let imgtype = ['jpg', 'jpeg', 'png', 'svg'];

	let file = e.target.files[0];
	let filetype = file.type.split('/')[1];
	
 	if(imgtype.indexOf(filetype) == -1) {
	 	alert('이미지는 jpg, jpeg, png, svg만 첨부 가능합니다.');
	 	return;
	}

	let reader = new FileReader();
	reader.readAsDataURL(file);
	reader.onload = event => {
		let url = event.target.result;
		const imgthumb = document.querySelector('.imageBox > img');
		imgthumb.setAttribute('src', url);
	};
}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
/* 주소 API 연결 */
function zipCodeClick() {
	const zipcode = document.querySelector('#homeZipcode');
	const address = document.querySelector('#homeAdrs');
	const addressD = document.querySelector('#homeDetail');
	
    new daum.Postcode({
        oncomplete: function(data) {
        	 zipcode.value = data.zonecode;
        	 address.value = data.roadAddress;
        	 addressD.focus();
        }
    }).open();
    
}
</script>
<script>
/* 이름 중복 확인 */
const nameChkBtn = document.querySelector('#nickNameChk');
const nameMsg = document.querySelector('.wrapperOne span');

nameChkBtn.addEventListener('click', () => {
	const nameVal = document.querySelector('#nickName');
	nameCheck(nameVal);
});

function nameCheck(name) {
	const value = name.value;
	 if(value == null || value == '') {
			alert('이름을 입력해주세요.');
			name.focus();
			return;
	} 
		
	if(!isValidNickNameFormat(value)) {
		alert('이름 형식이 맞지 않습니다. 한글만 사용 가능합니다.');
		name.focus();
		return;
	}
	
	$.ajax({
		url : "/signupCheck",
		data : {
			"member_name" : value
		},
		success : function(rs) {
			if(rs.nameCheck > 0) {
				alert('이미 동일한 이름이 있습니다.');
			} else {
				alert('사용 가능합니다.');
				nameMsg.setAttribute('data-check', 'yes');
			}
		}, 
		error : function(xhr, status, error) {
			alert('오류');
		}
	}); 	
}

/* 비밀번호 확인 */
const pw = document.querySelector('#inputPw');
const pwChk = document.querySelector('#inputPwAgain');
const msg = document.querySelector(".wrapperOne_half #rechkPW");
pwChk.addEventListener('blur', () => {
	if(!isValidPasswdFormat(pwChk.value)) {
		msg.innerHTML = "<i class='fas fa-exclamation'></i> 비밀번호 형식이 맞지 않습니다.";
		msg.style.color = "red";
		return;
	}
	if(pw.value != pwChk.value) {
		msg.innerHTML = "<i class='fas fa-exclamation'></i> 비밀번호가 일치하지 않습니다.";
		msg.style.color = "red";
		return;
	}
	if(isValidPasswdFormat(pwChk.value) && pw.value == pwChk.value) {
		msg.innerHTML = "<i class='far fa-check-circle'></i> 비밀번호가 일치합니다.";
		msg.style.color = 'blue';
		msg.setAttribute('data-check', 'yes');
	}
});

/* 전화번호 validation 확인 */
const telInput = document.querySelector('#phoneNum');
const telmsg = document.querySelector('.phoneUpdate span');
	
	telInput.addEventListener('blur', () => {
		const tel = telInput.value.replace(/ /g, '').replace(/-/g, '');
		telInput.value = tel;
		
		if(!isValidTelFormat(tel)) {
			telmsg.innerHTML = 	"<i class='fas fa-exclamation'></i> 전화번호 형식이 맞지 않습니다.";
			telmsg.style.color = "red";
			return;
		}
		if(isValidTelFormat(tel)) {
			telmsg.innerHTML = "<i class='far fa-check-circle'></i>";
			telmsg.style.color = 'blue';
			telmsg.setAttribute('data-check', 'yes');
		}
	});
	
const infoChk = document.querySelector('#infoChk');
const chkBtn = document.querySelector('.chkBtn');
	chkBtn.addEventListener('click', () => {
		
		if(!infoChk.checked) {
			alert('개인 정보 수집에 동의해주세요.');
			return;
		}
		
			submitChecks(); 
	});
	    

/* 형식 확인 */
function isValidNickNameFormat(nickname) {
    const nicknamePattern = /^[가-힣]+$/;
    return nicknamePattern.test(nickname);
}

function isValidPasswdFormat(passwd) {
    const passwdPattern = /^(?=.*?[^\s])[\w\d]{8,}$/;
    return passwdPattern.test(passwd);
}
function isValidTelFormat(tel) {
    const telPattern = /\d{11}/;
    return telPattern.test(tel);
 }
    
/* 저장 버튼 클릭시 validation 확인 */    
function submitChecks() {
	const spanArr = document.querySelectorAll('span.data-chk');
	const nickName = document.querySelector('#nickName');
	const inputPw = document.querySelector('#inputPw');
	const inputPwAgain = document.querySelector('#inputPwAgain');
	const phone = document.querySelector('#phoneNum');
	const inputs = [nickName, inputPw, inputPwAgain, phone];
	const userNm = document.querySelector('#loginName');

   		for(let i=0; i<inputs.length; i++) {
   			if(inputs[i].value.trim() == '' || inputs[i].value.trim() == null) {
   				alert(inputs[i].placeholder + '를 입력해주세요.');
   				inputs[i].focus();
   				return;
   			}
   		}     
	
		for(let i=0; i<spanArr.length; i++) {
			const id = spanArr[i].parentNode.querySelector('input').getAttribute('id');
			if(spanArr[i].getAttribute('data-check') != 'yes'){
				if(nickName.value != userNm.value && id=="nickName") {
					alert('이름 중복 확인을 해주세요.');
					spanArr[i].parentNode.querySelector('input').focus();
					return;
				}
				if(id=="inputPw") {
					alert('비밀번호를 일치하게 입력해주세요.');
					spanArr[i].parentNode.querySelector('input').focus();
					return;
				}
				if(id=="phoneNum") {
					alert('핸드폰 번호를 정확하게 입력해주세요.');
					spanArr[i].parentNode.querySelector('input').focus();
					return;
				}	
			}	
		}	
		if(!confirm('수정하시겠습니까?')) {
			return;
		}			
		$('#status').val('U');	
		
		const orginImg = document.querySelector('.imageBox > img').getAttribute('src').split('/image')[1];
		const formvalue = $('#frm')[0];
		let formdata = new FormData(formvalue);
		formdata.append("orgin_img", orginImg);
		
		$.ajax({
			url: "/member/setUpdateData",
			data: formdata,
			enctype:'multipart/form-data',
			processData: false,
			contentType:false,
			type: 'POST',
			success: function(rs) {
				if(rs.result > 0) {
					if(nickName.value == userNm.value) {
						alert('정보 수정이 완료되었습니다.');
						location.href="/member/myaccount";
					} else {
						alert('정보 수정이 완료되었습니다. 다시 로그인 해주세요.');
						location.href="/login";
					}
				} else {
					alert('정보 수정이 실패했습니다. 다시 확인해주세요.');
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