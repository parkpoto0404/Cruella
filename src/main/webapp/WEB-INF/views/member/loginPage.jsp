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
	      <!-- Login -->
	      <div class="card">
	        <div class="card-body">
	          <!-- 로그인 폼 상단 로고, 이름 -->
	          <div class="app-brand justify-content-center mb-6">
	            <a href="index.html" class="app-brand-link">
	              <img src="${ contextPath }/assets/img/mainlogo.png">
	              <span class="app-brand-text demo text-heading fw-bold">Cruella</span>
	            </a>
	          </div>
	          <!-- /로그인 폼 상단 로고, 이름 -->
	          <h4 class="mb-1">Welcome 👋</h4>
	          <p class="mb-6"></p>
	
	          <form id="formAuthentication" class="mb-4" action="${ contextPath }/member/signin.do" method="POST">
	            <div class="mb-6">  <!-- 아이디 입력 부분 -->
	              <label for="email" class="form-label">ID</label>
	              <input
	                type="text"
	                class="form-control"
	                id="email"
	                name="memNo"
	                placeholder="아이디를 입력하세요"
	                autofocus />
	            </div>
	            <div class="mb-6 form-password-toggle">  <!-- 비밀번호 입력 부분 -->
	              <label class="form-label" for="password">Password</label>
	              <div class="input-group input-group-merge">
	                <input
	                  type="password"
	                  id="password"
	                  class="form-control"
	                  name="memPwd"
	                  placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
	                  aria-describedby="password" />
	                <span class="input-group-text cursor-pointer"><i class="ti ti-eye-off"></i></span>
	              </div>
	            </div>
	            <div class="my-8">
	              <div class="d-flex justify-content-between">
	                <div class="form-check mb-0 ms-2">
	                </div>
	                <a href="${ contextPath }/member/findPwd.do">
	                  <p class="mb-0">비밀번호 찾기</p>
	                </a>
	              </div>
	            </div>
	            <div class="mb-6">
	              <button class="btn btn-primary d-grid w-100" type="submit">로그인</button>
	            </div>
	          </form>
	
	        </div>
	      </div>
	      <!-- /Login -->
	    </div>
	  </div>
	</div>
	
	<!-- / Content -->

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->

<script src="${ contextPath }/assets/vendor/libs/jquery/jquery.js"></script>
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