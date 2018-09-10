<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	
	<xsl:template match="DriverInvoice">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<xsl:variable name="pageid" select="generate-id()" />
			<!-- PAGE SETUP -->
			<fo:layout-master-set>

				<fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="6mm" margin-bottom="6mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="66.5mm" margin-left="0mm" margin-right="0mm" margin-bottom="5mm" />
					<fo:region-before region-name="header-first" extent="66.5mm"/>
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
				<!-- STATIC CONTENTS HEADER -->
				<fo:static-content flow-name="header-first">
					<fo:block-container height="100%" xsl:use-attribute-sets="default">

						<!-- SYSTEM ADDRESS -->
						<fo:block-container width="198mm" height="28mm" top="0" position="absolute" xsl:use-attribute-sets="border.bottom">
							<fo:block margin-left="10px" margin-top="10px" margin-bottom="10px">
								<fo:block xsl:use-attribute-sets="text.bold"> TO : </fo:block>
								<fo:block xsl:use-attribute-sets="text.bold"> <xsl:value-of select="SystemAddress/Company"/> </fo:block>
								<fo:block> <xsl:value-of select="SystemAddress/AddressLine1"/> </fo:block>
								<fo:block> <xsl:value-of select="SystemAddress/Country"/> </fo:block>
								<fo:block> <xsl:value-of select="SystemAddress/Postcode"/> </fo:block>
								<fo:block> <xsl:value-of select="SystemAddress/Phone"/> </fo:block>
							</fo:block>
						</fo:block-container>

						<!-- SUPPLIER ADDRESS -->
						<fo:block-container width="110mm" height="28mm" top="28mm" position="absolute" xsl:use-attribute-sets="">
							<fo:block width="50%" margin-left="10px" margin-top="10px" margin-bottom="10px">
								<fo:block xsl:use-attribute-sets="text.bold"> FROM : </fo:block>
								<fo:block xsl:use-attribute-sets="text.bold"> <xsl:value-of select="SupplierInfo/Address/Contact"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/Address/AddressLine1"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/Address/Country"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/Address/Postcode"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/Address/Phone"/> </fo:block>
							</fo:block>
						</fo:block-container>
	
						<!-- SUPPLIER OTHER INFO -->
						<fo:block-container width="30mm" height="28mm" left="128mm" top="28mm" position="absolute" xsl:use-attribute-sets="">
							<fo:block width="50%" margin-top="10px" margin-left="10px" margin-bottom="10px">
								<fo:block xsl:use-attribute-sets="text.bold"> Driver Name : </fo:block>
								<fo:block xsl:use-attribute-sets="text.bold"> Invoice Date : </fo:block>
								<fo:block xsl:use-attribute-sets="text.bold"> Invoice Number : </fo:block>
							</fo:block>
						</fo:block-container>
						<fo:block-container width="35mm" height="28mm" left="158mm" top="28mm" position="absolute" xsl:use-attribute-sets="">
							<fo:block width="50%" margin-top="10px" margin-bottom="10px">
								<fo:block> <xsl:value-of select="SupplierInfo/OtherInfo/DriverName"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/OtherInfo/InvoiceDate"/> </fo:block>
								<fo:block> <xsl:value-of select="SupplierInfo/OtherInfo/InvoiceNumber"/> </fo:block>
							</fo:block>
						</fo:block-container>

						<!-- JOBS TABLE HEADER -->
						<fo:block-container background-color="#DDD" height="10.5mm" width="198mm" top="56mm" position="absolute" xsl:use-attribute-sets="">
							<fo:block>
								<fo:table width="100%" xsl:use-attribute-sets="default">
									<fo:table-column column-width="15.00%" />
									<fo:table-column column-width="22.00%" />
									<fo:table-column column-width="22.00%" />
									<fo:table-column column-width="15.00%" />
									<fo:table-column column-width="13.00%" />
									<fo:table-column column-width="13.00%" />
									<fo:table-body>
										<fo:table-row xsl:use-attribute-sets="border.bottom">
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>HAWB</fo:block></fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>Pickup Date</fo:block></fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>Tariff Code</fo:block></fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>From Postcode</fo:block></fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>To Postcode</fo:block></fo:table-cell>
											<fo:table-cell xsl:use-attribute-sets="jobs.th"><fo:block>Tariff Charge</fo:block></fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:block-container>

					</fo:block-container>
				</fo:static-content>

				<!-- FOOTER PAGE NUMBER -->
				<fo:static-content flow-name="footer-pagenumber">
					<fo:block-container text-align="center" height="100%"  padding-top="2pt" xsl:use-attribute-sets="default">
						<fo:block>
							Page <fo:page-number/> of <fo:page-number-citation ref-id="{$pageid}"/>
						</fo:block>
					</fo:block-container>
				</fo:static-content>

				<!-- BODY CONTENTS -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!-- JOBS TABLE  -->
						<fo:table width="100%" xsl:use-attribute-sets="default border.left border.right border.bottom">
							<fo:table-column column-width="15.00%" />
							<fo:table-column column-width="22.00%" />
							<fo:table-column column-width="22.00%" />
							<fo:table-column column-width="15.00%" />
							<fo:table-column column-width="13.00%" />
							<fo:table-column column-width="13.00%" />
							<fo:table-body>
								<xsl:apply-templates select="Jobs/Job"/>
								<fo:table-row xsl:use-attribute-sets="border.bottom border.top">
									<fo:table-cell number-columns-spanned="3" xsl:use-attribute-sets="jobs.td text.bold">
										<fo:block>Total shipments : <xsl:value-of select="Jobs/Summary/TotalJob"/> </fo:block>
									</fo:table-cell>
									<fo:table-cell padding-right="10px" text-align="right" number-columns-spanned="3" xsl:use-attribute-sets="jobs.td text.bold">
										<fo:block>Tariff Total : <xsl:value-of select="format-number(Jobs/Summary/TotalTariff,'###,###,##0.00')"/></fo:block>
									</fo:table-cell>
								</fo:table-row>
							</fo:table-body>
						</fo:table>

						<!-- ADDITIONAL CHARGES -->
						<fo:block-container padding-top="10pt" padding-bottom="10pt" xsl:use-attribute-sets="default">
							<fo:block font-size="14pt" xsl:use-attribute-sets="">
								Additional Charges
							</fo:block>
	
							<fo:block-container width="120mm" margin-top="3mm" xsl:use-attribute-sets="default">
								<fo:block >
									<fo:table width="100%" xsl:use-attribute-sets="border.full">
										<fo:table-column column-width="50%" />
										<fo:table-column column-width="25%" />
										<fo:table-column column-width="25%" />
										<fo:table-body>
											<fo:table-row background-color="#DDD">
												<fo:table-cell xsl:use-attribute-sets="adch.td text.bold">
													<fo:block>Description</fo:block>
												</fo:table-cell>
												<fo:table-cell xsl:use-attribute-sets="adch.td text.bold">
													<fo:block>Value</fo:block>
												</fo:table-cell>
												<fo:table-cell xsl:use-attribute-sets="adch.td text.bold">
													<fo:block>VAT</fo:block>
												</fo:table-cell>
											</fo:table-row>
											<xsl:apply-templates select="AdditionalCharges/Charge"/>
											<fo:table-row>
												<fo:table-cell xsl:use-attribute-sets="adch.td text.bold">
													<fo:block> Total </fo:block>
												</fo:table-cell>
												<fo:table-cell text-align="right" xsl:use-attribute-sets="adch.td text.bold">
													<fo:block> <xsl:value-of select="format-number(AdditionalCharges/Summary/Total,'###,###,##0.00')" /> </fo:block>
												</fo:table-cell>
												<fo:table-cell text-align="right" xsl:use-attribute-sets="adch.td text.bold">
													<fo:block> <xsl:value-of select="format-number(AdditionalCharges/Summary/TotalVAT,'###,###,##0.00')" /> </fo:block>
												</fo:table-cell>
											</fo:table-row>
										</fo:table-body>
									</fo:table>
								</fo:block>
							</fo:block-container>
	
							<fo:block-container margin-top="-3mm" text-align="right" xsl:use-attribute-sets="default text.bold">
								<fo:block margin-right="10pt">
									Additional charges total : <xsl:value-of select="format-number(AdditionalCharges/Summary/Total,'###,###,##0.00')" />
								</fo:block>
							</fo:block-container>

						</fo:block-container>
						
						<!-- FOOTER -->
						<fo:block-container keep-together.within-page="always" margin-top="20mm">
							<!-- TOTAL GBP -->
							<fo:block-container padding-top="5pt" padding-bottom="5pt" height="5mm" font-size="10pt" text-align="right" xsl:use-attribute-sets="default border.top border.bottom text.bold">
								<fo:block margin-right="10pt">
									Total : GBP <xsl:value-of select="PaymentDetails/Total" />
								</fo:block>
							</fo:block-container>
		
							<!-- SIGNED -->
							<fo:block-container padding-top="5pt" padding-bottom="5pt" height="15mm" xsl:use-attribute-sets="default border.bottom">
								<fo:block margin-left="10pt" font-size="10pt" xsl:use-attribute-sets="text.bold">
									Payment Details
								</fo:block>
								<fo:block margin-left="10pt" margin-top="5mm">
									BACS : <xsl:value-of select="PaymentDetails/Total" />
								</fo:block>
								<fo:block-container width="10mm" height="13mm" left="120mm" position="absolute" xsl:use-attribute-sets="">
									<fo:block>Signed : </fo:block>
								</fo:block-container>
								<fo:block-container width="60mm" height="13mm" left="135mm" position="absolute" xsl:use-attribute-sets="border.full">
									<fo:block></fo:block>
								</fo:block-container>
							</fo:block-container>
						</fo:block-container>

					</fo:block>
					<fo:block id="{$pageid}" />
				</fo:flow>

			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!-- JOBS TABLES TEMPLATE -->
	<xsl:template match="Jobs/Job">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="jobs.td border.right">
				<fo:block>
					<xsl:value-of select="HAWB"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="jobs.td border.right">
				<fo:block>
					<xsl:value-of select="PickupDate"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="jobs.td border.right">
				<fo:block>
					<xsl:value-of select="TariffCode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="jobs.td border.right">
				<fo:block>
					<xsl:value-of select="FromPostcode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="jobs.td border.right">
				<fo:block>
					<xsl:value-of select="ToPostcode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" padding-right="10pt" xsl:use-attribute-sets="jobs.td">
				<fo:block>
					<xsl:value-of select="format-number(TariffCharge,'###,###,##0.00')"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!-- ADDITION CHARGES TABLE TEMPLATE -->
	<xsl:template match="AdditionalCharges/Charge">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="adch.td">
				<fo:block> <xsl:value-of select="Description" /> </fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="adch.td">
				<fo:block> <xsl:value-of select="format-number(UnitPrice,'###,###,##0.00')" /> </fo:block>
			</fo:table-cell>
			<fo:table-cell text-align="right" xsl:use-attribute-sets="adch.td">
				<fo:block> <xsl:value-of select="format-number(VAT,'###,###,##0.00')" /> </fo:block>
			</fo:table-cell>
		</fo:table-row>
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