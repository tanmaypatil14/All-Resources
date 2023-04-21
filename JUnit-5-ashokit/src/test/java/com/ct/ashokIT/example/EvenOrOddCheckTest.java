package com.ct.ashokIT.example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvFileSource;

class EvenOrOddCheckTest {

	@ParameterizedTest
	@CsvFileSource(resources = "/data.csv", numLinesToSkip = 1)
	void isEvenOrOddCheckTest(String input, String expected) {
		System.out.println(input);
		EvenOrOddCheck check = new EvenOrOddCheck();
		String actual = check.isEvenOrOddCheck(Integer.parseInt(input));
		assertEquals(expected, actual);
	}

}
