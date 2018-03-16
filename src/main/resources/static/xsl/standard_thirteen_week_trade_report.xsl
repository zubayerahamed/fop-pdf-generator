<xsl:stylesheet version="1.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">
	<xsl:template match="thirteenWeekTradeReport">
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="firstmaster" page-height="21cm" page-width="29.7cm" margin-top="8mm" margin-bottom="0mm" margin-left="1cm" margin-right="1cm">
					<fo:region-body margin-top="3cm" margin-bottom="1cm" />
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
			<fo:page-sequence master-reference="firstmaster">
				<xsl:variable name="pageid" select="generate-id()" />
				<!-- page header -->
				<fo:static-content flow-name="header-first">
					<fo:block-container width="95%" left="0mm" top="0mm" position="absolute">
						<xsl:call-template name="title" />
					</fo:block-container>
				</fo:static-content>

				<fo:flow flow-name="xsl-region-body">
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
									<fo:table-cell xsl:use-attribute-sets="table.th text.align.center">
										<fo:block font-weight="bold">
											<xsl:value-of select="tableHeader/clientCode" />
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="table.th text.align.center">
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
								<fo:table-row>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
										</fo:block>
									</fo:table-cell>
									<fo:table-cell xsl:use-attribute-sets="table.th">
										<fo:block font-weight="bold">
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
					<fo:block id="{$pageid}" />
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	
	<xsl:template name="title">
		<fo:block font-size="8pt" font-weight="bold" xsl:use-attribute-sets="header.border">
			<fo:block font-size="12pt" font-weight="bold">
				<xsl:value-of select="reportName" />
			</fo:block>
			<fo:table>
				<fo:table-column column-width="33.33%" />
				<fo:table-column column-width="33.33%" />
				<fo:table-column column-width="33.33%" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block space-before="7pt">
								From <xsl:value-of select="fromDate" /> To <xsl:value-of select="toDate" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block space-before="1.5pt" xsl:use-attribute-sets="text.align.center">
								Print Date : <xsl:value-of select="printDate" />
							</fo:block>
						</fo:table-cell>	
						<fo:table-cell>
							<fo:block space-before="3pt" xsl:use-attribute-sets="text.align.right">
								Page : &#160;&#160; <fo:page-number></fo:page-number>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="reportClients/reportClient">
		<fo:table-row>
			<fo:table-cell xsl:use-attribute-sets="table.td border.right text.align.center">
				<fo:block>
					<xsl:value-of select="clientCode" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell xsl:use-attribute-sets="table.td border.right text.align.center">
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
				Weeks
			</fo:block> 
			<fo:block font-weight="bold">
				<xsl:value-of select="description" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>


	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<!--! Attribute set / CSS ! -->
	<!--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<xsl:attribute-set name="header.border">
		<xsl:attribute name="border">2px solid #000000</xsl:attribute>
		<xsl:attribute name="padding">10px</xsl:attribute>
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
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">1px</xsl:attribute>
		<!-- <xsl:attribute name="border">1px solid #000000</xsl:attribute> -->
		<!-- <xsl:attribute name="background-color">#DDD</xsl:attribute> -->
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="border-bottom">1px solid #000000</xsl:attribute>
		<xsl:attribute name="margin-bottom">5px</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="table.td">
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="display-align">center</xsl:attribute>
		<xsl:attribute name="padding">2px</xsl:attribute>
		<!-- <xsl:attribute name="border">1px solid #000000</xsl:attribute> -->
		<xsl:attribute name="font-size">7pt</xsl:attribute>
		<xsl:attribute name="border-top">1px dotted #000000</xsl:attribute>
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

	<xsl:attribute-set name="text.align.center">
		<xsl:attribute name="text-align">center</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="text.align.right">
		<xsl:attribute name="text-align">right</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>

