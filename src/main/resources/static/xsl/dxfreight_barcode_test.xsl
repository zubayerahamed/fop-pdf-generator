<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper"
	extension-element-prefixes="java">

	<xsl:output method="xml" version="1.0" omit-xml-declaration="no"
		indent="yes" />

	<xsl:template match="dxfreight">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="DXFREIGHTLABEL"
					page-height="29.7cm" page-width="21cm" margin-top="1.5cm"
					margin-bottom="1.5cm" margin-left="1.5cm" margin-right="1.5cm">
					<fo:region-body margin-top="0.25mm" margin-left="0.25mm"
						margin-right="0.25mm" margin-bottom="0.25mm" />
					<fo:region-before extent="0mm" />
					<fo:region-after extent="0mm" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference
							page-position="first" master-reference="DXFREIGHTLABEL" />
						<fo:conditional-page-master-reference
							page-position="rest" master-reference="DXFREIGHTLABEL" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="DXFREIGHTLABEL">
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container>
						<fo:block>
							<xsl:variable name="code" select="trackingNumber"></xsl:variable>
							<xsl:value-of select="$code"></xsl:value-of>
							<fo:instream-foreign-object>
								<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns"
									message="{$code}">
									<barcode:code39>
										<barcode:height>
											15mm
										</barcode:height>
										<barcode:module-width>0.30mm</barcode:module-width>
										
										<barcode:human-readable>
											<barcode:display-start-stop>
												false
											</barcode:display-start-stop>
											<font-size>18pt</font-size>
										</barcode:human-readable>
									</barcode:code39>
								</barcode:barcode>
							</fo:instream-foreign-object>
						</fo:block>
					</fo:block-container>


				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>



	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid black</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid black</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid black</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid black</xsl:attribute>
		<xsl:attribute name="text-transform">uppercase</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="small.font.size">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="font-family">Courier</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.center">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>