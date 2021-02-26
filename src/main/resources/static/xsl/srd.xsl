<?xml version="1.0" encoding="UTF-8"?>
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<!--!                                                              !-->
<!--!    File Name    : SRD.xsl                                    !-->
<!--!    Description  : Outlet Sales Summary                       !-->
<!--!    Author       : Zubayer Ahamed                             !-->
<!--!    Date         : 15-Feb-2021                                !-->
<!--!    Copyright    : Copyright (c) ibtl.com                     !-->
<!--!                                                              !-->
<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
<xsl:stylesheet 
	version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<xsl:template match="srdreport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="pageid" select="generate-id()" />

			<!-- PAGE SETUP -->
			<fo:layout-master-set>
				<!-- PAGE MASTER -->
				<fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="35mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-before region-name="header-first" extent="35mm"/>
					<fo:region-after region-name="footer-pagenumber" extent="4.5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4-rest" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-after region-name="footer-pagenumber" extent="4.5mm"/>
				</fo:simple-page-master>
				<fo:simple-page-master master-name="A4-last" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
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
					<!-- <fo:block-container position="absolute" width="20%" top="0mm" left="0mm">
						<fo:block text-align="left" font-size="20px" font-weight="bold">
							<xsl:variable name="siteLogo" select="logo"/>
							<fo:external-graphic padding="0" margin="0" space-start="0" space-end="0" pause-before="0" pause-after="0" content-height="12mm" content-width="35mm" scaling="non-uniform" src="{$siteLogo}" />
						</fo:block>
					</fo:block-container> -->
					<fo:block-container width="100%" margin-top="15px">
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
					<fo:block-container width="100%">
						<fo:block font-size="9px" margin-top="10px">
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="8%" />
								<fo:table-column column-width="2%" />
								<fo:table-column column-width="90%" />

								<fo:table-body xsl:use-attribute-sets="table.font.size">
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="dealer.table.td">
											<fo:block font-weight="bold">
												Date
											</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="dealer.table.td">
											<fo:block font-weight="bold">
												:
											</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="dealer.table.td">
											<fo:block>
												<xsl:value-of select="fromDate"/> to <xsl:value-of select="toDate"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- FOOTER PAGE NUMBER -->
				<fo:static-content flow-name="footer-pagenumber">
					<fo:block-container position="absolute" width="40%">
						<fo:block text-align="left" font-size="8px">
							Page <fo:page-number/> of <fo:page-number-citation ref-id="{$pageid}"/>
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="40%" width="20%">
						<fo:block text-align="center" font-size="8px">
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="60%" width="40%">
						<fo:block text-align="right" font-size="8px">
							Printed On : <xsl:value-of select="printDate"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- BODY CONTENT -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block-container width="100%" margin-top="20px" right="0mm">
						<fo:block>
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="5%"/>
								<fo:table-column column-width="95%" />

								<!-- Table header -->
								<fo:table-header xsl:use-attribute-sets="table.font.size">
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
											<fo:block>SL.</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block>Invoice</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>
								<fo:table-body>
									<xsl:apply-templates select="invoices/invoice"/>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>

					<fo:block-container width="100%" margin-top="10px" right="0mm">
						<fo:block font-weight="bold" font-size="16px">Grand Total</fo:block>
						<fo:block>
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse" xsl:use-attribute-sets="table.font.size">
								<fo:table-column column-width="10%" />
								<fo:table-column column-width="2%" />
								<fo:table-column column-width="88%" />

								<fo:table-body>
									<fo:table-row>
										<fo:table-cell text-align="left">
											<fo:block font-weight="bold">Line Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="left">
											<fo:block><xsl:value-of select="grandLineAmt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell text-align="left">
											<fo:block font-weight="bold">Discount</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="left">
											<fo:block><xsl:value-of select="grandDiscount"/></fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell text-align="left">
											<fo:block font-weight="bold">VAT Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="left">
											<fo:block><xsl:value-of select="grantVatAmt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell text-align="left">
											<fo:block font-weight="bold">Net Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="center">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell text-align="left">
											<fo:block><xsl:value-of select="grandNetAmt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>

					<fo:block id="{$pageid}" />
				</fo:flow>
			</fo:page-sequence>
			
		</fo:root>
	</xsl:template>

	<!-- Invoice table template -->
	<xsl:template match="invoices/invoice">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="sl"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td">
				<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
					<fo:table-column column-width="15%"/>
					<fo:table-column column-width="2%" />
					<fo:table-column column-width="83%" />

					<fo:table-body>
						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Date</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="invDate"/></fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Invoice Number</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell font-weight="bold" text-align="left">
								<fo:block><xsl:value-of select="invNumber"/></fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Total Line Amount</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="lineAmt"/></fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Total Discount</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="discount"/></fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Total VAT Amount</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="vatAmt"/></fo:block>
							</fo:table-cell>
						</fo:table-row>

						<fo:table-row>
							<fo:table-cell text-align="left">
								<fo:block font-weight="bold">Total Net Amount</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="center">
								<fo:block>:</fo:block>
							</fo:table-cell>
							<fo:table-cell text-align="left">
								<fo:block><xsl:value-of select="netAmt"/></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>

				<!-- Item table -->
				<fo:block>
					<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
						<fo:table-column column-width="10%"/>
						<fo:table-column column-width="25%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="5%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />
						<fo:table-column column-width="10%" />

						<!-- Table header -->
						<fo:table-header xsl:use-attribute-sets="table.font.size">
							<fo:table-row>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Item Code</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="left">
									<fo:block>Name</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Price</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Qty</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="center">
									<fo:block>Unit</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Line Amount</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Discount</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Vat Amount</fo:block>
								</fo:table-cell>
								<fo:table-cell xsl:use-attribute-sets="client.table.th" text-align="right">
									<fo:block>Net Amount</fo:block>
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
					<xsl:value-of select="itemCode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="left">
				<fo:block>
					<xsl:value-of select="itemName"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="itemRate"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="itemQqty"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block>
					<xsl:value-of select="itemUnit"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="lineAmt"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="discount"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="vatAmt"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block>
					<xsl:value-of select="netAmt"/>
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
		<xsl:attribute name="background-color">#DDDDDD</xsl:attribute>
		<xsl:attribute name="border">1pt solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client.table.tf">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1pt solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="client.table.td">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1pt solid #000000</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>