<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : standard_driver_earnings_report.xsl        !-->
<!--!    Description  : Standard Driver Earnings Template          !-->
<!--!    Author       : Naim Murad                                 !-->
<!--!    Date         : 24-Sep-2019                                !-->
<!--!    Copyright    : Copyright (c) M.F. Systems, 2019           !-->
<!--!    Modified By  : Zubayer Ahamed   Date: 04-Oct-2019         !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<!-- ROOT TEMPLATE -->
	<xsl:template match="/">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

			<!-- PAGE LAYOUTS -->
			<fo:layout-master-set>
				<!-- FIRST PAGE RULES -->
				<fo:simple-page-master master-name="first" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="48mm" margin-bottom="1cm" />
					<fo:region-before region-name="header-first" extent="48mm" />
					<fo:region-after region-name="footer-all" extent="6mm" />
				</fo:simple-page-master>

				<!-- REST OF PAGE RULES -->
				<fo:simple-page-master master-name="rest" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="18mm" margin-bottom="1cm" />
					<fo:region-before region-name="header-rest" extent="18mm" />
					<fo:region-after region-name="footer-all" extent="6mm" />
				</fo:simple-page-master>

				<!-- PAGE DEFINATIONS -->
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference master-reference="first" page-position="first" />
						<fo:conditional-page-master-reference master-reference="rest" page-position="rest" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<!-- CALLING REPORT TEMPLATE -->
			<xsl:call-template name="report" />

		</fo:root>
	</xsl:template>

	<!-- REPORT TEMPLATE -->
	<xsl:template name="report">
		<xsl:call-template name="partial-report">
			<!-- CALLING PARTIAL-REPORT TEMPLATE WITH PASSIGN SOME VARIABLES -->
			<xsl:with-param name="start" select="0"/>
			<xsl:with-param name="length" select="7"/>
			<xsl:with-param name="max" select="count(DriverEarningsReport/datesWithinRange)"/>
		</xsl:call-template>
	</xsl:template>

	<!-- PARTIAL REPORT -->
	<xsl:template name="partial-report">
		<!-- CATCH AND DECLARE VARIABLES FROM ITS CALLING LOCATION -->
		<xsl:param name="start"/>
		<xsl:param name="length"/>
		<xsl:param name="max"/>

		<!-- PAGE GENERATED FROM HERE -->
		<fo:page-sequence master-reference="document">	
			<!-- FIRST PAGE HEADER DECLARATION -->
			<fo:static-content flow-name="header-first">
				<!-- FOR FIRST PAGE ONLY CALL TITLE TEMPLATE AND DECLARE  -->
				<xsl:call-template name="title"/>
				<fo:block-container left="0mm" padding-top="10pt" top="6mm" position="absolute">
					<xsl:call-template name="filter_field"/>
				</fo:block-container>

				<!-- CALLING TABLE HEADER -->
				<fo:block-container left="0mm" top="36mm" position="absolute">
					<xsl:call-template name="table-header">
						<xsl:with-param name="start" select="$start"/>
						<xsl:with-param name="length" select="$length"/>
						<xsl:with-param name="max" select="$max"/>
					</xsl:call-template>
				</fo:block-container>
			</fo:static-content>

			<!-- REST PAGES HEADER DECLARATION -->
			<fo:static-content flow-name="header-rest">
				<!-- CALLING TABLE HEADER -->
				<fo:block-container left="0mm" top="5.7mm" position="absolute">
					<xsl:call-template name="table-header">
						<xsl:with-param name="start" select="$start"/>
						<xsl:with-param name="length" select="$length"/>
						<xsl:with-param name="max" select="$max"/>
					</xsl:call-template>
				</fo:block-container>
			</fo:static-content>

			<!-- ALL PAGE FOOTER -->
			<fo:static-content flow-name="footer-all">
				<fo:block text-align="center" font-size="7pt">Page <fo:page-number/> of <fo:page-number-citation-last ref-id="end"/></fo:block>
			</fo:static-content>

			<!-- PAGE BODY AREA -->
			<fo:flow top="35mm" flow-name="xsl-region-body">
				<fo:block left="0mm" top="0mm">
					<!-- LOOP THROUGH EACH EARNINGS RESPONSE AND GENERATE TABLE -->
					<xsl:for-each select="DriverEarningsReport/earningsResponse">
						<!-- CALLING TABLE TEMPLATE WITH PASSING VARIABLES -->
						<xsl:call-template name="table-details">
							<xsl:with-param name="start" select="$start"/>
							<xsl:with-param name="length" select="$length"/>
							<xsl:with-param name="max" select="$max"/>
						</xsl:call-template>

						<!-- TOTAL PAGE COUNTER (GET THE LAST PAGE NUMBER) -->
						<xsl:if test="position() = last() and $start + $length &gt;= $max">
							<fo:block id="end"/>
						</xsl:if>
					</xsl:for-each> 
				</fo:block>
			</fo:flow>

		</fo:page-sequence>

		<!-- CONDITION ACTIVATED IF TABLE HAS EXTA COLUMN -->
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

	<!-- TITLE TEMPLATE -->
	<xsl:template name="title">
		<fo:block text-align="center" space-before.optimum="3pt" space-after.optimum="2pt" font-weight="bold">Driver earning report: <xsl:value-of select="DriverEarningsReport/reportName"/></fo:block>
	</xsl:template>

	<!-- FILTERED FIELDS -->
	<xsl:template name="filter_field">
		<fo:table font-size="8pt" table-layout="fixed">
			<fo:table-column column-width="8%"/>
			<fo:table-column column-width="1%"/>
			<fo:table-column column-width="91%"/>
			<fo:table-body>
				<!--BLANK SPACE-->
				<xsl:if test="DriverEarningsReport/startDate = ''">
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
				<xsl:if test="DriverEarningsReport/startDate != ''">
					<fo:table-row height="4mm" text-align="left" top="50mm">
						<fo:table-cell>
							<fo:block text-align="left"> Report period </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left"> : </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block text-align="left">&#160;&#160;&#160;&#160;&#160;<xsl:value-of select="DriverEarningsReport/startDate"/> &#160; to &#160;<xsl:value-of select="DriverEarningsReport/endDate"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</xsl:if>
			</fo:table-body>
		</fo:table>
	</xsl:template>

	<!-- TABLE HEADER TEMPLATE -->
	<xsl:template name="table-header">
		<xsl:param name="start"/>
		<xsl:param name="length"/>
		<xsl:param name="max"/>

		<fo:block>
			<fo:table table-layout="fixed" width="100%">

				<!-- TABLE HEADER -->
				<fo:table-header>
					<fo:table-row height="10.5mm">
						<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="left">
							<fo:block wrap-option="wrap">
								Driver name
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="right">
							<fo:block wrap-option="wrap">
								3rd most recent invoice
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="right">
							<fo:block wrap-option="wrap">
								2nd most recent invoice
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="right">
							<fo:block wrap-option="wrap">
								Most recent invoice
							</fo:block>
						</fo:table-cell>
						<xsl:for-each select="DriverEarningsReport/datesWithinRange[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
							<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="right">
								<fo:block wrap-option="wrap"><xsl:value-of select="text()"/></fo:block>
							</fo:table-cell>
						</xsl:for-each>
						<xsl:choose>
							<xsl:when test="$start + $length &gt;= $max">
								<fo:table-cell xsl:use-attribute-sets="table-header-style" vertical-align="top" text-align="right">
									<fo:block wrap-option="wrap">
										Total earned / <fo:inline xsl:use-attribute-sets="blue">Minimum earnings</fo:inline>
									</fo:block>
								</fo:table-cell>
							</xsl:when>
						</xsl:choose>
					</fo:table-row>	
				</fo:table-header>

				<!-- TABLE BLANK BODY -->
				<fo:table-body>
					<fo:table-row>
						<xsl:for-each select="(//node())[4 >= position()]">
							<fo:table-cell><fo:block></fo:block></fo:table-cell>
						</xsl:for-each>
						<xsl:for-each select="DriverEarningsReport/datesWithinRange[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">
							<fo:table-cell><fo:block></fo:block></fo:table-cell>
						</xsl:for-each>
						<xsl:choose>
							<xsl:when test="$start + $length &gt;= $max">
								<fo:table-cell><fo:block></fo:block></fo:table-cell>
							</xsl:when>
						</xsl:choose>
					</fo:table-row>
				</fo:table-body>

			</fo:table>
		</fo:block>
	</xsl:template>

	<!-- TABLE DATA TEMPLATE -->
	<xsl:template name="table-details">
		<xsl:param name="start"/>
		<xsl:param name="length"/>
		<xsl:param name="max"/>

		<fo:block font-size="10pt">
			<fo:table table-layout="fixed" width="100%">

				<!-- TABLE BODY WITH DATA -->
				<fo:table-body>
					<xsl:call-template name="table-body-template">
						<xsl:with-param name="start" select="$start"/>
						<xsl:with-param name="length" select="$length"/>
						<xsl:with-param name="max" select="$max"/>
					</xsl:call-template>
				</fo:table-body>

			</fo:table>
		</fo:block>
	</xsl:template>

	<!-- TABLE BODY -->
	<xsl:template name="table-body-template" select="DriverEarningsReport/earningsResponse">
		<xsl:param name="start"/>
		<xsl:param name="length"/>
		<xsl:param name="max"/>

		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="left">
				<fo:block wrap-option="wrap">
					<xsl:value-of select="driverName" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">
				<fo:block wrap-option="wrap">
					<xsl:value-of select="thirdMostRecent" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">
				<fo:block wrap-option="wrap">
					<xsl:value-of select="secondMostRecent" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">
				<fo:block wrap-option="wrap">
					<xsl:value-of select="mostRecent" />
				</fo:block>
			</fo:table-cell>
			<xsl:for-each select="dateWiseEarn[position() &gt;= $start + 1 and not(position() &gt; $start + $length)]">					
				<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">
					<fo:block wrap-option="wrap"><xsl:value-of select="text()"/></fo:block>
				</fo:table-cell>
			</xsl:for-each>
			<xsl:choose>
				<xsl:when test="$start + $length &gt;= $max">
					<fo:table-cell xsl:use-attribute-sets="data" vertical-align="top" text-align="right">
						<fo:block wrap-option="wrap">
							<xsl:choose>
								<xsl:when test="totalEarn &lt; minimumEarn"><fo:inline xsl:use-attribute-sets="red"><xsl:value-of select="totalEarn" /></fo:inline></xsl:when>
								<xsl:when test="totalEarn &gt;= minimumEarn"><fo:inline xsl:use-attribute-sets="green"><xsl:value-of select="totalEarn" /></fo:inline></xsl:when>
							</xsl:choose>
							<fo:inline> / </fo:inline> 
							<fo:inline xsl:use-attribute-sets="blue"><xsl:value-of select="minimumEarn"/></fo:inline>
						</fo:block>
					</fo:table-cell>
				</xsl:when>
			</xsl:choose>
		</fo:table-row>
	</xsl:template>

	<!-- STYLES ATTRIBUTES -->
	<xsl:attribute-set name="data">
		<xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="padding-left">2pt</xsl:attribute>
		<xsl:attribute name="padding-right">2pt</xsl:attribute>
		<xsl:attribute name="padding-top">2pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">2pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="table-header-style">
		<xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="padding-left">2pt</xsl:attribute>
		<xsl:attribute name="padding-right">2pt</xsl:attribute>
		<xsl:attribute name="padding-top">2pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">2pt</xsl:attribute>
		<xsl:attribute name="background-color">#DDD</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="blue">
		<xsl:attribute name="color">blue</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="red">
		<xsl:attribute name="color">red</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="green">
		<xsl:attribute name="color">green</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>