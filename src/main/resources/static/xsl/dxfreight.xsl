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
					<fo:block-container xsl:use-attribute-sets="" reference-orientation="270" height="10%" width="175px" right="3" position="absolute">
						<fo:block text-align="center" font-size="23px" font-weight="bold" margin-left="2px">
							<xsl:value-of select="serviceDescription" />
						</fo:block>
					</fo:block-container>
					<fo:block-container xsl:use-attribute-sets="border.left border.right" width="90%" position="absolute">
						<fo:block font-size="13px" margin-left="2px">
							<xsl:value-of select="serviceDescription" />
						</fo:block>
						<fo:block  margin-left="2px">
							CON NUM:
							<xsl:value-of select="consignmentNumber" />
						</fo:block>
						<fo:block margin-left="2px">
							DATE:
							<xsl:value-of select="manifestDate" />
						</fo:block>
						<fo:block-container width="100%" xsl:use-attribute-sets="border.bottom border.top border.right">
							<fo:table>
								<fo:table-column column-width="42%" />
								<fo:table-column column-width="6%" />
								<fo:table-column column-width="6%" />
								<fo:table-column column-width="6%" />
								<fo:table-column column-width="40%" />

								<fo:table-body xsl:use-attribute-sets="text.line.height">
									<fo:table-row >
										<fo:table-cell number-rows-spanned="3" xsl:use-attribute-sets="border.right">
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
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right">
											<fo:block>
												<fo:block-container height="25px">
													<fo:block></fo:block>
												</fo:block-container>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right">
											<fo:block>
												<fo:block-container height="25px">
													<fo:block></fo:block>
												</fo:block-container>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell number-rows-spanned="3" xsl:use-attribute-sets="">
											<fo:block>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell number-rows-spanned="3" xsl:use-attribute-sets="">
											<fo:block xsl:use-attribute-sets="text.center">
												<xsl:value-of select="deliveryServiceCentre"></xsl:value-of>
											</fo:block>
											<fo:block margin-top="20px" line-height="80px" font-family="sans-serif" font-weight="bold" font-size="80px" xsl:use-attribute-sets="text.center">
												<xsl:value-of select="origServiceCentre"></xsl:value-of>
											</fo:block>
											<fo:block xsl:use-attribute-sets="text.center">
												<xsl:value-of select="deliveryPostCode"></xsl:value-of>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell number-columns-spanned="2" xsl:use-attribute-sets="border.right border.top border.bottom">
											<fo:block>
												<xsl:variable name="sd" select="serviceDescription" />
												<xsl:choose>
													<xsl:when test="$sd != 'Three day'">
														<fo:block-container height="60px" background-color="#000000">
															<fo:block></fo:block>
														</fo:block-container>
													</xsl:when>
													<xsl:otherwise>
														<fo:block-container height="60px" background-color="#ffffff">
															<fo:block></fo:block>
														</fo:block-container>
													</xsl:otherwise>
												</xsl:choose>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									
									<fo:table-row>
										<fo:table-cell number-columns-spanned="2" xsl:use-attribute-sets="border.right">
											<fo:block>
												<fo:block-container height="30px">
													<fo:block line-height="45pt" font-family="sans-serif" font-size="30px" font-weight="bold" text-align="center">B</fo:block>
												</fo:block-container>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block-container>
						<fo:block margin-left="2px">
							<fo:table>
								<fo:table-column column-width="50%" />
								<fo:table-column column-width="50%" />
							
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="deliveryContact"></xsl:value-of>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block font-size="5pt" margin-top="2px">
												<xsl:value-of select="consignmentNumber"></xsl:value-of>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
					<fo:block-container xsl:use-attribute-sets="text.center" height="25px" left="100px" width="150px" position="absolute">
						<fo:block>
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
					<fo:block-container xsl:use-attribute-sets="text.center" height="14px" width="130" left="138" top="35" reference-orientation="270" position="absolute">
						<fo:block font-size="13px">
							<xsl:variable name="barcode" select="trackingNumber"></xsl:variable>
							<fo:instream-foreign-object>
								<barcode:barcode xmlns:barcode="http://barcode4j.krysalis.org/ns" message="{$barcode}">
									<barcode:code128>
										<barcode:height>8mm</barcode:height>
										<barcode:module-width>0.17mm</barcode:module-width>
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
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
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
		<xsl:attribute name="font-size">8pt</xsl:attribute>
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