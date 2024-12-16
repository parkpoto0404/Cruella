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
          <!-- Reset Password -->
          <div class="card">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center mb-6">
                <a href="index.html" class="app-brand-link">
			          <!-- 로그인 폼 상단 로고, 이름 -->
			          <div class="app-brand justify-content-center mb-6">
			            <a href="index.html" class="app-brand-link">
			              <img src="${ contextPath }/assets/img/mainlogo.png">
			              <span class="app-brand-text demo text-heading fw-bold">Cruella</span>
			            </a>
			          </div>
			          <!-- /로그인 폼 상단 로고, 이름 -->
                </a>
              </div>
              <!-- /Logo -->
              <h4 class="mb-1">비밀번호 변경 🔒</h4>
              <p class="mb-6">
                <span class="fw-medium">새로운 비밀번호로 변경하여 사용하세요.</span>
              </p>
              <form id="formAuthentication" action="${ contextPath }/member/resetPwd.do" method="POST">
              	<input type="hidden" name="memNo" value="${ loginUser.getMemNo() }">
                <div class="mb-6 form-password-toggle">
                  <label class="form-label" for="password">변경할 비밀번호</label>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="newPwd"
                      class="form-control"
                      name="newPwd"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password" />
                    <span class="input-group-text cursor-pointer"><i class="ti ti-eye-off"></i></span>
                  </div>
                </div>
                <div class="mb-3 form-password-toggle">
                  <label class="form-label" for="confirm-password">변경할 비밀번호 확인</label> <!-- 입력받은 비밀번호와 일치하는지 비교 기능 추가하기 -->
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="checkNewPwd"
                      class="form-control"
                      name="checkNewPwd"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password" />
                    <span class="input-group-text cursor-pointer"><i class="ti ti-eye-off"></i></span>
                  </div>
                  <div id="checkNewPwdResult" style="width: 364px; height: 30px; margin-top: 5px;">
                    
                  </div>
                </div>
                <button type="submit" id="resetBtn" class="btn btn-primary d-grid w-100 mb-6" disabled>비밀번호 변경하기</button>  <!-- 비밀번호 변경 쿼리문에서 회원 상태값 'Y'로 수정 -->
              </form>
            </div>
          </div>
          <!-- /Reset Password -->
        </div>
      </div>
    </div>

		<script>
			
			let checkPwdResult = false;
			
			// 비밀번호, 비밀번호 확인 값 결과에 따라 비밀번호 변경 버튼 활성화 또는 비활성화 처리 해주는 함수
			function btnControl() {
				
				if( checkPwdResult ) {
					$('#resetBtn').removeAttr('disabled'); // 비밀번호 변경하기 버튼 활성화
				}else {
					$('#resetBtn').attr('disabled', true); // 비밀번호 변경하기 버튼 비활성화
				}
				
			}
		
			
			$(function(){
			
			$("#checkNewPwd").on("keyup", function(){
				
				let newPwd = $("#newPwd").val();							// 입력한 비번 값
				let checkNewPwd = $("#checkNewPwd").val();		// 입력한 비번 확인 값

				if(newPwd === checkNewPwd && checkNewPwd !== "") {	// 두 값이 일치할 때
					
					checkPwdResult = true;
					
					$("#checkNewPwdResult").text('비밀번호가 일치합니다.').css('color', '#28C76F');
					
				}else {
					
					$("#checkNewPwdResult").text('비밀번호가 일치하지 않습니다.').css('color', '#FF4C51');
					
					checkPwdResult = false;
					
				}
				
				btnControl(); // 비밀번호 변경 버튼 처리
				
				})
			})
		
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