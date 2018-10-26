<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<!--! ! -->
<!--! File Name : bluesky_hawb_template.xsl ! -->
<!--! Description : Bluesky AWB template (customized) ! -->
<!--! Author : Ahsan ! -->
<!--! Date : 11-Feb-2015 ! -->
<!--! Copyright : Copyright (c) M.F. Systems, 2015 ! -->
<!--! ! -->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo"
	xmlns:java="com.metafour.netcourier.util.FopHelper"
	extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0"
		omit-xml-declaration="no" indent="yes" />
	<!-- ========================= -->
	<!-- root element: statement -->
	<!-- ========================= -->
	<xsl:template match="netc">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4"
					page-height="29.02cm" page-width="21cm" margin-top="4mm"
					margin-bottom="0mm" margin-left="10mm" margin-right="10mm">
					<fo:region-body margin-top="0mm" margin-left="0mm"
						margin-right="0mm" margin-bottom="0mm" />
					<fo:region-before extent="0mm" />
					<fo:region-after extent="0mm" />
				</fo:simple-page-master>
				<fo:page-sequence-master
					master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference
							page-position="first" master-reference="A4" />
						<fo:conditional-page-master-reference
							page-position="rest" master-reference="A4" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="document">
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container width="21cm" left="0mm"
						top="0mm" position="absolute">
						<xsl:call-template name="hawb" />
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template name="hawb">
		<fo:block-container height="25mm" width="180mm"
			left="10mm" top="12mm" position="absolute">
			<xsl:call-template name="awb" />
		</fo:block-container>
		<!-- <fo:block-container height="8mm" width="73mm" left="1.2mm" top="27.5mm" 
			position="absolute"> <xsl:call-template name="title"/> </fo:block-container> 
			<fo:block-container height="26mm" width="72mm" left="125mm" top="2mm" position="absolute"> 
			<xsl:call-template name="awb_info"/> </fo:block-container> <fo:block-container 
			height="26mm" width="31mm" left="67mm" top="2mm" position="absolute"> <xsl:call-template 
			name="other_info"/> </fo:block-container> <fo:block-container height="26mm" 
			width="25mm" left="99mm" top="2mm" position="absolute"> <xsl:call-template 
			name="pieces"/> </fo:block-container> -->

		<fo:block-container height="10mm" width="190mm"
			left="0mm" top="0mm" position="absolute">
			<xsl:call-template name="header" />
		</fo:block-container>

		<fo:block-container height="10mm" width="190mm"
			left="0mm" top="42mm" position="absolute">
			<xsl:call-template name="sender_receiver" />
		</fo:block-container>

		<fo:block-container height="100mm" width="90mm"
			left="0mm" top="52mm" position="absolute">
			<xsl:call-template name="sender" />
		</fo:block-container>

		<fo:block-container height="100mm" width="95mm"
			left="95mm" top="52mm" position="absolute">
			<xsl:call-template name="receiver" />
		</fo:block-container>

		<fo:block-container height="20mm" width="95mm"
			left="0mm" top="150mm" position="absolute">
			<xsl:call-template name="item_details" />
		</fo:block-container>

		<fo:block-container height="5mm" width="95mm"
			left="0mm" top="162mm" position="absolute">
			<xsl:call-template name="items_value" />
		</fo:block-container>

		<fo:block-container height="35mm" width="190mm"
			left="0mm" top="172mm" position="absolute">
			<xsl:call-template name="items_description" />
		</fo:block-container>

		<fo:block-container height="35mm" width="190mm"
			left="0mm" top="225mm" position="absolute">
			<xsl:call-template name="footer_with_logo" />
		</fo:block-container>

		<!--<fo:block-container height="20mm" width="60mm" left="0mm" top="82mm" 
			position="absolute"> <xsl:call-template name="job_details_prompt"/> </fo:block-container> -->

	</xsl:template>


	<!-- <xsl:template name="logo"> <fo:block> <xsl:variable name="imagepath" 
		select="concat('file:',/netc/hawb/image_path,'ateam_logo.jpg')"/> <fo:external-graphic 
		padding="0" margin="0" space-start="0" space-end="0" pause-before="0" pause-after="0" 
		content-height="39px" content-width="150px" scaling="non-uniform" src="{$imagepath}"/> 
		</fo:block> </xsl:template> -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- ! Template name : barcode (Barcode generator) ! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- ! Parameters used: ! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- ! awbn : number ! -->
	<!-- ! StartSoop value : true/false ! -->
	<!-- ! humanReadable value : true/false ! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- ! Example ! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- ! <xsl:call-template name="barcode"> ! -->
	<!-- ! <xsl:with-param name="awbn">123456</xsl:with-param> ! -->
	<!-- ! <xsl:with-param name="startStop">true</xsl:with-param> ! -->
	<!-- ! <xsl:with-param name="humanReadable">true</xsl:with-param> ! -->
	<!-- ! </xsl:call-template> ! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="barcode">
		<xsl:param name="awbn" />
		<xsl:param name="startStop" />
		<xsl:param name="humanReadable" />
		<xsl:param name="barcodeHeight" />
		<fo:block>
			<fo:instream-foreign-object>
				<barcode:barcode
					xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$awbn}">
					<barcode:code39>
						<barcode:height>
							<xsl:value-of select="$barcodeHeight" />
							mm
						</barcode:height>
						<barcode:module-width>.95mm</barcode:module-width>
						<xsl:if test="$humanReadable != 'true'">
							<barcode:human-readable>none</barcode:human-readable>
						</xsl:if>
						<barcode:human-readable>
							<barcode:display-start-stop>
								<xsl:value-of select="$startStop" />
							</barcode:display-start-stop>
							<font-size>18pt</font-size>
						</barcode:human-readable>
					</barcode:code39>
				</barcode:barcode>
			</fo:instream-foreign-object>
		</fo:block>
		<fo:block font-weight="normal" font-size="14pt"
			text-align="center" padding-top="6pt" margin-right="9mm"
			margin-top="-2.5mm">
			<xsl:value-of select="/netc/hawb/cs_awbn" />
		</fo:block>
	</xsl:template>

	<xsl:template name="awb">
		<fo:block font-size="7pt">
			<fo:table table-layout="fixed">
				<fo:table-column column-width="180mm" />
				<fo:table-body>
					<fo:table-row height="25mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="180mm" />
								<!-- <fo:table-column column-width="62mm"/> -->

								<fo:table-body>
									<fo:table-row>

										<fo:table-cell>


											<fo:block display-align="center" font-size="9pt"
												color="black">
												<xsl:call-template name="barcode">
													<xsl:with-param name="awbn">
														<xsl:value-of select="/netc/hawb/cs_awbn" />
													</xsl:with-param>
													<xsl:with-param name="startStop">
														false
													</xsl:with-param>
													<xsl:with-param name="humanReadable">
														true
													</xsl:with-param>
													<xsl:with-param name="barcodeHeight">
														25
													</xsl:with-param>

												</xsl:call-template>


											</fo:block>

										</fo:table-cell>

									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>




	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! header !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="header">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="10mm">
						<fo:table-cell border="1pt solid black">
							<fo:table table-layout="fixed">
								<fo:table-column column-width="95mm" />
								<fo:table-column column-width="95mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">
												<xsl:value-of select="/netc/hawb/cs_awbn" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" margin-left="10pt"
												font-weight="bold" margin-top="6pt">
												Service:
												<xsl:value-of select="/netc/hawb/sl_desc" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>



	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! Sender and Receiver !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="sender_receiver">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="10mm">
						<fo:table-cell border="1pt solid black">
							<fo:table table-layout="fixed">
								<fo:table-column column-width="95mm" />
								<fo:table-column column-width="95mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Sender</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Receiver</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! Sender !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="sender">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="10mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="95mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">
												<xsl:value-of select="/netc/hawb/ca_cnam" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_adr1" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_adr2" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_adr3" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_adr4" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_co_desc" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_zpcd" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_phon" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/ca_emal" />
											</fo:block>



										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! Receiver !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="receiver">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="95mm" />
				<fo:table-body>
					<fo:table-row height="10mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="95mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">
												<xsl:value-of select="/netc/hawb/da_cnam" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_adr1" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_adr2" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_adr3" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_adr4" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_co_desc" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_zpcd" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_phon" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_mobl" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/da_emal" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of select="/netc/hawb/cs_drdt" />
											</fo:block>

											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="10pt">
												<xsl:value-of
													select="substring(/netc/hawb/cs_note,1,70)" />
											</fo:block>
										</fo:table-cell>

									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! item_details !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="item_details">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="10mm">
						<fo:table-cell border="1pt solid black">
							<fo:table table-layout="fixed">
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Total pieces</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt"
											background-color="black">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" color="white"
												font-weight="bold" margin-left="10pt" margin-top="6pt">Pieces #</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Height (cms)</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Width (cms)</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="15pt" font-weight="bold"
												margin-left="10pt" margin-top="6pt">Depth (cms)</fo:block>
										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! items_value !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="items_value">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="5mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-column column-width="38mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_nopg" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" font-size="12pt"
												background-color="black" color="white" font-weight="bold"
												margin-left="10pt" margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_awbn" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_awbn" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_awbn" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" font-size="12pt" font-weight="bold"
												margin-left="10pt" margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_awbn" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>




								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! items_description !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="items_description">
		<fo:block>
			<xsl:variable name="TOTAL_VALUE">
				<xsl:choose>
					<xsl:when
						test="/netc/hawb/totalProforma = '' or /netc/hawb/totalProforma = 0.00">
						<xsl:choose>
							<xsl:when test="/netc/hawb/cs_csv3 != 0.00">
								<xsl:value-of
									select='format-number(/netc/hawb/cs_csv3, "###,###.00")' />
							</xsl:when>
							<xsl:otherwise>
								0.00
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of
							select='format-number(/netc/hawb/totalProforma, "###,###.00")' />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="35mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="76mm" />
								<fo:table-column column-width="111mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt"
											background-color="black">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="center" color="white" font-size="19pt"
												font-weight="bold" margin-top="20pt">
												<xsl:value-of select="/netc/hawb/da_cocd" />
											</fo:block>
										</fo:table-cell>
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt"
												border="1px solid #000000" background-color="black"
												color="white" font-weight="bold" margin-left="1pt">
												&#160; &#160; Total Consignment Weight &#160; &#160; &#160;
												&#160; &#160;&#160; &#160; &#160; &#160; &#160;
												<xsl:value-of select="/netc/hawb/cs_twgt" />
											</fo:block>
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt"
												border="1px solid #000000" font-weight="bold"
												margin-left="1pt" margin-top="2pt">&#160; &#160; Declared currency
												&#160; &#160; &#160; &#160; &#160; &#160; &#160;
												&#160;&#160; &#160; &#160; &#160; &#160; Total value</fo:block>
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-left="1pt" margin-top="2pt">
												&#160; &#160; &#160; &#160; &#160; &#160;
												<xsl:value-of select="/netc/hawb/csv3_cucd" />
												&#160; &#160; &#160; &#160; &#160; &#160; &#160;
												&#160;&#160; &#160; &#160; &#160; &#160; &#160; &#160;
												&#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;
												<xsl:value-of select="$TOTAL_VALUE" />
											</fo:block>
										</fo:table-cell>

									</fo:table-row>

									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt" height=".1pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">DESCRIPTION OF GOODS</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="11pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cs_cont" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt"
											background-color="black">
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" height="20mm" color="white"
												font-size="12pt" font-weight="bold" margin-bottom="20pt">&#160;
												&#160; Client Reference</fo:block>

										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!-- !! footer_with_logo !! -->
	<!-- !!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template name="footer_with_logo">
		<fo:block>
			<fo:table table-layout="fixed">
				<fo:table-column column-width="190mm" />
				<fo:table-body>
					<fo:table-row height="35mm">
						<fo:table-cell>
							<fo:table table-layout="fixed">
								<fo:table-column column-width="76mm" />
								<fo:table-column column-width="111mm" />
								<fo:table-body>
									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="2pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_cnam" />
											</fo:block>
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_adr1" />
											</fo:block>
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_adr2" />
											</fo:block>
											<fo:block padding-top="4pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_adr3" />
											</fo:block>
										</fo:table-cell>

										<fo:table-cell padding-right="0pt">
											<fo:block text-align="bottom" margin-left="120pt">
												<xsl:variable name="imagepath"
													select="concat('file:',/netc/hawb/image_path,'DLS_Master.jpg')" />
												<fo:external-graphic padding="0"
													margin="0" space-start="0" space-end="0" pause-before="0"
													pause-after="0" content-height="80px" content-width="180px"
													scaling="non-uniform" src="{$imagepath}" />
											</fo:block>

										</fo:table-cell>
									</fo:table-row>

									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="2pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_adr4" />
											</fo:block>

											<fo:block padding-top="2pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												<xsl:value-of select="/netc/hawb/cr_zpcd" />
											</fo:block>

										</fo:table-cell>
									</fo:table-row>

									<fo:table-row text-align="left">
										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="2pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												Tel:
												<xsl:value-of select="/netc/hawb/cr_phon" />
											</fo:block>

										</fo:table-cell>

										<fo:table-cell padding-right="0pt">
											<fo:block padding-top="2pt" padding-bottom="2pt"
												text-align="left" font-size="12pt" font-weight="bold"
												margin-top="2pt">
												&#160; &#160; Carrier&#160; &#160; &#160; &#160;
												<xsl:value-of
													select="/netc/hawb/delivery_agent" />
												&#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; Date
												&#160; &#160; &#160; &#160;
												<xsl:value-of select="/netc/hawb/cs_bkdt" />
											</fo:block>

										</fo:table-cell>
									</fo:table-row>

								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! Attribute set / CSS ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:attribute-set name="text.box">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.header">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="background-color">#4771D5</xsl:attribute>
		<xsl:attribute name="color">#ffffff</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.rightWhite">
		<xsl:attribute name="border-right">1px solid #ffffff</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.all">
		<xsl:attribute name="border">1px solid #4771D5</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>