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
import org.springframework.stereotype.Service;

import com.example.dao.CustomDAO;
import com.example.dao.DealDAO;
import com.example.dto.CustomVO;
import com.example.dto.DealVO;
import com.example.dto.ResellerVO;

@Service
public class DealServiceImpl implements DealService{

	   @Inject
	    private DealDAO d_dao;
	   
	@Override
	public List<DealVO> selectDeal(Map map) throws Exception {
		return d_dao.selectDeal(map);
	}

	@Override
	public int InsertDeal(Map map) {
		return d_dao.insertDeal(map);
	}

	@Override
	public int updateDeal(Map map) {
		return d_dao.updateDeal(map);
	}

	@Override
	public void excelDeal(HttpServletResponse response, List<DealVO> list) throws IOException {
       
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("거래 명단");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;

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
        cell.setCellValue("거래번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("고객");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("리셀러");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("상품");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("거래");

        cell = row.createCell(5);
        cell.setCellStyle(headStyle);
        cell.setCellValue("거래가격");
        
        cell = row.createCell(6);
        cell.setCellStyle(headStyle);
        cell.setCellValue("거래날짜");
        
        cell = row.createCell(7);
        cell.setCellStyle(headStyle);
        cell.setCellValue("메모");

        // 데이터 부분 생성
        for(DealVO vo : list) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getDeal_no());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getSeller_nm());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getGoods_nm());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getDeal_qty());

            cell = row.createCell(5);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getDeal_price());
            
            cell = row.createCell(6);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getDeal_dt());
            
            cell = row.createCell(7);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getMemo());
        }



        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Reseller_List.xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();
	}

	@Override
	public int updateStock(Map map) {
		return d_dao.updateStock(map);
	}
		
}


