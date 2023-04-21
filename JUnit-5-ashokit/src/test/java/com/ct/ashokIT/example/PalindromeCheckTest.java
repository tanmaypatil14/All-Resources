package com.ct.ashokIT.example;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class PalindromeCheckTest {

	@ParameterizedTest
	@ValueSource(strings = {"racecar", "radar", "madam", "liril", "ashok"})	
	void isPalindromeTest(String str) {
		PalindromeCheck palindromeCheck = new PalindromeCheck();
		boolean actual = palindromeCheck.isPalindrome(str);
//		assertEquals(true, actual);
		assertTrue(actual);
	}

}
