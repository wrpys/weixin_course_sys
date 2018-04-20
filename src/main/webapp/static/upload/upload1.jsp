<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%
    int maxsize = 0;//�ϴ������
    String upload_folder = ""; //�ϴ����ļ���λ��

    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("GBK");

    List items = null;
    try {

        maxsize = Integer.parseInt(request.getParameter("maxsize"));
        if(maxsize == 0){
            maxsize = 102400;//���û������ͼƬ�ϴ������ƴ�С����Ĭ��Ϊ200k
        }
        request.setAttribute("maxsize",maxsize);
        upload.setSizeMax(maxsize*1024);

        items = upload.parseRequest(request);

        FileItem item = (FileItem) items.get(0);
        String str = item.getName();
        String str2[] = str.split("\\\\");
        String fn = str2[str2.length-1];

        ServletContext servletContext = request.getSession().getServletContext();

        upload_folder = request.getParameter("upload_folder");
        if(upload_folder==null || upload_folder.equals("")){
            upload_folder = "FileService/video/index";   //���ûָ���ϴ����ļ��е�λ�ã���Ĭ��Ϊimg/merchandise/origonal�ļ���
        }
        File filePath = new File(servletContext.getRealPath(upload_folder) + File.separator + this.getSystime("yyyyMM"));
        if (!filePath.exists()) {
            filePath.mkdirs();
        }

        String fileName = this.getRandomFileName(fn);
        fileName=upload_folder+"/"+fileName;
//        System.out.println(fileName);
        File uploadFile = new File(servletContext.getRealPath(fileName));
        item.write(uploadFile);

        request.setAttribute("picImg", request.getParameter("picImg"));
        request.setAttribute("picInput",request.getParameter("picInput"));
        request.setAttribute("picArea",request.getParameter("picArea"));
        request.setAttribute("r",1);
        request.setAttribute("img_fileName", fileName);
        request.setAttribute("upload_folder", upload_folder);
        request.setAttribute("width",request.getParameter("width"));
        request.setAttribute("height",request.getParameter("height"));
    } catch (FileUploadException e) {
        request.setAttribute("r",1);
        request.setAttribute("img_fileName", "error.file_size_beyond");
    } catch (Exception e) {
        e.printStackTrace();
    }
    request.getRequestDispatcher("uploadVideo.jsp").forward(request,response);
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

