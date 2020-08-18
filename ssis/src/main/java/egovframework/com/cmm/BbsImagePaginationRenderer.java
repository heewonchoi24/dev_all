package egovframework.com.cmm;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;
/**
 * ImagePaginationRenderer.java 클래스

 * </pre>
 */
public class BbsImagePaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public BbsImagePaginationRenderer() {

	}

	public void initVariables(){
		firstPageLabel    = "<li class=\"first\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a></li>";
        previousPageLabel = "<li class=\"prev\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a></li>";
        currentPageLabel  = "<li class=\"on\"><a href=\"#\"><strong>{0}</strong></a></il>";
        otherPageLabel    = "<li><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a></li>";
        nextPageLabel     = "<li class=\"next\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a></li>";
        lastPageLabel     = "<li class=\"last\"><a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \"></a></li>";
	}



	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}
