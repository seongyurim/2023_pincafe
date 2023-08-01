package com.project.pincafe.file;

import java.io.File;
import java.io.IOException;

public class FileUploadUtil {

    public static void saveFile(FileVO vo) 
    {	
		File dirFile = new File(vo.getFilePath());
		
		if (false == dirFile.exists()) 
        {
			dirFile.mkdirs();
		}

        File file = new File(vo.getFilePath(), vo.getStoredName());
		
		try 
        {
            System.out.println("File Saved: " + file.getAbsolutePath());
			vo.getFile().transferTo(file);			
		}
		catch (IllegalStateException e) {
			e.printStackTrace();
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
    }    
}