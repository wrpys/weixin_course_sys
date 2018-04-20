<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%

	String upload_folder = "File/Resources"; //上传的文件夹位置
	FileItemFactory factory = new DiskFileItemFactory();
    //进度监听
	ServletFileUpload sfu = new ServletFileUpload(factory);
	sfu.setHeaderEncoding("GBK");

	//int maxsize = 204800;
	//sfu.setSizeMax(maxsize);
	
	List items = null;
	try {
		items = sfu.parseRequest(request);
		
		FileItem item = (FileItem) items.get(0);
		String str = item.getName();
		String str2[] = str.split("\\\\");
		String original_fileName = "";
		for (int i = 0; i < str2.length; i++) {
			original_fileName = original_fileName + str2[i];
			if (i < str2.length-1) {
				original_fileName = original_fileName + " \\\\ ";
			}
		}
		request.setAttribute("original_fileName", original_fileName);
		
		String fn = str2[str2.length-1];
		ServletContext servletContext = request.getSession().getServletContext();
		
		File filePath = new File(servletContext.getRealPath(upload_folder) + File.separator + this.getSystime("yyyyMM"));
		if (!filePath.exists()) {
			filePath.mkdirs();
		}
		
		String fileName = this.getRandomFileName(fn);
		File uploadFile = new File(servletContext.getRealPath(upload_folder) + File.separator + fileName);
		item.write(uploadFile);
		request.setAttribute("r",1);
		request.setAttribute("upload_fileName", upload_folder + "/" + fileName);
        request.setAttribute("fileSize", uploadFile.length());
	} catch (FileUploadException e) {
		request.setAttribute("r",1);
		request.setAttribute("upload_fileName", "error.file_size_beyond");
	} catch (Exception e) {
		e.printStackTrace();
	}
	request.getRequestDispatcher("uploadFile.jsp").forward(request,response);
%>
<%!

    //生成随机的文件名
	private String getRandomFileName(String filename){
		
		String name = filename.substring(filename.lastIndexOf("."));
		String systime = this.getSystime("ssmmHHddMMyyyy");
		String sysMonth = this.getSystime("yyyyMM");
		String str = sysMonth + "/" + new Random().nextInt(1000) + systime + name;
		
		return str;	
	}

    //根据格式获取系统时间
	private String getSystime(String format){
		
		if(format == null || format.equals("")){
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+08"));
		return  sdf.format(new Date());
		
	}
%>

