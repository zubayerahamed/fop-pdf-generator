<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : IL.xsl                                     !-->
<!--!    Description  : Item List Report                           !-->
<!--!    Author       : Zubayer Ahamed                             !-->
<!--!    Date         : 10-Apr-2019                                !-->
<!--!    Copyright    : Copyright (c) karigorit.com                !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<xsl:stylesheet 
	version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<xsl:template match="ilreport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="pageid" select="generate-id()" />

			<!-- PAGE SETUP -->
			<fo:layout-master-set>
				<!-- PAGE MASTER -->
				<fo:simple-page-master master-name="A4" page-height="21cm" page-width="29.02cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="25mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-before region-name="header-first" extent="25mm"/>
					<fo:region-after region-name="footer-pagenumber" extent="4.5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4-rest" page-height="21cm" page-width="29.02cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-after region-name="footer-pagenumber" extent="4.5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4-last" page-height="21cm" page-width="29.02cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-after region-name="footer-pagenumber" extent="4.5mm"/>
				</fo:simple-page-master>

				<!-- PAGE SEQUENCE DECLARATION -->
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="A4" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="A4-rest" />
						<fo:conditional-page-master-reference page-position="last" master-reference="A4-last" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<!-- PAGE SEQUENCE -->
			<fo:page-sequence master-reference="document">

				<!-- PAGE HEADER (STATIC CONTENT) -->
				<fo:static-content flow-name="header-first">
					<fo:block-container width="100%">
						<fo:block text-align="center" font-size="20px" font-weight="bold">
							<xsl:value-of select="shopName"/>
						</fo:block>
						<fo:block text-align="center" font-size="9px" margin-top="5px">
							<xsl:value-of select="shopAddress"/>
						</fo:block>
						<fo:block text-align="center" font-size="12px" font-weight="bold" margin-top="5px">
							<xsl:value-of select="reportName"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- FOOTER PAGE NUMBER -->
				<fo:static-content flow-name="footer-pagenumber">
					<fo:block-container position="absolute" width="20%">
						<fo:block text-align="left" font-size="8px">
							Page <fo:page-number/> of <fo:page-number-citation ref-id="{$pageid}"/>
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="20%" width="60%">
						<fo:block text-align="center" font-size="8px">
							<xsl:value-of select="copyright"/>
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="80%" width="20%">
						<fo:block text-align="right" font-size="8px">
							Printed Date : <xsl:value-of select="printDate"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- BODY CONTENT -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container width="100%">
						<fo:block>
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="100%" />

								<fo:table-body>
									<xsl:apply-templates select="categories/category"/>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>

					<fo:block id="{$pageid}" />
				</fo:flow>
			</fo:page-sequence>
			
		</fo:root>
	</xsl:template>

	<!-- Category table template -->
	<xsl:template match="categories/category">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="category.table.td">
				<fo:block font-weight="bold" font-size="14px" padding-top="10px" padding-bottom="10px" text-align="left">
					Category: <xsl:value-of select="categoryName"/>
				</fo:block>

				<!-- Item table -->
				<fo:block>
					<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
						<fo:table-column column-width="3%"/>
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="17%" />
						<fo:table-column column-width="12%" />
						<fo:table-column column-width="12%" />
						<fo:table-column column-width="8%"/>
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="8%" />
						<fo:table-column column-width="6%" />
						<fo:table-column column-width="8%" />

						<!-- Table header -->
						<fo:table-header xsl:use-attribute-sets="table.font.size">
							<fo:table-row>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>SL</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Item</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="left">
									<fo:block>Name</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Created</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Updated</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Cost Price</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Discount</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>VAT</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Sell Price</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>SD</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Status</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-header>

						<!-- table body -->
						<fo:table-body>
							<xsl:apply-templates select="items/item"/>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- Item table template -->
	<xsl:template match="items/item">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="sl"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="itemCode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="left">
				<fo:block>
					<xsl:value-of select="itemName"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="itemAddTime"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="itemUpdateTime"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="costPrice"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="discount"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="vat"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="sellPrice"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="sd"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="status"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- stylesheets -->
	<xsl:attribute-set name="border.full">
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="table.font.size">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="dealer.table.td">
		<xsl:attribute name="padding-top">2px</xsl:attribute>
		<xsl:attribute name="padding-bottom">2px</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client.table.th">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="background-color">#FF6C60</xsl:attribute>
		<xsl:attribute name="color">#fff</xsl:attribute>
		<xsl:attribute name="border">1pt solid #fd200e</xsl:attribute>
		<xsl:attribute name="padding-left">5px</xsl:attribute>
		<xsl:attribute name="padding-right">5px</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client.table.tf">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1pt solid #fd200e</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client.table.td">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1pt solid #fd200e</xsl:attribute>
		<xsl:attribute name="padding-left">5px</xsl:attribute>
		<xsl:attribute name="padding-right">5px</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="category.table.td">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>