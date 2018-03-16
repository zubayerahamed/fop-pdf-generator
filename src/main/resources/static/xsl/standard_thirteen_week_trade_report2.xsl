<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ex="http://exslt.org/dates-and-times" 
	extension-element-prefixes="ex" exclude-result-prefixes="fo">
	<xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes" />
	
	<!-- =========================== -->
	<!-- root element: thirteen week trade report -->
	<!-- =========================== -->
	<xsl:template match="thirteenWeekTradeReport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="firstmaster" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="3.6cm" margin-bottom="2cm" />
					<fo:region-before region-name="header-first" extent="8cm" />
					<fo:region-after region-name="footer-last" extent="2cm" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference page-position="first" master-reference="firstmaster" />
						<fo:conditional-page-master-reference page-position="rest" master-reference="firstmaster" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<xsl:apply-templates select="reportClients" />
		</fo:root>
	</xsl:template>

	<xsl:template match="reportClients">
		<fo:page-sequence master-reference="document">
			<xsl:variable name="pageid" select="generate-id()" />
			<!-- page header -->
			<fo:static-content flow-name="header-first">
				<fo:block-container height="38mm" width="150mm" left="0mm" top="0mm" position="absolute">
					<xsl:call-template name="title" />
				</fo:block-container>
			</fo:static-content>

			
		</fo:page-sequence>
	</xsl:template>
	
	<!-- ================================= -->
	<!-- Invoice title -->
	<!-- ================================= -->
	<xsl:template name="title">
		<fo:block font-size="11pt" font-weight="bold">
			<fo:block><xsl:value-of select="thirteenWeekTradeReport/reportName" /></fo:block>
			<fo:block>
				From 
				<xsl:value-of select="thirteenWeekTradeReport/fromDate" />
				To 
				<xsl:value-of select="thirteenWeekTradeReport/toDate" />
			</fo:block>
		</fo:block>
		<fo:block font-size="10pt" space-before="10pt" font-weight="bold">
			<fo:block>
				Page : &#160;&#160;
				<fo:page-number></fo:page-number>
			</fo:block>
			<fo:block>
				Printed : &#160;
				<xsl:value-of select="thirteenWeekTradeReport/printDate" />
			</fo:block>
		</fo:block>
	</xsl:template>
	

	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! Attribute set / CSS ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:attribute-set name="table.border">
		<xsl:attribute name="border">2px solid #000000</xsl:attribute>
		<xsl:attribute name="margin-bottom">10px</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="block.padding">
		<xsl:attribute name="padding">10px</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="text.box">
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
		<xsl:attribute name="margin-bottom">20px</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="table.th">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">1px</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
		<xsl:attribute name="background-color">#DDD</xsl:attribute>
		<xsl:attribute name="font-size">7pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="table.td">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
		<xsl:attribute name="font-size">7pt</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="text.header">
		<xsl:attribute name="font-size">8pt</xsl:attribute>
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="background-color">#E6489C</xsl:attribute>
		<xsl:attribute name="color">#000000</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="dealer.photo">
		<xsl:attribute name="border">1px solid #DDD</xsl:attribute>
		<xsl:attribute name="padding">5px</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.rightWhite">
		<xsl:attribute name="border-right">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.right">
		<xsl:attribute name="border-right">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.top">
		<xsl:attribute name="border-top">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.left">
		<xsl:attribute name="border-left">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.bottom">
		<xsl:attribute name="border-bottom">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="border.all">
		<xsl:attribute name="border">1px solid #000000</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>

