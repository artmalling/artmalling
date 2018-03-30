package common.util;


import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class Base64Util {
	 /**
     * Base64Encoding을 수행한다. binany in ascii out
     *
     * @param encodeBytes
     *            encoding할 byte array
     * @return encoding 된 String
     */
    public static String encode(byte[] encodeBytes) {

        BASE64Encoder base64Encoder = new BASE64Encoder();
        ByteArrayInputStream bin = new ByteArrayInputStream(encodeBytes);
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte[] buf = null;

        try {
            base64Encoder.encodeBuffer(bin, bout);
        } catch (Exception e) {
            e.printStackTrace();
        }
        buf = bout.toByteArray();

        return new String(buf).trim();
    }

    /**
     * Base64Decoding 수행한다. binany out ascii in
     *
     * @param strDecode
     *            decoding할 String
     * @return decoding 된 byte array
     */
    public static byte[] decode(String strDecode) {

        BASE64Decoder base64Decoder = new BASE64Decoder();
        ByteArrayInputStream bin = new ByteArrayInputStream(strDecode
                .getBytes());
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        byte[] buf = null;

        try {
            base64Decoder.decodeBuffer(bin, bout);
        } catch (Exception e) {
            e.printStackTrace();
        }

        buf = bout.toByteArray();

        return buf;
    }
}
