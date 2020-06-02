package com.example.service;

import java.io.IOException;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CustomDAO;
import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;

@Service
public class CustomServiceImpl implements CustomService {
	
    @Inject
    private CustomDAO c_dao;
    
	@Override
	public List<CustomVO> selectCustomer(Map map) throws Exception {
		
		return c_dao.selectCustomer(map);
	}
	
	@Override
	public int InsertCustomer(Map map) {
		return c_dao.insertCustomer(map);
	}

	@Override
	public int updateCustomer(Map map) {
		// TODO Auto-generated method stub
		return c_dao.updateCustomer(map);
	}

	@Override
	public void customExcel(HttpServletResponse response, List<CustomVO> customList) throws IOException {
		// TODO Auto-generated method stub
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("제품 명단");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;
        
        // 열 폭 수정
        sheet.setColumnWidth(2, 6000);
        sheet.setColumnWidth(3, 7000);

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
        cell.setCellValue("고객번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("이름");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("연락처");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("e-mail");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("담당자");
        
        // 데이터 부분 생성
        for(CustomVO vo : customList) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_id());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getTel_no());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getEmail());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getManager_nm());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Aether_Customer_List.xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();
	}

	@Override
	public int PagingCountCustom(Map map) {
		// TODO Auto-generated method stub
		return c_dao.PagingCountCustom(map);
	}

}
