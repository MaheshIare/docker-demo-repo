/**
 * 
 */
package com.docker.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author MAHESH
 *
 */
@RestController
@RequestMapping("/demo")
public class DockerDemoController {

	@GetMapping("/hello-world")
	@SuppressWarnings("rawtypes")
	public ResponseEntity<Map> helloWorld(){
		Map<String, Object> map = new HashMap<>();
		map.put("first-name", "Mahesh");
		map.put("middle-name", "Kumar");
		map.put("last-name", "Gutam");
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
}
