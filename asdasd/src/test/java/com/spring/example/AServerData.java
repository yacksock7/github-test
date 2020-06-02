package com.spring.example;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;


public class AServerData {
	public static void main (String[] agrs) throws IOException{
		Scanner input = new Scanner(System.in);
		ServerSocket server = new ServerSocket(12345);
		System.out.println("접속을 기다립니다.");
		Socket sock =server.accept();
		InetAddress inetaddr = sock.getInetAddress();
		System.out.println(inetaddr.getHostAddress()+"로 부터 접속 했습니다.");
		System.out.println(sock.getInetAddress()+"님이 접속했습니다.");
		
		InputStream in = sock.getInputStream();
		DataInputStream dis = new DataInputStream(in);
		String readData = dis.readUTF();
		
		System.out.println("수신 데이터 : " +readData);
		
		OutputStream out = sock.getOutputStream();
		DataOutputStream dos = new DataOutputStream(out);
		System.out.println("송신 문자열 입력 : ");
		String data = input.next();
		dos.writeUTF(data); 
		
		dis.close();
		in.close();
		sock.close();
		
		
	}
	
	

}
