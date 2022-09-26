package com.master.param;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Getter
@Setter
@ToString
public class AclModuleParam {
    private Integer id;

    @NotBlank(message = "权限模块名称不可以为空")
    private String name;

    private Integer parentId = 0;

    @NotNull(message = "权限模块展示顺序不可以为空")
    private Integer seq;

    @NotNull(message = "权限模块状态不可以为空")
    @Min(value = 0, message = "权限模块状态不合法")
    @Max(value = 1, message = "权限模块状态不合法")
    private Integer status;
    @Length(max = 200, message = "权限模块的备注需要再200字之间")
    private String remark;
}
