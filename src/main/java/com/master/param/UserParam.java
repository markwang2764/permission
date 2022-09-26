package com.master.param;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Data
public class UserParam {
    private Integer id;

    @NotBlank(message = "用户名不可以为空")
    private String username;
//    @NotBlank(message = "密码不可以为空")
//    @Length(min = 0, max = 20, message = "密码不能为空")
//    private String password;


    private String telephone;


    private String mail;

    @NotNull(message = "必须提供用户所在的部门")
    private Integer deptId;
    @NotNull(message = "必须指定用户的状态")
    @Min(value = 0, message = "用户状态不合法")
    @Max(value = 2, message = "用户状态不合法")
    private Integer status;
    @Length(min = 0, max = 200, message = "备注长度需要在200个字以内")
    private String remark;
}
