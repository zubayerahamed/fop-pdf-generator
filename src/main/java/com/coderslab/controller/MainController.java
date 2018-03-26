package com.coderslab.controller;

import java.io.File;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.coderslab.model.XMLFile;
import com.coderslab.model.XSLFile;

/**
 * @author Zubayer Ahamed
 *
 */
@Controller
@RequestMapping("/")
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@GetMapping
	public String loadIndexPage(Model model) {
		
		try {
			StringBuilder xslPath = new StringBuilder(this.getClass().getClassLoader().getResource("static").toURI().getPath())
					.append(File.separator).append("xsl").append(File.separator);
			StringBuilder xmlPath = new StringBuilder(this.getClass().getClassLoader().getResource("static").toURI().getPath())
					.append(File.separator).append("xml").append(File.separator);

			File[] listOfXMLFiles = new File(xmlPath.toString()).listFiles();
			File[] listOfXSLFiles = new File(xslPath.toString()).listFiles();

			List<XMLFile> xmlFiles = new ArrayList<>();
			for(File file : listOfXMLFiles) {
				XMLFile xmlFile = new XMLFile();
				xmlFile.setCode(file.getName().replaceAll("_", " ").replaceAll(".xml", "").toUpperCase());
				xmlFile.setFileName(file.getName());
				xmlFiles.add(xmlFile);
			}

			List<XSLFile> xslFiles = new ArrayList<>();
			for(File file : listOfXSLFiles) {
				XSLFile xslFile = new XSLFile();
				xslFile.setCode(file.getName().replaceAll("_", " ").replaceAll(".xsl", "").toUpperCase());
				xslFile.setFileName(file.getName());
				xslFiles.add(xslFile);
			}

			model.addAttribute("xslFiles", xslFiles);
			model.addAttribute("xmlFiles", xmlFiles);
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
		}

		return "index";
	}
}
