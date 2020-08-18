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
 * </pre>
 */
public class ImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public ImagePaginationRenderer() {

	}

	public void initVariables(){
		firstPageLabel    = "<span class=\"page_btn\"><a href=\"?pageIndex={1}\" class=\"prev_end\" onclick=\"{0}({1});return false; \"></a></span>";
        previousPageLabel = "<span class=\"page_btn\"><a href=\"?pageIndex={1}\" class=\"prev\" onclick=\"{0}({1});return false; \"></a></span>";
        currentPageLabel  = "<span class=\"page_wrap\"><a class=\"now_page\" href=\"#\">{0}</a></span>";
        otherPageLabel    = "<span class=\"page_wrap\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a></span>";
        nextPageLabel     = "<span class=\"page_btn\"><a href=\"?pageIndex={1}\" class=\"next\" onclick=\"{0}({1});return false; \"></a></span>";
        lastPageLabel     = "<span class=\"page_btn\"><a href=\"?pageIndex={1}\" class=\"next_end\" onclick=\"{0}({1});return false; \"></a></span>";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
