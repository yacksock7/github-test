package com.spring.example;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class AClientData {
	public static void main(String[] agrs) throws UnknownHostException, IOException {
		Scanner input = new Scanner(System.in);
		Socket sock = new Socket("192.168.0.16",12345);
		//127.0.0.1 = 루프백 주소.
		OutputStream out = sock.getOutputStream();
		DataOutputStream dos = new DataOutputStream(out);
		
		
		System.out.println("송신 문자열 입력 : ");
		String data = input.next();
		dos.writeUTF(data);  // 데이터 보낼대 UTF로 보내겠다.
			
		InputStream in = sock.getInputStream();
		DataInputStream dis = new DataInputStream(in);
		String readData = dis.readUTF();
		System.out.println("수신 데이터 : " +readData);
		
		dos.close();
		out.close();
		sock.close();
	}

}



