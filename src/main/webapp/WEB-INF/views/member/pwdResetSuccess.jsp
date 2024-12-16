<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${ contextPath }/assets/"
  data-template="views"
  data-style="light">
<head>
<meta charset="UTF-8">
<meta
  name="viewport"
  content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />
  
<title>Insert title here</title>

<meta name="description" content="" />

<script src="${ contextPath }/resources/assets/js/config.js"></script>

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="${ contextPath }/assets/img/favicon/favicon.ico" />

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
            <h4 class="mb-1">비밀번호 변경 완료! 🔒</h4>
            <p class="mb-6">
              <span class="fw-medium">새로운 비밀번호로 변경 되었어요. </span>
            </p>
            <form id="formAuthentication" action="auth-login-basic.html" method="GET">
              
              <div class="mb-6 form-password-toggle">
                <div class="text-center">
                  <a href="auth-login-basic.html">
                    <a class="btn btn-primary w-100 my-6" href="${ contextPath }/"> 로그인 하기 </a> <!-- 로그인 화면으로 연결 -->
                  </a>
                </div>  
              </div>
            </form>
          </div>
        </div>
        <!-- /Reset Password -->
      </div>
    </div>
  </div>

  <!-- / Content -->

  <!-- Core JS -->
  <!-- build:js assets/vendor/js/core.js -->

  <script src="../../assets/vendor/libs/jquery/jquery.js"></script>
  <script src="../../assets/vendor/libs/popper/popper.js"></script>
  <script src="../../assets/vendor/js/bootstrap.js"></script>
  <script src="../../assets/vendor/libs/node-waves/node-waves.js"></script>
  <script src="../../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
  <script src="../../assets/vendor/libs/hammer/hammer.js"></script>
  <script src="../../assets/vendor/libs/i18n/i18n.js"></script>
  <script src="../../assets/vendor/libs/typeahead-js/typeahead.js"></script>
  <script src="../../assets/vendor/js/menu.js"></script>

  <!-- endbuild -->

  <!-- Vendors JS -->
  <script src="../../assets/vendor/libs/@form-validation/popular.js"></script>
  <script src="../../assets/vendor/libs/@form-validation/bootstrap5.js"></script>
  <script src="../../assets/vendor/libs/@form-validation/auto-focus.js"></script>

  <!-- Main JS -->
  <script src="../../assets/js/main.js"></script>

  <!-- Page JS -->
  <script src="../../assets/js/pages-auth.js"></script>
</body>

</html>