package com.shirokumacafe.archetype.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shirokumacafe.archetype.common.utils.ConvertFileToImageUtil;
import com.shirokumacafe.archetype.entity.Course;
import com.shirokumacafe.archetype.entity.FileImage;
import com.shirokumacafe.archetype.repository.CourseMapper;
import com.shirokumacafe.archetype.repository.FileImageMapper;
import com.shirokumacafe.archetype.repository.FileMapper;

/**
 * 文件服务
 * @author CZX
 *
 */
@Component
@Transactional
public class FileService {
	
	@Autowired
    private FileMapper fileMapper;
	
	@Autowired
	private FileImageMapper fileImageMapper; 
	
	@Autowired
	private CourseMapper courseMapper;
	/**
	 * 上传文件
	 * @param request
	 * @param file
	 * @return
	 * @throws Exception
	 */
	public void upload(HttpServletRequest request, MultipartFile file) throws Exception {
		String cId = request.getParameter("cId");
		// 如果文件不为空，写入上传路径
		if (!file.isEmpty()) {
			// 上传文件路径
			String filePath = request.getServletContext().getRealPath("/file/");
			// 上传文件名
			String filename = file.getOriginalFilename();
			File path = new File(filePath, filename);
			// 判断路径是否存在，如果不存在就创建一个
			if (!path.getParentFile().exists()) {
				path.getParentFile().mkdirs();
			}
			// 通过cId去查询course是否存在fId,如果存在就更新file，否则新增file
			Course subCourse = courseMapper.selectByPrimaryKey(Integer.parseInt(cId));
			Integer fId = null;
			// 新增file
			if (null == subCourse.getfId() || 0 == subCourse.getfId()) {
				com.shirokumacafe.archetype.entity.File fileEntty = new com.shirokumacafe.archetype.entity.File();
				fileEntty.setfName(filename);
				fileEntty.setfAddr(filePath);
				fId = fileMapper.insertAndGetId(fileEntty);
			} else {
				// 更新子课程中对应的文件ID
				fId = subCourse.getfId();
			}
			Course course = new Course();
			course.setfId(fId);
			course.setcId(Integer.parseInt(cId));
			courseMapper.updateByPrimaryKeySelective(course);
			// 将上传文件保存到一个目标文件当中
			file.transferTo(new File(filePath + File.separator + filename));

			String subName[] = filename.split("\\.");
			String imgDirPath = filePath + "\\" + subName[0] + "\\";
			// 将文件转换为图片
			if (subName[1].equals("ppt")) {
				ConvertFileToImageUtil.converPPTtoImage(path + "", imgDirPath, "jpg");
			} else if (subName[1].equals("pptx")) {
				ConvertFileToImageUtil.converPPTXtoImage(path + "", imgDirPath, "jpg");
			} else {
				// is pdf
				ConvertFileToImageUtil.pdf2Imgs(path + "", imgDirPath, filename);
			}
			// 查看文件对应的图片是否存在
			FileImage exitFileImage = fileImageMapper.selectByFid(fId);
			if (null == exitFileImage) {
				FileImage fi = new FileImage();
				fi.setfId(fId);
				fi.setFiAddr(imgDirPath);
				fileImageMapper.insertSelective(fi);
			}
		}
	}
	
}
