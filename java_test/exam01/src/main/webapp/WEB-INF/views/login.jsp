<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 페이지</title>
</head>
<body>
<h1>로그인 페이지</h1>
<form method="POST" action="/loginOk">
    <table>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" name="userid" id="userid">
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" name="password" id="passcode">
            </td>
        </tr>
        <tr>
            <td colspan=2 align="center">
                <input type="submit" value="로그인" id="btnLogin">
            </td>
        </tr>
    </table>
</form>
<a href="/">홈</a>
&nbsp;&nbsp;
<a href="/signin">회원가입</a>
&nbsp;&nbsp;
<a href="/find">아이디&비밀번호찾기</a>
</body>
<script src='https://code.jquery.com/jquery-3.4.1.js'></script>
<script>
$(document)
.on('click', '#btnLogin', function(){
    if($('#userid').val()=='' || $('#passcode').val()=='') {
        alert("빈칸을 확인해주세요.");
        return false;
    }
    else {
        $.post('/checkUser', {userid:$('#userid').val(), password:$('#passcode').val()}, function(data){
		if(data=="ok") {
			alert("로그인되었습니다.");
			document.location="/";
		}
		else {
			alert("아이디와 비밀번호를 확인해주세요. 로그인 실패.. ");
			document.location="/login";
		}
	}, 'text');
	return true;
    }
})
</script>
</html>
