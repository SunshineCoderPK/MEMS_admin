package com.kaipan.mems.utils;

  
import java.util.List;



public class ConvertUtils {
	@SuppressWarnings("unchecked")  
	public static <T> List<T> convert(List<?> list) {  
	    return (List<T>)list;  
	}  


}
