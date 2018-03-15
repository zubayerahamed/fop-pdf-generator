<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<!--! File Name : standard_thirteen_week_trade_report.xsl ! -->
<!--! Description : 13 Week Trade Report ! -->
<!--! Author : Zubayer Ahamed ! -->
<!--! Date : 16-Mar-2018 ! -->
<!--! Copyright : Copyright (c) M.F. Systems, 2018 ! -->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ex="http://exslt.org/dates-and-times" extension-element-prefixes="ex"
	exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	<!-- =========================== -->
	<!-- root element: agent invoice -->
	<!-- =========================== -->

	<xsl:template match="thirteenWeekTradeReport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="firstmaster" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="3.6cm" margin-bottom="2cm" />
					<fo:region-before region-name="header-first" extent="8cm" />
					<fo:region-after region-name="footer-last" extent="2cm" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="firstmaster" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="firstmaster" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<xsl:apply-templates select="reportClients" />
		</fo:root>
	</xsl:template>

	<xsl:template match="reportClients">
		<fo:page-sequence-master master-reference="document">
			<!-- page header -->
			<fo:static-content flow-name="header-first">
				<fo:block-container height="38mm" width="150mm" left="0mm" top="0mm" position="absolute">
					<xsl:call-template name="title" />
				</fo:block-container>
				<fo:block-container height="10mm" width="90mm" left="65mm" top="0mm" position="absolute">
					<!-- call reference -->
				</fo:block-container>
				<fo:block-container height="7mm" width="28cm" left="0mm" top="30mm" position="absolute">
					<!-- call page header -->
				</fo:block-container>
			</fo:static-content>
		</fo:page-sequence-master>
	</xsl:template>
	
	<!-- ================================= -->
	<!-- Invoice title -->
	<!-- ================================= -->
	<xsl:template name="title">
		<fo:block font-size="11pt" font-weight="bold">
			<fo:block>
				<xsl:value-of select="/thirteenWeekTradeReport/reportName" />
			</fo:block>
			<fo:block>
				FOR INVOICES RUN FROM
				<xsl:value-of select="/thirteenWeekTradeReport/fromDate" />
				To
				<xsl:value-of select="/thirteenWeekTradeReport/toDate" />
			</fo:block>
		</fo:block>
		<fo:block font-size="10pt" space-before="10pt" font-weight="bold">
			<fo:block>
				Page : &#160;&#160;
				<fo:page-number></fo:page-number>
			</fo:block>
			<fo:block>
				Printed : &#160;
				<xsl:value-of select="/thirteenWeekTradeReport/printDate" />
			</fo:block>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>