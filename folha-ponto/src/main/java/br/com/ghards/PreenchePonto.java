package br.com.ghards;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileFilter;

import org.apache.commons.lang3.time.DateUtils;
import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

public class PreenchePonto {
  
	public static void main(String[] args) throws EncryptedDocumentException, IOException {
		
	    SimpleDateFormat sdf = new SimpleDateFormat();
	    Date date = new Date(System.currentTimeMillis());
	    sdf.applyPattern("MMMM");
	    final String monthName = sdf.format(date);

	    sdf.applyPattern("dd");
	    int day = Integer.parseInt(sdf.format(date));
	    
	    sdf.applyPattern("EEEE");
	    String dayName = sdf.format(date);
	    
	    sdf.applyPattern("HH:mm");
	    String startHourAndMinute = sdf.format(date);
	    System.out.println(startHourAndMinute);
	    
	    String endHourAndMinute = sdf.format(DateUtils.addHours(date, 1));
	    System.out.println(startHourAndMinute);
	    System.out.println(endHourAndMinute);
	    
	    File excelFile = null;
	    JFileChooser chooseFile = new JFileChooser();
		
	    chooseFile.setFileSelectionMode(JFileChooser.FILES_ONLY);
	    chooseFile.setFileFilter(new FileFilter() {
			
			@Override
			public String getDescription() {
				return "Excel Workbook";
			}
			
			@Override
			public boolean accept(File f) {
				if (f.isDirectory()) return true;
				if (f.getName().endsWith("xlsx")) {
					return true;
				}
				String fileName = f.getName().toLowerCase();
				if (fileName.contains(monthName) && fileName.contains("folha de ponto")) {
					return true;
				}
				return false;
			}
		});
	    
	    int chosenFile = chooseFile.showOpenDialog(null);
	    if (chosenFile == JFileChooser.APPROVE_OPTION) {
	    	excelFile = chooseFile.getSelectedFile();
	    }
	    
	    Workbook workbook = WorkbookFactory.create(excelFile);
	    Sheet firstSheet = workbook.getSheet(monthName);
	    String message = "";
	    Iterator<Row> rowIterator = firstSheet.rowIterator();
	    while (rowIterator.hasNext()) {
	    	
	    	Row row = rowIterator.next();
	    	Cell dayColumn = row.getCell(0);
	    	Cell dayNameColumn = row.getCell(1);
	    	
	    	try {
				if ((int) dayColumn.getNumericCellValue() == day) {
					row.getCell(3).setCellValue(startHourAndMinute);
					row.getCell(4).setCellValue(endHourAndMinute);
					message = "Horário de almoço de " + startHourAndMinute + " à " + endHourAndMinute + " adicionado com sucesso "
							+ "em " + dayName + " dia " + day + " de " + monthName;
				}
				
			} catch (Exception e) {}
	    }
	    
		String excelFilePath = excelFile.getAbsolutePath();		
		try (FileOutputStream fileOut = new FileOutputStream(excelFilePath + ".new")) {
		    workbook.write(fileOut);
		}
		Files.delete(Paths.get(excelFilePath));
		Files.move(Paths.get(excelFilePath + ".new"), Paths.get(excelFilePath));
	    
		workbook.close();
 
		new JOptionPane();
		JOptionPane.showMessageDialog(null, message);
	}
}