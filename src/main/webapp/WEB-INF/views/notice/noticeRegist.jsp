<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
							<form id="notice-form" action="${contextPath}/notice/noticeInsert.do" method="post" enctype="multipart/form-data">
							    <div class="card-body" style="align-items: center;">
							        <input type="hidden" name="deptCode" value="${loginUser.deptCode}" />
							        <input type="hidden" name="noticeContent" id="noticeContent">
							        <span style="font-size: 24px;">공지사항 작성</span><br><br>
							        
							        <label for="defaultFormControlInput" class="form-label">제목</label>
							        <input type="text" class="form-control" id="defaultFormControlInput" name="noticeTitle" placeholder="제목을 입력하세요." required><br>
							        
							        <label for="formFile" class="form-label">첨부파일<span id="fileText"> (첨부파일의 최대 크기는 10MB이며, 전체 첨부파일의 최대 크기는 100MB입니다. )</span></label>
							        <input class="form-control file" type="file" id="formFile" name="uploadFiles" multiple><br>
							        <div id="file-container"></div><br>
							        
											<label for="select2Info" class="form-label">읽기권한</label>
											<div class="select2-info">
											    <select id="select2Info" name="deptCode" class="select2 form-select" multiple>
											        <option value="T1" selected>남성의류</option>
											        <option value="T2" selected>여성의류</option>
											        <option value="T3" selected>식품</option>
											        <option value="T4" selected>스포츠</option>
											        <option value="T5" selected>뷰티</option>
											        <option value="T6" selected>명품</option>
											        <option value="T7" selected>문화센터</option>
											        <option value="T8" selected>디지털 및 가전</option>
											        <option value="S1" selected>영업총괄</option>
											        <option value="S3" selected>지원</option>
											    </select>
											</div><br>
							        
							        <label class="d-block form-label">상단 고정</label>
							        <div>
							            <input type="radio" class="form-check-input" id="is_pinned_yes" name="isPinned" value="1" required>
							            <label for="is_pinned_yes">Yes</label>
							            <input type="radio" class="form-check-input" id="is_pinned_no" name="isPinned" value="0" style="margin-left: 10px;" required checked>
							            <label for="is_pinned_no">No</label>
							        </div><br><br>
							        
							        <div id="notice-editor"></div><br>
							        
							        <div style="display: flex; justify-content: space-between; align-items: center;">
							            <button id="back" class="btn btn-secondary" type="button" onclick="window.history.back();">취소</button>
							            <button id="registerButton" class="btn btn-primary" type="submit">작성</button>
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
<script src="${contextPath}/assets/js/scripts.js"></script>
</body>
<script>

$(document).ready(function() {
    $('.file').on('change', function(evt) {
        const files = evt.target.files;
        let totalSize = 0;

        for (let i = 0; i < files.length; i++) {
            if (files[i].size > 10 * 1024 * 1024) {
                alert('첨부파일의 최대 크기는 10MB입니다.');
                evt.target.value = '';
                $('#file-container').empty();
                return;
            }

            totalSize += files[i].size;

            if (totalSize > 100 * 1024 * 1024) {
                alert('전체 첨부파일의 최대 크기는 100MB입니다.');
                evt.target.value = '';
                $('#file-container').empty();
                return;
            }
        }
    });

    const quill = new Quill('#notice-editor', {
        placeholder: '내용을 입력해주세요.',
        theme: 'snow',
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

    const form = document.getElementById('notice-form');
    const hiddenInput = document.getElementById('noticeContent');

    quill.on('text-change', function() {
        hiddenInput.value = quill.root.innerHTML;
    });

    form.addEventListener('submit', function(e) {
        hiddenInput.value = quill.root.innerHTML;

        if (!hiddenInput.value || hiddenInput.value.trim() === '') {
            e.preventDefault();
            alert("내용을 입력해주세요.");
        }
    });

    const fileInput = document.getElementById('formFile');
    const fileContainer = document.getElementById('file-container');
    let files = [];

    fileInput.addEventListener('change', function(event) {
        files = Array.from(event.target.files);
        renderFiles();
    });

    function renderFiles() {
        fileContainer.innerHTML = ''; // 기존 내용을 초기화

        files.forEach((file, index) => {
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
                files.splice(index, 1);
                renderFiles();
                fileInput.files = new FileListItem(...files);
            };

            fileDiv.appendChild(removeButton);
            fileContainer.appendChild(fileDiv);
        });
    }

    // Helper function to create a new FileList
    function FileListItem() {
        const b = new DataTransfer();
        files.forEach(file => b.items.add(file));
        return b.files;
    }
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
