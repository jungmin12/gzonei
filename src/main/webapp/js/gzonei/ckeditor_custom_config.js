var ckeditor_config = {filebrowserImageUploadUrl :'/ckupload.do'};
	            CKEDITOR.replace('nttCn',ckeditor_config);
	            CKEDITOR.instances.nttCn.updateElement;
	            CKEDITOR.fileTools.getUploadUrl(ckeditor_config,type='images');
	            CKEDITOR.on('dialogDefinition', function (ev) {
	                var dialogName = ev.data.name;
	                var dialog = ev.data.definition.dialog;
	                var dialogDefinition = ev.data.definition;
	                if (dialogName == 'image') {
	               	 dialog.on('show', function (obj) {
	                        this.selectPage('Upload'); //업로드텝으로 시작
	                    });
	                    dialogDefinition.removeContents('advanced'); // 자세히탭 제거
	                    dialogDefinition.removeContents('Link'); // 링크탭 제거
	                }
	            	if (dialogName == 'link') {
	            		ev.data.definition.getContents('target').get('linkTargetType')['default'] = '_blank';
	            	}//URL링크 때 새창으로 시작 
	            });