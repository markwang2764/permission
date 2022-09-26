package com.master.beans;

import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
@Builder
public class PageResult<T> {

    private List<T> data;

    private int total = 0;
}

