/**
 * Treeview (jquery)
 */

'use strict';


function jstreeRendering(jstreeView, theme, nodeData){
	jstreeView.jstree({
      core: {
        themes: {
          name: theme,
        },
        //check_callback: true,
		check_callback: function (op, node, par, pos, more) { // 노드 이동,추가,삭제 동작이 발생할때 허용할지 ,차단할 수 있는 함수
							if (op === "move_node") {
								return false;
							}
							return true;
						},
        data: nodeData 
		
      },
	  
      plugins: ['types', 'dnd'],
      types: {
        default: {
          icon: 'ti ti-folder'
        },
        html: {
          icon: 'ti ti-brand-html5 text-danger'
        },
        css: {
          icon: 'ti ti-brand-css3 text-info'
        },
        img: {
          icon: 'ti ti-photo text-success'
        },
        js: {
          icon: 'ti ti-brand-javascript text-warning'
        }
      },

    });
}


$(function () {
  var theme = $('html').hasClass('light-style') ? 'default' : 'default-dark', // 화이트모드 ,다크모드
  dragDrop = $('#jstree-drag-drop'),
  dragDrop2 = $('#jstree-drag-drop2');
  
  
  $.ajax({
	url: '/cruella/app/jstreeList.do',
	async: false,
	success:function(list){
		
		console.log(list);
		
		let nodeData = [];
		
		for(let i=0; i<list.length; i++){ // 부서 순차접근을 위한 for문
			
			let deptObj = {
				text: list[i].deptName,
				state: {
	              opened: false
	            },
				children:[]
			};
			
			let memList = list[i].memList;
			
			for(let j=0; j<memList.length; j++){ // 해당 부서 내의 사원들 순차접근을 위한 for문
				let memObj = {
					text: memList[j].memName + " " + memList[j].posName,
				    memName: memList[j].memName,
					memNo: memList[j].memNo,
					posCode: memList[j].posCode,
					teamName: list[i].deptName,
					icon: 'ti ti-user'
				};
				
				deptObj.children.push(memObj);
			}
			
			nodeData.push(deptObj);
			
		}
		
		jstreeRendering(dragDrop, theme,nodeData ); // 참조선 jstree 렌더링
		jstreeRendering(dragDrop2, theme,nodeData);// 결재선 jstree 렌더링
		
		
	}
	
  })
  
 
  
  
  


  // 참조선
  // Drag Drop
  // --------------------------------------------------------------------
  if (dragDrop.length) {
	
	


    let count = 0; // 드래그 카운트
	let refIndex = 0; // 참조 index count
	
    
    $(document).on('dnd_stop.vakata.dragDrop', function (e, data) {
		
		
     
      var dropDiv = $(data.event.target); // drop된 위치의 요소 => 여기에 노드 정보를 append 시키면됨
      console.log(dropDiv);
      //t.text("떨궈짐");


      var node = data.data.origin.get_node(data.element); // {..., original:{text:xx, memNo:xx}, ..}

      if (dropDiv.closest('tbody').hasClass('aa2')) { // closest : 드래그 시 가장 가까운 태그 찾음

        console.log(dropDiv.closest('tbody'));


        // 중복 검사 (input value에서 memNo를 비교)
        var memNo = node.original.memNo;
        var isDuplicate = dropDiv.closest('tbody').find('tr').toArray().some(function (row) {
          var existingMemNo = $(row).find('input[type="hidden"]').val(); // hidden input에서 memNo 가져오기
          return existingMemNo == memNo;
        });

        if (isDuplicate) {
          alert('이미 추가된 사용자입니다.');
          return; // 중복되면 추가하지 않음
        }
		
		if (count >= 3) {
		    alert('더이상 추가할 수 없습니다');
		   return; // 3개 이상일 경우 함수 종료
		 }


        if (count == 0) {

          dropDiv.closest("tbody").html(

            '<tr style="height: 50px; border: 1px solid;">'
            + '<input type="hidden" value="' + node.original.memNo + '"/>'
            + '<td style="width: 52px;"></td>'
            + '<td style="width: 138px;">기안서</td>'
            + '<td style="width: 150px;">' + node.original.memName + '</td>'
            + '<td style="width: 150px;">' + node.original.teamName + '</td>'
            + '<td style="padding-left: 42px;">참조</td>'
            + '<td style="width: 118px;"><i class="ti ti-trash"></i></td>'
            + '</tr>'

          );

        } else if (count > 0) {
          dropDiv.closest("tbody").append(


            '<tr style="height: 50px; border: 1px solid;">'
            + '<input type="hidden" value="' + node.original.memNo + '"/>'
            + '<td style="width: 52px;"></td>'
            + '<td style="width: 138px;">기안서</td>'
            + '<td style="width: 150px;">' + node.original.memName + '</td>'
            + '<td style="width: 150px;">' + node.original.teamName + '</td>'
            + '<td style="padding-left: 42px;">참조</td>'
            + '<td style="width: 118px;"><i class="ti ti-trash"></i></td>'
            + '</tr>'


          );


        }

        count++;
      }


      console.log(count);



    });


    
       // >> 버튼 클릭 시 선택된 노드 추가
       $('#move_button').on('click', function () {
        // 선택된 jstree 노드 가져오기
        var selectedNode = dragDrop.jstree('get_selected', true);
  
        // 선택된 노드가 있을 경우
        if (selectedNode.length > 0) {
          selectedNode.forEach(function (node) {
            // 중복 검사 (input value에서 memNo를 비교)
            var memNo = node.original.memNo;
            var isDuplicate = $('#drag_line_div2').find('tr').toArray().some(function (row) {
              var existingMemNo = $(row).find('input[type="hidden"]').val(); // hidden input에서 memNo 가져오기
              return existingMemNo == memNo;
            });
  
            if (isDuplicate) {
              alert('이미 추가된 사용자입니다.');
              return; // 중복되면 추가하지 않음
            }
			
			if (count >= 3) {
			alert('더이상 추가할 수 없습니다');
			 return; // 3개 이상일 경우 함수 종료
			 }
  
            // 첫 번째 항목일 때 테이블 초기화
            if (count === 0) {
              $('#drag_line_div2').html(
                '<tr style="height: 50px; border: 1px solid;">'
                + '<input type="hidden" value="' + node.original.memNo + '"/>'
                + '<td style="width: 52px;"></td>'
                + '<td style="width: 138px;">기안서</td>'
                + '<td style="width: 150px;">' + node.original.memName + '</td>'
                + '<td style="width: 150px;">' + node.original.teamName + '</td>'
                + '<td style="padding-left: 42px;">참조</td>'
                + '<td style="width: 118px;"><i class="ti ti-trash"></i></td>'
                + '</tr>'
              );
            } else {
              // 두 번째 이후 항목은 추가
              $('#drag_line_div2').append(
                '<tr style="height: 50px; border: 1px solid;">'
                + '<input type="hidden" value="' + node.original.memNo + '"/>'
                + '<td style="width: 52px;"></td>'
                + '<td style="width: 138px;">기안서</td>'
                + '<td style="width: 150px;">' + node.original.memName + '</td>'
                + '<td style="width: 150px;">' + node.original.teamName + '</td>'
                + '<td style="padding-left: 42px;">참조</td>'
                + '<td style="width: 118px;"><i class="ti ti-trash"></i></td>'
                + '</tr>'
              );
            }
  
            count++; // 카운트 증가
          });
        }
      });

    // 삭제
    $(document).on('click', '.aa2 .ti-trash', function () {
      var tr = $(this).closest('tr'); // 현재 클릭한 아이콘이 속한 tr 요소를 찾음
      tr.remove(); // 해당 tr 요소 삭제
      count--; // 삭제 후 카운트 감소 
      console.log(count);

      if (count === 0) {
        var emptyRow = '<tr style="height: 50px;" class="noref">'
                     + '<td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>'
                     + '</tr>';
        $('.aa2').append(emptyRow); 
      }


      
    });



  }

  dragDrop.bind("move_node.jstree", function (e, d) {
    console.log(e); //event
    console.log(d); //node


   

  });
	

	
	
	















  // 결재선 조직도
  // Drag Drop
  // --------------------------------------------------------------------
  
  
  if (dragDrop2.length) {
    


    let countDnd = 0; // 추가된 데이터를 세기 위한 변수
    let orderCount = 0; // 결재선 순서를 세기 위한 변수??
    
    $(document).on('dnd_stop.vakata.dragDrop2', function (e, data) {
		
		
		
		console.log('dnd_stop 작동됨');
		
      var dropDiv = $(data.event.target); // drop된 위치의 요소 => 여기에 노드 정보를 append 시키면됨
	  
		console.log(dropDiv);

      var node = data.data.origin.get_node(data.element); // {..., original:{text:xx, memNo:xx}, ..}
	  
	  
	  
	  console.log("드랍된 위치", dropDiv);
	  
	  
	// jstree 내에 드롭 막기
	  if(dropDiv.hasClass('jstree-node') 
		|| dropDiv.hasClass('jstree-anchor') 
		|| dropDiv.hasClass('jstree-default') ){
		  
          alert('이 영역에는 드롭할 수 없습니다.'); 
          return false; 
	  }
		  
		  
		  
		  
		  

      if (dropDiv.closest('tbody').hasClass('aa')) { // closest : 드래그 시 가장 가까운 태그 찾음

        // 중복 검사 (input value에서 memNo를 비교)
        var memNo = node.original.memNo;
		console.log('현재 옮겨지는 노드의 memNo', memNo);
		
		
		
        var isDuplicate = dropDiv.closest('tbody').find('tr').toArray().some(function (row) {
          var existingMemNo = $(row).find('input[type="hidden"]').val(); // hidden input에서 memNo 가져오기
		  console.log('현재 결재선에 등록된 memNo', existingMemNo);
          return existingMemNo == memNo;
        });
		
		
		// 결재선에 등록된 직급들
		var posCodeOrder = dropDiv.closest('tbody').find('tr').toArray().map(function (row) {
		   return $(row).find('input[name="posCode"]').val(); // 직급을 배열로 가져오기
		});

		    console.log('등록된 직급들:', posCodeOrder);

		    // 현재 추가하려는 직급
		    var newPosCode = node.original.posCode;
		
		
		  // 직급 점장이 등록되어 있으면 아래 직급들은 추가할 수 없음
		   if (posCodeOrder.includes('C1')) {
				if (newPosCode !== 'C1') {
				    alert('직급순서에 맞게 먼저 지정해주세요');
				    return; 
				}
		   }

		   // 직급 부점장이 등록되어 있으면 점장만 추가할 수 있음
		   if (posCodeOrder.includes('C2')) {
		       if (newPosCode !== 'C1' && newPosCode !== 'C2' ) {
		           alert('직급순서에 맞게 먼저 지정해주세요');
		           return; 
		       }
		   }

		   // 직급 부장이 등록되어 있으면 점장과 부점장만 추가할 수 있음
		   if (posCodeOrder.includes('C3')) {
		       if (newPosCode !== 'C1' && newPosCode !== 'C2' && newPosCode !== 'C3') {
		           alert('직급순서에 맞게 먼저 지정해주세요');
		           return;
		       }
		   }

		   // 직급 팀장이 등록되어 있으면 팀장 윗 직급들만 추가할 수 있음
		   if (posCodeOrder.includes('C4')) {
				if (newPosCode !== 'C1' && newPosCode !== 'C2' && newPosCode !== 'C3'&& newPosCode !== 'C4') {
					alert('직급순서에 맞게 먼저 지정해주세요');
					return; 
				}
		   }
		   
		   
		   // 직급 대리부턴 결재권한이 없음
		    var restrictedPosCodes = ['C5', 'C6', 'C7']; 
		       if (restrictedPosCodes.includes(newPosCode)) {
		           alert('결재권한이 없습니다');
		           return; 
		       }
		   
		   
		   
		
        if (isDuplicate) {
          alert('이미 추가된 사용자입니다.');
          return; // 중복되면 추가하지 않음
        }


        if (countDnd >= 3) {
          alert('더이상 추가할 수 없습니다');
          return; // 3개 이상일 경우 추가 못함
        }
		
		
		// 드롭시 첫 번째 항목일 때 기존 데이터에 덮어씌우기
        if (countDnd == 0) {

          dropDiv.closest("tbody").html(
            '<tr style="height: 50px; border: 1px solid;">'
            + '<td style="width: 138px;">결재서</td>'
            + '<td style="width: 150px;">' + node.original.memName
            + '<input type="hidden" value=' + node.original.memNo + '>'
			+ '<input type="hidden" name="posCode" value=' + node.original.posCode + '></td>'
            + '<td style="width: 150px;">' + node.original.teamName + '</td>'
            + '<td style="padding-left: 70px;">결재</td>'
            + '<td style="width: 153px; padding-left: 33px;"><i class="ti ti-trash"></i></td>'
            // + '<input type="hidden" value="' +  orderCount++ + '>'
            + '</tr>'
          );

          
		  // 드롭시 두 번째 항목일 때 연달아 추가
        } else if (countDnd > 0) {
          dropDiv.closest("tbody").append(
            '<tr style="height: 50px; border: 1px solid;">'
            + '<td style="width: 138px;">결재서</td>'
            + '<td style="width: 150px;">' + node.original.memName
            + '<input type="hidden" value=' + node.original.memNo + '>'
			+ '<input type="hidden" name="posCode" value=' + node.original.posCode + '></td>'
            + '<td style="width: 150px;">' + node.original.teamName + '</td>'
            + '<td style="padding-left: 70px;">결재</td>'
            + '<td style="width: 153px; padding-left: 33px;"><i class="ti ti-trash"></i></td>'
            // + '<input type="hidden" value="' +  orderCount++ + '>'
            + '</tr>'
          );
	

        }

        countDnd++;

      }


    });
	
	
	
	
     //   '>>' 버튼 클릭 시 선택된 노드 추가
     $('#move_button2').on('click', function () {
		
		
		
		
		
		
      // 선택된 jstree 노드 가져오기
      var selectedNode = dragDrop2.jstree('get_selected', true);

      // 선택된 노드가 있을 경우
      if (selectedNode.length > 0) {
        selectedNode.forEach(function (node) {
          // 중복 검사 (input value에서 memNo를 비교)
          var memNo = node.original.memNo;
		  
		  
          var isDuplicate = $('#drag_line_div').find('tr').toArray().some(function (row) { // 배열형태로 요소 찾기
            var existingMemNo = $(row).find('input[type="hidden"]').val(); // hidden input에서 memNo 가져오기
            return existingMemNo == memNo;
          });
		  

			// 직급 조건 체크 (직급에 맞는지 검사)
			var posCodeOrder = $('#drag_line_div').find('tr').toArray().map(function(row) { // 배열형태로 새로 생성
				return $(row).find('input[name="posCode"]').val(); // 직급을 배열로 가져오기
			});
			
			

			/*console.log('등록된 직급들:', posCodeOrder);*/

			// 현재 추가하려는 직급
			var newPosCode = node.original.posCode;
			
			
			
			
			

			// 직급 점장이 등록되어 있으면 아래 직급들은 추가할 수 없음
			if (posCodeOrder.includes('C1')) {
				alert('직급순서에 맞게 먼저 지정해주세요');
				return;
			}

			// 직급 부점장이 등록되어 있으면 점장만 추가할 수 있음
			if (posCodeOrder.includes('C2')) {
				if (newPosCode !== 'C1') {
					alert('직급순서에 맞게 먼저 지정해주세요');
					return;
				}
			}

			// 직급 부장이 등록되어 있으면 점장과 부점장만 추가할 수 있음
			if (posCodeOrder.includes('C3')) {
				if (newPosCode !== 'C1' && newPosCode !== 'C2') {
					alert('직급순서에 맞게 먼저 지정해주세요');
					return;
				}
			}

			// 직급 팀장이 등록되어 있으면 팀장 윗 직급들만 추가할 수 있음
			if (posCodeOrder.includes('C4')) {
				if (newPosCode !== 'C1' && newPosCode !== 'C2' && newPosCode !== 'C3') {
					alert('직급순서에 맞게 먼저 지정해주세요');
					return;
				}
			}


			// 직급 대리부턴 결재권한이 없음
			var restrictedPosCodes = ['C5', 'C6', 'C7'];
			if (restrictedPosCodes.includes(newPosCode)) {
				alert('결재권한이 없습니다');
				return;
			}
			
			
		  
		  

          if (isDuplicate) {
            alert('이미 추가된 사용자입니다.');
            return; // 중복되면 추가하지 않음
          }

          if (countDnd >= 3) {
            alert('더이상 추가할 수 없습니다');
            return; // 3개 이상일 경우 함수 종료
          }
  

          // 클릭시 첫 번째 항목일 때 기존 데이터에 덮어씌우기
          if (countDnd === 0) {
            $('#drag_line_div').html(
              '<tr style="height: 50px; border: 1px solid;">'
              + '<td style="width: 138px;">결재서</td>'
              + '<td style="width: 150px;">' + node.original.memName
              + '<input type="hidden" value=' + node.original.memNo + '>'
			  + '<input type="hidden" name="posCode" value=' + node.original.posCode + '></td>'
              + '<td style="width: 150px;">' + node.original.teamName + '</td>'
              + '<td style="padding-left: 70px;">결재</td>'
              + '<td style="width: 153px; padding-left: 33px;"><i class="ti ti-trash"></i></td>'
              + '</tr>'
            );
			
          } else {
            // 두 번째 이후 항목은 연달아 추가
            $('#drag_line_div').append(
              '<tr style="height: 50px; border: 1px solid;">'
            + '<td style="width: 138px;">결재서</td>'
            + '<td style="width: 150px;" class="mem_name">' + node.original.memName
            + '<input type="hidden" value=' + node.original.memNo + '>'
			+ '<input type="hidden" name="posCode"  value=' + node.original.posCode + '></td>'
            + '<td style="width: 150px;">' + node.original.teamName + '</td>'
            + '<td style="padding-left: 70px;">결재</td>'
            + '<td style="width: 153px; padding-left: 33px;"><i class="ti ti-trash"></i></td>'
            + '</tr>'
            );
          }

          countDnd++; // 카운트 증가
        });
      }
    });





    // 삭제
    $(document).on('click', '.aa .ti-trash', function () {
      var tr = $(this).closest('tr'); // 현재 클릭한 아이콘이 속한 tr 요소를 찾음
      tr.remove(); // 해당 tr 요소 삭제
      countDnd--; // 삭제 후 카운트 감소 
      console.log(countDnd);

      if (countDnd === 0) {
        var emptyRow = '<tr style="height: 50px;">'
                     + '<td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>'
                     + '</tr>';
        $('.aa').append(emptyRow); // tbody에 추가
      }


      
    });



  }

  dragDrop2.bind("move_node.jstree", function (e, d) {
    //console.log(e); //event
    //console.log(d); //node
	
	
    



  });




  // --------------------------------------------------------------------------------------

    // 취소버튼
  $(document).on('click', '#app_close_btn', function() {
    // 드래그하여 추가된 데이터 초기화
    $('.aa2').html('<tr style="height: 50px;">'
                   + '<td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>'
                   + '</tr>');
  
    // 클릭하여 추가된 데이터 초기화
    $('.aa').html('<tr style="height: 50px;">'
                  + '<td><span style="color: #aea9a9;">드래그하여 추가할 수 있습니다.</span></td>'
                  + '</tr>');
  
    // 카운트 리셋 
    count = 0;  
    countDnd = 0;  
  });



//--------------------------------------------------------------------------------------------------






// 결재정보 확인버튼 클릭시
  // ----------------------------------------------------------------------------------------------

  $(document).on('click','#app_success_btn', function(){


     
     var countLevel = 1; // 순서지정
	 
	 //var idcount = 0; // 아이디 카운트
	 var rovalIndex = 0;
	 
	 

	 $('.app_line_div').html('');

	 // #drag_line_div의 각 tr에 대해 데이터를 가져와서 append
	 $('#drag_line_div tr').each(function() {
	     // 각 row에서 필요한 데이터 가져오기
	     var memNo = $(this).find('input[type="hidden"]').val();
	     var memName = $(this).find('td').eq(1).text().trim(); // 두 번째 td (memName)
	     var teamName = $(this).find('td').eq(2).text().trim(); // 세 번째 td (teamName)

	     // 결재선 추가할 div 
	     var div = '<span class="line_user">'
	                 + '<span>' + teamName + '</span>'
	                 + '<span class="signLine">서명</span>'
	                 + '<span class="app_line_date">' + memName + '</span>'
	                 + '<input type="hidden" value="' + memNo + '" name="rovalList[' + rovalIndex + '].rvNo">'
	                 + '<input type="hidden" name="rovalList[' + rovalIndex++ + '].appLevel" value="' + countLevel++ + '">'
	             + '</span>';

	     // 각 div를 계속해서 append
	     $('.app_line_div').append(div);
		 
		 
		 if($('#drag_line_div tr').text() == '드래그하여 추가할 수 있습니다.'){
			
			$('.app_line_div').html(
			      '<span class="line_title"><b>결재선</b></span>'
			      +'<span class="line_user">'
			       + '<span>부서명</span>'
			        +'<span class="signLine">서명</span>'
			        +'<span class="sign_date">이름</span>'
			      +'</span>'
			    );
		 }
		 
	 });
	
	 
	 
	 
	 
	 
	 
	
	// 참조
	var refIndex = 0;
	
	$('#drag_line_div2 tr').not(".noref").each(function(){
		
		
		var refNo = $(this).find('input[type="hidden"]').val();
		
		var div2 = '<input type="hidden" value="' + refNo + '" name="refList[' + refIndex++ + '].refNo">'
		
				               
		/*$('#ref_list_div').append(div2);*/
		
		if($('#drag_line_div2 tr').length > 1){
		       $('#ref_list_div').append(div2);
			
		 }else if($('#drag_line_div2 tr').length == 1){
			$('#ref_list_div').html(div2);
			
		 }
		
		
	});
	
	
	
  
  });
  
  
  
	
	
	
	






});







