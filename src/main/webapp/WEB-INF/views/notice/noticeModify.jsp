<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="light-style layout-navbar-fixed layout-menu-fixed layout-compact" dir="ltr" data-theme="theme-default" data-assets-path="${contextPath}/assets/" data-template="views" data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/assets/js/config.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js"></script>
<link rel="stylesheet" href="${contextPath}/assets/css/styles.css">
<link rel="stylesheet" href="${contextPath}/assets/vendor/libs/select2/select2.css" />
<link rel="stylesheet" href="${contextPath}/assets/vendor/libs/bootstrap-select/bootstrap-select.css" />
<style>
  .delete-btn {
    position: absolute;
    top: -20px;
    right: -5px;
    background: none;
    border: none;
    font-size: 20px;
    color: black;
    cursor: pointer;
    line-height: 1;
  }
  .delete-btn:hover {
    color: red;
  }
  #fileText{
  	color: gray;
  	font-size: 11px;
  }
	#boardNotice::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#boardNotice.active::before {
	  border: 2px solid white; /* 테두리만 흰색으로 변경 */
	}
</style>
</head>
<body>
<div class="layout-wrapper layout-content-navbar">
  <div class="layout-container">
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <div class="layout-page">
      <jsp:include page="/WEB-INF/views/common/nav.jsp" />
      <div class="content-wrapper">
        <div class="container-xxl flex-grow-1 container-p-y">
          <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="container card" style="padding: 50px;">
                <form id="notice-form" action="${contextPath}/notice/noticeUpdate.do" method="post" enctype="multipart/form-data">
                  <div class="card-body" style="align-items: center;">
                    <input type="hidden" name="deptCode" value="${loginUser.deptCode}" />
                    <input type="hidden" name="noticeNo" value="${n.noticeNo}"/>
                    <input type="hidden" name="noticeContent" id="noticeContent">
                    <span style="font-size: 24px;">공지사항 수정</span><br><br>
                    
                    <label for="defaultFormControlInput" class="form-label">제목</label>
                    <input type="text" class="form-control" id="defaultFormControlInput" name="noticeTitle" placeholder="제목을 입력하세요." value="${n.noticeTitle}" required><br>
                    
                    <label for="formFile" class="form-label">첨부파일<span id="fileText"> (첨부파일의 최대 크기는 10MB이며, 전체 첨부파일의 최대 크기는 100MB입니다. )</span></label>
                    <input class="form-control file" type="file" id="formFile" name="uploadFiles" multiple><br>
                    <div id="file-container">
                      <c:forEach var="at" items="${n.attachList}">
                        <div class="file-item" style="position: relative; display: inline-block; margin: 10px;" data-fileno="${at.fileNo}">
                          <c:choose>
                            <c:when test="${fn:endsWith(at.filesystemName, '.jpg') || fn:endsWith(at.filesystemName, '.jpeg') || fn:endsWith(at.filesystemName, '.png') || fn:endsWith(at.filesystemName, '.gif')}">
                              <img src="${contextPath}${at.filePath}/${at.filesystemName}" style="max-width: 120px; height: auto; max-height: 150px;"/>
                            </c:when>
                            <c:otherwise>
                              <p style="margin: 0; padding: 5px; border: 1px solid #ccc; background: #f9f9f9;">
                                ${at.originalName}
                              </p>
                            </c:otherwise>
                          </c:choose>
                          <span class="origin_attach_del delete-btn" data-fileno="${at.fileNo}">&#10005;</span>
                        </div>
                      </c:forEach>
                    </div>
                    <br>                        
                    <label for="select2Info" class="form-label">읽기권한</label>
                    <div class="select2-info">
                      <select id="select2Info" name="deptCode" class="select2 form-select" multiple>
                        <option value="T1" <c:if test="${fn:contains(n.deptCodes, 'T1')}">selected</c:if>>남성의류</option>
                        <option value="T2" <c:if test="${fn:contains(n.deptCodes, 'T2')}">selected</c:if>>여성의류</option>
                        <option value="T3" <c:if test="${fn:contains(n.deptCodes, 'T3')}">selected</c:if>>식품</option>
                        <option value="T4" <c:if test="${fn:contains(n.deptCodes, 'T4')}">selected</c:if>>스포츠</option>
                        <option value="T5" <c:if test="${fn:contains(n.deptCodes, 'T5')}">selected</c:if>>뷰티</option>
                        <option value="T6" <c:if test="${fn:contains(n.deptCodes, 'T6')}">selected</c:if>>명품</option>
                        <option value="T7" <c:if test="${fn:contains(n.deptCodes, 'T7')}">selected</c:if>>문화센터</option>
                        <option value="T8" <c:if test="${fn:contains(n.deptCodes, 'T8')}">selected</c:if>>디지털 및 가전</option>
                        <option value="S1" <c:if test="${fn:contains(n.deptCodes, 'S1')}">selected</c:if>>영업총괄</option>
                        <option value="S3" <c:if test="${fn:contains(n.deptCodes, 'S3')}">selected</c:if>>지원</option>
                      </select>
                    </div><br>
                    
                    <label class="d-block form-label">상단 고정</label>
                    <div>
                      <input type="radio" class="form-check-input" id="is_pinned_yes" name="isPinned" value="1" ${n.isPinned == 1 ? 'checked' : ''} required>
                      <label for="is_pinned_yes">Yes</label>
                      <input type="radio" class="form-check-input" id="is_pinned_no" name="isPinned" value="0" ${n.isPinned == 0 ? 'checked' : ''} style="margin-left: 10px;" required>
                      <label for="is_pinned_no">No</label>
                    </div><br><br>
                    
                    <div id="notice-editor"></div><br>
                    
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                      <button id="back" class="btn btn-secondary" type="button" onclick="location.href='${contextPath}/notice/noticeDetail.do?no=${n.noticeNo}'">취소</button>
                      <button id="registerButton" class="btn btn-primary" type="submit">수정</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        <div class="content-backdrop fade"></div>
      </div>
    </div>
    <div class="layout-overlay layout-menu-toggle"></div>
    <div class="drag-target"></div>
  </div>
</div>
<script>
    $(document).ready(function() {
        $('#select2Info').select2();
    });
</script>
<script src="${contextPath}/assets/js/scripts.js"></script>
</body>


<script>
$(document).ready(function() {
    const dataTransfer = new DataTransfer();
    const fileInput = document.getElementById('formFile');
    const fileContainer = document.getElementById('file-container');

    // 파일 입력 처리
    $('.file').on('change', function(evt) {
        const files = evt.target.files;
        let totalSize = 0;

        for (let i = 0; i < files.length; i++) {
            if (files[i].size > 10 * 1024 * 1024) { // 개별 파일 크기 10MB 제한
                alert('첨부파일의 최대 크기는 10MB입니다.');
                evt.target.value = ''; // 입력 초기화
                $('#file-container').empty(); // 파일 컨테이너 초기화
                return;
            }

            totalSize += files[i].size;

            if (totalSize > 100 * 1024 * 1024) { // 전체 파일 크기 100MB 제한
                alert('전체 첨부파일의 최대 크기는 100MB입니다.');
                evt.target.value = ''; // 입력 초기화
                $('#file-container').empty(); // 파일 컨테이너 초기화
                return;
            }

            dataTransfer.items.add(files[i]); // 파일 목록에 추가
        }

        renderFiles(dataTransfer.files); // 검증을 통과한 파일만 렌더링
        fileInput.files = dataTransfer.files; // 파일 입력 업데이트
    });

    function renderFiles(files) {
        fileContainer.innerHTML = ''; // 기존 내용을 초기화

        Array.from(files).forEach((file, index) => {
            const fileType = file.type;
            const validImageTypes = ['image/jpeg', 'image/png', 'image/gif'];

            const fileDiv = document.createElement('div');
            fileDiv.style.position = 'relative';
            fileDiv.style.display = 'inline-block';
            fileDiv.style.margin = '10px';
            fileDiv.setAttribute('data-index', index);

            if (validImageTypes.includes(fileType)) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.maxWidth = '120px';
                    img.style.height = 'auto';
                    img.style.maxHeight = '150px';
                    fileDiv.appendChild(img);
                };
                reader.readAsDataURL(file);
            } else {
                const p = document.createElement('p');
                p.textContent = file.name;
                p.style.margin = '0';
                p.style.padding = '5px';
                p.style.border = '1px solid #ccc';
                p.style.background = '#f9f9f9';
                fileDiv.appendChild(p);
            }

            const removeButton = document.createElement('button');
            removeButton.innerHTML = '&#10005;';
            removeButton.className = 'delete-btn';
            removeButton.onclick = function() {
                dataTransfer.items.remove(index); // 파일 목록에서 제거
                renderFiles(dataTransfer.files); // 업데이트된 파일 목록 재렌더링
                fileInput.files = dataTransfer.files; // 파일 입력 업데이트
            };

            fileDiv.appendChild(removeButton);
            fileContainer.appendChild(fileDiv);
        });
    }

    // Quill 에디터 초기화
    const quill = new Quill('#notice-editor', {
        theme: 'snow',
        placeholder: '내용을 입력해주세요.',
        modules: {
            toolbar: [
                [{ font: [] }, { size: [] }],
                ['bold', 'italic', 'underline', 'strike'],
                [{ color: [] }, { background: [] }],
                [{ script: 'super' }, { script: 'sub' }],
                [{ header: '1' }, { header: '2' }, 'blockquote', 'code-block'],
                [{ list: 'ordered' }, { list: 'bullet' }, { indent: '-1' }, { indent: '+1' }],
                [{ direction: 'rtl' }],
                ['link', 'image', 'video', 'formula'],
                ['clean']
            ]
        }
    });

    const noticeContentHidden = document.getElementById('noticeContent');
    noticeContentHidden.value = `${n.noticeContent}`;
    if (noticeContentHidden && noticeContentHidden.value) {
        quill.clipboard.dangerouslyPasteHTML(0, noticeContentHidden.value); // Quill에 HTML 내용 삽입
    }

    // 폼 제출 시 내용 동기화
    const form = document.getElementById('notice-form');
    form.addEventListener('submit', function(e) {
        noticeContentHidden.value = quill.root.innerHTML; // Quill의 내용을 숨겨진 input에 저장
        if (!noticeContentHidden.value || noticeContentHidden.value.trim() === '') {
            e.preventDefault();
            alert("내용을 입력해주세요.");
        }
    });

    fileInput.files = dataTransfer.files; // 초기 파일 목록 설정

    $(".origin_attach_del").on("click", function() {
        // 삭제할 첨부파일 번호를 submit 시 넘기기 위한 작업
        let hiddenEl = "<input type='hidden' name='delFileNo' value='" + $(this).data("fileno") + "'>";
        $("#notice-form").append(hiddenEl);
        // 화면으로부터 삭제된 것처럼 보여지게 해당 첨부파일 링크 삭제 처리
        $(this).parent().remove();
    });
});

//사이드바 처리
document.addEventListener("DOMContentLoaded", function () {
	
	const element = document.getElementById("boardNotice");
	
	document.getElementById("boardSide").classList.add("open");
	element.style.backgroundColor = "#958CF4";
	element.style.color = "white";
	element.classList.add("active");
	
	
});
</script>
<script src="${contextPath}/assets/vendor/libs/select2/select2.js"></script>
<script src="${contextPath}/assets/vendor/libs/bootstrap-select/bootstrap-select.js"></script>
<script src="${contextPath}/assets/js/forms-selects.js"></script>
</html>
