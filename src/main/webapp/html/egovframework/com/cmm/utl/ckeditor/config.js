/**
 * @license Copyright (c) 2003-2018, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.height = 600;
	config.filebrowserUploadUrl = '/GZONEI/ckupload.do';
	/*config.uploadUrl = '/GZONEI/ckupload.do';*/
	config.filebrowserUploadMethod = 'form';
	config.allowedContent = true;
	// endter / shiftEnter Mode
	//config.enterMode = CKEDITOR.ENTER_BR;
	//config.shiftEnterMode = CKEDITOR.ENTER_P;
};
