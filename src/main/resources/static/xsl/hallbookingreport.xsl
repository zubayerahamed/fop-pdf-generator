<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
	version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<xsl:template match="hallbookingreport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="pageid" select="generate-id()" />

			<!-- PAGE SETUP -->
			<fo:layout-master-set>
				<!-- PAGE MASTER -->
				<fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="25mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-before region-name="header-first" extent="25mm"/>
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
					<fo:block-container width="100%" border-bottom ="1px solid #000000" >
						<fo:block text-align="center" font-size="20px" font-weight="bold">
							<xsl:value-of select="businessName"/>
						</fo:block>
						<fo:block text-align="center" font-size="9px" margin-top="1px" font-style="italic">
							<xsl:value-of select="businessAddress"/>
						</fo:block>
						<fo:block text-align="center" font-size="12px" font-weight="bold" margin-top="4px">
							<xsl:value-of select="reportName"/>
						</fo:block>
						<fo:block text-align="left" font-size="7px" font-weight="bold"  margin-top="2px" padding-bottom="5px">
							Date: <xsl:value-of select="fromDate"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- FOOTER PAGE NUMBER -->
				<fo:static-content flow-name="footer-pagenumber">
					<fo:block-container position="absolute" width="25%">
						<fo:block text-align="left" font-size="8px">
							Page <fo:page-number/> of <fo:page-number-citation ref-id="{$pageid}"/>
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="25%" width="50%">
						<fo:block text-align="center" font-size="8px">
							<xsl:value-of select="copyrightText"/>
						</fo:block>
					</fo:block-container>
					<fo:block-container position="absolute" left="75%" width="25%">
						<fo:block text-align="right" font-size="8px">
							Printed Date : <xsl:value-of select="printDate"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- BODY CONTENT -->
 				<fo:flow flow-name="xsl-region-body">
					<fo:block-container  width="40%" margin-top="5px">
						<fo:block>
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="30%" />
								<fo:table-column column-width="5%" />
								<fo:table-column column-width="65%" />

								<fo:table-header>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th" number-columns-spanned="3">
											<fo:block>Booking Detail</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>

								<fo:table-body>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Booking Date</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xdate"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Function</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xfunction"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Start Date</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xstartdate"/> <xsl:value-of select="header/xstarttime"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>End Date</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xenddate"/> <xsl:value-of select="header/xendtime"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Client Name</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xcus"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Address</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xcus"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Mobile No</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block><xsl:value-of select="header/xcus"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>Ref By</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>:</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block></fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>

						<fo:block margin-top="25px">
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="70%" />
								<fo:table-column column-width="30%" />

								<fo:table-header>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block>Detail</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Amount</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>

								<fo:table-body>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>1. Facilities</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block text-align="right"><xsl:value-of select="header/xfacamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block>2. Food Charge</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.td">
											<fo:block text-align="right"><xsl:value-of select="header/xfoodamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Total</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xtotamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">VAT</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xvatamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Receivable Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xgrandtot"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Advance Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xpaid"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Due Amount</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xdue"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
						
					</fo:block-container>
					<fo:block-container position="absolute" width="55%" right="0mm" left="45%" top="5px">
						<fo:block>
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="50%" />
								<fo:table-column column-width="15%" />
								<fo:table-column column-width="15%" />
								<fo:table-column column-width="20%" />

								<fo:table-header>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block>Facilities</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Qty</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Rate</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Line Amount</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>

								<fo:table-body>
									<xsl:apply-templates select="facilitiesdetails/facilitiesdetail"/>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th" number-columns-spanned="3">
											<fo:block text-align="right">Total</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xfacamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>

						<fo:block margin-top="25px">
							<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
								<fo:table-column column-width="40%" />
								<fo:table-column column-width="15%" />
								<fo:table-column column-width="15%" />
								<fo:table-column column-width="15%" />
								<fo:table-column column-width="15%" />

								<fo:table-header>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block>Food Item</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Qty</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Rate</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="center">Unit</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right">Line Amount</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-header>

								<fo:table-body>
									<xsl:apply-templates select="fooddetails/fooddetail"/>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="client.table.th" number-columns-spanned="4">
											<fo:block text-align="right">Total</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="client.table.th">
											<fo:block text-align="right"><xsl:value-of select="header/xfoodamt"/></fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>

					</fo:block-container>

					<fo:block-container  width="100%" margin-top="25px">
						<fo:block>
							Received By
						</fo:block>
						<fo:block-container width="60mm" height="13mm" bottom="0" xsl:use-attribute-sets="border.full">
							<fo:block></fo:block>
						</fo:block-container>
					</fo:block-container>
					<fo:block-container width="100%" margin-top="25px">
						<fo:block>
							Client Sign
						</fo:block>
						<fo:block-container width="60mm" height="13mm" bottom="0" xsl:use-attribute-sets="border.full">
							<fo:block></fo:block>
						</fo:block-container>
					</fo:block-container>
					<fo:block id="{$pageid}" />
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- Category table template -->
	<xsl:template match="fooddetails/fooddetail">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="client.table.td">
				<fo:block><xsl:value-of select="xitem"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xqtyord"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xrate"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="center">
				<fo:block><xsl:value-of select="xunit"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xlineamt"/></fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row xsl:use-attribute-sets="category.table.tr">
			<fo:table-cell number-columns-spanned="5">
				<fo:block>
					<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
						<fo:table-column column-width="40%" />
						<fo:table-column column-width="15%" />
						<fo:table-column column-width="15%" />
						<fo:table-column column-width="15%" />
						<fo:table-column column-width="15%" />

						<fo:table-body>
							<xsl:apply-templates select="subitems/subitem"/>
						</fo:table-body>
					</fo:table>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
		<fo:table-row xsl:use-attribute-sets="category.table.tr">
			<fo:table-cell number-columns-spanned="5"><fo:block></fo:block></fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- Item table template -->
	<xsl:template match="subitems/subitem">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="category.table.td">
				<fo:block><xsl:value-of select="xitem"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="category.table.td" text-align="right">
				<fo:block><xsl:value-of select="xqtyord"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="category.table.td" text-align="right">
				<fo:block></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="category.table.td" text-align="center">
				<fo:block><xsl:value-of select="xunit"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="category.table.td" text-align="right">
				<fo:block></fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<xsl:template match="facilitiesdetails/facilitiesdetail">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="client.table.td">
				<fo:block><xsl:value-of select="xitem"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xqtyord"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xrate"/></fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="client.table.td" text-align="right">
				<fo:block><xsl:value-of select="xlineamt"/></fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>


	<!-- stylesheets -->
	<xsl:attribute-set name="border.full">
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
		<xsl:attribute name="float">left</xsl:attribute>
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
		<xsl:attribute name="padding-left">5px</xsl:attribute>
		<xsl:attribute name="padding-right">5px</xsl:attribute>
		<xsl:attribute name="background-color">#DDDDDD</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
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
		<xsl:attribute name="padding-left">5px</xsl:attribute>
		<xsl:attribute name="padding-right">5px</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="category.table.tr">
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="category.table.td">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="padding">5px</xsl:attribute>
		<xsl:attribute name="padding-left">5px</xsl:attribute>
		<xsl:attribute name="padding-right">5px</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>