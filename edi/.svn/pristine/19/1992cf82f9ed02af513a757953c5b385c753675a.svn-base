package ecom.util;

import com.barcodelib.barcode.Linear;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Barcode {
    
    public void make(HttpServletRequest request, HttpServletResponse response, String Data) throws ServletException {
        try {
            if (Data.length() > 0) {
                Linear barcode = new Linear();
                barcode.setType(Linear.CODE39);
                barcode.setData(Data);
            
                response.setContentType("image/gif");
                ServletOutputStream servletoutputstream = response.getOutputStream();
     
                barcode.renderBarcode(servletoutputstream);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
