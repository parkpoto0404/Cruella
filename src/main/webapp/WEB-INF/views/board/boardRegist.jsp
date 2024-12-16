<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html
  lang="en"
  class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="${contextPath}/assets/"
  data-template="views"
  data-style="light">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${contextPath}/resources/assets/js/config.js"></script>
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
	#boardTeam::before {
	  content: ''; /* 가상 요소 필수 */
	  display: inline-block; /* 블록 요소 */
	  width: 10px; /* 동그라미 크기 */
	  height: 10px; /* 동그라미 크기 */
	  border-radius: 50%; /* 완전한 원 */
	  background-color: transparent; /* 배경을 투명으로 설정 */
	  border: 2px solid gray; /* 초기 테두리 색상 */
	}
	#boardTeam.active::before {
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
         <!-- nav 끝 -->
         
         <div class="content-wrapper">
            <!-- 세션 시작 -->
            <div class="container-xxl flex-grow-1 container-p-y">
               <!-- 이쪽에 세션정보 넣어야합니다 ----------------------------------------------------------------------- -->
               
               <!-- Content wrapper -->
               <div class="content-wrapper">
							   <div class="container-xxl flex-grow-1 container-p-y">
							     <div class="container card" style="padding: 50px;">
							       <form id="board-form" action="${contextPath}/board/boardInsert.do" method="post" enctype="multipart/form-data">
							         <div class="card-body" style="align-items: center;">
							           <div>
							             <input type="hidden" name="deptCode" value="${loginUser.deptCode}" />
							             <input type="hidden" name="boardContent" id="boardContent">
							             <span style="font-size: 24px;">팀게시판 작성</span><br><br><br>
							             <label for="defaultFormControlInput" class="form-label">제목</label>
							             <input type="text" class="form-control" id="defaultFormControlInput" name="boardTitle" placeholder="제목을 입력하세요." required />
							             <br>
							             <label for="formFile" class="form-label">첨부파일<span id="fileText"> (첨부파일의 최대 크기는 10MB이며, 전체 첨부파일의 최대 크기는 100MB입니다. )</span></label>
							             <input class="form-control file" type="file" id="formFile" name="uploadFiles" multiple />
							             <br>
							             <div id="file-container"></div>
							             <br> 
							             <div id="board-editor"></div>
							             <br>
							             <div style="display: flex; justify-content: space-between; align-items: center;">
							               <button id="back" class="btn btn-secondary" type="button" onclick="window.history.back();">취소</button>
							               <button id="registerButton" class="btn btn-primary" type="submit">작성</button>
							             </div>
							           </div>
							         </div>
							       </form>
							     </div>
							   </div>
							 </div>


               <script>
               $(document).ready(function() {
            	    $('.file').on('change', function(evt) {
            	        const files = evt.target.files; // FileList[0: File, 1: File, ..]
            	        let totalSize = 0;

            	        for (let i = 0; i < files.length; i++) {
            	            if (files[i].size > 10 * 1024 * 1024) {
            	                alert('첨부파일의 최대 크기는 10MB입니다.');
            	                evt.target.value = '';
            	                $('#file-container').empty(); // 파일 컨테이너 초기화
            	                return;
            	            }

            	            totalSize += files[i].size;

            	            if (totalSize > 100 * 1024 * 1024) {
            	                alert('전체 첨부파일의 최대 크기는 100MB입니다.');
            	                evt.target.value = '';
            	                $('#file-container').empty(); // 파일 컨테이너 초기화
            	                return;
            	            }
            	        }
            	    });
            	});

            	document.addEventListener('DOMContentLoaded', function() {
            	    // Quill 에디터 초기화
            	    const quill = new Quill('#board-editor', {
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

            	    // 폼 제출 시 내용 동기화
            	    const form = document.getElementById('board-form');
            	    const hiddenInput = document.getElementById('boardContent');

            	    // Quill 에디터 변경 시 내용 동기화
            	    quill.on('text-change', function() {
            	        hiddenInput.value = quill.root.innerHTML;
            	    });

            	    // 폼 제출 시 최종 확인
            	    form.addEventListener('submit', function(e) {
            	        hiddenInput.value = quill.root.innerHTML;

            	        console.log("Quill Content:", quill.root.innerHTML);
            	        console.log("Hidden Input Value:", hiddenInput.value);

            	        if (!hiddenInput.value || hiddenInput.value.trim() === '') {
            	            e.preventDefault();
            	            alert("내용을 입력해주세요.");
            	        }
            	    });
            	});

            	document.addEventListener('DOMContentLoaded', function() {
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

            	function removeFile() {
            	    document.getElementById('formFile').value = '';
            	    document.getElementById('file-container').innerHTML = '';
            	}

            	//사이드바 처리
            	document.addEventListener("DOMContentLoaded", function () {
            		
            		const element = document.getElementById("boardTeam");
            		
            		document.getElementById("boardSide").classList.add("open");
            		element.style.backgroundColor = "#958CF4";
            		element.style.color = "white";
            		element.classList.add("active");
            		
            		
            	});

               </script>
            </div>
            <!-- 세션 끝 -->
            
            <!-- 푸터 시작 -->
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
            <!-- 푸터 끝 -->
            
            <div class="content-backdrop fade"></div>
         </div>
      </div>
      
      <div class="layout-overlay layout-menu-toggle"></div>
      <div class="drag-target"></div>
      
   </div>
</div>
</body>
</html>
