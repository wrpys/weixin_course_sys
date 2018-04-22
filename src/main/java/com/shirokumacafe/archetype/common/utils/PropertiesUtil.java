package com.shirokumacafe.archetype.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Properties;

/**
 * 配置文件加载
 */
public class PropertiesUtil {

    private final static String CONFIG_PATH = "application.properties";

    private static Properties properties = null;

    public static Properties getProperties(String filePath) throws IOException {
        URL url = PropertiesUtil.class.getClassLoader().getResource("/");
        if (url == null) {
            url = PropertiesUtil.class.getClassLoader().getResource("");
        }
        InputStream inStream = new FileInputStream(url.getPath() + File.separator + filePath);
        Properties properties = new Properties();
        properties.load(inStream);
        inStream.close();
        return properties;
    }

    public static Properties getProperties() throws IOException {
        if (properties == null) {
            properties = PropertiesUtil.getProperties(CONFIG_PATH);
        }
        return properties;
    }

}
