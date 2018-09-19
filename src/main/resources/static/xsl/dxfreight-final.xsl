<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="dxfreight">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<!-- PAGE MASTER -->
				<fo:simple-page-master master-name="DXFREIGHTLABEL" page-width="101.6mm" page-height="152.4mm" margin-top="5mm" margin-bottom="5mm" margin-left="5mm" margin-right="5mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm" />
				</fo:simple-page-master>

				<!-- PAGE SEQUENCE DECLARATION -->
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="DXFREIGHTLABEL" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="DXFREIGHTLABEL" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<!-- PAGE SEQUENCE -->
			<fo:page-sequence master-reference="DXFREIGHTLABEL">
				<fo:flow flow-name="xsl-region-body">

					<xsl:variable name="sd" select="serviceDescription" />

					<xsl:choose>
						<xsl:when test="$sd != 'THREE DAY'">
							<xsl:call-template name="GRAPHIC-TABLE" />
							<xsl:call-template name="VERTICLE-SERVICE-TEXT" />
							<xsl:call-template name="HEADER-SECTION" />
							<xsl:call-template name="ADDRESS-SECTION" />
							<xsl:call-template name="FOOTER-SECTION" />
							<xsl:call-template name="RIGHT-SECTION" />
							<xsl:call-template name="MIDDLE-SECTION" />
							<xsl:call-template name="TOP-BARCODE" />
							<xsl:call-template name="BOTTOM-BARCODE" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="GRAPHIC-TABLE-3D"/>
							<xsl:call-template name="VERTICLE-SERVICE-TEXT-3D" />
							<xsl:call-template name="HEADER-SECTION-3D" />
							<xsl:call-template name="ADDRESS-SECTION-3D" />
							<xsl:call-template name="FOOTER-SECTION-3D" />
							<xsl:call-template name="RIGHT-SECTION-3D" />
							<xsl:call-template name="MIDDLE-SECTION-3D" />
							<xsl:call-template name="TOP-BARCODE-3D" />
							<xsl:call-template name="BOTTOM-BARCODE-3D" />
						</xsl:otherwise>
					</xsl:choose>

				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- BOTTOM BARCODE 3D -->
	<xsl:template name="BOTTOM-BARCODE-3D">
		<fo:block-container width="61.5mm" left="7.0mm" top="92.25mm" position="absolute" text-align="center" xsl:use-attribute-sets="font.courier">
			<fo:block xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>14mm</barcode:height>
							<barcode:module-width>0.38mm</barcode:module-width>
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

	<!-- BOTTOM BARCODE -->
	<xsl:template name="BOTTOM-BARCODE">
		<fo:block-container width="61.5mm" left="7.0mm" top="79.25mm" position="absolute" text-align="center" xsl:use-attribute-sets="font.courier">
			<fo:block xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>14mm</barcode:height>
							<barcode:module-width>0.38mm</barcode:module-width>
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

	<!-- TOP BARCODE 3D -->
	<xsl:template name="TOP-BARCODE-3D">
		<fo:block-container right="-1.75mm" top="73mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="30pt" xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>14mm</barcode:height>
							<barcode:module-width>0.52mm</barcode:module-width>
							<barcode:human-readable>
								<barcode:display-start-stop>
									false
								</barcode:display-start-stop>
								<barcode:font-size>
									9pt
								</barcode:font-size>
							</barcode:human-readable>
						</barcode:code128>
					</barcode:barcode>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- TOP BARCODE -->
	<xsl:template name="TOP-BARCODE">
		<fo:block-container right="-1.75mm" top="60mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="30pt" xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>14mm</barcode:height>
							<barcode:module-width>0.52mm</barcode:module-width>
							<barcode:human-readable>
								<barcode:display-start-stop>
									false
								</barcode:display-start-stop>
								<barcode:font-size>
									9pt
								</barcode:font-size>
							</barcode:human-readable>
						</barcode:code128>
					</barcode:barcode>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- MIDDEL SECTION 3D -->
	<xsl:template name="MIDDLE-SECTION-3D">
		<fo:block-container right="66mm" top="78mm" width="30mm" position="absolute" font-size="50pt" font-weight="bold" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block> <xsl:value-of select="hubCode"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- MIDDEL SECTION -->
	<xsl:template name="MIDDLE-SECTION">
		<fo:block-container right="66mm" top="65mm" width="30mm" position="absolute" font-size="50pt" font-weight="bold" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block> <xsl:value-of select="hubCode"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- RIGHT SECTION 3D -->
	<xsl:template name="RIGHT-SECTION-3D">
		<fo:block-container right="24mm" top="108mm" width="30mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block margin-top="-0.5mm" margin-left="5mm"> EX : <xsl:value-of select="origServiceCentre"></xsl:value-of> </fo:block>
			<fo:block text-align="center" font-size="80pt" font-weight="bold" margin-left="2mm" margin-top="8mm"> <xsl:value-of select="deliveryServiceCentre"></xsl:value-of> </fo:block>
			<fo:block margin-top="8.5mm" margin-left="5mm"> <xsl:value-of select="deliveryPostCode"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- RIGHT SECTION -->
	<xsl:template name="RIGHT-SECTION">
		<fo:block-container right="24mm" top="95mm" width="30mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block margin-top="-0.5mm" margin-left="5mm"> EX : <xsl:value-of select="origServiceCentre"></xsl:value-of> </fo:block>
			<fo:block text-align="center" font-size="80pt" font-weight="bold" margin-left="2mm" margin-top="8mm"> <xsl:value-of select="deliveryServiceCentre"></xsl:value-of> </fo:block>
			<fo:block margin-top="8.5mm" margin-left="5mm"> <xsl:value-of select="deliveryPostCode"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- FOOTER SECTION 3D -->
	<xsl:template name="FOOTER-SECTION-3D">
		<fo:block-container right="85.5mm" top="14mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block margin-top="0.5mm"> <xsl:value-of select="customerName"></xsl:value-of> </fo:block>
		</fo:block-container>
		<fo:block-container right="85.5mm" top="86mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="7pt"> <xsl:value-of select="clientReference"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- FOOTER SECTION -->
	<xsl:template name="FOOTER-SECTION">
		<fo:block-container right="85.5mm" top="1mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block margin-top="0.5mm"> <xsl:value-of select="customerName"></xsl:value-of> </fo:block>
		</fo:block-container>
		<fo:block-container right="85.5mm" top="73mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="7pt"> <xsl:value-of select="clientReference"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- ADDRESS SECTION 3D -->
	<xsl:template name="ADDRESS-SECTION-3D">
		<fo:block-container left="7mm" top="14mm" width="58.5mm" height="61.5mm" position="absolute" xsl:use-attribute-sets="font.courier.address" reference-orientation="270">
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryName"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress1"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress2"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress3"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryTown"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryCounty"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold">
				ITEM:
				<xsl:value-of select="itemCount"></xsl:value-of>
				of
				<xsl:value-of select="totalItem"></xsl:value-of>
			</fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> WEIGHT: <xsl:value-of select="contentTotalWeight" /> Kg </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> REF: <xsl:value-of select="consignmentReference1" /> </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="contentDescription" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- ADDRESS SECTION -->
	<xsl:template name="ADDRESS-SECTION">
		<fo:block-container left="7mm" top="1mm" width="58.5mm" height="61.5mm" position="absolute" xsl:use-attribute-sets="font.courier.address" reference-orientation="270">
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryName"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress1"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress2"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryAddress3"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryTown"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm"> <xsl:value-of select="deliveryCounty"></xsl:value-of> </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold">
				ITEM:
				<xsl:value-of select="itemCount"></xsl:value-of>
				of
				<xsl:value-of select="totalItem"></xsl:value-of>
			</fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> WEIGHT: <xsl:value-of select="contentTotalWeight" /> Kg </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> REF: <xsl:value-of select="consignmentReference1" /> </fo:block>
			<fo:block margin-top="0.20mm" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="contentDescription" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- HEADER SECTION 3D -->
	<xsl:template name="HEADER-SECTION-3D">
		<fo:block-container right="-1.5mm" top="14mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="30pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="serviceDescription" /> </fo:block>
			<fo:block margin-top="-0.5mm"> CON NUM: <xsl:value-of select="consignmentNumber" /> </fo:block>
			<fo:block margin-top="0.5mm"> DATE: <xsl:value-of select="manifestDate" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- HEADER SECTION -->
	<xsl:template name="HEADER-SECTION">
		<fo:block-container right="-1.5mm" top="1mm" position="absolute" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block font-size="30pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="serviceDescription" /> </fo:block>
			<fo:block margin-top="-0.5mm"> CON NUM: <xsl:value-of select="consignmentNumber" /> </fo:block>
			<fo:block margin-top="0.5mm"> DATE: <xsl:value-of select="manifestDate" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- VERTICLE SERVICE TEXT 3D -->
	<xsl:template name="VERTICLE-SERVICE-TEXT-3D">
		<fo:block-container top="-129mm" font-size="47pt" text-align="center" position="absolute" xsl:use-attribute-sets="font.courier text.bold" reference-orientation="180">
			<fo:block > <xsl:value-of select="serviceCode" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- VERTICLE SERVICE TEXT -->
	<xsl:template name="VERTICLE-SERVICE-TEXT">
		<fo:block-container top="4mm" font-size="47pt" text-align="center" position="absolute" xsl:use-attribute-sets="font.courier text.bold" reference-orientation="180">
			<fo:block > <xsl:value-of select="serviceCode" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- GRAPHIC TABLE 3D -->
	<xsl:template name="GRAPHIC-TABLE-3D">

		<!-- TABLE BORDER HORIZONTAL FIRST -->
		<fo:block-container width="91.5mm" height="0mm" top="13mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL LAST -->
		<fo:block-container width="91.5mm" height="0mm" top="142mm" border-bottom="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE 1 -->
		<fo:block-container width="0mm" height="129mm" top="13mm" left="7.0mm" border-left="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE 2 -->
		<fo:block-container width="0mm" height="129mm" top="13mm" left="68.5mm" border-right="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 1 -->
		<fo:block-container width="61.5mm" height="0mm" top="73mm" left="7.0mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 3 -->
		<fo:block-container width="61.5mm" height="0mm" top="93mm" left="7.0mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 2 -->
		<fo:block-container width="16mm" height="0mm" top="83mm" left="52.5mm" border-top="1px solid #6a6a6a" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- MIDDLE WHITE BOX -->
		<fo:block-container width="26mm" height="20mm" top="73mm" left="26.5mm" position="absolute" xsl:use-attribute-sets="border.right border.left"><fo:block></fo:block></fo:block-container>
	</xsl:template>

	<!-- GRAPHIC TABLE -->
	<xsl:template name="GRAPHIC-TABLE">
		<!-- TABLE BORDER HORIZONTAL FIRST -->
		<fo:block-container width="91.5mm" height="0mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL LAST -->
		<fo:block-container width="91.5mm" height="0mm" border-bottom="1px solid #000000" top="129mm" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE 1 -->
		<fo:block-container width="0mm" height="129mm" left="7.0mm" border-left="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE 2 -->
		<fo:block-container width="0mm" height="129mm" left="68.5mm" border-right="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 1 -->
		<fo:block-container width="61.5mm" height="0mm" top="60mm" left="7.0mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 3 -->
		<fo:block-container width="61.5mm" height="0mm" top="80mm" left="7.0mm" border-top="1px solid #000000" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL MIDDLE 2 -->
		<fo:block-container width="16mm" height="0mm" top="70mm" left="52.5mm" border-top="1px solid #6a6a6a" position="absolute"><fo:block></fo:block></fo:block-container>

		<!-- MIDDLE BLACK BOX -->
		<fo:block-container width="26mm" height="20mm" top="60mm" left="26.5mm" background-color="#000000"  position="absolute"><fo:block></fo:block></fo:block-container>
	</xsl:template>

	<!-- STYLE SHEETS -->
	<xsl:attribute-set name="border.full">
		<xsl:attribute name="border">1px solid #000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid #000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid #000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid #000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid #000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="font.courier">
		<xsl:attribute name="font-family">Courier</xsl:attribute>
		<xsl:attribute name="font-size">13pt</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="font.courier.address">
		<xsl:attribute name="font-family">Courier</xsl:attribute>
		<xsl:attribute name="font-size">11pt</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.bold">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>