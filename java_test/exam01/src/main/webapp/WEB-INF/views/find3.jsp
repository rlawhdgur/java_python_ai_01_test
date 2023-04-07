<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ㅁㄴㅁㄴㅇㅁㄴㅇ</title>
</head>
<body>
<input type="radio" name="findOption" value="id" onclick="showFindId()"> 아이디 찾기
<input type="radio" name="findOption" value="password" onclick="showFindPassword()"> 비밀번호 찾기
<form method="POST" action="/find_id">
<div id="findIdForm" style="display:none;">
    <table>
    <!-- 아이디 찾기 폼 -->
        <tr>
            <td>이름</td>
            <td>
            <input type="text" name="name" id="find_name">
            </td>
        </tr>
        <tr>
            <td>핸드폰 번호</td>
            <td>
                <input type="text" name="phoneNumber" id="find_mobile">
            </td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="email" name="email" id="find_email">
            </td>
        </tr>
        <tr>
            <td>
                <input type="button" value="아이디 찾기" id="btn_find_id">
            </td>
        </tr>
    </table>
</div>
</form>

<form method="POST" action="/find_password">
<div id="findPasswordForm" style="display:none;">
    <!-- 비밀번호 찾기 폼 -->
    <table>
        <tr>
            <td>아이디</td>
            <td>
                <input type="text" name="userid" id="find_id">
            </td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>
                <input type="email" name="email" id="find_email_">
            </td>
        </tr>
        <tr>
            <td>
                <input type="button" value="비밀번호 찾기" id="btn_find_password">
            </td>
        </tr>
    </table>
</div>
</form>

</body>
<script src='https://code.jquery.com/jquery-3.4.1.js'></script>
<script>
function showFindId() {
    document.getElementById("findIdForm").style.display = "block";
    document.getElementById("findPasswordForm").style.display = "none";
}
      
function showFindPassword() {
    document.getElementById("findPasswordForm").style.display = "block";
    document.getElementById("findIdForm").style.display = "none";
}
$(document)
// 아이디 찾는 코드
.on('click', '#btn_find_id', function(){
    if($("#find_name").val()=="" || $("#find_email").val()=="" || $("#find_mobile").val()=="") {
        alert("빈칸을 확인해주세요.");
        return false;
    }
    else {
        $.post('/find_id', {name:$('#find_name').val(), email:$('#find_email').val(), phoneNumber:$('#find_mobile').val()}, function(data){
            if(data=="fail") {
                alert("정보가 맞지 않습니다. 다시 시도해주세요.");
                return document.location="/find";
            }
            else {
                alert("아이디는 " + data + " 입니다.");
            }
        }, 'text');
    }
})

// 비밀번호 찾는 코드
.on('click', '#btn_find_password', function(){
    if($('#find_id').val() == "" || $('#find_email_').val() =="") {
        alert("빈칸을 확인해주세요.");
        return false;
    }
    else {
        $.post('/find_password', {userid:$('#find_id').val(), email:$('#find_email_').val()}, function(data){
            if(data == "fail") {
                alert("정보가 맞지 않습니다. 다시 시도해주세요.");
                return document.location="/find";
            }
            else {
                alert("비밀번호는 " + data + " 입니다.");
            }
        }, 'text');
    }
})
</script>
</html>