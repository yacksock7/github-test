package com.example.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.example.dao.DealDAO;
import com.example.dao.GoodsDAO;
import com.example.dto.DealVO;
import com.example.dto.GoodsVO;

@Service
public class GoodsServiceImpl implements GoodsService {
	
	  @Inject
	    private GoodsDAO g_dao;
	   
	   
	@Override
	public List<GoodsVO> selectGoods(Map map) throws Exception {
		return g_dao.selectGoods(map);
	}


	@Override
	public int InsertGoods(Map map) {
		// TODO Auto-generated method stub
		return g_dao.insertGoods(map);
	}


	@Override
	public int updateGoods(Map map) {
		// TODO Auto-generated method stub
		return g_dao.updateGoods(map);
	}


	@Override
	public void goodsExcel(HttpServletResponse response, List<GoodsVO> goodsList) throws IOException {

		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("제품 명단");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;

        // 열 폭 수정
        sheet.setColumnWidth(1, 4000);
        sheet.setColumnWidth(2, 4000);
        sheet.setColumnWidth(3, 4000);
        sheet.setColumnWidth(4, 4000);
        
        // 테이블 헤더용 스타일
        CellStyle headStyle = wb.createCellStyle();
        // 가는 경계선을 가집니다.
        headStyle.setBorderTop(BorderStyle.THIN);
        headStyle.setBorderBottom(BorderStyle.THIN);
        headStyle.setBorderLeft(BorderStyle.THIN);
        headStyle.setBorderRight(BorderStyle.THIN);

        
        // 배경색은 노란색입니다.
        headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
        headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        // 데이터는 가운데 정렬합니다.
        headStyle.setAlignment(HorizontalAlignment.CENTER);

        // 데이터용 경계 스타일 테두리만 지정
        CellStyle bodyStyle = wb.createCellStyle();
        bodyStyle.setBorderTop(BorderStyle.THIN);
        bodyStyle.setBorderBottom(BorderStyle.THIN);
        bodyStyle.setBorderLeft(BorderStyle.THIN);
        bodyStyle.setBorderRight(BorderStyle.THIN);
        bodyStyle.setAlignment(HorizontalAlignment.CENTER);

        // 헤더 생성
        row = sheet.createRow(rowNo++);
        cell = row.createCell(0);
        cell.setCellStyle(headStyle);
        cell.setCellValue("제품번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("제품");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("소비자가격");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("판매가격");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("제조회사");
        
        // 데이터 부분 생성
        for(GoodsVO vo : goodsList) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getGoods_no());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getGoods_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getUnit_price());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getSale_price());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getMake_company());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Aether_Goods_List.xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();
	}


	@Override
	public int PagingCountGoods(Map map) {
		// TODO Auto-generated method stub
		return g_dao.PagingCountGoods(map);
	}
		
	}







