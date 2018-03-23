<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">

	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />

	<xsl:template match="dxfreight">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="DXFREIGHTLABEL" page-width="102mm" page-height="102mm" margin-top="1mm" margin-bottom="1mm" margin-left="1mm" margin-right="1mm">
					<fo:region-body margin-top="0.25mm" margin-left="0.25mm" margin-right="0.25mm" margin-bottom="0.25mm" />
					<fo:region-before extent="0mm" />
					<fo:region-after extent="0mm" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="DXFREIGHTLABEL" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="DXFREIGHTLABEL" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="DXFREIGHTLABEL">
				<fo:flow flow-name="xsl-region-body">
					
					<fo:block-container>
						<xsl:call-template name="barcode">
							<xsl:with-param name="awbn">
								<xsl:value-of select="/dxfreight/consignmentNumber" />
								<xsl:value-of select="/dxfreight/trackingNumber" />
							</xsl:with-param>
							<xsl:with-param name="startStop">
								false
							</xsl:with-param>
							<xsl:with-param name="humanReadable">
								false
							</xsl:with-param>
							<xsl:with-param name="barcodeHeight">
								14
							</xsl:with-param>
							<xsl:with-param name="fontSize">
								10
							</xsl:with-param>
						</xsl:call-template>
					</fo:block-container>
					<fo:block-container>
						<fo:table xsl:use-attribute-sets="border.left">
							<fo:table-column column-width="35%" />
							<fo:table-column column-width="20%" />
							<fo:table-column column-width="15%" />
							<fo:table-column column-width="33%" />
							<fo:table-column column-width="7%" />

							<fo:table-body xsl:use-attribute-sets="small.font.size">
								<fo:table-row>
									<fo:table-cell number-columns-spanned="4">
										<fo:block font-size="14pt">
											<xsl:value-of select="serviceDescription" />
										</fo:block>
										<fo:block>
											CON NUM:
											<xsl:value-of select="consignmentNumber" />
										</fo:block>
										<fo:block>
											DATE:
											<xsl:value-of select="manifestDate" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell number-rows-spanned="3" xsl:use-attribute-sets="border.left">
										<fo:block-container reference-orientation="270">
											<fo:block font-size="15pt">
												<xsl:value-of select="serviceDescription" />
											</fo:block>
										</fo:block-container>
									</fo:table-cell>
								</fo:table-row>

								<fo:table-row>
									<fo:table-cell xsl:use-attribute-sets="border.top border.bottom border.right">
										<fo:block>
											<xsl:value-of select="deliveryName"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryAddress1"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryAddress2"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryAddress3"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryTown"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryCountry"></xsl:value-of>
										</fo:block>
										<fo:block>
											ITRM:
											<xsl:value-of select="contentItem"></xsl:value-of>
										</fo:block>
										<fo:block>
											WEIGHT:
											<xsl:value-of select="contentTotalWeight"></xsl:value-of>
										</fo:block>
										<fo:block>
											REF:
											<xsl:value-of select="consignmentReference1"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="contentDescription"></xsl:value-of>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="border.top border.right border.bottom">
										<fo:block height="30%" position="absolute">
											a
										</fo:block>
										<fo:block height="40%" background-color="#000000" position="absolute">
											a
										</fo:block>
										<fo:block height="30%" font-weight="bold" text-align="center">
											<xsl:value-of select="hubCode"></xsl:value-of>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="border.top border.right border.bottom">
										<fo:block>
											Barcode
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="border.top border.bottom text.center">
										<fo:block>
											<xsl:value-of select="consignmentReference1"></xsl:value-of>
										</fo:block>
										<fo:block font-size="30pt">
											<xsl:value-of select="deliveryServiceCentre"></xsl:value-of>
										</fo:block>
										<fo:block>
											<xsl:value-of select="deliveryPostCode"></xsl:value-of>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<fo:table-row>
									<fo:table-cell number-columns-spanned="2">
										<fo:block>
											<xsl:value-of select="deliveryContact"></xsl:value-of>
										</fo:block>
									</fo:table-cell>
									<fo:table-cell number-columns-spanned="2">
										<fo:block>
											<xsl:value-of select="consignmentNumber"></xsl:value-of>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<xsl:template name="barcode">
		<xsl:param name="awbn" />
		<xsl:param name="startStop" />
		<xsl:param name="humanReadable" />
		<xsl:param name="barcodeHeight" />
		<xsl:param name="fontSize" />
		<fo:block>
			<fo:instream-foreign-object>
				<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$awbn}">
					<barcode:code128>
						<barcode:height>
							<xsl:value-of select="$barcodeHeight" />
							mm
						</barcode:height>
						<barcode:module-width>5mm</barcode:module-width>
						<xsl:if test="$humanReadable != 'true'">
							<barcode:human-readable>none</barcode:human-readable>
						</xsl:if>
						<barcode:human-readable>
							<barcode:display-start-stop>
								<xsl:value-of select="$startStop" />
							</barcode:display-start-stop>
							<barcode:font-size>
								<xsl:value-of select="$fontSize" />
								pt
							</barcode:font-size>
						</barcode:human-readable>
					</barcode:code128>
				</barcode:barcode>
			</fo:instream-foreign-object>
		</fo:block>
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