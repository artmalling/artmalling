package common.namo;

import java.io.*;
import java.lang.String;
import javax.mail.internet.MimeUtility;
import javax.mail.MessagingException;

public class CodeConverter
{
	/**
	 * convertString : 
	 */
	static String convertString(String src, String enc)
	{
		String converted = null;

		try
		{
			converted = new String(src.getBytes(), enc);
		}
		catch(UnsupportedEncodingException uee)
		{
			return null;
		}

		return converted;
	}

	static String convertString(byte [] src, String enc)
	{
		String converted = null;
		try
		{
			converted = new String(src, enc);
		}
		catch(UnsupportedEncodingException uee)
		{
			return null;
		}

		return converted;
	}

	/**
	 * MIME Encode 
	 */
	static String getMIMEEncodedString(String encoded)
	{
		String charset = null;
		String enctype = null;
		String content = null;
		String converted = null;
		byte [] convertsrc;
		int beginindex = 0;
		int endindex = 0;

		// is MIME Encoded word?
		if(encoded.charAt(0) == '=' && encoded.charAt(1) == '?')
		{
			beginindex = encoded.indexOf("?", endindex);
			endindex = encoded.indexOf("?", beginindex + 1);
			if(beginindex == -1 || endindex == -1)
				return null;
			charset = new String(encoded.substring(beginindex + 1, endindex));

			beginindex = endindex;
			endindex = encoded.indexOf("?", beginindex + 1);
			if(beginindex == -1 || endindex == -1)
				return null;
			enctype = new String(encoded.substring(beginindex + 1, endindex));
			if(enctype.equals("b"))
				enctype = "base64";

			beginindex = endindex;
			endindex = encoded.indexOf("?", beginindex + 1);
			if(beginindex == -1 || endindex == -1)
				return null;
			content = new String(encoded.substring(beginindex + 1, endindex));
		}

		if(charset != null && charset.length() > 0)
		{
			try
			{
				InputStream is = new ByteArrayInputStream(content.getBytes("iso-8859-1"));
				try
				{
					is = MimeUtility.decode(is, enctype);
				}
				catch(MessagingException moe)
				{
					return null;
				}
 				convertsrc = new byte[is.available() + 1];
				is.read(convertsrc);
			}
			catch(IOException ioe)
			{
				return null;
			}
			converted = convertString(convertsrc, charset).trim();
		}

		return converted;
	}

	// test
	static void main(String[] argv)
	{
		// 
		String test = new String("=?euc-kr?b?x9Gx2y5qcGc=?=");
		test = getMIMEEncodedString(test);
	}
};
