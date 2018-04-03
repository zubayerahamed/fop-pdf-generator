/**
 * @copyrights coderslab.bd.com
 */
package com.coderslab.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * @author Zubayer Ahamed
 *
 */
@Data
public class Email implements Serializable {
	/**
	 * Generated serial version UID
	 */
	private static final long serialVersionUID = -674619482635150033L;

	private long id;
	private String from;
	private String to;
	private String cc;
	private String bcc;
	private String subject;
	private String body;
	private Date sentDate;
	private Date reveiveDate;
	private boolean sentMail = false;
	private boolean docMail = false;
	private List<String> files;
	private String emailHost;
	private String username;
	private String password;
}
