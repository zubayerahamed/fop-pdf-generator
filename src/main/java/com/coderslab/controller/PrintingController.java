package com.coderslab.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.net.MalformedURLException;
import java.net.URISyntaxException;

import javax.servlet.http.HttpServletRequest;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactoryConfigurationError;

import org.apache.fop.apps.FOPException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coderslab.service.PrintingService;

/**
 * @author Zubayer Ahamed
 *
 */
@Controller
@RequestMapping("/print")
public class PrintingController {

	private static final Logger logger = LoggerFactory.getLogger(PrintingController.class);

	@Autowired private PrintingService printingService;

	@GetMapping
	public String loadfirstpage() {
		return "redirect:/";
	}

	@GetMapping("/{xmlFileName}/{xslTemplateName}/")
	public ResponseEntity<byte[]> printDxFreight(@PathVariable("xmlFileName") String xmlFileName, @PathVariable("xslTemplateName") String xslTemplateName, HttpServletRequest request) throws TransformerFactoryConfigurationError, TransformerException, FOPException, MalformedURLException{
		String message;
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(new MediaType("text", "html"));
		headers.add("X-Content-Type-Options", "nosniff");

		StringBuilder template = null;
		try {
			template = new StringBuilder(this.getClass().getClassLoader().getResource("static").toURI().getPath())
					.append(File.separator).append("xsl").append(File.separator)
					.append(xslTemplateName);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		if (template == null) {
			message = "No Template found";
			return new ResponseEntity<>(message.getBytes(), headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		StringBuilder xmlFile = null;
		try {
			xmlFile = new StringBuilder(this.getClass().getClassLoader().getResource("static").toURI().getPath())
					.append(File.separator).append("xml").append(File.separator)
					.append(xmlFileName);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}
		if (xmlFile == null) {
			message = "XML not found";
			return new ResponseEntity<>(message.getBytes(), headers, HttpStatus.INTERNAL_SERVER_ERROR);
		}

		byte[] byt = null;
		ByteArrayOutputStream out = null;
		out = printingService.transfromToPDFBytes(xmlFile.toString(), template.toString(), request);

		if (out == null) {
			message = "Can't generate PDF to print";
			byt = message.getBytes();
		} else {
			byt = out.toByteArray();
			headers.setContentType(new MediaType("application", "pdf"));
		}
		return new ResponseEntity<>(byt, headers, HttpStatus.OK);
	}
}
