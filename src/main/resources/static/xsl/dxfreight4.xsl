<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">

	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="dxfreight">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="DXFREIGHTLABEL" page-width="102mm" page-height="102mm" margin-top="1mm" margin-bottom="1mm" margin-left="1mm" margin-right="1mm">
					<fo:region-body margin-top="0.25mm" margin-left="0.25mm" margin-right="0.25mm" margin-bottom="0.25mm" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="DXFREIGHTLABEL" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="DXFREIGHTLABEL" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="DXFREIGHTLABEL" xsl:use-attribute-sets="default.font.size">
				<fo:flow flow-name="xsl-region-body">
					<!-- 1st block -->
					<fo:block-container xsl:use-attribute-sets="text.center" left="0mm" width="65mm" height="10mm" reference-orientation="270" position="absolute">
						<fo:block font-size="30pt">
							<xsl:value-of select="serviceDescription" />
						</fo:block>
					</fo:block-container>

					<!-- 2nd block -->
					<fo:block-container xsl:use-attribute-sets="border.left border.right" left="10mm" width="89mm" height="65mm" position="absolute">
						<xsl:call-template name="header"></xsl:call-template>
						<xsl:call-template name="barcode"></xsl:call-template>
					</fo:block-container>

					<!-- 3rd block -->
					<fo:block-container xsl:use-attribute-sets="border.top" top="19mm" left="10mm" width="89mm" position="absolute">
						<xsl:call-template name="address"></xsl:call-template>
						<xsl:call-template name="hubcodeArea"></xsl:call-template>
						<xsl:call-template name="barcode_verticle"></xsl:call-template>
						<xsl:call-template name="depot_postcode_section"></xsl:call-template>
						<xsl:call-template name="customer_name"></xsl:call-template>
					</fo:block-container>

				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- header -->
	<xsl:template name="header">
		<fo:block-container width="100%" xsl:use-attribute-sets="" position="relative">
			<fo:block margin-left="2px" font-size="18pt" font-weight="bold">
				<xsl:value-of select="serviceDescription" />
			</fo:block>
			<fo:block margin-left="2px" margin-top="2mm">
				CON NUM: <xsl:value-of select="consignmentNumber" />
			</fo:block>
			<fo:block margin-left="2px">
				DATE: <xsl:value-of select="manifestDate" />
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- barcode -->
	<xsl:template name="barcode">
		<fo:block-container left="43mm" width="45mm" xsl:use-attribute-sets="" position="absolute">
			<fo:block xsl:use-attribute-sets="text.center">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>10mm</barcode:height>
							<barcode:module-width>0.25mm</barcode:module-width>
							<barcode:human-readable>
								<barcode:display-start-stop>
									false
								</barcode:display-start-stop>
								<barcode:font-size>
									8pt
								</barcode:font-size>
							</barcode:human-readable>
						</barcode:code128>
					</barcode:barcode>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<!-- address details -->
	<xsl:template name="address">
		<fo:block-container xsl:use-attribute-sets="border.right border.bottom" width="40mm" height="42mm">
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryName"></xsl:value-of>
			</fo:block>
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryAddress1"></xsl:value-of>
			</fo:block>
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryAddress2"></xsl:value-of>
			</fo:block>
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryAddress3"></xsl:value-of>
			</fo:block>
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryTown"></xsl:value-of>
			</fo:block>
			<fo:block margin-left="2px">
				<xsl:value-of select="deliveryCountry"></xsl:value-of>
			</fo:block>
			<fo:block font-weight="bold" margin-left="2px">
				ITEM:
				<xsl:value-of select="itemCount"></xsl:value-of>
				of
				<xsl:value-of select="totalItem"></xsl:value-of>
			</fo:block>
			<fo:block font-weight="bold" margin-left="2px">
				WEIGHT:
				<xsl:value-of select="contentTotalWeight"></xsl:value-of>
			</fo:block>
			<fo:block font-weight="bold" margin-left="2px">
				REF:
				<xsl:value-of select="consignmentReference1"></xsl:value-of>
			</fo:block>
			<fo:block font-weight="bold" margin-left="2px">
				<xsl:value-of select="contentDescription"></xsl:value-of>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<!-- hub code -->
	<xsl:template name="hubcodeArea">
		<fo:block-container height="10mm" width="12mm" xsl:use-attribute-sets="border.right border.bottom text.center" position="absolute" left="40mm">
			<fo:block-container height="10mm" width="6mm" xsl:use-attribute-sets="border.right" position="absolute"><fo:block></fo:block></fo:block-container>
		</fo:block-container>

		<xsl:variable name="sd" select="serviceDescription" />
		<xsl:choose>
			<xsl:when test="$sd != 'Three day'">
				<fo:block-container background-color="#ffffff" top="10mm" height="16mm" width="11.5mm" xsl:use-attribute-sets="border.right border.top border.bottom text.center" position="absolute" left="40.5mm">
					<fo:block></fo:block>
				</fo:block-container>
			</xsl:when>
			<xsl:otherwise>
				<fo:block-container background-color="#ffffff" top="10mm" height="16mm" width="11.5mm" xsl:use-attribute-sets="border.right border.top border.bottom text.center" position="absolute" left="40.5mm">
					<fo:block></fo:block>
				</fo:block-container>
			</xsl:otherwise>
		</xsl:choose>

		<fo:block-container top="26mm" height="16mm" width="12mm" xsl:use-attribute-sets="border.right border.bottom text.center" position="absolute" left="40mm">
			<fo:block font-size="38pt" font-weight="bold">B</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<!-- barcode verticle -->
	<xsl:template name="barcode_verticle">
		<fo:block-container reference-orientation="270" height="7.25mm" left="52mm" width="42mm" xsl:use-attribute-sets="border.bottom text.center" position="absolute">
			<fo:block xsl:use-attribute-sets="text.center">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>10mm</barcode:height>
							<barcode:module-width>0.20mm</barcode:module-width>
							<barcode:human-readable>
								<barcode:display-start-stop>
									false
								</barcode:display-start-stop>
								<barcode:font-size>
									0pt
								</barcode:font-size>
							</barcode:human-readable>
						</barcode:code128>
					</barcode:barcode>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<!-- depot_postcode_section -->
	<xsl:template name="depot_postcode_section">
		<fo:block-container left="59mm" height="42mm" xsl:use-attribute-sets="border.bottom text.center" position="absolute">
			<fo:block>
				<xsl:value-of select="deliveryServiceCentre"></xsl:value-of>
			</fo:block>
			<fo:block margin-top="4mm" font-family="sans-serif" font-weight="bold" font-size="70pt">
				<xsl:value-of select="origServiceCentre"></xsl:value-of>
			</fo:block>
			<fo:block>
				<xsl:value-of select="deliveryPostCode"></xsl:value-of>
			</fo:block>
		</fo:block-container>
	</xsl:template>
	
	<!-- customer_name -->
	<xsl:template name="customer_name">
		<fo:block-container>
			<fo:block margin-left="2px">
				<xsl:value-of select="customerName"></xsl:value-of>
			</fo:block>
		</fo:block-container>
		<fo:block-container left="45mm" width="30mm" position="absolute" xsl:use-attribute-sets="text.center" top="42mm">
			<fo:block margin-left="2px" font-size="7pt">
				<xsl:value-of select="consignmentNumber"></xsl:value-of>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<xsl:attribute-set name="text.uppercase">
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.full">
		<xsl:attribute name="border">1px solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid black</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="default.font.size">
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="font-family">Courier</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.center">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.line.height">
		<xsl:attribute name="line-height">13pt</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>