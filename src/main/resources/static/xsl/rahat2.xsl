<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="netc">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="pageid" select="generate-id()" />

			<!-- PAGE SETUP -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="66.5mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-before region-name="header" extent="66.5mm"/>
					<fo:region-after region-name="footer" extent="4.5mm"/>
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="A4" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="A4" />
						<fo:conditional-page-master-reference page-position="last" master-reference="A4" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>



			<!-- CONTENT BEGINS FROM HERE -->
			<!-- PAGE SEQUENCE -->
			<fo:page-sequence master-reference="document">
				<!-- STATIC CONTENT HEADER -->
				<fo:static-content flow-name="header">
					<fo:block-container height="100%" xsl:use-attribute-sets="border.full">

						<!-- FIRST SECTION -->
						<fo:block-container width="198mm" height="28mm" top="0" position="absolute" xsl:use-attribute-sets="border.full">
							<fo:block>Hi there</fo:block>
						</fo:block-container>


					</fo:block-container>
				</fo:static-content>

				<!-- STATIC CONTENT FOOTER -->
				<fo:static-content flow-name="footer">
					<fo:block-container height="100%" xsl:use-attribute-sets="border.full">

						<!-- FIRST SECTION -->
						<fo:block-container width="198mm" height="28mm" top="0" position="absolute">
							<fo:block>Hi there</fo:block>
						</fo:block-container>


					</fo:block-container>
				</fo:static-content>


				<!-- DYNAMIC BODY -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container height="100%" xsl:use-attribute-sets="border.full">
						<fo:block>
							hi there
						</fo:block>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>

		</fo:root>

	</xsl:template>


	<!-- STYLES -->
	<xsl:attribute-set name="border.full">
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="default">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="jobs.th">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="padding">10pt</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="jobs.td">
		<xsl:attribute name="padding">5pt</xsl:attribute>
		<xsl:attribute name="padding-left">10pt</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="adch.td">
		<xsl:attribute name="padding">2.5pt</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.bold">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>