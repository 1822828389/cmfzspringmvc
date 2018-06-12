package com.baizhi.controller;import com.baizhi.annotation.UserAnnoation;import com.baizhi.entity.ProvinceVO;import com.baizhi.entity.User;import com.baizhi.entity.UserPro;import com.baizhi.service.UserService;import org.apache.poi.hssf.usermodel.HSSFWorkbook;import org.apache.poi.ss.usermodel.*;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.http.MediaType;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.ResponseBody;import org.springframework.web.bind.annotation.RestController;import org.springframework.web.multipart.MultipartFile;import javax.servlet.http.HttpServletRequest;import javax.servlet.http.HttpServletResponse;import java.io.File;import java.io.FileInputStream;import java.io.IOException;import java.io.UnsupportedEncodingException;import java.lang.reflect.Field;import java.util.*;/** * Created by dell on 2018/6/2. */@RestController@RequestMapping(value = "/user")public class UserController {    @Autowired    private UserService userService;    @RequestMapping(value = "/queryall",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})    public Map<String, Object> queryAllUser(Integer page, Integer rows) {        Map<String, Object> map=new HashMap<String, Object>();        List<User> list = userService.queryByPage((page - 1) * rows, rows);        int count=userService.querySize();        map.put("total",count);        map.put("rows",list);        return map;    }    @RequestMapping(value = "/update")    public void UpdateUser(User user) {        System.out.println(user);        userService.updateUser(user);    }    @RequestMapping(value = "/querynumbytime")    public List<Integer> queryNumByTime() {        Integer days[] = {7, 15, 30, 90, 183, 365};        List<Integer> list = new ArrayList<Integer>();        for (Integer day : days) {            list.add(userService.queryNumByDate(day));        }        return list;    }    @RequestMapping(value = "/querynumbysex", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})    public List<ProvinceVO> queryNubBySex() {        return userService.queryNumByProAndSex("m");    }    @RequestMapping(value = "/querynumbysex1", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})    public List<ProvinceVO> queryNubBySex1() {        return userService.queryNumByProAndSex("g");    }    @RequestMapping(value = "/querysx", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})    public List<UserPro> querySx() {        List<UserPro> children = new ArrayList<UserPro>();        Class<User> userClass = User.class;        Field[] field = userClass.getDeclaredFields();        for (Field f : field) {            UserPro userPro = new UserPro();            userPro.setId(f.getName());            System.out.println(f.getName());            userPro.setText(f.getAnnotation(UserAnnoation.class).name());            System.out.println(f.getAnnotation(UserAnnoation.class).name());            children.add(userPro);        }        return children;    }    @ResponseBody    @RequestMapping("/customerExport")    public void customerExport(String titles, String fileds, HttpServletResponse response) {        //标题行        String[] title = titles.split(",");        String[] allFiled = fileds.split(",");        Workbook workbook = new HSSFWorkbook();        //日期格式        DataFormat dataFormat = workbook.createDataFormat();        short format = dataFormat.getFormat("yyyy年MM月dd日");        //字体格式        Font font = workbook.createFont();        font.setColor(Font.COLOR_RED);        CellStyle cellStyle = workbook.createCellStyle();        cellStyle.setDataFormat(format);        cellStyle.setFont(font);        cellStyle.setAlignment(HorizontalAlignment.CENTER);        Sheet sheet = workbook.createSheet("工作表");        Row row = sheet.createRow(0);        for (int i = 0; i < title.length; i++) {            String s = title[i];            Cell cell = row.createCell(i);            cell.setCellValue(s);        }        //数据行        // List<User> users = Arrays.asList(new User(0, "小黑0", "1234560", new Date()), new User(1, "小黑1", "1234561", new Date()), new User(2, "小黑2", "1234562", new Date()), new User(3, "小黑3", "1234563", new Date()), new User(4, "小黑4", "1234564", new Date()));        List<User> users = userService.queryAll();        for (int i = 0; i < users.size(); i++) {            Row dataRow = sheet.createRow(i + 1);            for (int j = 0; j < allFiled.length; j++) {                Cell cell = dataRow.createCell(j);                //填充属性                Class<? extends User> userClass = users.get(i).getClass();                String methodName = "get" + allFiled[j].substring(0, 1).toUpperCase() + allFiled[j].substring(1);                try {                    Object invoke = userClass.getDeclaredMethod(methodName, null).invoke(users.get(i), null);                    if (invoke instanceof Date) {                        sheet.setColumnWidth(j, 18 * 256);                        cell.setCellStyle(cellStyle);                        cell.setCellValue((Date) invoke);                    } else {                        cell.setCellValue(invoke.toString());                    }                } catch (Exception e) {                    e.printStackTrace();                }            }        }        String name = "用户自定义导出的数据.xls";        String fileName = "";        try {            fileName = new String(name.getBytes("UTF-8"), "ISO8859-1");        } catch (UnsupportedEncodingException e) {            e.printStackTrace();        }        response.setHeader("content-disposition", "attachment;fileName=" + fileName);        response.setContentType("application/vnd.ms-excel");        try {            workbook.write(response.getOutputStream());            workbook.close();        } catch (IOException e) {            e.printStackTrace();        }    }    @RequestMapping(value = "/import")    public void importUser(MultipartFile file,HttpServletRequest request) throws Exception{        //获取当前项目路径        String projetPath = request.getSession().getServletContext().getRealPath("/");        System.out.println("======"+projetPath);        File files = new File(projetPath);        //web项目的路径        String webappsPath = files.getParent();        System.out.println(webappsPath);        //上传文件夹的路径        File uploadPath = new File(webappsPath + "/upload");        //创建上传文件夹        if (!uploadPath.exists()) {            uploadPath.mkdir();        }        //获取原始文件名        String oldFilename = file.getOriginalFilename();        //获取后缀名        String newName = oldFilename;        try {            //上传到指定的文件夹            file.transferTo(new File(uploadPath.getPath(), newName));        } catch (IOException e) {            e.printStackTrace();        }        String realpath = projetPath+oldFilename;        System.out.println(realpath);        String realpath1 = realpath.replace("\\", "/");        System.out.println(realpath1);        //"E:/用户自定义导出的数据 .xls"        List<User> users = new ArrayList<User>();        Workbook workbook = new HSSFWorkbook(new FileInputStream(realpath1));        Sheet sheet = workbook.getSheet("工作表");        Class<User> userClass = User.class;        Field[] field = userClass.getDeclaredFields();        for (int i = 1; i <=sheet.getLastRowNum(); i++) {            User user = new User();            Row row = sheet.getRow(i);            //System.out.println(i);            int j = 0;            for (Field f : field) {                Cell cell = row.getCell(j);                j++;                String methods = "set" + f.getName().substring(0, 1).toUpperCase() + f.getName().substring(1);                try {                    if (methods.equals("setId")) {                        int numericCellValue = (int) cell.getNumericCellValue();                        String s = String.valueOf(numericCellValue);                        userClass.getDeclaredMethod(methods, String.class).invoke(user, s);                    } else if (methods.equals("setRegtime")) {                        userClass.getDeclaredMethod(methods, Date.class).invoke(user, cell.getDateCellValue());                    } else {                        userClass.getDeclaredMethod(methods, String.class).invoke(user, cell.getStringCellValue());                    }                } catch (Exception e) {                    e.printStackTrace();                }            }            users.add(user);        }        /*for (User user : users) {            System.out.println(user);        }*/        userService.insertUser(users);    }}