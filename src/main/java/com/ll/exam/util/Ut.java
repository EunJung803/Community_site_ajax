package com.ll.exam.util;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ll.exam.article.dto.ArticleDto;

public class Ut {
    private static final ObjectMapper om;

    static {
        om = new ObjectMapper();
    }

    public static class json {
        public static String toStr(Object obj, String defaultValue) {

            try {
                return om.writeValueAsString(obj);
            } catch (JsonProcessingException e) {
                return defaultValue;
            }
        }

        public static Object toObj(String jsonStr, Class cls, Object defaultValue) {
            try {
                return om.readValue(jsonStr, cls);
            } catch (JsonProcessingException e) {
                return defaultValue;
            }
        }
    }
}
