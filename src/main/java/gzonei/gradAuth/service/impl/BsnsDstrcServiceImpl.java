package gzonei.gradAuth.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.gradAuth.service.BsnsDstrcService;
@Service("BsnsDstrcService")
public class BsnsDstrcServiceImpl implements BsnsDstrcService {
	
	@Resource(name="BsnsDstrcDAO")
	private BsnsDstrcDAO bsnsdstrcdao;
	
	@Override
	public List<?> selectBsnsDstrc() {
		// TODO Auto-generated method stub
		return bsnsdstrcdao.selectBsnsDstrc();
	}

	@Override
	public void updateBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		bsnsdstrcdao.updateBsnsDstrc(vo);
	}

	@Override
	public void deleteBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		bsnsdstrcdao.deleteBsnsDstrc(vo);
	}

	@Override
	public void createBsnsDstrc(EgovMap vo) {
		// TODO Auto-generated method stub
		bsnsdstrcdao.createBsnsDstrc(vo);
	}

	@Override
	public List<?> selectDstrcAuthor() {
		return bsnsdstrcdao.selectDstrcAuthor();
	}

	@Override
	public void updateCodeChecker(EgovMap vo) {
		// TODO Auto-generated method stub
		bsnsdstrcdao.updateCodeChecker(vo);
	}



}
