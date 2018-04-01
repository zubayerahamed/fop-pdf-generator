/**
 * 
 */
package com.coderslab.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.net.MalformedURLException;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import com.coderslab.service.PrintingService;

/**
 * @author Zubayer Ahamed
 *
 */
@Service
public class PrintingServiceImpl implements PrintingService{

	@Override
	public ByteArrayOutputStream transfromToPDFBytes(String xmlFile, String template, HttpServletRequest request) throws TransformerFactoryConfigurationError, TransformerException, FOPException, MalformedURLException {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		File file = new File(template);
		Source xslSrc = new StreamSource(file);
		StreamSource xmlSource = new StreamSource(new File(xmlFile));
		Transformer transformer = TransformerFactory.newInstance().newTransformer(xslSrc);
		if (transformer == null) {
			throw new TransformerException("File not found: " + template);
		}
		//for image path setting
		String serverPath = request.getSession().getServletContext().getRealPath("/");

		FopFactory fopFactory = FopFactory.newInstance();
		fopFactory.setBaseURL(serverPath);
		FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
		Fop fop = FopFactory.newInstance().newFop(MimeConstants.MIME_PDF, foUserAgent, out);
		// Make sure the XSL transformation's result is piped through to FOP
		Result res = new SAXResult(fop.getDefaultHandler());
		// Start the transformation and rendering process
		transformer.transform(xmlSource, res);
		return out;
	}

	@Override
	public ByteArrayOutputStream transfromToPDFBytes(Document document, String template, HttpServletRequest request) throws TransformerException, MalformedURLException, FOPException {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		File file = new File(template);
		Source xslSrc = new StreamSource(file);

		Transformer transformer = TransformerFactory.newInstance().newTransformer(xslSrc);

		String serverPath = request.getSession().getServletContext().getRealPath("/");
		FopFactory fopFactory = FopFactory.newInstance();
		fopFactory.setBaseURL(serverPath);
		FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

		Fop fop = FopFactory.newInstance().newFop(MimeConstants.MIME_PDF, foUserAgent, out);

		// Make sure the XSL transformation's result is piped through to FOP
		Result res = new SAXResult(fop.getDefaultHandler());
		// Start the transformation and rendering process
		transformer.transform(new DOMSource(document), res);
		return out;
	}

	@Override
	public ByteArrayOutputStream transfromToThermalBytes(Document document, String template) throws TransformerException {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		// Setup a buffer to obtain the content length
		Source xsltSrc = new StreamSource(this.getClass().getClassLoader().getResourceAsStream(template));
		Transformer transformer = TransformerFactory.newInstance().newTransformer(xsltSrc);
		// Start the transformation and rendering process
		transformer.transform(new DOMSource(document), new StreamResult(out));
		return out;
	}

}
