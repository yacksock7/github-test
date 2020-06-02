package com.example.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import com.example.dao.ScheduleDAO;
import com.example.dto.GoodsVO;
import com.example.dto.SGVO;
import com.example.dto.ScheduleGoodsVO;
import com.example.dto.ScheduleGoodsVO.ScheduleGoodsList;
import com.example.dto.ScheduleVO;

@Service
public  class ScheduleServiceImpl implements ScheduleService{

	@Inject
	private ScheduleDAO s_dao;

	@Override
	public List<ScheduleVO> selectSchedule(Map map) {
		// TODO Auto-generated method stub
		return s_dao.selectSchedule(map);
	}

	@Override
	public int insertSchedule(Map map) {
		return s_dao.insertSchedule(map);
	}

	@Override
	public int updateSchedule(Map map) {
		return s_dao.updateSchedule(map);
	}

	@Override
	public int insertScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return s_dao.insertScheduleGoods(map);
	}

	@Override
	public ScheduleVO selectOneSchedule(Map map) {
		// TODO Auto-generated method stub
		return s_dao.selectOneSchedule(map);
	
	}

	@Override
	public List<SGVO> selectScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return s_dao.selectScheduleGoods(map);
	}

	@Override
	public int updateScheduleGoods(Map map) {
		// TODO Auto-generated method stub
		return s_dao.updateScheduleGoods(map);
	}

	@Override
	public void scheduleExcel(HttpServletResponse response, List<ScheduleVO> scheduleList) throws IOException {
		// TODO Auto-generated method stub
		// 워크북 생성
        Workbook wb = new HSSFWorkbook();
        Sheet sheet = wb.createSheet("영업 스케쥴");
        Row row = null;
        Cell cell = null;
        int rowNo = 0;
        
        // 열 폭 수정
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 7000);
        sheet.setColumnWidth(6, 4000);

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

//        //DATE형식 출력하기
//    	SimpleDateFormat fommatter = new SimpleDateFormat("yyyyMMdd");
//		data = fommatter.format(cell.getDateCellValue()); 
     		
     		
        
        // 헤더 생성
        row = sheet.createRow(rowNo++);
        cell = row.createCell(0);
        cell.setCellStyle(headStyle);
        cell.setCellValue("스캐쥴 번호");

        cell = row.createCell(1);
        cell.setCellStyle(headStyle);
        cell.setCellValue("리셀러");

        cell = row.createCell(2);
        cell.setCellStyle(headStyle);
        cell.setCellValue("고객");

        cell = row.createCell(3);
        cell.setCellStyle(headStyle);
        cell.setCellValue("메모");
        
        cell = row.createCell(4);
        cell.setCellStyle(headStyle);
        cell.setCellValue("미팅날짜");
        
        cell = row.createCell(5);
        cell.setCellStyle(headStyle);
        cell.setCellValue("제품수량");
        
        cell = row.createCell(6);
        cell.setCellStyle(headStyle);
        cell.setCellValue("판매금액");
        
        // 데이터 부분 생성
        for(ScheduleVO vo : scheduleList) {
        	// 데이터 포멧터
     		DataFormatter formatter = new DataFormatter();
     		// 데이트 포맷
     		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
     		
            row = sheet.createRow(rowNo++);
            cell = row.createCell(0);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getSchedule_no());
            
            cell = row.createCell(1);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getReseller_nm());

            cell = row.createCell(2);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getCustomer_nm());
            
            cell = row.createCell(3);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getMemo());
            
            cell = row.createCell(4);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getSchedule_dt());
            cell.setCellValue(sdf.format(cell.getDateCellValue()));
            
            cell = row.createCell(5);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getTotal_qty());

            cell = row.createCell(6);
            cell.setCellStyle(bodyStyle);
            cell.setCellValue(vo.getTotal_price());
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
        response.setHeader("Content-Disposition", "attachment;filename=Aether_Schedule_List.xls");

        // 엑셀 출력
        wb.write(response.getOutputStream());
        wb.close();
		
	}

	@Override
	public int PagingCountSchedule(Map map) {
		// TODO Auto-generated method stub
		return s_dao.PagingCountSchedule(map);
	}

}
