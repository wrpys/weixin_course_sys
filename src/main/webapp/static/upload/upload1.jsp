<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="java.util.*,java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%
    int maxsize = 0;//上传的最大
    String upload_folder = ""; //上传的文件夹位置

    FileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("GBK");

    List items = null;
    try {

        maxsize = Integer.parseInt(request.getParameter("maxsize"));
        if(maxsize == 0){
            maxsize = 102400;//如果没有设置图片上传的限制大小，就默认为200k
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
            upload_folder = "FileService/video/index";   //如果没指明上传的文件夹的位置，则默认为img/merchandise/origonal文件夹
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

