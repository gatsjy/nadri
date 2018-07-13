<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>�Խù� �󼼺���</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="shortcut icon" href="/images/common/favicon.ico">

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- Bootstrap CDN -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<!-- common.js / common.css CDN -->
<script src="/javascript/common.js"></script>
<link rel="stylesheet" href="/css/common.css">
<!-- toolbar.js CDN -->
<script src="/javascript/toolbar.js"></script>

<!-- flexslider CDN (�����̵��) -->
<link rel="stylesheet" href="/css/flexslider.css" type="text/css">
<script src="/javascript/flexslider.js"></script>

<style>
   #boardTitle{
      height : 50px;
   }
   #boardImg{
      width : 500px;
      height : 500px;
   }
   #boardContent{
      height : 200px;
   }
   #commList{
      display : none;
   }
   .icon{
      cursor : pointer;
      width : 30px;
      height : 30px;
   }
   .iconDetail{
      display : none;
      cursor : pointer;
      width : 30px;
      height : 30px;
   }
   .userList{
      display: flex;
      flex-direction: row;
   }
   .userInfoAndBoardDate{
      display: flex;
      flex-direction: column;
      justify-content: center;
      margin-left : 10px;
   }
   #more{
      position : relative;
       margin-left: auto;
   }
   #moreContent{
      position : absolute;
      border-radius: 10%;
      /*background-image : url(/images/board/more_back.png);*/
      background-color : #E8E8E8;
      z-index : 10;
      text-align : center;
   }
   .moreDetail{
      cursor : pointer;
      display : none;
   }
   /* ȭ���� �۾����� �� ���������� ���� ���Բ� ���� */
   @media only screen and (max-width: 600px) {
      .container{
         display: flex;
         flex-direction: column-reverse;
      }
      .col-md-4{
         flex-direction: row;
      }
   }
   .img-circle{   
      cursor : pointer;
      height : 64px;
      width : 64px;
   }
   .userModal{
      /*text-align: center; /*�ȿ� ���빰 �������*/
        padding-top : 20%; /*���â �����¿� �����༭ ����� �߰Բ� ����*/
   }
   .userModalInner-backdrop-bg{
       opacity: 0.5;
   }
   .userModalContent{
      text-align: center; /*�ȿ� ���빰 �������*/
      padding : 5% /*�ȿ� ���빰 ����*/
   }
   /*.userModalInner .modal-backdrop.in {
       opacity: 0;
   }*/
   
   /*  �Ű����� ���� admin css  */
   .inquireTitle {
      margin-bottom: 10px;
      width: 100%;
   }
   .reportUser {
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;
   }
   .reportLink{
      display: inline;
      float: right;
      visibility: hidden;
      position : absolute;
      right:1vw;   
   }
   .inquireWrite {
      width: 100%;
   }
   body.waiting * {
      cursor: progress;
   }
   .count1 div {
      display: none;
      float: right;
   }
   .count2 div {
      display: none;
      float: right;
   }
   .fonted{
      float: left;
      margin-bottom: 10px;
   }
</style>

<script>
$(function(){
   //*�����̵�� ����
   $('.flexslider').flexslider({
      animation: "slide"
   });
   
   //*������ Ŭ��
   $(".moreImg").on("click", function(){
       var top =  $(this).offset().top+$(this).outerHeight(true); //�����ϴ� ��� ��ġ
       var right = ($(window).width() - ($(this).offset().left+$(this).outerWidth())); //�����ϴ� ������ġ
       
       $("#moreContent").css("top",top).css("right",right);
   
      if( $(".moreDetail").is(":visible")){
          $(".moreDetail").slideUp();
      }else{
          $(".moreDetail").slideDown();
      }
   })
   //*������ �޴�
   $("#modifyBoard").on("click", function(){
      $("#firstForm").attr("method","GET").attr("action", "/board/updateBoard").submit();
   })
   $("#deleteBoard").on("click", function(){
      var result = confirm('�Խù��� ���� �����Ͻðڽ��ϱ�?');
      if(result) {
         $.ajax({
            url : "/board/json/deleteBoard/"+$("#boardNo").val().trim(),
            method : "POST"
         })
         alert("�����Ǿ����ϴ�.");
         self.location="/board/listBoard.jsp";
      } else {
         alert("����Ͽ����ϴ�.");
          $(".moreDetail").slideDown();
      }
   })
   
   $("#addCart").on("click", function(){
      alert("�����ٱ����߰�����..")
   })
   //*������ ���� �� Ŭ���� fadeOut();
   $(document).mouseup(function(e){
      if( !$(".moreDetail").is(e.target) ){
         $(".moreDetail").fadeOut();
      }
   })
   
   //*��Ʈ Ŭ��
   $("#likeIcon>.icon").on("click", function(){
      if( $(this).attr("src")=="/images/board/like_empty.png" ){ //���ƿ�+1
         $.ajax({
            url : "/board/json/addLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_full.png"); //�̹��� ����
      }else{ //���ƿ�-1
         $.ajax({
            url : "/board/json/deleteLike/"+$("#boardNo").val().trim(),
            method : "POST",
            success : function(data, status){
               $("#likePrint").text("���ƿ� "+data+"��");
            }
         })
         $(this).attr("src","/images/board/like_empty.png"); //�̹��� ����
      }
   })
   
   //*��� Ŭ��
   $("#commIcon").on("click", function(){
      $("#commContent").focus();
   })
   
   //*���� Ŭ���� SNS ������ ����
   $("#shareIcon>.icon").on("click", function(){
      if( $(".iconDetail").css("display")=="none" ){
         $(".iconDetail").show("scale");
      }else{
         $(".iconDetail").hide("scale");
      }
   })
   //* SNS����
   $("#kakaoShare").on("click", function(){
      alert("īī���� �����մϴ�.");
   })
   $("#facebookShare").on("click", function(){
      alert("���̽������� �����մϴ�.");
   })
   $("#instagramShare").on("click", function(){
      alert("�ν�Ÿ�׷����� �����մϴ�.");
   })
   
   //*������������..
   $("#addFriend").on("click", function(){
      
   })
   $("#inquireUser").on("click", function(){
      var counter = $(this).attr('name');
       $('.reportedUserId').val(counter);
       $('.reportedUserId').attr('disabled', 'disabled');
       $('.inquireCode').val('0').prop("selected", true);
       $('.inquireCode').attr('disabled', 'disabled');
       $('.reportUser').css('visibility', 'visible');
       $('.reportLink').css('visibility', 'hidden');
   })
   
   
   //* Admin (�Ű���)
   var inquireType = $('.inquireCode option:selected').val();

      $('.inquireCode').on('change', function() {
         inquireType = this.value;
         if (inquireType == '0') {
            $('.reportUser').css('visibility', 'visible');
         } else {
            $('.reportUser').css('visibility', 'hidden');
         }
      })

      $(".inquireSend").on(
            "click",
            function(e) {

               var form = $(".inquire_form");

               // you can't pass Jquery form it has to be javascript form object
               var formData = new FormData(form[0]);

               //if you only need to upload files then 
               //Grab the File upload control and append each file manually to FormData
               //var files = form.find("#fileupload")[0].files;

               //$.each(files, function() {
               //  var file = $(this);
               //  formData.append(file[0].name, file[0]);
               //});

               if ($('.inquireTitle').val() == '') {
                  alert("������ �Է����ּ���!");
                  $('.inquireTitle').focusin();
                  return;
               } else if ($('.inquireWrite').val() == '') {
                  alert("������ �Է����ּ���!");
                  $('.inquireTitle').focusin();
               } else {

                  $('body').addClass('waiting');
                  
                  var reportUser = $('.reportedUserId').val();
                  
                  if(reportUser==''){
                     console.log("�����Ű� �ƴմϴ�~");
                     reportUser = "null";
                  }
                  
                  var inquireCode = $('.inquireCode').val();
                  
                  var title = $('.inquireTitle').val();
                  var title_enc = encodeURI(encodeURIComponent(title));
                  
                  var write = $('.inquireWrite').val();
                  var write_enc = encodeURI(encodeURIComponent(write));
                  
                  var link = $('.inquireLink').val();
                                    
                  $.ajax({
                     type : "POST",
                     url : "/restAdmin/addInquire/"+reportUser+"/"+inquireCode+"/"+write_enc+"/"+title_enc+"/"+link,
                     //dataType: 'json', //not sure but works for me without this
                     data : formData,
                     contentType: false,//this is requireded please see answers above
                     processData : false, //this is requireded please see answers above
                     //cache: false, //not sure but works for me without this
                     success : function(data, status) {
                        if (status == "success") {
                           $('body').removeClass('waiting');
                           $('form')[0].reset();
                           $('#myModal').modal('hide');
                           console.log(data);
                        }
                     }
                  });
               }

            });

/*       $('img').on('click', function() {
         var counter = $(this).attr('name');
         $('.reportedUserId').val(counter);
         $('.reportedUserId').attr('disabled', 'disabled');
         $('.inquireCode').val('0').prop("selected", true);
         $('.inquireCode').attr('disabled', 'disabled');
         $('.reportLink').css('visibility', 'hidden');
         $('.reportUser').css('visibility', 'visible');
      }) */

      $('.inquireTitle').on('click', function() {
         $('.count1 div').css('display', 'inline-block');
      })

      $('.inquireTitle').on('focusout', function() {
         $('.count1 div').css('display', 'none');
      })

      $('.inquireWrite').on('click', function() {
         $('.count2 div').css('display', 'inline-block');
      })

      $('.inquireWrite').on('focusout', function() {
         $('.count2 div').css('display', 'none');
      })

      $('.inquireWrite').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter2').text(currentLength - 1);
      });

      $('.inquireTitle').on("input", function() {
         var maxlength = $(this).attr("maxlength");
         var currentLength = $(this).val().length;
         $('.textCounter1').text(currentLength - 1);
      });
      
      $('#inquireBoard').on('click', function() {
         var counter = $(this).attr('name');
         $('.inquireLink').val(counter);
         $('.inquireLink').attr('disabled', 'disabled');
         $('.inquireCode').val('1').prop("selected", true);
         $('.inquireCode').attr('disabled', 'disabled');
         $('.reportUser').css('visibility', 'hidden');
         $('.reportLink').css('visibility', 'visible');
      })
})
</script>
</head>

<body>
   <jsp:include page="/layout/toolbar.jsp"/>

   <!-- ������ ��ư Ŭ���� ����� �׸� --> 
   <span id="moreContent">
      <span class="moreDetail" id="modifyBoard">�Խù�����</span><br>
      <span class="moreDetail" id="deleteBoard">�Խù�����</span><br>
      <span class="moreDetail" id="inquireBoard" name="${board.boardNo}" data-toggle="modal" data-target="#inquireModal">�Խù��Ű�</span><br>
      <span class="moreDetail" id="addCart">�����ٱ��� �߰�</span>
   </span>
               
   <div class="container">
      
      <div class="col-md-8"> <!-- ����+�̹���+���� -->
         <form id="firstForm" class="form-horizontal">
            <input type="hidden" id="boardNo" name="boardNo" value="${board.boardNo}">
            <!-- ���� -->
            <div id="boardTitle" class="bg-warning">${board.boardTitle}</div>
            <br>
            
            <!-- �̹��� -->
            <div class="flexslider">
               <ul class="slides">
                  <c:forTokens var="images" items="${board.boardImg}" delims=",">
                      <li><img src="/images/board/posts/${images}"/></li>
                  </c:forTokens>
               </ul>
            </div>
            
            <!-- �ؽ��±� -->
            <div id="hashTag" class="bg-warning">${board.hashTag}</div>
            
            <!-- ���� -->
            <div id="boardContent" class="bg-warning">${board.boardContent}</div>
         </form>
      </div>
      
      <div class="col-md-4"> <!-- ��������+�Խù����(���ƿ�+���+����)+��� -->
         <form id="lastForm" class="form-horizontal">
            <!-- �������� -->
            <div class="userList">
                <div id="userProfile"><img src="/images/user/${user.profileImg}" class="img-circle" data-toggle="modal" data-target=".userModal"></div>
                   <!-- ������ Ŭ���� �������� ���â���� ��� ���� -->
               <div class="modal modal-center fade userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
                 <div class="modal-dialog modal-sm userModalInner">
                   <div class="modal-content userModalContent">
                     <!-- ���� �� ���� -->
                          <button type="button" class="close" data-dismiss="modal">&times;</button><br>
                     <div class="modalUserProfile"><img src="/images/user/${user.profileImg}" class="img-circle"></div>
                     <div class="modalUserName">�̸� : ${user.userName}</div>
                     <div class="modalUserId">���̵� : ${user.userId}</div>
                     <div class="modalUserIntroduce">�ڱ�Ұ� : ${user.introduce}</div>
                     <div class="modalUserButton">
                        <button type="button" class="btn btn-primary" id="addFriend">ģ���߰�</button>
                        <button type="button" class="btn btn-danger" id="inquireUser" name="${user.userId}" data-toggle="modal" data-target="#inquireModal">�����Ű�</button>
                     </div>
                   </div>
                 </div>
               </div>
               <!-- ������ Ŭ���� �������� ���â���� ��� �� -->
               <div class="userInfoAndBoardDate">
                  <div id="userInfo"><b>${user.userName}</b> (${user.userId})</div>
                  <div id="boardDate"><fmt:formatDate value="${board.boardDate}" pattern="yyyy�� MM�� dd�� hh:mm:ss"/></div>
               </div>
               <div id="more"><img class="moreImg" src="/images/board/more.png" style="cursor:pointer;width:20px;height:20px;margin-top:10px"></div>
            </div>
            <br>
            
            <!-- ������(���ƿ�+���+����) -->
            <div id="iconList">
               <span id="likeIcon">
                  <c:if test="${likeFlag==0}"><img class="icon" src="/images/board/like_empty.png"></c:if>
                  <c:if test="${likeFlag!=0}"><img class="icon" src="/images/board/like_full.png"></c:if>
               </span>&nbsp;&nbsp;
               <span id="commIcon"><img class="icon" src="/images/board/comment.png"></span>&nbsp;&nbsp;
               <!-- �����ϱ� ��ư Ŭ���� ����� �׸� -->
               <span id="shareIcon">
                  <img class="icon" src="/images/board/share.png">&nbsp;&nbsp;
                  <img class="iconDetail" id="kakaoShare" src="/images/board/share/kakao.png">
                  <img class="iconDetail" id="facebookShare" src="/images/board/share/facebook.png">
                  <img class="iconDetail" id="instagramShare" src="/images/board/share/instagram.png">
               </span>
            </div>
            <br>
            
            <!-- ���ƿ�@��+���@�� -->
            <div id="viewList">
               <span id="likePrint">���ƿ� ${likeCount}��</span>&nbsp;&nbsp;
               <span id="commPrint">��� ${commentCount}��</span>
            </div>
            <br>
            
            <!-- ��۸���Ʈ -->
            <div id="commList"></div>
            <br>
            
            <!-- ����Է��� -->
            <div id="commProm">
               <input class="form-control" type="text" id="commContent" name="commContent" placeholder="����� �Է����ּ���..">
            </div>
         </form>
      </div>
      
   </div><!-- e.o.container -->
   
   
   <!-- �Ű� Modal content -->
   <div class="modal fade" id="inquireModal" role="dialog">
      <div class="modal-dialog">
         <div class="modal-content">
            <div class="modal-header">
               <button type="button" class="close" data-dismiss="modal">&times;</button>
               <h4 class="modal-title">
                     �Ű��ϱ�<br>
                  <h6 style="color: lightgrey;">�Ű����� â�� �ݾƵ� �����˴ϴ�</h6>
               </h4>
            </div>
            <div class="modal-body">
               <form class="inquire_form" enctype="multipart/form-data">
                  �� �� �� ��
                 <select class="inquireCode" name="inquireCode" style="height: 30px;">
                     <option value="9">�����ϼ���</option>
                     <option value="0">�����Ű�</option>
                     <option value="1">�Խñ۽Ű�</option>
                     <option value="2">��۽Ű�</option>
                     <option value="3">������û</option>
                     <option value="4">��Ÿ����</option>
                  </select>
                  <span class="reportUser">�Ű��������̵�<input type="text" name="reportUserId" class="reportedUserId" value="">
                  </span>
                  <span class="reportLink">�� �� �� ũ<input type="text" name="inquireLink" class="inquireLink" value="">
                  </span>
                  <hr />
                  <div class="count1">
                     <p class="fonted">����</p>
                     <div>/30</div>
                     <div class="textCounter1">0</div>
                  </div>
                  <input type="text" class="inquireTitle" name="inquireTitle" value="" placeholder="������ �Է����ּ���." maxlength="30"><br>
                  <div class="count2">
                     <p>�� �� �� ��</p>
                     <div>/100</div>
                     <div class="textCounter2">0</div>
                  </div>
                  <textarea class="inquireWrite" name="inquireWrite" value="" placeholder="������ �Է��� �ּ���." maxlength="100"></textarea>
                  <br>
                  <p class="fonted">
                     <input type="file" name="inquire_file" multiple="multiple">
                  </p>
                  <br>
               </form>
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-primary inquireSend">������</button>
               <button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
            </div>
         </div>

      </div>
   </div>
   
</body>
</html>