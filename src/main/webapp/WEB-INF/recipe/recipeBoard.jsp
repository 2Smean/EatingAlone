<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
   href="https://fonts.googleapis.com/css2?family=Gamja+Flower&family=Jua&family=Lobster&family=Nanum+Pen+Script&family=Permanent+Marker&family=Single+Day&display=swap"
   rel="stylesheet">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
   rel="stylesheet">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
body * {
   font-family: 'Jua';
}

div.simpleicon {
   margin: 30px 100px;
}

div.simpleicon * {
   cursor: pointer;
   margin-right: 30px;
   font-size: 30px;
}

div.list {
   margin: 30px 50px;
}

div.box {
   width: 200px;
   height: 270px;
   text-align: center;
   border: 3px solid black;
   border-radius: 20px;
   float: left;
   margin-right: 30px;
   margin-bottom: 20px;
}

div.box figure img {
   width: 160px;
   height: 160px;
   margin-top: 5px;
}

.recipe_img {
   width: 160px;
   height: 160px;
   margin-top: 5px;
}

.day {
   color: gray;
   font-size: 0.8em;
   margin-right: 20px;
}

div.content {
   display: none;
}
</style>
<script type="text/javascript">
   $(function(){
      //처음 시작시 그리드모양 이미지형태로 출력하기
      grid();
      
      
      $(".simplegrid").css("color","brown");
      
      $(".simplegrid").click(function(){
         $(this).css("color","brown");
         $(".simplelist").css("color","black");
         grid();
      });
      
      $(".simplelist").click(function(){
         $(this).css("color","brown");
         $(".simplegrid").css("color","black");
         list();
        

      });
      
   });
   function grid()
   {
      $.ajax({
         type:"get",
         dataType:"json",
         url:"./view",
         success:function(res){
            let s="";
            $.each(res,function(idx,item){
               var recipeName=item.recipeName;
               console.log(item.recipeTitle);
               s+=
                  `
                  <div class="box" style="background-color:#FFFFF0;">
                     <figure>
                     <img src="https://kr.object.ncloudstorage.com/semi-project-eatingalone/photo/\${item.recipePhoto}" ><br>
                        <figcaption>
                           <b>\${item.recipeTitle}</b><br>
                           <span style="color:gray;">\${item.recipeName}</span>
                           <br>
                           <span class="day">작성자<br>
                              &nbsp;&nbsp;&nbsp;
                           조회수\${item.recipeViewCount}</span>
                        </figcaption>
                     </figure>
                  </div>
                  `;
            });
            $(".list").html(s);
          }
      });
   }
   
    function list()
      {
         $.ajax({
            type:"get",
            dataType:"json",
            url:"./view",
            success:function(res){
               let s="";
               s+=
               `
               <table class="table table-bordered" style="450px">
               `;
               $.each(res,function(idx,item){
                  var recipeName=item.recipeName;
                  console.log(recipeName);
                  s+=
                  `
                  <tr>
                     <td>
                     <img class="recipe_img" src="https://kr.object.ncloudstorage.com/semi-project-eatingalone/photo/\${item.recipePhoto}" >
                        <h5><b class="subject" style="cursor:pointer">\${item.recipeTitle}</b></h5>
                        <div style="margin-left:20px;color:black;" class="content">
                           <pre>\${item.recipeContent}</pre>
                           </div>
                           <div>
                              <span>${item.recipeName}</span>&nbsp;&nbsp;
                              <span class="day">작성일<br>
                                 &nbsp;&nbsp;
                                 조회수
                              </span>
                           </div>
                        </td>
                     </tr>
                  `;
               });
               s+="</table>";
               $(".list").html(s);
               //첫번째 content만 일단 보이도록
               $("div.content").eq(0).css("display","block");
            }
         });
         }
   </script>
</head>
<body>
   <div style="margin: 30px;">
      <div class="input-group" style="width: 400px;">
         <h5>상품명 검색</h5>
         <input type="text" class="form-control"
            style="width: 150px; margin-left: 50px;" autofocus
            placeholder="검색단어입력" id="txtword">
      </div>
      <div style="margin: 20px; font-size: 22px;" class="result">출력</div>
   </div>
   <div class="simpleicon">
      <i class="bi bi-grid simplegrid"></i> <i
         class="bi bi-list-ul simplelist"></i>
   </div>
	<div>
	<h4>현재 총 ${totalCount }개의 레시피가 있습니다.</h4>
	</div>
   <div class="list">123</div>
</body>
</html>