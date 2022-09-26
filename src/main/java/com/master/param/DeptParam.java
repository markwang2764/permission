package com.master.param;

import lombok.Data;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotBlank;

import javax.validation.constraints.NotNull;
import java.util.Date;

@Data
public class DeptParam {
    private Integer id;

    @NotBlank(message = "部门名称不可以为空")
    private String name;

    private Integer parentId = 0;

    @NotNull(message = "展示顺序不可以为空")
    private Integer seq;

    @Length(max = 150, message = "备注的长度不能超过150")
    private String remark;

}
