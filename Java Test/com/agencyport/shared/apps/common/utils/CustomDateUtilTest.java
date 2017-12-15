package com.agencyport.shared.apps.common.utils;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;

public class CustomDateUtilTest {
	
	private CustomDateUtil customDateUtil;

	@Before
	public void setUp() throws Exception {
		
	}

	@Test
	public void test() {
		assertEquals(customDateUtil.getOneYearOldDate("1990-08-25"), "08-25-1989");
	}
	

}
