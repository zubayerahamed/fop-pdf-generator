/**
 * 
 */
package com.coderslab.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import com.coderslab.model.Student;

/**
 * @author Zubayer
 *
 */
@RestController
@RequestMapping("/createxml")
public class XMLGenerateController {
	
	private static final String XML_DIR = "src//main//resources//static//xml//";
	
	// utility method to create text node
	private Node getStudentElements(Document doc, String name, String value) {
		Element node = doc.createElement(name);
		node.appendChild(doc.createTextNode(value));
		return node;
	}

	private Node getStudent(Document doc, Student student) {
		Element st = doc.createElement("student");
		// create id element
		st.appendChild(getStudentElements(doc, "id", String.valueOf(student.getId())));
		// create name element
		st.appendChild(getStudentElements(doc, "name", student.getName()));
		// create gender element
		st.appendChild(getStudentElements(doc, "email", student.getEmail()));

		return st;
	}

	@RequestMapping
	public Document xmlpage() throws ParserConfigurationException, TransformerException {
		List<Student> list = new ArrayList<>();
		for (int i = 0; i <= 10; i++) {
			list.add(new Student(i, "name" + i, "name@metafour.com"));
		}
		return generateXML(list);
	}

	public Document generateXML(List<Student> students) throws ParserConfigurationException, TransformerException {
		DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
		Document doc = documentBuilder.newDocument();

		// add elements to Document
		Element rootElement = doc.createElement("students");
		doc.appendChild(rootElement);

		for (Student student : students) {
			rootElement.appendChild(getStudent(doc, student));
		}

		// for output to file, console
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		// for pretty print
		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		DOMSource source = new DOMSource(doc);
		// write to file
		StreamResult file = new StreamResult(new File(XML_DIR + "//student.xml"));
		// write data
		transformer.transform(source, file);

		return doc;
	}
	
}
