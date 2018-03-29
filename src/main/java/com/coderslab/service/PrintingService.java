package com.coderslab.service;

import java.io.ByteArrayOutputStream;
import java.net.MalformedURLException;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactoryConfigurationError;

import org.apache.fop.apps.FOPException;
import org.springframework.stereotype.Component;

/**
 * @author Zubayer Ahamed
 *
 */
@Component
public interface PrintingService {

	/**
	 * Transform any document object to Byte Array output Stream for print
	 * @param xmlFile
	 * @param template
	 * @param request
	 * @return ByteArrayOutputStream
	 * @throws TransformerFactoryConfigurationError
	 * @throws TransformerException
	 * @throws FOPException
	 * @throws MalformedURLException 
	 */
	public ByteArrayOutputStream transfromToPDFBytes(String xmlFile, String template, HttpServletRequest request)
			throws TransformerFactoryConfigurationError, TransformerException, FOPException, MalformedURLException;
}
