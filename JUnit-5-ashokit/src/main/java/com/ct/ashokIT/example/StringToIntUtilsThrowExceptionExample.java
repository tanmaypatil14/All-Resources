package com.ct.ashokIT.example;

public class StringToIntUtilsThrowExceptionExample {
	
	public static Integer convertToInt(String str) {
		if(str == null || str.trim().length() == 0) {
			throw new IllegalArgumentException("String must be not null or empty");
		}
		return Integer.parseInt(str);
	}
}
