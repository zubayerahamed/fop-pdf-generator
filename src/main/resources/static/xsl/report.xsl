<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo" xmlns:java="org.m4.fop.utility.Helper" extension-element-prefixes="java">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	
	<xsl:template match="DriverInvoice">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">

			<!-- PAGE SETUP -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="A4" page-height="29.02cm" page-width="21cm" margin-top="4mm" margin-bottom="0mm" margin-left="6mm" margin-right="6mm">
					<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm" />
					<fo:region-before extent="0mm" />
					<fo:region-after extent="0mm" />
				</fo:simple-page-master>

				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="A4" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="A4" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<!-- PAGE CONTENT -->
			<fo:page-sequence master-reference="A4" xsl:use-attribute-sets="default">
				<!-- static content -->
				
				
				<fo:flow flow-name="xsl-region-body">
					<!-- System address -->
					<fo:block-container width="198mm" height="28mm" top="0" position="absolute" xsl:use-attribute-sets="border.full">
						<fo:block margin-left="10px" margin-top="10px" margin-bottom="10px">
							<fo:block> TO : </fo:block>
							<fo:block> <xsl:value-of select="SystemAddress/Company"/> </fo:block>
							<fo:block> <xsl:value-of select="SystemAddress/AddressLine1"/> </fo:block>
							<fo:block> <xsl:value-of select="SystemAddress/Country"/> </fo:block>
							<fo:block> <xsl:value-of select="SystemAddress/Postcode"/> </fo:block>
							<fo:block> <xsl:value-of select="SystemAddress/Phone"/> </fo:block>
						</fo:block>
					</fo:block-container>

					<!-- Supplier address -->
					<fo:block-container width="99mm" height="28mm" top="28mm" position="absolute" xsl:use-attribute-sets="border.left border.bottom">
						<fo:block width="50%" margin-left="10px" margin-top="10px" margin-bottom="10px">
							<fo:block> From : </fo:block>
							<fo:block> <xsl:value-of select="SupplierInfo/Address/Contact"/> </fo:block>
							<fo:block> <xsl:value-of select="SupplierInfo/Address/AddressLine1"/> </fo:block>
							<fo:block> <xsl:value-of select="SupplierInfo/Address/Country"/> </fo:block>
							<fo:block> <xsl:value-of select="SupplierInfo/Address/Postcode"/> </fo:block>
							<fo:block> <xsl:value-of select="SupplierInfo/Address/Phone"/> </fo:block>
						</fo:block>
					</fo:block-container>

					<!-- Supplier Other info -->
					<fo:block-container width="99mm" height="28mm" left="99mm" top="28mm" position="absolute" xsl:use-attribute-sets="border.right border.bottom">
						<fo:block width="50%" margin-top="10px" margin-left="10px" margin-bottom="10px">
							<fo:block> Driver Name : <xsl:value-of select="SupplierInfo/OtherInfo/DriverName"/> </fo:block>
							<fo:block> Invoice Date : <xsl:value-of select="SupplierInfo/OtherInfo/InvoiceDate"/> </fo:block>
							<fo:block> Invoice Number : <xsl:value-of select="SupplierInfo/OtherInfo/InvoiceNumber"/> </fo:block>
							<fo:block> Page 1 of 3 </fo:block>
						</fo:block>
					</fo:block-container>
					<!-- Jobs -->
					<fo:block-container width="198mm" height="56mm" top="56mm" position="absolute" xsl:use-attribute-sets="border.left border.right border.bottom">
						<fo:block>
							<fo:table width="100%">
								<fo:table-column column-width="16.66%" />
								<fo:table-column column-width="16.66%" />
								<fo:table-column column-width="16.66%" />
								<fo:table-column column-width="16.66%" />
								<fo:table-column column-width="16.66%" />
								<fo:table-column column-width="16.66%" />
								<fo:table-body>
									<fo:table-row xsl:use-attribute-sets="border.bottom">
										<fo:table-cell xsl:use-attribute-sets="border.right"><fo:block>HAWB</fo:block></fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right"><fo:block>Pickup Date</fo:block></fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right"><fo:block>Tariff Code</fo:block></fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right"><fo:block>From Postcode</fo:block></fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.right"><fo:block>To Postcode</fo:block></fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets=""><fo:block>Tariff Charge</fo:block></fo:table-cell>
									</fo:table-row>
									<xsl:apply-templates select="Jobs/Job"/>
									<fo:table-row xsl:use-attribute-sets="border.top">
										<fo:table-cell number-columns-spanned="3">
											<fo:block>
												Total Shipments : <xsl:value-of select="Jobs/Summary/TotalJob"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell number-columns-spanned="3">
											<fo:block>
												Tariff Total : <xsl:value-of select="Jobs/Summary/TotalTariff"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
					</fo:block-container>

					<!-- Additional Charges -->
					<fo:block-container width="198mm" height="40mm" top="112mm" position="absolute" xsl:use-attribute-sets="border.top border.left border.right border.bottom">
						<fo:block>
							Additional Charges
						</fo:block>
						<fo:block>
							<fo:table table-layout="fixed" width="50%" border-collapse="collapse" xsl:use-attribute-sets="border.full">
								<fo:table-column column-width="33.33%" />
								<fo:table-column column-width="33.33%" />
								<fo:table-column column-width="33.33%" />
								<fo:table-body>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>Description</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>Value</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>VAT</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>MIA</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>48.87</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>-</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>MIA</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>48.87</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>-</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>MIA</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>48.87</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>-</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>MIA</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>48.87</fo:block>
										</fo:table-cell>
										<fo:table-cell xsl:use-attribute-sets="border.full">
											<fo:block>-</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</fo:table-body>
							</fo:table>
						</fo:block>
						<fo:block>
							Additional Charges Total: 121.87
						</fo:block>
					</fo:block-container>

					<!-- Total -->
					<fo:block-container width="198mm" height="10mm" top="152mm" position="absolute" xsl:use-attribute-sets="border.top border.left border.right border.bottom">
						<fo:block>
							Total : GBP 171.87
						</fo:block>
					</fo:block-container>

					<!-- Payment Details -->
					<fo:block-container width="198mm" height="16mm" top="162mm" position="absolute" xsl:use-attribute-sets="border.top border.left border.right border.bottom">
						<fo:block>
							Payment Details
						</fo:block>
						<fo:block>
							BACS : 171.87
						</fo:block>
						<fo:block-container top="2mm" left="99mm" position="absolute" width="60mm" height="10mm" xsl:use-attribute-sets="border.full">
							<fo:block></fo:block>
						</fo:block-container>
					</fo:block-container>
				</fo:flow>
			</fo:page-sequence>

			
			
			
			
		</fo:root>
	</xsl:template>

	<!-- Jobs table rows -->
	<xsl:template match="Jobs/Job">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="border.right">
				<fo:block>
					<xsl:value-of select="HAWB"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="border.right">
				<fo:block>
					<xsl:value-of select="PickupDate"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="border.right">
				<fo:block>
					<xsl:value-of select="TariffCode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="border.right">
				<fo:block>
					<xsl:value-of select="FromPostcode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="border.right">
				<fo:block>
					<xsl:value-of select="ToPostcode"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="">
				<fo:block>
					<xsl:value-of select="TariffCharge"/>
				</fo:block>
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


</xsl:stylesheet>