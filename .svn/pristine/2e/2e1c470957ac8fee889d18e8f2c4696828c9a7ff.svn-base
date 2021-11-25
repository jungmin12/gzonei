package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 *   2016. 6. 17.   장동한       표준프레임워크 v3.6 리뉴얼
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables(){

		firstPageLabel    = "<li class=\"page-item\"><a aria-label=\"first\" class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&lt;&lt;</span><span class=\"sr-only\">첫번째페이지</span></a></li>";
		previousPageLabel = "<li class=\"page-item\"><a aria-label=\"Previous\" class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&lt;</span><span class=\"sr-only\">이전페이지</span></a></li>";
		
        currentPageLabel  = "<li class=\"page-item active\"><a class=\"page-link\" onClick=\"return false;\">{0}</a></li>";
        otherPageLabel    = "<li class=\"page-item\"><a class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        
        nextPageLabel    = "<li class=\"page-item\"><a aria-label=\"Next\" class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&gt;</span><span class=\"sr-only\">다음페이지</span></a></li>";
        lastPageLabel    = "<li class=\"page-item\"><a aria-label=\"last\" class=\"page-link\" href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"><span aria-hidden=\"true\">&gt;&gt;</span><span class=\"sr-only\">마지막페이지</span></a></li>";

	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
