package com.citiustech.example;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class StudentExampleTest {
	
	StudentExample example;
	
	@BeforeEach
	public void inIt() {
		example = new StudentExample();
	}
	
	@Test
	public void testAdd() {
		example.add("Kim");
		example.add("Jason");
		example.add("Mary");
		example.add("Michael");
		example.add("John");
		
		assertEquals(5, example.sizeOfStudents(), "Adding 5 Students to list");
	}
	
	@Test
	public void testSize() {
		example.add("Kim");
		example.add("Jason");
		example.add("Mary");
		assertEquals(3, example.sizeOfStudents(), "Checking size of list");
	}
	
	@Test
	public void testRemove() {
		example.add("Kim");
		example.add("Jason");
		example.add("Mary");
		example.remove("Jason");
		assertEquals(2, example.sizeOfStudents(), "Removing 1 element from list");
	}
	
	@Test
	public void testRemoveAll() {
		example.removeAll();
	}
}
