package com.baizhi.controller;import com.baizhi.entity.Menu;import com.baizhi.service.MenuService;import org.springframework.beans.factory.annotation.Autowired;import org.springframework.http.MediaType;import org.springframework.web.bind.annotation.RequestMapping;import org.springframework.web.bind.annotation.RestController;import java.util.List;/** * Created by dell on 2018/5/25. */@RestController@RequestMapping(value="/menu")public class MenuController {    @Autowired    private MenuService menuService;    @RequestMapping(value="/query", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})    public List<Menu> query(){        List<Menu> list=menuService.query();       /* for (Menu m:list) {            System.out.println(m)1;        }*/        return list;    }}