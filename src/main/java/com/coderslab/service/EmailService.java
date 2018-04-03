/**
 * 
 */
package com.coderslab.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.coderslab.model.Email;

/**
 * @author Zubayer Ahamed
 *
 */
@Service
public interface EmailService {

	/**
	 * Send Email
	 * @param email
	 * @return boolean
	 */
	public boolean sendEmail(Email email);

	public boolean sendEmail(Email email, String templateContent);

	public boolean sendEmail(Email email, String templateContent, Map<String, Object> context);

	public boolean sendEmail(String to, String subject, String body);

	public boolean sendEmail(String to, String replyTo, String subject, String body);

	public boolean sendEmail(String to, String cc, String bcc, String replyTo, String subject, String body);

	/**
	 * Validate Email addresses from Email's array
	 * @param emails
	 * @return boolean
	 */
	public boolean validate(String emails);

}
