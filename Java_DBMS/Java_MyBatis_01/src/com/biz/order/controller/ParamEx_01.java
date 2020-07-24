package com.biz.order.controller;

import com.biz.order.model.OrderVO;

public class ParamEx_01 {

	public static void main(String[] args) {

		ParamTest pTest = new ParamTest();
		/*
		 * primitive 형 변수는 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 값을 변경해도 매개변수로 보낸 곳에서
		 * 원래 있던 값은 절대 변하지 않는다.
		 */
		int intNum1 = 3;
		int intNum2 = 4;
		System.out.printf("intNum1 : %d, intNum2 : %d\n", intNum1, intNum2);
		pTest.add(intNum1, intNum2);
		System.out.printf("intNum1 : %d, intNum2 : %d\n", intNum1, intNum2);
		
		
		/*
		 * Class 형 변수는 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 객체의 일부요소(필드변수)를 변경하면
		 * 보낸 곳의 원본 데이터가 변해 버린다.
		 */
		
		OrderVO oV = new OrderVO();
		System.out.println(oV.getO_pcode());
		pTest.add(oV);
		System.out.println(oV.getO_pcode());
		
		
		/*
		 * 배열을 다른 method에 매개변수로 전달했을 때
		 * 전달받은 method에서 배열의 일부요소 값을 변경하면 보낸 곳에 원본 배열도
		 * 데이터가 변해버린다.
		 */
		int[] intA = new int[3];
		System.out.println(intA[0]);
		pTest.add(intA);
		System.out.println(intA[0]);
		
		
		
		
		/*
		 * 객체나, 배열을 매개변수로 전달했을때
		 * 전달받은 method에서 새로(new) 객체나 배열을 생성하게 되면
		 * 원본 객체나, 배열과는 전혀 다른 대상이 된다.
		 * 따라서 아무리 전달 받은 method에서 값을 변경해도 원본의 값은 알 수 없다.
		 */
		System.out.println("================================================");
		System.out.println(oV.getO_pcode());
		pTest.add(oV);
		System.out.println(oV.getO_pcode());
		
		
		System.out.println(intA[0]);
		pTest.add(intA);
		System.out.println(intA[0]);
		
		
		
		
		
		
		
		
		
		
	}
}
