<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en"
	class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
	dir="ltr" data-theme="theme-default"
	data-assets-path="${ contextPath }/assets/" data-template="views"
	data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${ contextPath }/resources/assets/js/config.js"></script>
<style>
		#signup::before {
		  content: ''; /* 가상 요소 필수 */
		  display: inline-block; /* 블록 요소 */
		  width: 10px; /* 동그라미 크기 */
		  height: 10px; /* 동그라미 크기 */
		  border-radius: 50%; /* 완전한 원 */
		  background-color: transparent; /* 배경을 투명으로 설정 */
		  border: 2px solid gray; /* 초기 테두리 색상 */
		}
		#signup.active::before {
		  border: 2px solid white; /* 테두리만 흰색으로 변경 */
		}
</style>

</head>
<body>
	<div class="layout-wrapper layout-content-navbar">
		<div class="layout-container">


			<!-- 헤더 시작 -->
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
			<!-- 헤더 끝 -->

			<div class="layout-page">

				<!-- nav 시작 -->
				<jsp:include page="/WEB-INF/views/common/nav.jsp" />
				<!-- nav 끗 -->


				<div class="content-wrapper">
					<!-- 세션 시작 -->
					<div class="container-xxl flex-grow-1 container-p-y">
						<!-- 이쪽에 세션정보 넣어야합니다 -->


						<div class="row">
							<div class="col-md-12">
								<div class="nav-align-top">
									<ul
										class="nav nav-pills flex-column flex-sm-row mb-6 gap-2 gap-lg-0">
										<c:if test="${ loginUser.deptCode eq 'S2'}">
											<li class="nav-item"><a class="nav-link active"
												href="${ contextPath }/member/signup.do"> <i
													class="ti-sm ti ti-user-check me-1_5"></i> 직원등록
											</a></li>
										</c:if>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/member/employeelistview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 직원조회 </a></li>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/wl/checkinrecordview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 출근기록조회 </a></li>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/member/workhoursview.do""><i
												class="ti-sm ti ti-users me-1_5"></i> 근무시간조회 </a></li>
										<c:if test="${ loginUser.deptCode eq 'S2'}">
											<li class="nav-item"><a class="nav-link"
												href="${ contextPath }/member/salarypayment.do""><i
													class="ti-sm ti ti-users me-1_5"></i> 급여지급 </a></li>
										</c:if>

										<li class="nav-item"><a class="nav-link"
											href="${ contextPath }/member/checksalary.do""><i
												class="ti-sm ti ti-money me-1_5"></i> 급여내역확인 </a></li>
								</div>
							</div>
						</div>

						<div class="container-xxl flex-grow-1 container-p-y">
							<div class="row">
								<div class="col-md-12">

									<div class="card mb-6">
										<!-- Account -->

										<form id="formAccountSettings"
											action="${ contextPath }/member/insert.do" method="post"
											enctype="multipart/form-data">
											<div class="card-body">
												<div style="text-align: center;">
													<img src="${contextPath}/assets/img/default_profile.png"
														alt="user-avatar"
														class="d-block w-px-140 h-px-140 rounded mx-auto"
														id="uploadedAvatar"
														style="margin-bottom: 20px; align-items: center; max-width: 120px; max-height: 120px; object-fit: cover;"
														height="120px" />
													<div class="button-wrapper">
														<label for="upload" class="btn btn-primary me-3 mb-4"
															tabindex="0"> <span class="d-none d-sm-block">첨부파일
																업로드</span> <i class="ti ti-upload d-block d-sm-none"></i> <input
															type="file" id="upload" class="account-file-input" hidden
															accept="image/*" name="uploadFile" />
														</label>
														<!-- 														<button type="button"
															class="btn btn-label-secondary account-image-reset mb-4">
															<i class="ti ti-refresh-dot d-block d-sm-none"></i> <span
																class="d-none d-sm-block">삭제하기</span>
														</button> -->
													</div>


												</div>
											</div>

											<script>
												
												$(document).ready(function() {
													
													
													// 파일 업로드 
													$('#upload').on("change", function(evt) {
														const file = evt.target.files[0]; // 사용자가 선택한 파일
														console.log("실행");
														const memNo = $('#memNo').val();
										
														if (file) {
															// 선택된 파일 업로드전 미리보기
															const reader = new FileReader();
															reader.onload = function(r) {
																$('#uploadedAvatar').attr("src", r.target.result); // 이미지 변경
															};
															reader.readAsDataURL(file);
										
															let formData = new FormData();
															formData.append("uploadFile", file);
															formData.append("memNo", memNo);
														}
										
													})
												})
											</script>

											<h5 class="pb-4 border-bottom mb-4"></h5>
											<div class="card-body pt-4">
												<div class="row">
													<div class="mb-4 col-md-6">
														<label for="memName" class="form-label">이름</label> <input
															class="form-control" type="text" id="memName"
															name="memName" autofocus required />
														<div id="nameError" class="text-danger mt-2"
															style="display: none;">이름은 한글 2자 이상이어야 합니다.</div>
													</div>
													<script>
														$(document)
																.ready(
																		function() {
																			const nameInput = $('#memName');
																			const nameError = $('#nameError');

																			// 이름 유효성검사
																			function validateName() {
																				const nameValue = nameInput
																						.val()
																						.trim();
																				const nameRegex = /^[가-힣]{2,}$/; // 한글만 허용, 최소 2자 이상
																				if (!nameRegex
																						.test(nameValue)) {
																					nameError
																							.text(
																									'이름은 한글 2자 이상이어야 합니다.')
																							.show();
																					return false;
																				}
																				nameError
																						.hide();
																				return true;
																			}

																			// 실시간 입력 시 유효성 검사
																			nameInput
																					.on(
																							'input',
																							function() {
																								validateName();
																							});

																			// 폼 제출 시 유효성 검사
																			$(
																					'#formAccountSettings')
																					.on(
																							'submit',
																							function(
																									event) {
																								if (!validateName()) {
																									event
																											.preventDefault(); 
																								}
																							});
																		});
				
														
													</script>

													<div class="mb-4 col-md-6">
														<label for="account" class="form-label">계좌번호</label>
														<div
															style="display: flex; align-items: center; gap: 10px;">
															<select class="form-select" style="max-width: 120px;"
																name="bankName">
																<option value="">선택</option>
																<option value="신한">국민</option>
																<option value="신한">신한</option>
																<option value="신한">우리</option>
															</select> <input class="form-control" type="text" name="account"
																id="account" placeholder="계좌번호 입력" required />
														</div>
														<small id="accountError"
															style="color: red; display: none;">계좌번호는 3-3-6
															형식이어야 합니다.</small>
													</div>


													<script>
														$(document)
																.ready(
																		function() {
																			$(
																					'#account')
																					.on(
																							'input',
																							function() {
																								let input = $(
																										this)
																										.val()
																										.replace(
																												/[^0-9]/g,
																												''); // 숫자 외 문자 제거
																								let formatted = '';

																								// 3-3-6 형식으로 포맷팅
																								if (input.length <= 3) {
																									formatted = input;
																								} else if (input.length <= 6) {
																									formatted = input
																											.slice(
																													0,
																													3)
																											+ '-'
																											+ input
																													.slice(3);
																								} else {
																									formatted = input
																											.slice(
																													0,
																													3)
																											+ '-'
																											+ input
																													.slice(
																															3,
																															6)
																											+ '-'
																											+ input
																													.slice(
																															6,
																															12);
																								}

																								$(
																										this)
																										.val(
																												formatted);

																								// 유효성 검사: 3-3-6 형식이 아닐 경우 경고 표시
																								const isValid = /^[0-9]{3}-[0-9]{3}-[0-9]{6}$/
																										.test(formatted);
																								if (!isValid
																										&& input.length > 0) {
																									$(
																											'#accountError')
																											.show();
																								} else {
																									$(
																											'#accountError')
																											.hide();
																								}
																							});
																		});
													</script>
													<div class="mb-4 col-md-6">
														<label for="memNo" class="form-label">사번</label> <input
															class="form-control" type="text" id="memNo" name="memNo"
															value="${ memNo }" readonly />
													</div>
													<div class="mb-4 col-md-6">
														<label for="deptCode" class="form-label">부서</label> <select
															id="deptCode" class="select form-select" name="deptCode">
															<option value="">선택</option>
															<option value="S1">영업총괄</option>
															<option value="S2">인사</option>
															<option value="S3">지원</option>
															<option value="T1">남성의류</option>
															<option value="T2">여성의류</option>
															<option value="T3">식품</option>
															<option value="T4">스포츠</option>
															<option value="T5">뷰티</option>
															<option value="T6">명품</option>
															<option value="T7">문화센터</option>
															<option value="T8">디지털 및 가전</option>
														</select>
													</div>
													<div class="mb-4 col-md-6">
														<label class="form-label" for="memPwd">비밀번호</label>
														<div class="input-group input-group-merge">
															<input type="text" id="memPwd" name="memPwd"
																value="${ memPwd }" class="form-control" readonly/>
														</div>
													</div>
													<div class="mb-4 col-md-6">
														<label for="posCode" class="form-label">직급</label> <select
															id="posCode" class="select form-select" name="posCode">
															<option value="">선택</option>
															<!-- 															<option value="C1">점장</option>
															<option value="C2">부점장</option> -->
															<option value="C3">부장</option>
															<option value="C4">팀장</option>
															<option value="C5">대리</option>
															<option value="C6">주임</option>
															<option value="C7">사원</option>
														</select>
													</div>

													<script>
													$(document).ready(function() {
														$('#posCode').on("change",function(){
															
															/* if($('#posCode').val() === 'C1'){
																$('#salary').val('20000000');
															}else if(){
																
															} */
															
															switch($('#posCode').val()){
															case 'C1' : $('#salary').val('20000000'); break;
															case 'C2' : $('#salary').val('10000000'); break;
															case 'C3' : $('#salary').val('5500000'); break;
															case 'C4' : $('#salary').val('4000000'); break;
															case 'C5' : $('#salary').val('3000000'); break;
															case 'C6' : $('#salary').val('2600000'); break;
															case 'C7' : $('#salary').val('2300000'); break;
															}
															
														})
													})
	                        </script>







													<div class="mb-4 col-md-6">
														<label for="email" class="form-label">Email</label>
														<div
															style="display: flex; align-items: center; gap: 10px;">
															<!-- 이메일 입력 -->
															<input class="form-control" type="text" id="email"
																name="email" placeholder="이메일 아이디를 입력하세요" required />
															<!-- 이메일 도메인 선택 -->
															<select class="form-select" style="max-width: 150px;"
																onchange="setEmailDomain(this.value)"
																title="이메일 도메인 주소 선택">
																<option value="custom">직접입력</option>
																<option value="naver.com">naver.com</option>
																<option value="gmail.com">gmail.com</option>
																<option value="hanmail.net">hanmail.net</option>
																<option value="nate.com">nate.com</option>
																<option value="kakao.com">kakao.com</option>
															</select>
														</div>
													</div>

													<script>
													    // 이메일 도메인 자동 적용 함수
													    function setEmailDomain(domain) {
													        const emailInput = document.getElementById('email');
													        const [localPart] = emailInput.value.split('@'); // '@' 기준으로 로컬 파트 분리
													
													        if (domain === 'custom') {
													            // 도메인 직접입력 선택 시 기존 값 유지
													            emailInput.value = localPart;
													            emailInput.focus();
													        } else {
													            // 선택된 도메인을 이메일에 추가
													            emailInput.value = localPart + '@' + domain;
													        }
													    }
													</script>

													<div class="mb-4 col-md-6">
														<label for="salary" class="form-label">급여</label> <input
															type="text" class="form-control" id="salary"
															name="salary" value="" required />
													</div>
													<div class="mb-4 col-md-6">
														<label class="hireDate2" for="country">입사날짜</label> <input
															class="form-control" type="date" id="hireDate"
															name="endDate" placeholder="YYYY/MM/DD" required />
													</div>
													<div class="mb-4 col-md-6">
														<label for="address" class="form-label">주소</label> <input
															class="form-control" type="text" id="address"
															name="address" placeholder="Address" required />
													</div>
													<div class="mb-4 col-md-6">
														<label for="memSSN" class="form-label">주민등록번호</label> <input
															class="form-control" type="text" id="memSSN"
															name="memSSN" placeholder="000000-0000000" required
															pattern="^\d{6}-\d{7}$" />
													</div>
													<div class="mb-4 col-md-6">
														<label for="phone" class="form-label">전화번호</label> <input
															class="form-control" type="text" id="phone" name="phone"
															placeholder="010-1111-2222" required
															pattern="^\d{3}-\d{4}-\d{4}$" />
														<div id="phoneError" class="text-danger mt-2"
															style="display: none;"></div>
													</div>

													<script>
													$(document).ready(function () {
													    $('#phone').on('blur', function () {
													        const phone = $(this).val();
													        if (phone) {
													            $.ajax({
													                type: 'POST',
													                url: '${contextPath}/member/checkPhone.do',
													                data: { phone: phone },
													                success: function (res) {
													                    if (res) {
													                        $('#phoneError').text('이미 등록된 휴대폰 번호입니다.').show();
													                    } else {
													                        $('#phoneError').hide();
													                    }
													                },
													                error: function () {
													                    $('#phoneError').text('중복 검사에 실패했습니다. 다시 시도해주세요.').show();
													                }
													            });
													        }
													    });
													});

													</script>

												</div>
												<div class="mt-2" style="justify-self: center;">
													<button type="submit" class="btn btn-primary me-3">등록하기</button>
													<a href="${contextPath}/member/dashbord.do"
														class="btn btn-label-secondary">취소하기</a>

												</div>
										</form>
									</div>
									<!-- /Account -->
								</div>

							</div>
						</div>
					</div>




				</div>
				<!-- 세션 끝 -->



				<!-- 푸터 시작 -->
				<jsp:include page="/WEB-INF/views/common/footer.jsp" />
				<!-- 푸터 끝 -->

				<div class="content-backdrop fade"></div>
				<!-- wrapper 닫기 -->
			</div>

			<!-- nav layout page 닫기 -->
		</div>

		<!-- layout-container 닫기 -->
	</div>
	<!-- Overlay -->
	<div class="layout-overlay layout-menu-toggle"></div>

	<!-- Drag Target Area To SlideIn Menu On Small Screens -->
	<div class="drag-target"></div>


	<!-- layout wrapper 닫기 -->
	</div>





	<script>
    // 사이드바 처리
	document.addEventListener("DOMContentLoaded", function () {
  	
		const element = document.getElementById("signup");
		
  	document.getElementById("member").classList.add("open");
  	element.style.backgroundColor = "#958CF4";
  	element.style.color = "white";
  	element.classList.add("active");
  	
  	
	});
	</script>
	
	<script>
    document.addEventListener("DOMContentLoaded", function () {
        const salaryInput = document.getElementById("salary");

        // 숫자에 콤마를 추가하는 함수
        function formatNumberWithCommas(number) {
            if (!number) return "";
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }

        // 입력 값 실시간 포맷팅
        salaryInput.addEventListener("input", function () {
            const rawValue = salaryInput.value.replace(/,/g, ""); // 기존 콤마 제거
            if (!isNaN(rawValue)) {
                salaryInput.value = formatNumberWithCommas(rawValue); // 포맷팅된 값 삽입
            } else {
                salaryInput.value = ""; // 숫자가 아니면 초기화
            }
        });

</script>
	

</body>
</html>