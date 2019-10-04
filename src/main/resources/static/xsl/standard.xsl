<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : standard_driver_earnings_report.xsl        !-->
<!--!    Description  : Standard Driver Earnings Template          !-->
<!--!    Author       : Naim Murad                                 !-->
<!--!    Date         : 24-Sep-2019                                !-->
<!--!    Copyright    : Copyright (c) M.F. Systems, 2019           !-->
<!--!    Modified By  :                  Date:                     !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="first" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="48mm" margin-bottom="1cm" />
					<fo:region-before region-name="header-first" extent="48mm" />
					<fo:region-after region-name="footer-all" extent="6mm" />
				</fo:simple-page-master>

				<fo:simple-page-master master-name="rest" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="12mm" margin-bottom="1cm" />
					<fo:region-before region-name="header-rest" extent="12mm" />
					<fo:region-after region-name="footer-all" extent="6mm" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="first" page-position="first" />
						<fo:conditional-page-master-reference master-reference="rest" page-position="rest" />
						<!-- <fo:conditional-page-master-reference master-reference="first" /> -->
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<xsl:call-template name="report" />
		</fo:root>
	</xsl:template>

	<!-- ========================= -->
	<!-- Jobs report title template      -->
	<!-- ========================= -->
	<xsl:template name="title">
		<fo:block text-align="center" space-before.optimum="3pt" space-after.optimum="2pt" font-weight="bold">Driver earning report: <xsl:value-of select="earningReport/reportName"/></fo:block>
	</xsl:template>

	<!-- ========================= -->
	<!-- Jobs Filter fields template -->
	<!-- ========================= -->
	<xsl:template name="filter_field">
		<fo:table font-size="8pt" table-layout="fixed">
			<fo:table-column column-width="8%"/>
			<fo:table-column column-width="1%"/>
			<fo:table-column column-width="91%"/>
			<fo:table-body>
				<!--BLANK SPACE-->
				<xsl:if test="earningReport/fromDate = ''">
					<fo:table-row height="4mm" text-align="left">
						<fo:table-cell>
							<fo:block text-align="left"> &#160;</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left"> : </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left"> : </fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
				
				<!--DATA-->
				<xsl:if test="earningReport/fromDate != ''">
					<fo:table-row height="4mm" text-align="left" top="50mm">
						<fo:table-cell>
							<fo:block text-align="left"> Report period </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left"> : </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left">&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="earningReport/fromDate"/> &#160; to &#160;<xsl:value-of select="earningReport/toDate"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
	<!-- ========================= -->
	<!-- Jobs Header template      -->
	<!-- ========================= -->
	<xsl:template name="report">			
		<xsl:call-template name="partial-report">
			<xsl:with-param name="start" select="0"/>
			<xsl:with-param name="length" select="12"/>
			<xsl:with-param name="max" select="count(earningReport/tableHeader/head)"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="partial-report">
		<xsl:param name="start"/>
		<xsl:param name="length"/>		
		<xsl:param name="max"/>
		
		<fo:page-sequence master-reference="document">	
			
			<fo:static-content flow-name="header-first">
				<xsl:call-template name="title"/>				
				<fo:block-container left="0mm" padding-top="10pt" top="6mm" position="absolute">
					<xsl:call-template name="filter_field"/>
				</fo:block-container>
				<fo:block-container left="0mm" top="39.5mm" position="absolute">					
					<xsl:call-template name="header">
						<xsl:with-param name="start" select="$start"/>
						<xsl:with-param name="length" select="$length"/>
						<xsl:with-param name="max" select="$max"/>
					</xsl:call-template>
				</fo:block-container>
			</fo:static-content>
			
			<fo:static-content flow-name="header-rest">
				<fo:block-container left="0mm" top="3.5mm" position="absolute">					
					<xsl:call-template name="header">
						<xsl:with-param name="start" select="$start"/>
						<xsl:with-param name="length" select="$length"/>
						<xsl:with-param name="max" select="$max"/>
					</xsl:call-template>
				</fo:block-container>
			</fo:static-content>
			
			<fo:static-content flow-name="footer-all">
				<fo:block text-align="center" font-size="7pt">Page <fo:page-number/> of <fo:page-number-citation-last ref-id="end"/></fo:block>
			</fo:static-content>
			
			
			<fo:flow top="35mm" flow-name="xsl-region-body">
				<fo:block left="0mm" top="0mm">					
					<xsl:for-each select="earningReport/tableData">										
						<xsl:call-template name="details">
							<xsl:with-param name="start" select="$start"/>
							<xsl:with-param name="length" select="$length"/>
							<xsl:with-param name="max" select="$max"/>
						</xsl:call-template>
						
						<!-- for last page -->
						<xsl:if test="position() = last() and $start + $length &gt;= $max">
							<fo:block id="end"/>
						</xsl:if>
					</xsl:for-each>					
				</fo:block>
			</fo:flow>			
			
		</fo:page-sequence>
						
		<xsl:choose>
			<xsl:when test="$start + $length &lt; $max">
				<xsl:call-template name="partial-report">
					<xsl:with-param name="start" select="$start + $length"/>
					<xsl:with-param name="length" select="$length"/>
					<xsl:with-param name="max" select="$max"/>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="header">
		<xsl:param name="start"/>
		<xsl:param name="length"/>		
		<xsl:param name="max"/>
		<fo:block>
			<fo:table table-layout="fixed" width="100%">
				<xsl:for-each select="earningReport/tableHeader/head[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
					<fo:table-column column-width="proportional-column-width(1)"/>
				</xsl:for-each>
				<fo:table-body>
					<fo:table-row height="12mm">
						<xsl:for-each select="earningReport/tableHeader/head[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
							<fo:table-cell xsl:use-attribute-sets="header" vertical-align="top" text-align="right">
								<fo:block wrap-option="wrap"><xsl:value-of select="text()"/></fo:block>
							</fo:table-cell>
						</xsl:for-each>
					</fo:table-row>	
				</fo:table-body>
			</fo:table>
		</fo:block>			
	</xsl:template>
	
	
	<xsl:template name="details">
		<xsl:param name="start"/>
		<xsl:param name="length"/>		
		<xsl:param name="max"/>
		
		<xsl:variable name="row_no" select="position()" />
		
		<fo:block  font-size="10pt">
			<fo:table table-layout="fixed" width="100%">
				<xsl:for-each select="earningReport/tableHeader/head[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
					<fo:table-column column-width="proportional-column-width(1)"/>
				</xsl:for-each>
				<fo:table-body>
					<fo:table-row>
						<xsl:for-each select="data[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
							<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">								
								<fo:block wrap-option="wrap"><xsl:value-of select="text()"/></fo:block>
							</fo:table-cell>
						</xsl:for-each>
					</fo:table-row>	
				</fo:table-body>
			</fo:table>						
		</fo:block>
		
	</xsl:template>
		
	<xsl:attribute-set name="data">
	  <xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
	  <xsl:attribute name="font-size">8pt</xsl:attribute>
	  <xsl:attribute name="padding-left">2pt</xsl:attribute>
	  <xsl:attribute name="padding-right">2pt</xsl:attribute>
	  <xsl:attribute name="padding-top">2pt</xsl:attribute>
	  <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
	</xsl:attribute-set>
		
	<xsl:attribute-set name="header">
	  <xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
	  <xsl:attribute name="font-size">8pt</xsl:attribute>
	  <xsl:attribute name="font-weight">bold</xsl:attribute>
	  <xsl:attribute name="padding-left">2pt</xsl:attribute>
	  <xsl:attribute name="padding-right">2pt</xsl:attribute>
	  <xsl:attribute name="padding-top">2pt</xsl:attribute>
	  <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>