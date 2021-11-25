package gzonei.payment.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface PaymentService {
	
	/** 희진 */
	// 정산관리 리스트 조회
	public List<?> selectExcclcList(EgovMap map) throws SQLException , IOException;

	//정산관리 내역 수 조회
	public int selectExcclcListTotCnt(EgovMap map) throws SQLException , IOException;
	
	// 정산정보 입력
	public int insertExcclcInfo(Map<String, Object> map) throws SQLException , IOException;
	
	//정산정보 조회
	public EgovMap selectExcclcDetail(EgovMap map) throws SQLException, IOException;
	
	//정산정보 수정
	public int updateExcclcInfo(Map<String, Object> map) throws SQLException, IOException;

	//무통장 승인 리스트 조회
	public List<?> selectNbkkCnfirmList(EgovMap map) throws SQLException , IOException;
	
	//무통장 승인 내역 수 조회
	public int selectNbkkCnfirmListTotCnt(EgovMap map) throws SQLException , IOException;
	
}
