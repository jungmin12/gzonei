package gzonei.oper.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.oper.service.DevBestService;
@Service("DevBestService")
public class DevBestServiceImpl implements DevBestService {
	
	
	@Resource(name="DevBestDAO")
	private DevBestDAO devbestdao;
	
	
	@Override
	public List<?> selectBest() throws SQLException , IOException{
		return devbestdao.selectBest();
	}

	@Override
	public List<?> selectAlldevBestModalList(EgovMap searchVO) throws SQLException, IOException {
		return devbestdao.selectAlldevBestModalList(searchVO);
	}
	@Override
	public int selectAlldevBestModalTotCnt(EgovMap searchVO) throws SQLException, IOException {
		return devbestdao.selectAlldevBestModalTotCnt(searchVO);
	}
	@Override
	public List<?> selectdevBestDstrcCodeList() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return devbestdao.selectdevBestDstrcCodeList();
	}

	@Override
	public EgovMap selectInvtInfo(EgovMap searchVO)throws SQLException , IOException {
		return devbestdao.selectInvtInfo(searchVO);
	}

	@Override
	public void insertdevBestInfo(EgovMap insertVO)throws SQLException , IOException {
		devbestdao.insertdevBestInfo(insertVO);
	}

	@Override
	public EgovMap selectDevBestOldFile(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return devbestdao.selectDevBestOldFile(searchVO);
	}

	@Override
	public EgovMap selectFree(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return devbestdao.selectFree(searchVO);
	}

	@Override
	public List<?> selectSstusList(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return devbestdao.selectSstusList(searchVO);
	}

	@Override
	public List<?> selectDevBestNewFile(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return  devbestdao.selectDevBestNewFile(searchVO);
	}

	@Override
	public EgovMap selectImage(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return devbestdao.selectImage(searchVO);
	}

	@Override
	public EgovMap selectLc(EgovMap searchVO) {
		// TODO Auto-generated method stub
		return devbestdao.selectLc(searchVO);
	}


}
