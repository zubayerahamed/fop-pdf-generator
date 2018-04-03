/**
 * 
 */
package com.coderslab.service.impl;

import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.assertj.core.util.Strings;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.coderslab.model.Email;
import com.coderslab.service.EmailService;

/**
 * @author Zubayer Ahamed
 *
 */
@Service
public class EmailServiceImpl implements EmailService{
	
	private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);
	private static final String EMAIL_REGEX = "^[a-zA-Z0-9_!#$%&.*+/=?`{|}~^-]+(?:\\.[a-zA-Z0-9_!#$%&.*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+(?!web)[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])*$";

	@Override
	public boolean sendEmail(Email email) {
		return false;
	}

	@Override
	public boolean sendEmail(Email email, String templateContent) {
		if(Strings.isNullOrEmpty(templateContent)) return sendEmail(email);
		
		return false;
	}

	@Override
	public boolean sendEmail(Email email, String templateContent, Map<String, Object> context) {
		if(context.isEmpty()) return sendEmail(email, templateContent);
		
		return false;
	}

	@Override
	public boolean sendEmail(String to, String subject, String body) {
		return false;
	}

	@Override
	public boolean sendEmail(String to, String replyTo, String subject, String body) {
		return false;
	}

	@Override
	public boolean sendEmail(String to, String cc, String bcc, String replyTo, String subject, String body) {
		return false;
	}

	@Override
	public boolean validate(String emails) {
		if(Strings.isNullOrEmpty(emails)) return false;
		emails = emails.indexOf(';') != -1 ? emails.replace(';', ',') : emails;
		Pattern pattern = Pattern.compile(EMAIL_REGEX);
		String[] emailsArray = emails.split(",");
		for(String email : emailsArray) {
			if(Strings.isNullOrEmpty(email)) continue;
			Matcher matcher = pattern.matcher(email);
			if(!matcher.matches()) return false;
		}
		return true;
	}

}
