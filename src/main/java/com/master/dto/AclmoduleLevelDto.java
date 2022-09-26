package com.master.dto;

import com.google.common.collect.Lists;
import com.master.model.SysAclModule;
import lombok.Data;
import org.springframework.beans.BeanUtils;

import java.util.ArrayList;
import java.util.List;
@Data
public class AclmoduleLevelDto extends SysAclModule {
    private List<AclmoduleLevelDto> aclModuleList = new ArrayList<>();

    private List<AclDto> aclList = Lists.newArrayList();

    public static AclmoduleLevelDto adapt(SysAclModule aclModule) {
        AclmoduleLevelDto dto = new AclmoduleLevelDto();
        BeanUtils.copyProperties(aclModule, dto);
        return dto;
    }
}
