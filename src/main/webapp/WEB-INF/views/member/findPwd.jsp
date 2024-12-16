<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/assets/vendor/libs/jquery/jquery.js"></script>
 <!-- Favicon -->
 <link rel="icon" type="image/x-icon" href="../../assets/img/favicon/favicon.ico" />

 <!-- Fonts -->
 <link rel="preconnect" href="https://fonts.googleapis.com" />
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
 <link
   href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
   rel="stylesheet" />

 <!-- Icons -->
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/fonts/fontawesome.css" />
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/fonts/tabler-icons.css" />
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/fonts/flag-icons.css" />

 <!-- Core CSS -->

 <link rel="stylesheet" href="${ contextPath }/assets/vendor/css/rtl/core.css" />
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/css/rtl/theme-default.css" />

 <link rel="stylesheet" href="${ contextPath }/assets/css/demo.css" />

 <!-- Vendors CSS -->
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/libs/node-waves/node-waves.css" />

 <link rel="stylesheet" href="${ contextPath }/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/libs/typeahead-js/typeahead.css" />
 <!-- Vendor -->
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/libs/@form-validation/form-validation.css" />

 <!-- Page CSS -->
 <!-- Page -->
 <link rel="stylesheet" href="${ contextPath }/assets/vendor/css/pages/page-auth.css" />

 <!-- Helpers -->
 <script src="${ contextPath }/assets/vendor/js/helpers.js"></script>
 <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->

 <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
 <script src="${ contextPath }/assets/js/config.js"></script>
</head>
  <body>
    <!-- Content -->
    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="authentication-inner py-6">
          <!-- Forgot Password -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
		          <div class="app-brand justify-content-center mb-6">
		            <a href="index.html" class="app-brand-link">
		              <img src="${ contextPath }/assets/img/mainlogo.png">
		              <span class="app-brand-text demo text-heading fw-bold">Cruella</span>
		            </a>
		          </div>
              <!-- /Logo -->
              <h4 class="mb-1">비밀번호 찾기 🔒</h4>
              <p class="mb-6">등록하신 이메일을 입력해 주세요. <br> 확인 후, 임시 비밀번호를 발급 받으실 수 있습니다.</p>
              <form id="formAuthentication" class="mb-6" method="POST">
                <div class="mb-6">
                  <label for="email" class="form-label">Email</label>
                  <input
                    type="text"
                    class="form-control"
                    id="email"
                    name="email"
                    placeholder="이메일을 입력하세요."
                    autofocus />
                </div>
                <button class="btn btn-primary d-grid w-100" onclick="fnSendCode();">임시 비밀번호 발급 받기</button> <!-- 임시비밀번호 발급 클릭 시 회원 상태값 'A'로 변경 -->
              </form>
              <div class="text-center">
                <a href="${ contextPath }" class="d-flex justify-content-center">
                  <i class="ti ti-chevron-left scaleX-n1-rtl me-1_5"></i>
                  로그인 화면으로
                </a>
              </div>
            </div>
          </div>
          <!-- /Forgot Password -->
        </div>
      </div>
    </div>
    
    
		<script>

			function fnSendCode(){
				
			  event.preventDefault();

				
				let email = $('#email').val();
				
				$.ajax({
					url: '${contextPath}/member/sendCode.do',
					type: 'POST',
					data: {email: email},
					success: function(res){
							console.log(res);
						if(res == "YYY"){	// 일치하는 이메일이 있을 경우
							window.location.href = "${contextPath}/member/sentEmail.do?email=" + email;
						}else{
							alert('등록된 이메일이 아닙니다.');
						}
						
					},
					error: function(){
						console.log('ajax 실패');
					}
				})
				
			}
			
			
		
		</script>

		
    <!-- / Content -->

    <!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->


  <script src="${ contextPath }/assets/vendor/libs/popper/popper.js"></script>
  <script src="${ contextPath }/assets/vendor/js/bootstrap.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/node-waves/node-waves.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/hammer/hammer.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/i18n/i18n.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/typeahead-js/typeahead.js"></script>
  <script src="${ contextPath }/assets/vendor/js/menu.js"></script>

  <!-- endbuild -->

  <!-- Vendors JS -->
  <script src="${ contextPath }/assets/vendor/libs/@form-validation/popular.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/@form-validation/bootstrap5.js"></script>
  <script src="${ contextPath }/assets/vendor/libs/@form-validation/auto-focus.js"></script>

  <!-- Main JS -->
  <script src="${ contextPath }/assets/js/main.js"></script>

  <!-- Page JS -->
  <script src="${ contextPath }/assets/js/pages-auth.js"></script>
  </body>
</html>