/**
 * 
 */
package com.coderslab.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author zubayer
 *
 */
@Controller
@RequestMapping("/")
public class MainController {

	@GetMapping
	public String loadIndexPage() {
		return "index";
	}
}
