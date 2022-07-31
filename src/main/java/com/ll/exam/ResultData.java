package com.ll.exam;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ResultData<T> {
    private final String msg;
    private String resultCode;
    private T data;
}

/*
// 롬복 적용 전

public class ResultData<T> {
    private final String msg;
    private String resultCode;
    private T data;

    public ResultData (String resultCode, String msg, T data) {
        this.resultCode = resultCode;
        this.msg = msg;
        this.data = data;
    }
 */