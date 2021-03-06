$( document ).ready(function() {
	/* 파일 추가  */
	/*$('#devInfoAdminInsrtAddFile, #devInfoAdminDtlAddFile').on('click',function(e){
		var fileNum = $(this).parents('.form-upload').find('.devInfoAdminFormG').length+1;
		if(fileNum > 0){
			$('#devInfoAdminInsrtDelFile, #devInfoAdminDtlDelFile').css({'display':'inline-block'});
			$('.file_author').css({'display':'block'});
		}
		var uploadHtml;
		if($(this).id == "devInfoAdminInsrtAddFile"){
			uploadHtml = getInsrtHtml(fileNum);
		}else{
			uploadHtml = getDtlHtml(fileNum);
		}
//		<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
		$(this).parents('.form-upload').append(uploadHtml);
	});
	
	 파일 삭제 
	$('#devInfoAdminInsrtDelFile, #devInfoAdminDtlDelFile').on('click',function(){
		console.log('click');
		var fileNum = $(this).parents('.form-upload').find('.devInfoAdminFormG').length-1;
		if(fileNum == 0 ){
			$(this).css({'display':'none'});
			$('.file_author').css({'display':'none'});
		}
		console.log('fileNum : '+fileNum);
		$(this).parents('.form-upload').find('.devInfoAdminFileFormG').last().remove();
		$(this).parents('.form-upload').find('.devInfoAdminFileAuth').last().remove();
	});*/
	
	/* 첨부파일 삭제*/
	$(document).on('click','.file_del_btn',function(){
		var check1 = $(this).parent().prev('.form-group__upload').find('.form-control').val(null);
		$(this).parent().prev('.form-group__upload').find('.form-control').val(null);
	})
	
	/* 업로드 버튼 클릭*/
	
	
	/* 파일명 바꾸기 */
	//$('#devInfoAdminInsrtForm, #devInfoAdminDtlForm, #devPrtnInsrtForm, #devPrtnDtlForm').on('change','.form-upload__file--hidden',function(){
	$(document).on('change','.form-upload__file--hidden',function(){
		//debugger;
		if(window.FileReader){
			var file = $(this)[0].files[0];
			if(file == undefined || file == null){
				var filename="";
			}else{
				var filename = $(this)[0].files[0].name;								
			}
        } else {
            var filename = $(this).val().split('/').pop().split('\\').pop();
        }

        $(this).siblings('.form-control').val(filename);
        //사업자등록증
        if($(this).hasClass("bizFile")){
        	$(this).siblings('.form-control').removeClass("bizFile");
        	$(this).parent('a').attr("href", "#");
        	$(this).siblings('.form-control').attr("style","");
        }
	});
	
	
	
	/* 파일 수정 */
	$(document).on('click','.file_edit_btn',function(){
		var fileNum = $(this).attr("id");
		console.log('fileNum : '+fileNum);
		$(this).parent().prevAll('p').css({'display':'none'});
		$(this).next('.file_del_btn').css({'display':'none'});
		var html = '';
		html += '<div class="file-group-upload">                                                              ';
		html += '<input type="text" readonly="readonly" class="form-control disabled">                        ';
		html += '<input type="file" id="'+fileNum+'" name="'+fileNum+'" class="form-upload__file--hidden">        ';
		html += '</div>                                                                                       ';
		html += '<div class="form-input__addon">                                                              ';
		html += '<label for="'+fileNum+'" class="btn btn-sm btn-primary" data-button="upload">파일선택</label>';
		html += '<button type="button" class="cancel_btn">취소</button>                                       ';
		html += '</div>                                                                                       ';
		
		$(this).parent().parent().append(html);
		$(this).remove();
	});
	
	/* 파일 수정 취소*/
	$(document).on('click','.cancel_btn',function(){
		debugger;
		var test = $(this).parent().parent().prevAll('p');
		$(this).parent().prevAll('p').css({'display':'block'});
		$(this).parent().prev('.file-button').find('.file_del_btn').css({'display':'block'});
		$(this).parent().prev('.file-button').prepend('<button type="button" class="file_edit_btn">파일수정</button>');
		$('.file-group-upload').remove();
	});
		
});
function addFileUploadInput(id){
	var fileNum = $('#'+id).parents('.form-upload').find('.devInfoAdminFormG').length+1;
	if(fileNum > 0){
		$('#devInfoAdminInsrtDelFile, #devInfoAdminDtlDelFile').css({'display':'inline-block'});
		$('.file_author').css({'display':'block'});
	}
	var uploadHtml;
	if(id == "devInfoAdminInsrtAddFile"){
		uploadHtml = getInsrtHtml(fileNum);
	}else{
		uploadHtml = getDtlHtml(fileNum);
	}
//	<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
	$('#'+id).parents('.form-upload').append(uploadHtml);
}
function removeFileUploadInput(id){
	console.log('click');
	var fileNum = $('#'+id).parents('.form-upload').find('.devInfoAdminFormG').length-1;
	if(fileNum == 0 ){
		$('#'+id).css({'display':'none'});
		$('.file_author').css({'display':'none'});
	}
	console.log('fileNum : '+fileNum);
	$('#'+id).parents('.form-upload').find('.devInfoAdminFileFormG').last().remove();
	$('#'+id).parents('.form-upload').find('.devInfoAdminFileAuth').last().remove();
}

function initDtlHtml(){
	var uploadHtml = '';
	uploadHtml += '<div class="file-form-group devInfoAdminFileFormG">                                                                                            ';
	uploadHtml += '<div class="form-group__upload devInfoAdminFormG">                                                                                             ';
	uploadHtml += '		<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                                                   ';
	uploadHtml += '		<input type="file" name="atchFile_1" id="DtlAtchFile_1" class="form-upload__file--hidden">                                                ';
	uploadHtml += '	</div>                                                                                                                                        ';
	uploadHtml += '	<div class="form-input__addon">                                                                                                               ';
	uploadHtml += '        <label for="DtlAtchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>                                  ';
	uploadHtml += '        <button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                                                   ';
	uploadHtml += '	</div>                                                                                                                                        ';
	uploadHtml += '</div>                                                                                                                                         ';
	uploadHtml += '<div class="form-group file_author devInfoAdminFileAuth">                                                                                      ';
	uploadHtml += '   <input name="fileAuthor" type="hidden" value="CM00200010"/>                                                                                 ';
	uploadHtml += '</div>                                                                                                                                         ';
	uploadHtml += '<div class="file-button">                                                                                                                      ';
	uploadHtml += ' 	<button type="button" id="devInfoAdminDtlAddFile" onclick="addFileUploadInput(\'devInfoAdminDtlAddFile\');" class="bgNone">추가</button>    ';
	uploadHtml += '	<button type="button" id="devInfoAdminDtlDelFile" onclick="removeFileUploadInput(\'devInfoAdminDtlDelFile\');" class="bgNone">삭제</button>     ';
	uploadHtml += '</div>																																			';
	return uploadHtml;
}
function initInsrtHtml(){
	var uploadHtml = '';
	uploadHtml += '<div class="file-form-group devInfoAdminFileFormG">                                                                                               ';
	uploadHtml += '	<div class="form-group__upload devInfoAdminFormG">                                                                                               ';
	uploadHtml += '		<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                                                      ';
	uploadHtml += '		<input type="file" name="atchFile_1" id="InsrtAtchFile_1" class="form-upload__file--hidden">                                                 ';
	uploadHtml += '	</div>                                                                                                                                           ';
	uploadHtml += '	<div class="form-input__addon">                                                                                                                  ';
	uploadHtml += '		<label for="InsrtAtchFile_1" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>                                      ';
	uploadHtml += '		<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                                                         ';
	uploadHtml += '	</div>                                                                                                                                           ';
	uploadHtml += '</div>                                                                                                                                            ';
	uploadHtml += '<div class="form-group file_author devInfoAdminFileAuth">                                                                                         ';
	uploadHtml += '   <input name="fileAuthor" type="hidden" value="CM00200010"/>                                                                                    ';
	uploadHtml += '</div>                                                                                                                                            ';
	uploadHtml += '<div class="file-button">                                                                                                                         ';
	uploadHtml += '	<button type="button" id="devInfoAdminInsrtAddFile" onclick="addFileUploadInput(\'devInfoAdminInsrtAddFile\');" class="bgNone ">추가</button>              ';
	uploadHtml += '	<button type="button" id="devInfoAdminInsrtDelFile" onclick="removeFileUploadInput(\'devInfoAdminInsrtDelFile\');" class="bgNone ">삭제</button>         ';
	uploadHtml += '</div>                                                                                                                                           ';
	return uploadHtml;
}
function getDtlHtml(fileNum){
	var uploadHtml = '';
		uploadHtml += '<div class="file-form-group devInfoAdminFileFormG">                                                               ';
		uploadHtml += '<div class="form-group__upload devInfoAdminFormG">                                                                ';
		uploadHtml += '	<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                          ';
		uploadHtml += '	<input type="file" name="atchFile_'+fileNum+'" id="DtlAtchFile_'+fileNum+'" class="form-upload__file--hidden">   ';
		uploadHtml += '</div>                                                                                                            ';
		uploadHtml += '<div class="form-input__addon">                                                                                   ';
		uploadHtml += '	<label for="DtlAtchFile_'+fileNum+'" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>  ';
		uploadHtml += '	<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                             ';
		uploadHtml += '</div>                                                                                                            ';
		uploadHtml += '</div>                                                                                                            ';
		uploadHtml += '	<div class="form-group file_author devInfoAdminFileAuth">                                                        ';
		uploadHtml += '	<input name="fileAuthor" type="hidden" value="CM00200010"/>                                                      ';
		uploadHtml += '</div>                                                                                                            ';
		
	return uploadHtml;
}
function getInsrtHtml(fileNum){
	var uploadHtml = '';
	uploadHtml += '<div class="file-form-group devInfoAdminFileFormG">                                                                     ';
	uploadHtml += '	<div class="form-group__upload devInfoAdminFormG">                                                                     ';
	uploadHtml += '		<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                            ';
	uploadHtml += '		<input type="file" name="atchFile_'+fileNum+'" id="InsrtAtchFile_'+fileNum+'" class="form-upload__file--hidden">   ';
	uploadHtml += '	</div>                                                                                                                 ';
	uploadHtml += '<div class="form-input__addon">                                                                                         ';
	uploadHtml += '	<label for="InsrtAtchFile_'+fileNum+'" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>      ';
	uploadHtml += '	<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                                   ';
	uploadHtml += '</div>                                                                                                                  ';
	uploadHtml += '</div>                                                                                                                  ';
	uploadHtml += '	<div class="form-group file_author devInfoAdminFileAuth">                                                              ';
	uploadHtml += '	<input name="fileAuthor" type="hidden" value="CM00200010"/>                                                            ';
	uploadHtml += '</div>                                                                                                                  ';
	return uploadHtml;
}


