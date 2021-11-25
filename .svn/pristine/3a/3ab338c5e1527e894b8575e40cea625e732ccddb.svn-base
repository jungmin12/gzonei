var excelHandler = {
        getExcelFileName : function(){
            return 'json-test.xlsx';
        },
        getSheetName : function(){
            return 'Json Test Sheet';
        },
        getExcelData : function(){
            return [{'상품명':'삼성 갤럭시 s11' , '가격':'200000'}, {'상품명':'삼성 갤럭시 s12' , '가격':'220000'}, {'상품명':'삼성 갤럭시 s13' , '가격':'230000'}]; 
        },
        getWorksheet : function(){
            return XLSX.utils.json_to_sheet(this.getExcelData());
        }
}

function s2ab(s) { 
	var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    return buf;       
}

function exportExcel(){ 
    // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기 
    var newWorksheet = excelHandler.getWorksheet();
    
    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

    // step 4. 엑셀 파일 만들기 
    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

    // step 5. 엑셀 파일 내보내기 
    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
}

function exportExcel(fileNm, sheetNm, json){ 
	 // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기 
//    var newWorksheet = excelHandler.getWorksheet();
    var newWorksheet = XLSX.utils.json_to_sheet(json);
    
    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
//     XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());
    XLSX.utils.book_append_sheet(wb, newWorksheet, sheetNm);

    // step 4. 엑셀 파일 만들기 
    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

    // step 5. 엑셀 파일 내보내기 
//     saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), fileNm+".xlsx");
}