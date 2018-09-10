package com.coderslab.service;

import java.io.ByteArrayOutputStream;
import java.net.MalformedURLException;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactoryConfigurationError;

import org.apache.fop.apps.FOPException;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;

/**
 * @author Zubayer Ahamed
 *
 */
@Component
public interface PrintingService {

	/**
	 * Transform XML file and XSL file to Byte Array output Stream for print
	 * @param xmlFile
	 * @param template
	 * @param request
	 * @return ByteArrayOutputStream
	 * @throws TransformerFactoryConfigurationError
	 * @throws TransformerException
	 * @throws FOPException
	 * @throws MalformedURLException 
	 */
	public ByteArrayOutputStream transfromToPDFBytes(String xmlFile, String template, HttpServletRequest request) throws TransformerFactoryConfigurationError, TransformerException, FOPException, MalformedURLException;

	/**
	 * Transform Document Object and XSL file to ByteArrayOutputStream for print
	 * @param document
	 * @param template
	 * @param request
	 * @return ByteArrayOutputStream
	 * @throws TransformerException
	 * @throws MalformedURLException
	 */
	public ByteArrayOutputStream transfromToPDFBytes(Document document, String template, HttpServletRequest request) throws TransformerException, MalformedURLException, FOPException;

	/**
	 * Transform Document Object and XSL file to ByteArrayOutputStream for print
	 * @param document
	 * @param template
	 * @return ByteArrayOutputStream
	 * @throws TransformerException
	 * @throws MalformedURLException
	 */
	public ByteArrayOutputStream transfromToThermalBytes(Document document, String template) throws TransformerException;

	/**
	 * Transform XML file and XSL file to Byte Array output Stream for print
	 * @param xmlFile
	 * @param template
	 * @param request
	 * @return ByteArrayOutputStream
	 * @throws TransformerException
	 */
	public ByteArrayOutputStream transfromToThermalBytes(String xmlFile, String template, HttpServletRequest request) throws TransformerFactoryConfigurationError, TransformerException, FOPException, MalformedURLException;
}
