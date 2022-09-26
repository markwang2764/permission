package com.master.controller;

import com.master.common.JsonData;
import com.master.dto.DeptLevelDto;
import com.master.param.DeptParam;
import com.master.service.SysDeptService;
import com.master.service.SysTreeService;
import com.master.util.BeanValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/sys/dept")
@Slf4j
public class SysDeptController {
    @Autowired
    private SysDeptService sysDeptService;
    @Resource
    private SysTreeService sysTreeService;
    @RequestMapping("/save.json")
    @ResponseBody
    public JsonData save(DeptParam param) {
        sysDeptService.save(param);
        return JsonData.success();
    }

    @RequestMapping("/dept.page")
    @ResponseBody
    public ModelAndView page() {
        return new ModelAndView("dept");
    }

    @RequestMapping("/tree.json")
    @ResponseBody
    public JsonData tree(){
        List<DeptLevelDto> dtoList = sysTreeService.deptTree();
        return JsonData.success(dtoList);
    }

    @RequestMapping("/update.json")
    @ResponseBody
    public JsonData update(DeptParam param) {
        BeanValidator.check(param);
        sysDeptService.update(param);
        return JsonData.success();
    }

    @RequestMapping("/delete.json")
    @ResponseBody
    public JsonData delete(@RequestParam("id") int id) {
        sysDeptService.delete(id);
        return JsonData.success();
    }


}
