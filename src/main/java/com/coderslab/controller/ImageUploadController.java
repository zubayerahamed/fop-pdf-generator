/**
 * 
 */
package com.coderslab.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author cyclingbd007
 *
 */
@Controller
@RequestMapping("/image")
public class ImageUploadController {

	@GetMapping
	public String loadImageCropper() {
		return "image_cropper";
	}
}
