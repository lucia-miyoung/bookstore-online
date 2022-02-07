<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 - National Bookstore</title>
    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css?family=Kaushan+Script|Montserrat|Noto+Sans+KR|Open+Sans|Roboto&display=swap"
      rel="stylesheet"
    />
    <!-- Fontawesome -->
<script src="https://kit.fontawesome.com/3fb56dfe63.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="/resources/js/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="/resources/js/jquery-ui-1.10.3.custom.js"></script>
    <!-- css reset -->
    <link rel="stylesheet" href="../../../resources/css/reset.css" />

    <!-- individual page stylesheet -->
    <link rel="stylesheet" href="../../../resources/css/signin.css" />
  </head>
  <body>
    <header class="topbar">
      <nav>
        <div class="container">       
          <h2>로그인</h2>
        </div>
      </nav>
    </header>
    <form action="" id="frm" method="post">
    <div class="body-wrapper">
      <div class="selection-container">
        <div class="email">
          <h3>이메일 로그인</h3>
          <div class="selection">
          	<input type="text" name="member_id" id="member_id" value=""  placeholder="아이디" onKeypress="javascript:if(event.keyCode==13) {gologin();}"/>
          	<input type="password" name="member_pw" id ="member_pw" value=""  placeholder="비밀번호" onKeypress="javascript:if(event.keyCode==13) {gologin();}"/>
            <a href="#" class="loginBtn"><span class="fas fa-envelope-square"></span>로그인</a>
          </div>
        </div>
        <div class="social">
          <h3>회원 가입</h3>
          <div class="selection">
            <a href="#" class="signupBtn"><span class="fas fa-copy"></span>회원가입</a>
          </div>
        </div>
      </div>
    </div>
    </form>
    
    <script>
	/* 로그인 validation 확인 */
    const loginBtn = document.querySelector('.loginBtn');
    const signupBtn = document.querySelector('.signupBtn');    
    loginBtn.addEventListener('click', () => {
    	gologin();
		
    });
    signupBtn.addEventListener('click', () => {
    	$('#frm').attr('action', '/signup');
		$('#frm').submit();
    });
    
    const inputs = document.querySelectorAll('.email .selection input');
    const memId = document.querySelector('#member_id');
    
	function gologin() {
       	for(let i=0; i<inputs.length; i++) {
       		if(inputs[i].value.trim() == '' || inputs[i].value.trim() == null) {
       			alert(inputs[i].placeholder + '를 입력해주세요.');
       			inputs[i].focus();
       			return;
       		}
       	}           		
       	if(!isValidEmailFormat(memId.value)) {
       		alert('유효한 형식이 아닙니다. 이메일 형식으로 입력해주세요.');
       		memId.focus();
       		return;
       	}
	 	 $.ajax({
			url: "/loginChk.do"
			, data: $('#frm').serialize()
			, success : function(rs) {
				console.log(rs);
				if(rs.loginCheck == 0) {
					alert('아이디 또는 비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
					$('#member_id').focus();
					return;
				}
				$('#frm').attr('action', "/book/main.do");
				$('#frm').submit();
			}
			, error : function(xhr, status, error) {
				alert('오류');
			}
		}); 
	}
	
	/* 이메일 형식 체크 */
    function isValidEmailFormat(email) {
    	const emailPattern =/^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
        return emailPattern.test(email);
    } 
    </script>
  </body>
</html>
