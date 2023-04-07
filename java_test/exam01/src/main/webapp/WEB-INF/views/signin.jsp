<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 페이지</title>
</head>
<body>
<h1>회원가입 페이지</h1>
<form method="POST" action="/viewUser" id=frmSignIn>
    <table>
    <tr>
        <td>로그인아이디</td><td><input type=text name=userid id=newId placeholder="15자이내로 입력해주세요." pattern="^[a-z0-9-_]{6,15}$">
        <input type="button" value='중복확인' id="btnIdCheck">
        <input type=hidden id=I_Duplicate>
		<div id="id_max_cnt">*영소문&숫자 6~15자이내</div>
		<div id="newId_success">아이디 형식입니다.</div>
		<div id="newId_danger">아이디 형식이 아닙니다.</div>
    </tr>
    <tr>
        <td>비밀번호</td><td><input type=password name=password id=newPasscode placeholder="20자이내로 입력해주세요." pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$">
		<div id="pw_lead">*영어&숫자&특수문자 합쳐서 입력하세요.</div>
		<div id="pw_max_cnt">(8~20자이내)</div>
		<div id="pw_success">비밀번호 형식입니다.</div>
		<div id="pw_danger">비밀번호 형식이 아닙니다.</div>
	</tr>
    <tr>
        <td>비밀번호확인</td><td><input type=password name=newPasscode_ id=newPasscode_>
		<!-- <div id="newPasscode_read">비밀번호확인하세요.</div> -->
		<div id="newPasscode_success">비밀번호가 일치합니다.</div>
		<div id="newPasscode_danger">비밀번호가 일치하지 않습니다.</div>
	</tr>
    <tr>
        <td>이름</td><td><input type=text name=name id=name>
    </tr>
    <tr>
        <td>닉네임</td><td><input type=text name=nickname id=nickname pattern="^[가-힣a-zA-Z0-9]{2,10}$">
        <input type="button" value='중복확인' id="btnNickCheck">
        <input type=hidden id=N_Duplicate>
		<div id="nickname_">*영소문&한글&숫자만 입력하세요.</div>
		<div id="nick_max_cnt">(2~10자이내)</div>
		<div id="nickname_success">닉네임 형식 입니다.</div>
		<div id="nickname_danger">닉네임 형식이 아닙니다.</div>
    </tr>
    <tr>
        <td>이메일</td><td><input type=email name=email id=email pattern="^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$">
		<!-- <input type="button" value='중복확인' id="btnEmailCheck">
		<input type=hidden id=E_Duplicate> -->
		<div id="email_success">이메일 형식입니다.</div>
		<div id="email_danger">이메일 형식이 아닙니다.</div>
    </tr>
    <tr>
        <td>핸드폰번호</td><td><input type=text name=phoneNumber id=mobile pattern="^(010)[0-9]{3,4}[0-9]{4}$">
		<div id="mobile_success">핸드폰번호 형식입니다.</div>
		<div id="mobile_danger">핸드폰번호 형식이 아닙니다.</div>
    </tr>
    <tr>
        <td colspan=2 align=center>
            <input type=submit value='회원가입' id=btnSignIn>
        </td>
    </tr>
    </table>
</form>
    <a href='/'>홈으로</a>
    &nbsp;&nbsp;
    <a href='/login'>로그인하기</a>
	&nbsp;&nbsp;
	<a href="/find">아이디&비밀번호찾기</a>
</body>
<script src='https://code.jquery.com/jquery-3.4.1.js'></script>
<script>
$(document)
.ready($('#newId_success').hide())
.ready($('#newId_danger').hide())
.ready($('#nickname_success').hide())
.ready($('#nickname_danger').hide())
// .ready($('#newPasscode_read').hide())
.ready($('#pw_success').hide())
.ready($('#pw_danger').hide())
.ready($('#newPasscode_success').hide())
.ready($('#newPasscode_danger').hide())
.ready($('#email_success').hide())
.ready($('#email_danger').hide())
.ready($('#mobile_success').hide())
.ready($('#mobile_danger').hide())

// 아이디 중복확인 버튼 코드
.on('click', '#btnIdCheck', function(){
	if(!/^[a-z0-9-_]{6,15}$/.test($('#newId').val())) {
		alert("아이디 형식이 맞지 않습니다.");
		return false;
	}
	if($('#newId').val()=='') {
        alert("아이디를 입력해주세요.");
		return false;
    }
	else {
        $.post('/checkId', {userid:$('#newId').val()}, function(data){
			if(data=='true') {
				alert("이미 사용중인 아이디입니다.");
			}
			else {
				alert("사용가능한 아이디입니다.");
				$('#I_Duplicate').val('ok');
			}
		}, 'text');
		return false;
    }
})

// 아이디 입력받는 코드
.on('input', '#newId', function(){
	if(!/^[a-z0-9-_]{6,15}$/.test($('#newId').val())) {
		$('#newId_success').hide();
		$('#newId_danger').show();
		return false;
	}
	else {
		$('#newId_success').show();
		$('#newId_danger').hide();
	}
	// if($('#newId').val().length > 16) {
	// 	alert("6~15자이내 입력해주세요.");
	// 	return false;
	// }
})

// 닉네임 중복확인 버튼 코드
.on('click', '#btnNickCheck', function(){
	if($('#nickname').val()=='') {
        alert("사용할 닉네임을 입력해주세요.");
		return false;
    }
	else {
        $.post('/checkNick', {nickname:$('#nickname').val()}, function(data){
			if(data=='true') {
				alert("이미 사용중인 닉네임입니다.");
				$('#N_Duplicate').val('fail');
			}
			else {
				alert("사용가능한 닉네임입니다.");
				$('#N_Duplicate').val('ok');
			}
		}, 'text');
		return false;
    }
})

// 이메일 중복확인하는 코드
// .on('click', '#btnEmailCheck', function(){
// 	if($('#email').val()=='') {
//         alert("이메일을 입력해주세요.");
// 		return false;
//     }
// 	if(!/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/.test($('#email').val())) {
// 		alert("이메일형식이 아닙니다.");
// 		return false;
// 	}
// 	else {
//         $.post('/checkEmail', {email:$('#email').val()}, function(data){
// 		if(data=='true') {
// 			alert("이미 사용중인 이메일입니다.");
// 		}
// 		else {
// 			alert("사용가능한 이메일입니다.");
// 			$('#E_Duplicate').val('ok');
// 		}
// 	}, 'text');
// 	return false;
//     }
// })

// 회원가입 버튼을 누르면 처리되는 코드
.on('click', '#btnSignIn', function(){
	if($('#newId').val()=='' || $('#name').val()=='' || $('#mobile').val()=='') {
		alert("빈칸을 확인해주세요.");
		return false;
	}
	if($('#I_Duplicate').val()!="ok") {
		alert("아이디 중복확인 하십시오.");
		return false;
	}
	// if($('#newPasscode').val()!=$('#newPasscode_').val()){
	// 	alert("비밀번호가 일치하지 않습니다.");
	// 	return false;
	// }
	if($('#N_Duplicate').val()!="ok") {
		alert("닉네임 중복확인 하십시오.");
		return false;
	}
	if($('#newPasscode').val()!=$('#newPasscode_').val()){
		alert("비밀번호가 다릅니다.");
		return false;
	}
	else {
		$.post('/viewUser', {userid:$('#newId').val(), password:$('#newPasscode').val(),
			name:$('#name').val(), nickname:$('#nickname').val(), email:$('#email').val(), 
			phoneNumber:$('#mobile').val()}, function(data){
				if(data == "ok") {
					alert("회원가입 되었습니다.");
					document.location = '/login';
				}
				else {
					alert("회원가입 실패!!");
					$('#newId', '#newPasscode', '#newPasscode_', '#name',
							'#mobile', '#I_Duplicate', '#N_Duplicate').val('');
				}
		}, 'text');
	}	
})
	
	
// 비밀번호 입력받을 때 코드
.on('input', '#newPasscode', function(){
	if(!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/.test($('#newPasscode').val())) {
		$('#pw_danger').show();
		$('#pw_success').hide();
		return false;
	}
	else {
		$('#pw_danger').hide();
		$('#pw_success').show();
	}
})

// 비밀번호확인 입력받을 때 코드
.on('input', '#newPasscode_', function(){
	// if($('#newPasscode_').val()=="") {
	// 	$('#newPasscode_read').show();	
	// }
	if($('#newPasscode').val()!=$('#newPasscode_').val()){
		$('#newPasscode_danger').show();
		$('#newPasscode_success').hide();
		return false;
	}
	else {
		$('#newPasscode_danger').hide();
		$('#newPasscode_success').show();
		return false;
	}
})


// 닉네임 입력받을 때 코드
.on('input', '#nickname', function(){
	if(!/^[가-힣a-zA-Z0-9]{2,10}$/.test($('#nickname').val())) {
		$('#nickname_danger').show();
		$('#nickname_success').hide();
		return false;
	}
	else {
		$('#nickname_danger').hide();
		$('#nickname_success').show();
		return false;
	}
})

	
// 이메일 입력받을 때 코드
.on('input', '#email', function(){
	if(!/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/.test($('#email').val())) {
		$('#email_danger').show();
		$('#email_success').hide();
		return false;
	}
	else {
		$('#email_danger').hide();
		$('#email_success').show();
		return false;
	}
})

// 핸드폰번호 입력받을 때 코드
.on('input', '#mobile', function(){
	if(!/^(010)[0-9]{3,4}[0-9]{4}$/.test($('#mobile').val())) {
		$('#mobile_danger').show();
		$('#mobile_success').hide();
		return false;
	}
	else {
		$('#mobile_danger').hide();
		$('#mobile_success').show();
		return false;
	}
})
</script>
</html>