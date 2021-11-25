$( document ).ready(function() {
	/* 파일 추가  */
	$('.addFile').on('click',function(){
		var fileNum = $('.form-group__upload').length+1;
		if(fileNum > 0){
			$('.delFile').css({'display':'inline-block'});
//			$('.file_author').css({'display':'block'});
		}
		var bbsId = $("input[name='bbsId']").val();
		var uploadHtml = '';
		uploadHtml += '	<div class="file-form-group">                                                                                                   ';
		uploadHtml += '		<div class="form-group__upload devInfoAdminFormG">                                                                          ';
		uploadHtml += '			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                                 ';
		uploadHtml += '			<input type="file" id="atchFile_'+fileNum+'" name="atchFile_'+fileNum+'" class="form-upload__file--hidden">             ';
		uploadHtml += '		</div>                                                                                                                      ';
		uploadHtml += '		<div class="form-input__addon">                                                                                             ';
		uploadHtml += '			<label for="atchFile_'+fileNum+'" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>            ';
		uploadHtml += '			<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                                    ';
		uploadHtml += '		</div>                                                                                                                      ';
		uploadHtml += '	</div>                                                                                                                          ';
		if(bbsId == "BBSMSTR_000000000011" ){
			uploadHtml += '	<div class="form-group file_author">                                                                                            ';
			uploadHtml += '	    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div> ';
			uploadHtml += '	    <div class="col-sm-4">                                                                                                      ';
			uploadHtml += '		    <select name="fileAuthor" class="form-control">                                                                         ';
//			uploadHtml += '		    	<option value="">---권한 설정---</option>                                                                           ';
			uploadHtml += '	            <option value="bbs009005">1레벨</option>																				';
			uploadHtml += '	            <option value="bbs009006">2레벨</option>																				';
			uploadHtml += '	            <option value="bbs009007">3레벨</option>																				';
//			uploadHtml += '		    	<option value="CM00209998">무료</option>                                                                            ';
//			uploadHtml += '		    	<option value="CM00200005">실버 (이코노미)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200006">실버 (스페셜)</option>                                                                   ';
//			uploadHtml += '		    	<option value="CM00200007">골드 (이코노미)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200008">골드 (비즈니스)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200009">골드 (스페셜)</option>                                                                   ';
//			uploadHtml += '		    	<option value="CM00200010">프리미엄 (이코노미)</option>                                                             ';
//			uploadHtml += '		    	<option value="CM00200011">프리미엄 (스페셜)</option>                                                               ';
		}else if(bbsId == "BBSMSTR_000000000006" ){
			uploadHtml += '	<div class="form-group file_author">                                                                                            ';
			uploadHtml += '	    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div> ';
			uploadHtml += '	    <div class="col-sm-4">                                                                                                      ';
			uploadHtml += '		    <select name="fileAuthor" class="form-control">                                                                         ';
			uploadHtml += '	            <option value="bbs010005">1레벨</option>																				';
			uploadHtml += '	            <option value="bbs010006">2레벨</option>																				';
			uploadHtml += '	            <option value="bbs010007">3레벨</option>																				';
//			uploadHtml += '		    	<option value="">---권한 설정---</option>                                                                           ';
//			uploadHtml += '		    	<option value="CM00209998">무료</option>                                                                            ';
//			uploadHtml += '		    	<option value="CM00200005">실버 (이코노미)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200006">실버 (스페셜)</option>                                                                   ';
//			uploadHtml += '		    	<option value="CM00200007">골드 (이코노미)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200008">골드 (비즈니스)</option>                                                                 ';
//			uploadHtml += '		    	<option value="CM00200009">골드 (스페셜)</option>                                                                   ';
//			uploadHtml += '		    	<option value="CM00200010">프리미엄 (이코노미)</option>                                                             ';
//			uploadHtml += '		    	<option value="CM00200011">프리미엄 (스페셜)</option>                                                               ';
		}else{
			uploadHtml += '	<div class="form-group file_author" style="display:none;">                                                                                            ';
			uploadHtml += '	    <div class="col-sm-2 control-label col-lg-2"><label for="select">첨부파일 권한<span class="pilsu">필수</span></label></div> ';
			uploadHtml += '	    <div class="col-sm-4">                                                                                                      ';
			uploadHtml += '		    <select name="fileAuthor" class="form-control">                                                                         ';
			uploadHtml += '		    	<option value="CM00209998">무료</option>                                                                            ';
		}
		uploadHtml += '		    </select>                                                                                                               ';
		uploadHtml += '    	</div>                                                                                                                      ';
		uploadHtml += '	</div>                                                                                                                          ';

//		<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
		$('.form-upload').append(uploadHtml);
	});
	
	
	// 결재업무용
	$('.addFileOper').on('click',function(){
		var fileNum = $('.form-group__upload').length+1;
		if(fileNum > 0){
			$('.delFile').css({'display':'inline-block'});
			$('.file_author').css({'display':'block'});
		}
		
		
		var uploadHtml = '';
		uploadHtml += '	<div class="file-form-group">                                                                                                   ';
		uploadHtml += '		<div class="form-group__upload devInfoAdminFormG">                                                                          ';
		uploadHtml += '			<input type="text" readonly="readonly" name="atchFileNm" class="form-control disabled">                                 ';
		uploadHtml += '			<input type="file" id="atchFile_'+fileNum+'" name="atchFile_'+fileNum+'" class="form-upload__file--hidden">             ';
		uploadHtml += '		</div>                                                                                                                      ';
		uploadHtml += '		<div class="form-input__addon">                                                                                             ';
		uploadHtml += '			<label for="atchFile_'+fileNum+'" class="btn btn-sm btn-secondary" data-button="upload">파일첨부하기</label>            ';
		uploadHtml += '			<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>                                    ';
		uploadHtml += '		</div>                                                                                                                      ';
		uploadHtml += '	</div>                                                                                                                          ';
		
//		<button type="button" class="btn btn-sm btn-primary file_del_btn">파일 삭제</button>
		$('.form-upload').append(uploadHtml);
	});
	
	
	
	
	
	
	/* 파일 삭제 */
	$('.delFile').on('click',function(){
		console.log('click');
		var fileNum = $('.form-group__upload').length-1;
		if(fileNum == 0 ){
			$(this).css({'display':'none'});
			$('.file_author').css({'display':'none'});
		}
		console.log('fileNum : '+fileNum);
		$('.file-form-group').last().remove();
		$('.file_author').last().remove();
	});
	
	/* 첨부파일 삭제*/
	$(document).on('click','.file_del_btn',function(){
		var check1 = $(this).parent().prev('.form-group__upload').find('.form-control').val(null);
		$(this).parent().prev('.form-group__upload').find('.form-control').val(null);
		$(this).parent().prev('.form-group__upload').find("a").attr("href", "#");
	})
	
	/* 파일명 바꾸기 */
	$(document).on('change','.form-upload__file--hidden',function(){
		
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
		html +=' <div class="file-group-upload">                                                                   ';
		html +=' 	<input type="text" readonly="readonly" class="form-control disabled">                          ';
 		html +=' 	<input type="file" id='+fileNum+' name='+fileNum+' class="form-upload__file--hidden">          ';
		html +=' </div>                                                                                            ';
		html +=' <div class="form-input__addon">                                                                   ';
		html +=' 	<label for="'+fileNum+'" class="btn btn-sm btn-primary" data-button="upload">파일선택</label>  ';
		html +=' 	<button type="button" class="cancel_btn">취소</button>                                         ';
		html +=' </div>                                                                                            ';
		
		$(this).parent().parent().append(html);
		$(this).remove();
	});
	
	/* 파일 수정 취소*/
	$(document).on('click','.cancel_btn',function(){
		
		var test = $(this).parent().parent().prevAll('p');
		$(this).parent().prevAll('p').css({'display':'block'});
		$(this).parent().prev('.file-button').find('.file_del_btn').css({'display':'block'});
		$(this).parent().prev('.file-button').prepend('<button type="button" class="file_edit_btn">파일수정</button>');
		$('.file-group-upload').remove();
	});
		
});