<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">
	<xsl:template match="thirteenWeekTradeReport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="simpleA4" page-height="21cm" page-width="29.7cm" margin-top="2cm" margin-bottom="2cm" margin-left="2cm" margin-right="2cm">
					<fo:region-body />
				</fo:simple-page-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="simpleA4">
				<fo:flow flow-name="xsl-region-body">
					<fo:block font-size="16pt" font-weight="bold" space-after="5mm">
						<xsl:value-of select="reportName" />
					</fo:block>
					<fo:block font-size="10pt" font-weight="bold" space-after="5mm">
						Date : <xsl:value-of select="fromDate" /> to <xsl:value-of select="toDate" />
					</fo:block>
					<fo:block font-size="10pt" font-weight="bold" space-after="5mm">
						Print Date : <xsl:value-of select="printDate" />
					</fo:block>
					<fo:block font-size="10pt">
						<fo:table table-layout="fixed" width="100%" border-collapse="collapse">
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<fo:table-column column-width="6.25%" />
							<!-- table header -->
							<fo:table-header>
								<fo:table-row>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
											<xsl:value-of select="tableHeader/clientCode" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
											<xsl:value-of select="tableHeader/clientDes" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
											<xsl:value-of select="tableHeader/total" />
										</fo:block>
									</fo:table-cell>
									<xsl:apply-templates select="tableHeader/weeks/week" />
								</fo:table-row>
							</fo:table-header>
							<!-- table body -->
							<fo:table-body>
								<xsl:apply-templates select="reportClients/reportClient" />
							</fo:table-body>
						</fo:table>
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="reportClients/reportClient">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="table.td">
				<fo:block>
					<xsl:value-of select="clientCode" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="table.td">
				<fo:block>
					<xsl:value-of select="clientDes" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="table.td">
				<fo:block>
					<xsl:value-of select="totalJobs" /> 
				</fo:block>
				<fo:block>
					<xsl:value-of select="totalNetPrice" />
				</fo:block>
			</fo:table-cell>
			<xsl:apply-templates select="weeks/week" />
		</fo:table-row>
	</xsl:template>


	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! thirteen weeks table column week report  ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template match="weeks/week">
		<fo:table-cell xsl:use-attribute-sets="table.td">
			<fo:block>
				<xsl:value-of select="jobs" />
			</fo:block> 
			<fo:block>
				<xsl:value-of select="netPrice" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! thirteen weeks table column header ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:template match="tableHeader/weeks/week">
		<fo:table-cell xsl:use-attribute-sets="table.th">
			<fo:block font-weight="bold">
				<xsl:value-of select="prevDate" />
			</fo:block> 
			<fo:block font-weight="bold">
				<xsl:value-of select="nextDate" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! Attribute set / CSS ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

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

