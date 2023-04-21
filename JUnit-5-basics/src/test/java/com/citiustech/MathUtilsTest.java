package com.citiustech;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.RepeatedTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MathUtilsTest {

	MathUtils mathUtils;
	
	@BeforeAll
	void beforeAllInIt() {
		mathUtils = new MathUtils();
		System.out.println("This method needs run before Instance is created");
	}
	
	@BeforeAll
	void inIt() {
		
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

	@Test
	void testComputeCircleArea() {
		double expected = 314.1592653589793238462643;
		double actual = mathUtils.computeCircleArea(10);
		assertEquals(expected, actual, "Should return right circle area");
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
