<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8"%>
<html>
<head>
    <title>register</title>
    <style>
        .file-input-wrapper {
            width: 300px;
            border: 2px solid #11B560;
            padding: 10px;
            border-radius: 10px;
            display: table;
            margin-left: auto;
            margin-right: auto;
            background-color: #fff;
        }/* 백그라운드색 변경 보더변경 */

        .file-input-wrapper input[type=file] {
            width: calc(100% - 22px);
            box-sizing: border-box;
            margin-top: 5px;
            display: table;
            margin-left: auto;
            margin-right: auto;
        }
        input[type=text],
        input[type=email],
        input[type=password],
        input[type=submit]{
            width: 300px;
            padding: 10px;
            border-radius: 10px;
            margin-bottom: 10px;
            display: table;
            margin-left: auto;
            margin-right: auto;
            border: 2px solid #11B560;
        }/* 보더변경하고 색상변경 */
        .box {
            display: table;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body style="background-color: #eeefc7b8;">
<div class="fs_40 text-center cGreen fw_600 my-3">JOIN US</div>
<form action="/semi/member/register" method="post">
    <input type="text" name="userName" placeholder="성명 입력"><br>
    <div class="box"><input type="email" name="userEmail" placeholder="이메일" id="userEmail"><br>
    <label for="emailCheckbox" class="cGreen fw_600 fs_17">아이디 중복 확인<input type="checkbox" id="emailCheckbox" class="ml-2" /></label></div><br>
    <input type="password" name="userPassword" placeholder="비밀번호"><br><!--아이디 중복확인부분 글자색 굵기 크기 변경  -->

    <div class="file-input-wrapper">
        <input type="file" name="userImage" placeholder="사진" class="m-0"> <!-- 마진 0으로 -->
    </div><br>

    <input type="text" name="userPhoneNumber"  placeholder="휴대전화번호(Ex:010-1234-5678)"><br>
    <input type="submit" value="회원가입" class="btn_green2"><!-- 버튼클래스속성 추가 -->
</form>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    $('#emailCheckbox').on("click",function (){
       const userEmail =$('#userEmail').val();
       $.ajax({
           url : "/semi/member/duplicatedEmailCheck",
           dataType:"json",
           method :"POST",
           data : {"userEmail" : userEmail},
           success :function (response){
               console.log(response);
               console.log("hihi")
           },
           error : function(response){
               console.log(response);
           }
       })
    })
</script>
</body>
</html>