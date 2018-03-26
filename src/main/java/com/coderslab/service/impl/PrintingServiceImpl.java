/**
 * 
 */
package com.coderslab.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.FOPException;
import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.MimeConstants;
import org.springframework.stereotype.Service;

import com.coderslab.service.PrintingService;

/**
 * @author Zubayer Ahamed
 *
 */
@Service
public class PrintingServiceImpl implements PrintingService{

	@Override
	public ByteArrayOutputStream transfromToPDFBytes(String xmlFile, String template, HttpServletRequest request)
			throws TransformerFactoryConfigurationError, TransformerException, FOPException {
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

		FopFactory fopFactory = FopFactory.newInstance(new File(serverPath).toURI());
		FOUserAgent foUserAgent = fopFactory.newFOUserAgent();
		Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, foUserAgent, out);
		Result res = new SAXResult(fop.getDefaultHandler());
		transformer.transform(xmlSource, res);
		return out;
	}

}
