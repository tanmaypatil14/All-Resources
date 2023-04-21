package com.ct.ashokIT.example;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class StringToIntUtilsThrowExceptionExampleTest {

	@ParameterizedTest
	@ValueSource(strings = {"2","1", "null", " "})
	void stringToIntUtilsThrowExceptionExampleTest(String str) {
//		Integer actual = StringToIntUtilsThrowExceptionExample.convertToInt(str);
//		assertEquals(2, actual);
		assertThrows(IllegalArgumentException.class, ()-> StringToIntUtilsThrowExceptionExample.convertToInt(str));
	}

}
