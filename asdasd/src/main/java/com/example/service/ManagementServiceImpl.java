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

import com.example.dao.ManagementDAO;
import com.example.dto.CustomVO;
import com.example.dto.GoodsVO;
import com.example.dto.ManagementVO;
import com.example.dto.UserVO;

@Service
public class ManagementServiceImpl implements ManagementService{
	@Inject
	ManagementDAO m_dao;

	@Override
	public List<ManagementVO> selectManagement(Map map) {
		// TODO Auto-generated method stub
		return m_dao.selectManagement(map);
	}

	@Override
	public List<UserVO> selectMngReseller(Map map) {
		// TODO Auto-generated method stub
		return m_dao.selectMngReseller(map);
	}

	@Override
	public List<CustomVO> selectMngCustomer(Map map) {
		// TODO Auto-generated method stub
		return m_dao.selectMngCustomer(map);
	}

	@Override
	public List<GoodsVO> selectMngGoods(Map map) {
		// TODO Auto-generated method stub
		return m_dao.selectMngGoods(map);
	}

	@Override
	public void goods_managementExcel(HttpServletResponse response, List<GoodsVO> t_GoodsList) throws IOException {
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("상품별 매출조회");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;


        // 열 폭 수정
        sheet.setColumnWidth(1, 4000);
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
        cell.setCellValue("상품번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("상품명");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("판매량");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("매출");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("순이익");
        
        // 데이터 부분 생성
        for(GoodsVO vo : t_GoodsList) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getGoods_no());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getGoods_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_qty());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_price());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_margin());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Total_Sales_Revenue(Goods).xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();
		
	}

	@Override
	public void reseller_managementExcel(HttpServletResponse response, List<UserVO> t_RsellerList) throws IOException {
		
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("리셀러별 매출조회");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;


        // 열 폭 수정
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
        cell.setCellValue("리셀러 ID");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("리셀러명");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("판매량");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("매출");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("마진");
        
        // 데이터 부분 생성
        for(UserVO vo : t_RsellerList) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getOffice_id());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getManager());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_qty());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_price());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_margin());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Aether_Goods_List.xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();	
	}

	@Override
	public void custom_managementExcel(HttpServletResponse response, List<CustomVO> t_CustomerList) throws IOException {
		
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("고객별 매출조회");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;

        // 열 폭 수정
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
        cell.setCellValue("고객번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("고객명");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("판매량");
        
        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("매출");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("마진");

        cell = row.createCell(5);
        cell.setCellStyle(headStyle);
        cell.setCellValue("담당자");
        
        // 데이터 부분 생성
        for(CustomVO vo : t_CustomerList) {
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_id());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_qty());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_price());

            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getT_margin());

            cell = row.createCell(5);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getManager_nm());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Total_Sales_Revenue(Custmoer).xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();		
		
		
	}

	@Override
	public int r_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return m_dao.r_PagingCountMng(map);
	}

	@Override
	public int c_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return m_dao.c_PagingCountMng(map);
	}

	@Override
	public int g_PagingCountMng(Map map) {
		// TODO Auto-generated method stub
		return m_dao.g_PagingCountMng(map);
	}



}
