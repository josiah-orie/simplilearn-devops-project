package com.simplilearn.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectController {

	@GetMapping("/")
	public String home() {
		return "index.html";

	}
}
