<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
<!--! File Name : cwx_pl_template.xsl ! -->
<!--! Description : P & L Template ! -->
<!--! Author : Mehedi Hasan ! -->
<!--! Date : 25-Apr-2011 ! -->
<!--! Copyright : Copyright (c) M.F. Systems, 2011 ! -->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ex="http://exslt.org/dates-and-times" extension-element-prefixes="ex" exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	<!-- =========================== -->
	<!-- root element: agent invoice -->
	<!-- =========================== -->

	<xsl:template match="InvoicePLReport">
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
			<xsl:apply-templates select="invoices" />
		</fo:root>
	</xsl:template>

	<!-- ================================= -->
	<!-- templates for invoice page -->
	<!-- ================================= -->
	<xsl:template match="invoices">
		<fo:page-sequence master-reference="document">
			<xsl:variable name="pageid" select="generate-id()" />
			<!-- page header -->
			<fo:static-content flow-name="header-first">
				<fo:block-container height="38mm" width="150mm" left="0mm" top="0mm" position="absolute">
					<xsl:call-template name="title" />
				</fo:block-container>
				<fo:block-container height="10mm" width="90mm" left="65mm" top="0mm" position="absolute">
					<xsl:call-template name="invoice_reference" />
				</fo:block-container>
				<fo:block-container height="7mm" width="28cm" left="0mm" top="30mm" position="absolute">
					<xsl:call-template name="page_header" />
				</fo:block-container>
			</fo:static-content>

			<fo:flow flow-name="xsl-region-body">
				<fo:table table-layout="fixed">
					<fo:table-column column-width="28cm" />
					<fo:table-body>
						<xsl:for-each select="node()">
							<xsl:choose>
								<xsl:when test="name()='invoice'">
									<fo:table-row keep-together="always">
										<fo:table-cell>
											<fo:block>
												<xsl:call-template name="job" />
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:when>
								<!--<xsl:when test="name()='group_summary'"> <fo:table-row keep-together="always"> <fo:table-cell> <fo:block> <xsl:call-template name="group_summary"/> </fo:block> </fo:table-cell> </fo:table-row> </xsl:when> -->
							</xsl:choose>
						</xsl:for-each>
					</fo:table-body>
				</fo:table>

				<xsl:if test="position() = last()">
					<fo:block font-size="8pt" font-weight="bold">
						<xsl:call-template name="invoice_summary" />
					</fo:block>
				</xsl:if>

				<fo:block id="{$pageid}" />
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>


	<!-- ================================= -->
	<!-- Invoice title -->
	<!-- ================================= -->
	<xsl:template name="title">
		<fo:block font-size="11pt" font-weight="bold">
			<fo:block>INVOICE PROFIT REPORT</fo:block>
			<fo:block>
				FOR INVOICES RUN FROM
				<xsl:value-of select="/InvoicePLReport/Info/fromDate" />
				To
				<xsl:value-of select="/InvoicePLReport/Info/toDate" />
			</fo:block>
		</fo:block>
		<fo:block font-size="10pt" space-before="10pt" font-weight="bold">
			<fo:block>
				Page : &#160;&#160;
				<fo:page-number></fo:page-number>
			</fo:block>
			<fo:block>
				Printed : &#160;
				<xsl:value-of select="/InvoicePLReport/Info/currentDate" />
				&#160;&#160;&#160;
				<xsl:value-of select="/InvoicePLReport/Info/currentTime" />
			</fo:block>
		</fo:block>
	</xsl:template>


	<!-- ================================= -->
	<!-- invoice references -->
	<!-- ================================= -->
	<xsl:template name="invoice_reference">
		<fo:block font-size="10pt" font-weight="bold">
			<fo:table table-layout="fixed">
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="40mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block>Station : </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>LHR</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- ================================= -->
	<!-- page header -->
	<!-- ================================= -->
	<xsl:template name="page_header">
		<fo:block font-size="9pt" font-weight="bold" border-bottom=".3mm" border-color="black">
			<fo:table table-layout="fixed" padding="0.5pt">
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="45mm" />
				<fo:table-column column-width="19mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="18mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="12mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000" text-align="left">
							<fo:block>Invoice</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000" text-align="left">
							<fo:block>Account</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000" text-align="left">
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Total</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Surcharge</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Nett</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Disc</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>VAT</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Gross</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Linehaul</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Del Cost</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>Profit</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-bottom="1pt solid #000000">
							<fo:block>%</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- ================================= -->
	<!-- templates for invoice line -->
	<!-- ================================= -->
	<xsl:template name="job">
		<fo:block font-size="9pt">
			<fo:table table-layout="fixed">
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="45mm" />
				<fo:table-column column-width="19mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="18mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="12mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="text.data" text-align="left">
							<fo:block>
								<xsl:value-of select="invoiceno" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" text-align="left">
							<fo:block>
								<xsl:value-of select="clientcode" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" text-align="left">
							<fo:block>
								<xsl:value-of select="clientname" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="total" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="surcharge" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="nett" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="discount" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="vat" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="gross" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="linhl" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="del" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="profit" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data">
							<fo:block>
								<xsl:value-of select="profitPrcnt" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<!-- ================================ -->
	<!-- invoice summary -->
	<!-- ================================ -->
	<xsl:template name="invoice_summary">
		<fo:block font-size="9pt" font-weight="bold" border-bottom=".3mm" border-color="black" padding-top="1mm">
			<fo:table table-layout="fixed" padding="0.5pt">
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="45mm" />
				<fo:table-column column-width="19mm" />
				<fo:table-column column-width="25mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="15mm" />
				<fo:table-column column-width="18mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="20mm" />
				<fo:table-column column-width="12mm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//total), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//surcharge), "##.##")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//nett), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//discount), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//vat), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//gross), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//linhl), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//del), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//profit), "#.00")' />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="text.data" border-top="1pt solid #000000">
							<fo:block>
								<xsl:value-of select='format-number(sum(//profit)*100 div (sum(//nett)-sum(//disc)),"#.00")' />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>


	<xsl:attribute-set name="text.header">
		<xsl:attribute name="font-size">9pt</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="display-align">before</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="text.data">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="display-align">before</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
	</xsl:attribute-set>


</xsl:stylesheet>
