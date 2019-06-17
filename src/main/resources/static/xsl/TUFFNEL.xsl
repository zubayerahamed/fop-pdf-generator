<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : tuffnell.xsl                               !-->
<!--!    Description  : TUFFNELL PDF TEMPLATE                      !-->
<!--!    Author       : Zubayer Ahamed                             !-->
<!--!    Date         : 17-Jun-2019                                !-->
<!--!    Copyright    : Copyright (c) M.F. Systems, 2019           !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="tfn">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<!-- PAGE MASTER -->
				<fo:simple-page-master master-name="TUFFNELLLABEL" page-width="101.6mm" page-height="127mm" margin-top="2mm" margin-bottom="2mm" margin-left="2mm" margin-right="2mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm" />
				</fo:simple-page-master>

				<!-- PAGE SEQUENCE DECLARATION -->
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="TUFFNELLLABEL" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="TUFFNELLLABEL" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<!-- PAGE SEQUENCE -->
			<fo:page-sequence master-reference="TUFFNELLLABEL">
				<fo:flow flow-name="xsl-region-body">

					<xsl:call-template name="GRAPHIC-TABLE" />
					<xsl:call-template name="HEADER-SECTION" />
					<xsl:call-template name="CONSIGNMENT-REF-SECTION" />
					<xsl:call-template name="COLLECTION-ADDRESS-SECTION" />
					<xsl:call-template name="ITEM-WEIGHT-DDATE-SECTION" />
					<xsl:call-template name="COMPANY-SECTION" />
					<xsl:call-template name="DELIVERY-ADDRESS-SECTION" />
					<xsl:call-template name="BOTTOM-BARCODE" />
					<xsl:call-template name="RIGHT-BARCODE" />
					<xsl:call-template name="SPECIAL-INS-SECTION" />
					<xsl:call-template name="BLACK-BOX-SECTION" />

				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- GRAPHIC TABLE -->
	<xsl:template name="GRAPHIC-TABLE">
		<!-- TABLE BORDER HORIZONTAL 1ST -->
		<fo:block-container width="92mm" height="0mm" top="12mm" position="absolute" xsl:use-attribute-sets="border.top"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL 2ND -->
		<fo:block-container width="92mm" height="0mm" top="24mm" position="absolute" xsl:use-attribute-sets="border.top"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL 3RD -->
		<fo:block-container width="27mm" height="0mm" top="64mm" position="absolute" xsl:use-attribute-sets="border.top"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL 4TH -->
		<fo:block-container width="92mm" height="0mm" top="84mm" position="absolute" xsl:use-attribute-sets="border.top"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER HORIZONTAL 5TH -->
		<fo:block-container width="92mm" height="0mm" top="96mm" position="absolute" xsl:use-attribute-sets="border.top"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE FIRST -->
		<fo:block-container width="0mm" height="84.36mm" top="12mm" left="0mm" position="absolute" xsl:use-attribute-sets="border.left"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE LAST -->
		<fo:block-container width="0mm" height="84.36mm" top="12mm" left="92mm" position="absolute" xsl:use-attribute-sets="border.right"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE MIDDLE 1 -->
		<fo:block-container width="0mm" height="12mm" top="12mm" left="50mm" position="absolute" xsl:use-attribute-sets="border.right"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE MIDDLE 2 -->
		<fo:block-container width="0mm" height="60mm" top="24mm" left="27mm" position="absolute" xsl:use-attribute-sets="border.right"><fo:block></fo:block></fo:block-container>

		<!-- TABLE BORDER VERTICLE MIDDLE 3 -->
		<fo:block-container width="0mm" height="38mm" top="46mm" left="83mm" position="absolute" xsl:use-attribute-sets="border.right"><fo:block></fo:block></fo:block-container>
	</xsl:template>

	<!-- HEADER SECTION -->
	<xsl:template name="HEADER-SECTION">
		<fo:block-container width="50mm" height="15mm" right="0mm" top="-3.8mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="42pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="serviceCode" /> </fo:block>
		</fo:block-container>
		<fo:block-container width="30mm" height="15mm" left="62mm" top="-3.8mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="42pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="depot" /> </fo:block>
		</fo:block-container>
		<fo:block-container left="75mm" top="9mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="10pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="deliveryRound" /> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- CONSIGNMENT-REF SECTION -->
	<xsl:template name="CONSIGNMENT-REF-SECTION">
		<fo:block-container width="48.5mm" left="1.5mm" top="12.5mm" position="absolute" xsl:use-attribute-sets="font.courier2">
			<fo:block font-size="7pt"> Consignment Ref. </fo:block>
			<fo:block font-size="22pt" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="consignmentReference"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- COLLECTION ADDRESS SECTION -->
	<xsl:template name="COLLECTION-ADDRESS-SECTION">
		<fo:block-container left="52mm" top="12.2mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="7pt" margin-top="0mm"> <xsl:value-of select="collectionCompany"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-0.7mm"> <xsl:value-of select="collectionAddress1"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-0.7mm"> <xsl:value-of select="collectionAddress2"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-0.7mm"> <xsl:value-of select="collectionAddress3"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-0.7mm"> <xsl:value-of select="collectionAddress4"/>, <xsl:value-of select="collectionPostcode"/></fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- ITEM-WEIGHT-DDATE SECTION -->
	<xsl:template name="ITEM-WEIGHT-DDATE-SECTION">
		<fo:block-container width="26mm" height="44mm" left="0.5mm" top="24.5mm" position="absolute" xsl:use-attribute-sets="font.courier2">
			<fo:block font-size="7pt"> Item </fo:block>
			<fo:block font-size="19pt" margin-left="2mm" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="itemNo"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt"> of </fo:block>
			<fo:block font-size="19pt" margin-left="6mm" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="totalItem"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-1.5mm"> Total Weight Kg </fo:block>
			<fo:block font-size="19pt" margin-top="1mm" xsl:use-attribute-sets="text.bold"> <xsl:value-of select="weight"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt" margin-top="-1.5mm"> Despatched </fo:block>
			<fo:block margin-top="1.5mm" font-size="10pt" font-weight="bold"> <xsl:value-of select="despatchDate"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- COMPANY SECTION -->
	<xsl:template name="COMPANY-SECTION">
		<fo:block-container width="26mm" height="20mm" left="0.5mm" top="64mm" text-align="center" position="absolute" xsl:use-attribute-sets="font.courier2">
			<fo:block margin-top="0.5mm" font-size="10pt" font-weight="bold"> Tuffnells </fo:block>
			<fo:block margin-top="-0.5mm" font-size="8pt"> Parcels Express </fo:block>
			<fo:block margin-top="-0.5mm" font-size="9pt"> <xsl:value-of select="deliveryTelephone"></xsl:value-of> </fo:block>
			<fo:block margin-top="1mm" font-size="8pt"> <xsl:value-of select="accountNo"></xsl:value-of> </fo:block>
			<fo:block margin-top="-0.5mm" font-size="8pt" font-weight="bold"> <xsl:value-of select="deliveryDepotNumber"></xsl:value-of>/<xsl:value-of select="deliveryRound"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- DELIVERY-ADDRESS SECTION -->
	<xsl:template name="DELIVERY-ADDRESS-SECTION">
		<fo:block-container left="29mm" top="26.5mm" position="absolute" xsl:use-attribute-sets="font.courier2">
			<fo:block font-size="7pt"> Deliver To </fo:block>
		</fo:block-container>
		<fo:block-container width="50mm" left="29mm" top="29.5mm" position="absolute" font-weight="bold" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryCompany"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryAddress1"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryAddress2"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryAddress3"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryAddress4"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryCounty"></xsl:value-of> </fo:block>
			<fo:block font-size="9pt"> <xsl:value-of select="deliveryCountry"></xsl:value-of> </fo:block>
			<fo:block font-size="21pt"> <xsl:value-of select="deliveryPostcode"></xsl:value-of> </fo:block>
			<fo:block font-size="7pt"> Tel: </fo:block>
			<fo:block font-size="11pt" text-align="center"> <xsl:value-of select="deliveryTelephone"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- SPECIAL-INS SECTION -->
	<xsl:template name="SPECIAL-INS-SECTION">
		<fo:block-container width="91mm" height="11.5mm" left="0.5mm" top="84mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block margin-top="0.5mm" font-size="8pt"> <xsl:value-of select="specialInstruction"></xsl:value-of> </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- BLACK-BOX SECTION -->
	<xsl:template name="BLACK-BOX-SECTION">
		<fo:block-container width="9mm" height="5.0mm" top="42mm" left="83mm" background-color="#000" text-align="center" position="absolute">
			<fo:block margin-top="0.5mm" color="#fff" font-weight="bold" font-size="10pt"> T/L </fo:block>
			<fo:block margin-top="2.5mm" font-weight="bold" font-size="10pt"> - </fo:block>
		</fo:block-container>
		<fo:block-container width="9mm" height="5.0mm" top="56mm" left="83mm" background-color="#000" text-align="center" position="absolute">
			<fo:block margin-top="0.5mm" color="#fff" font-weight="bold" font-size="10pt"> ALT </fo:block>
			<fo:block margin-top="2.5mm" font-weight="bold" font-size="10pt"> - </fo:block>
		</fo:block-container>
		<fo:block-container width="9mm" height="5.0mm" top="70mm" left="83mm" background-color="#000" text-align="center" position="absolute">
			<fo:block margin-top="0.5mm" color="#fff" font-weight="bold" font-size="10pt"> RPO </fo:block>
		</fo:block-container>
	</xsl:template>

	<!-- BOTTOM BARCODE -->
	<xsl:template name="BOTTOM-BARCODE">
		<fo:block-container left="-0.5mm" right="0mm" top="97mm" position="absolute" xsl:use-attribute-sets="font.courier">
			<fo:block font-size="30pt" xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="barcode"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>25mm</barcode:height>
							<barcode:module-width>0.53mm</barcode:module-width>
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

	<!-- RIGHT BARCODE -->
	<xsl:template name="RIGHT-BARCODE">
		<fo:block-container width="61.5mm" right="-1mm" top="24.25mm" position="absolute" text-align="center" xsl:use-attribute-sets="font.courier" reference-orientation="270">
			<fo:block xsl:use-attribute-sets="text.bold">
				<xsl:variable name="barcode" select="barcode"></xsl:variable>
				<fo:instream-foreign-object>
					<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
						<barcode:code128>
							<barcode:height>7mm</barcode:height>
							<barcode:module-width>0.41mm</barcode:module-width>
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
	<xsl:attribute-set name="font.courier2">
		<xsl:attribute name="font-family">Courier</xsl:attribute>
		<xsl:attribute name="font-size">13pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.bold">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>