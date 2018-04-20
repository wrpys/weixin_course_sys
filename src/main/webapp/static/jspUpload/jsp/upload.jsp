<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%

	int maxsize = 204800;
	String errorpath = "error.500";
	String upload_folder = "File/temp"; //�ϴ����ļ���λ��
	
	FileItemFactory factory = new DiskFileItemFactory();
	ServletFileUpload upload = new ServletFileUpload(factory);
	upload.setHeaderEncoding("GBK");
	upload.setSizeMax(maxsize);
	
	List items = null;
	try {
		items = upload.parseRequest(request);
		
		FileItem item = (FileItem) items.get(0);
		String str = item.getName();
		String str2[] = str.split("\\\\");
		String excel_realName = "";
		for (int i = 0; i < str2.length; i++) {
			excel_realName = excel_realName + str2[i];
			if (i < str2.length-1) {
				excel_realName = excel_realName + " \\\\ ";
			}
		}
		request.setAttribute("excel_realName", excel_realName);
		
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
		request.setAttribute("excel_fileName", upload_folder+"/"+fileName);
		
	} catch (FileUploadException e) {
		request.setAttribute("r",1);
		request.setAttribute("excel_fileName", errorpath);
	} catch (Exception e) {
		e.printStackTrace();
	}
	request.getRequestDispatcher("uploadExcel.jsp").forward(request,response);
%>
<%!

    //����������ļ���
	private String getRandomFileName(String filename){
		
		String name = filename.substring(filename.lastIndexOf("."));
		
		String systime = this.getSystime("ssmmHHddMMyyyy");
		
		String sysMonth = this.getSystime("yyyyMM");
			
		String str = sysMonth + "/" + new Random().nextInt(1000) + systime + name;
		
		return str;	
	}

    //���ݸ�ʽ��ȡϵͳʱ��
	private String getSystime(String format){
		
		if(format == null || format.equals("")){
			format = "yyyy-MM-dd HH:mm:ss";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(format);
		sdf.setTimeZone(TimeZone.getTimeZone("GMT+08"));
		return  sdf.format(new Date());
		
	}
%>

