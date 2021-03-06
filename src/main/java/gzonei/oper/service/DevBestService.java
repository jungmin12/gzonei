package gzonei.oper.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface DevBestService {
	
	
	//개발정보 Best조회
	public List<?> selectBest() throws SQLException , IOException;
	
	//개발 사업 전체 사업번호/사업명 조회
	public List<?> selectAlldevBestModalList(EgovMap searchVO) throws SQLException , IOException;
	
	//개발 사업 TotCnt
	public int selectAlldevBestModalTotCnt(EgovMap searchVO) throws SQLException , IOException;
	
	//사업지구 코드 리스트(전체)
	public List<?> selectdevBestDstrcCodeList() throws SQLException , IOException;
	
	//선택한 개발 사업 조회
	public EgovMap selectInvtInfo(EgovMap searchVO) throws SQLException , IOException;
	
	//투자 정보 조회(미정)
	
	//개발 정보 입력
	public void insertdevBestInfo (EgovMap insertVO) throws SQLException , IOException;
	//파일 가져오기
	public EgovMap selectDevBestOldFile(EgovMap searchVO);

	public EgovMap selectFree(EgovMap searchVO);

	public List<?> selectSstusList(EgovMap searchVO);

	public List<?> selectDevBestNewFile(EgovMap searchVO);

	public EgovMap selectImage(EgovMap searchVO);

	public EgovMap selectLc(EgovMap searchVO);

}
