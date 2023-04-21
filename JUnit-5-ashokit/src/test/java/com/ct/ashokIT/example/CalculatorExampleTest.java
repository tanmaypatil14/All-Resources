package com.ct.ashokIT.example;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;

class CalculatorExampleTest {

	private CalculatorExample mathUtils;

	@BeforeAll
	static void beforeAllInIt() {
//		mathUtils = new CalculatorExample();
		System.out.println("This method needs run before Instance is created");
	}

	@BeforeEach
	void inIt() {
		mathUtils = new CalculatorExample();
		System.out.println("Initialize before each............");
	}

	@AfterEach
	void cleanUp() {
		System.out.println("Clean Up After each method........");
	}

	@Test
	@DisplayName("Testing add method")
	void testAdd() {
		int expected = 2;
		int actual = mathUtils.add(1, 1);
		assertEquals(expected, actual, "The add method should add two numbers");
	}

	@RepeatedTest(3)
	void testDivide() {
		assertThrows(ArithmeticException.class, () -> mathUtils.divide(1, 0), "Divide by zero should throw");
	}

	@Test
	@Disabled
	@DisplayName("TDD(Test Driven Developement) should not run")
	void testDisabled() {
		fail("This method should be disabled");
	}

}
